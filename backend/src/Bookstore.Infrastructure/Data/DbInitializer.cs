using Bookstore.Domain.Entities;
using Bookstore.Domain.Enums;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace Bookstore.Infrastructure.Data;

public static class DbInitializer
{
    private static readonly System.Text.Json.JsonSerializerOptions JsonOpts = new() { PropertyNameCaseInsensitive = true };

    private static List<T> Read<T>(System.Text.Json.JsonElement root, string name) =>
        root.TryGetProperty(name, out var el)
            ? System.Text.Json.JsonSerializer.Deserialize<List<T>>(el.GetRawText(), JsonOpts) ?? new List<T>()
            : new List<T>();

    private static async Task<bool> SeedFromJsonAsync(BookstoreDbContext context)
    {
        var path = Path.Combine(AppContext.BaseDirectory, "SeedData.json");
        if (!File.Exists(path)) return false;

        using var doc = System.Text.Json.JsonDocument.Parse(await File.ReadAllTextAsync(path));
        var root = doc.RootElement;
        var now = DateTime.UtcNow;

        var discounts = Read<Discount>(root, "Discounts");
        // Vouchers are always valid at deploy time: start yesterday, expire in 60 days
        foreach (var d in discounts) { d.StartDate = now.AddDays(-1); d.EndDate = now.AddDays(60); d.TimesUsed = 0; d.IsActive = true; }

        var isSqlServer = context.Database.IsSqlServer();
        async Task Insert<T>(List<T> items, string table, bool identity = true) where T : class
        {
            if (items.Count == 0) return;
            if (isSqlServer && identity)
            {
                await using var tx = await context.Database.BeginTransactionAsync();
                await context.Database.ExecuteSqlRawAsync($"SET IDENTITY_INSERT [{table}] ON");
                context.Set<T>().AddRange(items);
                await context.SaveChangesAsync();
                await context.Database.ExecuteSqlRawAsync($"SET IDENTITY_INSERT [{table}] OFF");
                await tx.CommitAsync();
            }
            else
            {
                context.Set<T>().AddRange(items);
                await context.SaveChangesAsync();
            }
            context.ChangeTracker.Clear();
        }

        await Insert(Read<Category>(root, "Categories"), "Categories");
        await Insert(Read<Publisher>(root, "Publishers"), "Publishers");
        await Insert(Read<Author>(root, "Authors"), "Authors");
        await Insert(Read<User>(root, "Users"), "Users");
        await Insert(Read<Address>(root, "Addresses"), "Addresses");
        await Insert(Read<Book>(root, "Books"), "Books");
        await Insert(Read<BookAuthor>(root, "BookAuthors"), "BookAuthors", false);
        await Insert(discounts, "Discounts");
        await Insert(Read<GoodsReceipt>(root, "GoodsReceipts"), "GoodsReceipts");
        await Insert(Read<GoodsReceiptItem>(root, "GoodsReceiptItems"), "GoodsReceiptItems");
        await Insert(Read<Order>(root, "Orders"), "Orders");
        await Insert(Read<OrderItem>(root, "OrderItems"), "OrderItems");
        await Insert(Read<Payment>(root, "Payments"), "Payments");
        await Insert(Read<Review>(root, "Reviews").GroupBy(r => new { r.UserId, r.BookId }).Select(g => g.First()).ToList(), "Reviews");

        // Sync PostgreSQL sequences with imported explicit IDs
        if (context.Database.IsNpgsql())
        {
            var tables = new[] {
                "Categories", "Publishers", "Authors", "Users", "Addresses",
                "Books", "Discounts", "GoodsReceipts", "GoodsReceiptItems",
                "Orders", "OrderItems", "Payments", "Reviews", "Carts", "CartItems"
            };

            foreach (var table in tables)
            {
                try
                {
                    await context.Database.ExecuteSqlRawAsync(
                        $"SELECT setval(pg_get_serial_sequence('\"{table}\"', 'Id'), COALESCE((SELECT MAX(\"Id\") FROM \"{table}\"), 1));"
                    );
                }
                catch { }
            }
        }

        return true;
    }

