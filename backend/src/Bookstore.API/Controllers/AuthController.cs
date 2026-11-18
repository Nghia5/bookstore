using Bookstore.Domain.Entities;
using Bookstore.Domain.Enums;
using Bookstore.Infrastructure.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace Bookstore.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly BookstoreDbContext _context;
    private readonly IConfiguration _configuration;

    public AuthController(BookstoreDbContext context, IConfiguration configuration)
    {
        _context = context;
        _configuration = configuration;
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginRequest request)
    {
        if (string.IsNullOrWhiteSpace(request.Email) || string.IsNullOrWhiteSpace(request.Password))
        {
            return BadRequest(new { message = "Vui lòng nhập đầy đủ email và mật khẩu." });
        }

        var user = await _context.Users
            .FirstOrDefaultAsync(u => u.Email.ToLower() == request.Email.Trim().ToLower());

        var hash = DbInitializer.HashPassword(request.Password);

        if (user == null || user.PasswordHash != hash)
        {
            return Unauthorized(new { message = "Email hoặc mật khẩu không chính xác." });
        }

        if (!user.IsActive)
        {
            return Unauthorized(new { message = "Tài khoản hiện đang bị khóa." });
        }

        var token = GenerateJwtToken(user);

        return Ok(new
        {
            token,
            user = new
            {
                user.Id,
                user.Email,
                user.FullName,
                user.PhoneNumber,
                Role = user.Role.ToString()
            }
        });
    }

    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] RegisterRequest request)
    {
        if (string.IsNullOrWhiteSpace(request.Email) || string.IsNullOrWhiteSpace(request.Password) || string.IsNullOrWhiteSpace(request.FullName))
        {
            return BadRequest(new { message = "Vui lòng điền đầy đủ các thông tin bắt buộc." });
        }

        var exists = await _context.Users.AnyAsync(u => u.Email.ToLower() == request.Email.Trim().ToLower());
        if (exists)
        {
            return Conflict(new { message = "Email này đã được sử dụng." });
        }

        var newUser = new User
        {
            Email = request.Email.Trim().ToLower(),
            PasswordHash = DbInitializer.HashPassword(request.Password),
            FullName = request.FullName.Trim(),
            PhoneNumber = request.PhoneNumber?.Trim(),
            Role = UserRole.Customer,
            IsActive = true,
            CreatedAt = DateTime.UtcNow
        };

        _context.Users.Add(newUser);
        await _context.SaveChangesAsync();

        var token = GenerateJwtToken(newUser);

        return Ok(new
        {
            token,
            user = new
            {
                newUser.Id,
                newUser.Email,
                newUser.FullName,
                newUser.PhoneNumber,
                Role = newUser.Role.ToString()
            }
        });
    }

    [HttpGet("me")]
    public async Task<IActionResult> GetCurrentUser()
    {
        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized(new { message = "Vui lòng đăng nhập." });
        }

        var user = await _context.Users
            .Include(u => u.Addresses)
            .Include(u => u.Orders)
            .FirstOrDefaultAsync(u => u.Id == userId);

        if (user == null) return NotFound(new { message = "Không tìm thấy người dùng." });

        return Ok(new
        {
            user.Id,
            user.Email,
            user.FullName,
            user.PhoneNumber,
            Role = user.Role.ToString(),
            user.CreatedAt,
            TotalOrders = user.Orders.Count,
            TotalSpent = user.Orders.Where(o => o.Status != OrderStatus.Cancelled).Sum(o => o.FinalAmount),
            Addresses = user.Addresses.Select(a => new
            {
                a.Id,
                a.ReceiverName,
                a.ReceiverPhone,
                a.StreetAddress,
                a.Ward,
                a.District,
                a.City,
                a.IsDefault
            })
        });
    }

    [HttpPut("profile")]
    public async Task<IActionResult> UpdateProfile([FromBody] UpdateProfileRequest request)
    {
        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized(new { message = "Vui lòng đăng nhập." });
        }

        var user = await _context.Users.FindAsync(userId);
        if (user == null) return NotFound(new { message = "Không tìm thấy người dùng." });

        if (!string.IsNullOrWhiteSpace(request.FullName)) user.FullName = request.FullName.Trim();
        if (request.PhoneNumber != null) user.PhoneNumber = request.PhoneNumber.Trim();

        await _context.SaveChangesAsync();

        return Ok(new
        {
            message = "Cập nhật thông tin thành công!",
            user = new
            {
                user.Id,
                user.Email,
                user.FullName,
                user.PhoneNumber,
                Role = user.Role.ToString()
            }
        });
    }

    [HttpPut("change-password")]
    public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest request)
    {
        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized(new { message = "Vui lòng đăng nhập." });
        }

        var user = await _context.Users.FindAsync(userId);
        if (user == null) return NotFound(new { message = "Không tìm thấy người dùng." });

        var currentHash = DbInitializer.HashPassword(request.CurrentPassword);
        if (user.PasswordHash != currentHash)
        {
            return BadRequest(new { message = "Mật khẩu hiện tại không chính xác." });
        }

        if (string.IsNullOrWhiteSpace(request.NewPassword) || request.NewPassword.Length < 6)
        {
            return BadRequest(new { message = "Mật khẩu mới phải có ít nhất 6 ký tự." });
        }

        user.PasswordHash = DbInitializer.HashPassword(request.NewPassword);
        await _context.SaveChangesAsync();

        return Ok(new { message = "Đổi mật khẩu thành công!" });
    }

    [HttpPost("addresses")]
    public async Task<IActionResult> AddAddress([FromBody] AddAddressRequest request)
    {
        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized(new { message = "Vui lòng đăng nhập." });
        }

        if (string.IsNullOrWhiteSpace(request.ReceiverName) || string.IsNullOrWhiteSpace(request.StreetAddress))
        {
            return BadRequest(new { message = "Họ tên người nhận và địa chỉ không được để trống." });
        }

        var isFirst = !await _context.Addresses.AnyAsync(a => a.UserId == userId);

        var address = new Address
        {
            UserId = userId,
            ReceiverName = request.ReceiverName.Trim(),
            ReceiverPhone = request.ReceiverPhone?.Trim() ?? string.Empty,
            StreetAddress = request.StreetAddress.Trim(),
            Ward = request.Ward?.Trim() ?? "Phường Bến Nghé",
            District = request.District?.Trim() ?? "Quận 1",
            City = request.City?.Trim() ?? "TP. Hồ Chí Minh",
            IsDefault = isFirst || request.IsDefault
        };

        if (address.IsDefault)
        {
            var oldDefaults = await _context.Addresses.Where(a => a.UserId == userId).ToListAsync();
            foreach (var a in oldDefaults) a.IsDefault = false;
        }

        _context.Addresses.Add(address);
        await _context.SaveChangesAsync();

        return Ok(new { message = "Thêm địa chỉ thành công!", addressId = address.Id });
    }

    [HttpDelete("addresses/{id:int}")]
    public async Task<IActionResult> DeleteAddress(int id)
    {
        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized(new { message = "Vui lòng đăng nhập." });
        }

        var address = await _context.Addresses.FirstOrDefaultAsync(a => a.Id == id && a.UserId == userId);
        if (address == null) return NotFound(new { message = "Không tìm thấy địa chỉ." });

        _context.Addresses.Remove(address);
        await _context.SaveChangesAsync();

        return Ok(new { message = "Đã xóa địa chỉ thành công!" });
    }

    private string GenerateJwtToken(User user)
    {
        var jwtSettings = _configuration.GetSection("JwtSettings");
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings["Key"] ?? "DefaultSecretKeyForBookstoreDevelopmentOnly!"));
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        var claims = new[]
        {
            new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
            new Claim(ClaimTypes.Email, user.Email),
            new Claim(ClaimTypes.Name, user.FullName),
            new Claim(ClaimTypes.Role, user.Role.ToString())
        };

        var expiry = DateTime.UtcNow.AddMinutes(double.Parse(jwtSettings["ExpiryMinutes"] ?? "60"));

        var token = new JwtSecurityToken(
            issuer: jwtSettings["Issuer"],
            audience: jwtSettings["Audience"],
            claims: claims,
            expires: expiry,
            signingCredentials: creds
        );

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}

public class LoginRequest
{
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}

public class RegisterRequest
{
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public string FullName { get; set; } = string.Empty;
    public string? PhoneNumber { get; set; }
}

public class UpdateProfileRequest
{
    public string? FullName { get; set; }
    public string? PhoneNumber { get; set; }
}

public class ChangePasswordRequest
{
    public string CurrentPassword { get; set; } = string.Empty;
    public string NewPassword { get; set; } = string.Empty;
}

public class AddAddressRequest
{
    public string ReceiverName { get; set; } = string.Empty;
    public string? ReceiverPhone { get; set; }
    public string StreetAddress { get; set; } = string.Empty;
    public string? Ward { get; set; }
    public string? District { get; set; }
    public string? City { get; set; }
    public bool IsDefault { get; set; }
}
