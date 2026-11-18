namespace Bookstore.Domain.Entities;

public class Address
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public string ReceiverName { get; set; } = string.Empty;
    public string ReceiverPhone { get; set; } = string.Empty;
    public string StreetAddress { get; set; } = string.Empty;
    public string Ward { get; set; } = string.Empty;
    public string District { get; set; } = string.Empty;
    public string City { get; set; } = string.Empty;
    public bool IsDefault { get; set; }

    public User User { get; set; } = null!;

    public string GetFullAddress() => $"{StreetAddress}, {Ward}, {District}, {City}";
}