    private static async Task NormalizeCategoryNamesAsync(BookstoreDbContext context)
    {
        try
        {
            var map = new Dictionary<string, (string Name, string Slug)>(StringComparer.OrdinalIgnoreCase)
            {
                ["Kinh tế & Kinh doanh"] = ("Kinh tế", "kinh-te"),
                ["Kinh tế & Đầu tư"] = ("Kinh tế", "kinh-te"),
                ["Tâm lý & Kỹ năng sống"] = ("Kỹ năng sống", "ky-nang-song"),
                ["Tâm lý & Kỹ năng"] = ("Kỹ năng sống", "ky-nang-song"),
                ["Công nghệ & Lập trình"] = ("Công nghệ", "cong-nghe"),
                ["Lịch sử & Triết học"] = ("Lịch sử", "lich-su"),
                ["Văn học Thiếu nhi"] = ("Thiếu nhi", "thieu-nhi"),
                ["Khoa học & Vũ trụ"] = ("Khoa học", "khoa-hoc")
            };

            var categories = await context.Categories.ToListAsync();
            bool changed = false;
            foreach (var c in categories)
            {
                if (map.TryGetValue(c.Name, out var target))
                {
                    if (c.Name != target.Name || c.Slug != target.Slug)
                    {
                        c.Name = target.Name;
                        c.Slug = target.Slug;
                        changed = true;
                    }
                }
            }

            if (changed)
            {
                await context.SaveChangesAsync();
            }
        }
        catch { }
    }

    public static async Task SeedAsync(BookstoreDbContext context)
    {
        await context.Database.EnsureCreatedAsync();

        if (await context.Books.AnyAsync())
        {
            await NormalizeCategoryNamesAsync(context);
            return; // DB has been seeded
        }

        if (await SeedFromJsonAsync(context))
        {
            await NormalizeCategoryNamesAsync(context);
            return; // Full dataset (1000 books, vouchers, receipts...) loaded
        }

        // 1. Seed Categories
        var catVanHoc = new Category { Name = "Văn học", Slug = "van-hoc", Description = "Tiểu thuyết, truyện ngắn, thơ ca kinh điển và đương đại" };
        var catKinhTe = new Category { Name = "Kinh tế & Đầu tư", Slug = "kinh-te", Description = "Kinh doanh, khởi nghiệp, tài chính cá nhân và thị trường" };
        var catKyNang = new Category { Name = "Tâm lý & Kỹ năng", Slug = "tam-ly-ky-nang", Description = "Phát triển bản thân, tư duy lãnh đạo, quản trị cảm xúc" };
        var catLichSu = new Category { Name = "Lịch sử & Triết học", Slug = "lich-su-triet-hoc", Description = "Lịch sử thế giới, văn minh nhân loại, triết học cổ điển" };
        var catThieuNhi = new Category { Name = "Văn học Thiếu nhi", Slug = "thieu-nhi", Description = "Truyện đồng thoại, giáo dục nhân cách cho thiếu niên" };

        context.Categories.AddRange(catVanHoc, catKinhTe, catKyNang, catLichSu, catThieuNhi);
        await context.SaveChangesAsync();

        // 2. Seed Publishers
        var pubNxbTre = new Publisher { Name = "NXB Trẻ", Address = "161B Lý Chính Thắng, Q.3, TP.HCM", ContactEmail = "hopthu@nxbtre.com.vn" };
        var pubNhaNam = new Publisher { Name = "Công ty Nhã Nam", Address = "59 Đỗ Quang, Cầu Giấy, Hà Nội", ContactEmail = "contact@nhanam.vn" };
        var pubKimDong = new Publisher { Name = "NXB Kim Đồng", Address = "55 Quang Trung, Hai Bà Trưng, Hà Nội", ContactEmail = "cskh@nxbkimdong.com.vn" };
        var pubFirstNews = new Publisher { Name = "First News - Trí Việt", Address = "11H Nguyễn Thị Minh Khai, Q.1, TP.HCM", ContactEmail = "triviet@firstnews.com.vn" };

        context.Publishers.AddRange(pubNxbTre, pubNhaNam, pubKimDong, pubFirstNews);
        await context.SaveChangesAsync();

        // 3. Seed Authors
        var authorPaulo = new Author { Name = "Paulo Coelho", Nationality = "Brazil", Biography = "Nhà văn tiểu thuyết gia nổi tiếng người Brazil, tác giả kiệt tác Nhà Giả Kim." };
        var authorDale = new Author { Name = "Dale Carnegie", Nationality = "Mỹ", Biography = "Bậc thầy về nghệ thuật giao tiếp và thuyết phục con người." };
        var authorHarari = new Author { Name = "Yuval Noah Harari", Nationality = "Israel", Biography = "Nhà sử học, giáo sư khoa Lịch sử tại Đại học Hebrew Jerusalem." };
        var authorJames = new Author { Name = "James Clear", Nationality = "Mỹ", Biography = "Chuyên gia hàng đầu thế giới về thói quen và sự thay đổi hành vi." };
        var authorToHoai = new Author { Name = "Tô Hoài", Nationality = "Việt Nam", Biography = "Một trong những cây đại thụ của nền văn học thiếu nhi hiện đại Việt Nam." };
        var authorNguyenNhatAnh = new Author { Name = "Nguyễn Nhật Ánh", Nationality = "Việt Nam", Biography = "Nhà văn Việt Nam nổi tiếng với những tác phẩm viết về tuổi mới lớn, học trò." };
        var authorNguyenPhong = new Author { Name = "Nguyên Phong", Nationality = "Việt Nam", Biography = "Bút danh của GS. John Vu, tác giả và dịch giả nhiều tác phẩm tâm linh, văn hóa phương Đông." };

        context.Authors.AddRange(authorPaulo, authorDale, authorHarari, authorJames, authorToHoai, authorNguyenNhatAnh, authorNguyenPhong);
        await context.SaveChangesAsync();

        // 4. Seed Books
        var books = new List<Book>
        {
            new Book
            {
                ISBN = "978-604-1-16503-4",
                Title = "Nhà Giả Kim (The Alchemist)",
                Description = "Tất cả những trải nghiệm trong chuyến phiêu lưu theo đuổi vận mệnh của chàng chăn cừu Santiago đã giúp cậu thấu hiểu được ý nghĩa sâu xa nhất của hạnh phúc, hòa hợp với vũ trụ và con người.",
                OriginalPrice = 89000,
                SalePrice = 69000,
                StockQuantity = 120,
                PageCount = 228,
                PublishYear = 2020,
                Language = "vi",
                CoverImageUrl = "https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80",
                IsAvailable = true,
                CategoryId = catVanHoc.Id,
                PublisherId = pubNhaNam.Id
            },
            new Book
            {
                ISBN = "978-604-58-9442-5",
                Title = "Đắc Nhân Tâm (How to Win Friends and Influence People)",
                Description = "Cuốn sách nghệ thuật xử thế kinh điển mọi thời đại, hướng dẫn con người cách ứng xử nhân văn, kết nối và thấu hiểu người khác để đạt được thành công bền vững.",
                OriginalPrice = 96000,
                SalePrice = 75000,
                StockQuantity = 200,
                PageCount = 320,
                PublishYear = 2021,
                Language = "vi",
                CoverImageUrl = "https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80",
                IsAvailable = true,
                CategoryId = catKyNang.Id,
                PublisherId = pubFirstNews.Id
            },
            new Book
            {
                ISBN = "978-604-1-17855-3",
                Title = "Sapiens: Lược Sử Loài Người",
                Description = "Hành trình từ một loài vượn người tầm thường trên thảo nguyên châu Phi trở thành bá chủ hành tinh và mối nguy đe dọa sinh thái toàn cầu qua ngòi bút của Yuval Noah Harari.",
                OriginalPrice = 219000,
                SalePrice = 175000,
                StockQuantity = 85,
                PageCount = 560,
                PublishYear = 2021,
                Language = "vi",
                CoverImageUrl = "https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80",
                IsAvailable = true,
                CategoryId = catLichSu.Id,
                PublisherId = pubNhaNam.Id
            },
            new Book
            {
                ISBN = "978-604-56-8219-0",
                Title = "Atomic Habits: Thay Đổi Tí Hon, Hiệu Quả Bất Ngờ",
                Description = "Phương pháp khoa học đã được chứng minh để xây dựng những thói quen tốt mỗi ngày và từ bỏ những thói quen xấu một cách tự nhiên và bền bỉ.",
                OriginalPrice = 169000,
                SalePrice = 135000,
                StockQuantity = 150,
                PageCount = 388,
                PublishYear = 2022,
                Language = "vi",
                CoverImageUrl = "https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80",
                IsAvailable = true,
                CategoryId = catKyNang.Id,
                PublisherId = pubFirstNews.Id
            },
            new Book
            {
                ISBN = "978-604-2-19822-7",
                Title = "Dế Mèn Phiêu Lưu Ký",
                Description = "Tác phẩm văn học thiếu nhi kinh điển của nhà văn Tô Hoài, bài học sâu sắc về tình bạn, lòng bao dung, tinh thần quả cảm và khát vọng tự do.",
                OriginalPrice = 55000,
                SalePrice = 45000,
                StockQuantity = 100,
                PageCount = 184,
                PublishYear = 2022,
                Language = "vi",
                CoverImageUrl = "https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80",
                IsAvailable = true,
                CategoryId = catThieuNhi.Id,
                PublisherId = pubKimDong.Id
            },
            new Book
            {
                ISBN = "978-604-1-19223-8",
                Title = "Mắt Biếc",
                Description = "Chuyện tình buồn da diết của Ngạn dành cho Hà Lan từ thuở ấu thơ dưới bóng cây thầu đâu làng Đo Đo đến khi trưởng thành giữa dòng đời biến chuyển.",
                OriginalPrice = 110000,
                SalePrice = 88000,
                StockQuantity = 140,
                PageCount = 296,
                PublishYear = 2021,
                Language = "vi",
                CoverImageUrl = "https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80",
                IsAvailable = true,
                CategoryId = catVanHoc.Id,
                PublisherId = pubNxbTre.Id
            },
            new Book
            {
                ISBN = "978-604-58-8821-9",
                Title = "Muôn Kiếp Nhân Sinh - Tập 1",
                Description = "Tác phẩm ghi lại những câu chuyện tiền kiếp kỳ lạ có thật qua góc nhìn minh triết của GS. John Vu, khám phá luật nhân quả và quy luật vũ trụ bao la.",
                OriginalPrice = 168000,
                SalePrice = 138000,
                StockQuantity = 95,
                PageCount = 420,
                PublishYear = 2020,
                Language = "vi",
                CoverImageUrl = "https://images.unsplash.com/photo-1463320726281-696a485928c7?auto=format&fit=crop&w=600&q=80",
                IsAvailable = true,
                CategoryId = catLichSu.Id,
                PublisherId = pubFirstNews.Id
            },
            new Book
            {
                ISBN = "978-604-1-18012-9",
                Title = "Cho Tôi Xin Một Vé Đi Tuổi Thơ",
                Description = "Một chuyến tàu hoài niệm đưa người lớn trở lại với tuổi thơ trong trẻo, hồn nhiên đầy ắp tiếng cười và những trò nghịch ngợm ngây ngô.",
                OriginalPrice = 90000,
                SalePrice = 72000,
                StockQuantity = 110,
                PageCount = 212,
                PublishYear = 2021,
                Language = "vi",
                CoverImageUrl = "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80",
                IsAvailable = true,
                CategoryId = catVanHoc.Id,
                PublisherId = pubNxbTre.Id
            }
        };

        context.Books.AddRange(books);
        await context.SaveChangesAsync();

        // 5. Link Book Authors
        context.BookAuthors.AddRange(
            new BookAuthor { BookId = books[0].Id, AuthorId = authorPaulo.Id },
            new BookAuthor { BookId = books[1].Id, AuthorId = authorDale.Id },
            new BookAuthor { BookId = books[2].Id, AuthorId = authorHarari.Id },
            new BookAuthor { BookId = books[3].Id, AuthorId = authorJames.Id },
            new BookAuthor { BookId = books[4].Id, AuthorId = authorToHoai.Id },
            new BookAuthor { BookId = books[5].Id, AuthorId = authorNguyenNhatAnh.Id },
            new BookAuthor { BookId = books[6].Id, AuthorId = authorNguyenPhong.Id },
            new BookAuthor { BookId = books[7].Id, AuthorId = authorNguyenNhatAnh.Id }
        );

        // 6. Seed Demo Users
        var passwordHash = HashPassword("Admin@123");
        var adminUser = new User
        {
            Email = "admin@bookstore.vn",
            PasswordHash = passwordHash,
            FullName = "Quản trị viên",
            PhoneNumber = "0901234567",
            Role = UserRole.Admin,
            IsActive = true
        };

        var customerUser = new User
        {
            Email = "docgia@gmail.com",
            PasswordHash = HashPassword("User@123"),
            FullName = "Nguyễn Văn Độc Giả",
            PhoneNumber = "0987654321",
            Role = UserRole.Customer,
            IsActive = true
        };

        context.Users.AddRange(adminUser, customerUser);
        await context.SaveChangesAsync();

        // 7. Seed Sample Reviews
        context.Reviews.AddRange(
            new Review { UserId = customerUser.Id, BookId = books[0].Id, Rating = 5, Comment = "Cuốn sách gối đầu giường tuyệt vời nhất đời tôi!", CreatedAt = DateTime.UtcNow.AddDays(-10) },
            new Review { UserId = customerUser.Id, BookId = books[1].Id, Rating = 5, Comment = "Nội dung kinh điển, đọc bao nhiêu lần vẫn thấy tâm đắc.", CreatedAt = DateTime.UtcNow.AddDays(-5) },
            new Review { UserId = customerUser.Id, BookId = books[2].Id, Rating = 5, Comment = "Góc nhìn sử học cực kỳ mới mẻ và thuyết phục.", CreatedAt = DateTime.UtcNow.AddDays(-2) }
        );

        await context.SaveChangesAsync();
    }

    public static string HashPassword(string password)
    {
        var bytes = SHA256.HashData(Encoding.UTF8.GetBytes(password + "BookstoreSalt2026"));
        return Convert.ToBase64String(bytes);
    }
}
