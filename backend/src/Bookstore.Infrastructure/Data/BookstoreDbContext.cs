using Bookstore.Domain.Entities;
using Bookstore.Domain.Enums;
using Microsoft.EntityFrameworkCore;

namespace Bookstore.Infrastructure.Data;

public class BookstoreDbContext : DbContext
{
    public BookstoreDbContext(DbContextOptions<BookstoreDbContext> options) : base(options)
    {
    }

    public DbSet<User> Users => Set<User>();
    public DbSet<Address> Addresses => Set<Address>();
    public DbSet<Category> Categories => Set<Category>();
    public DbSet<Author> Authors => Set<Author>();
    public DbSet<Publisher> Publishers => Set<Publisher>();
    public DbSet<Book> Books => Set<Book>();
    public DbSet<BookAuthor> BookAuthors => Set<BookAuthor>();
    public DbSet<Review> Reviews => Set<Review>();
    public DbSet<Cart> Carts => Set<Cart>();
    public DbSet<CartItem> CartItems => Set<CartItem>();
    public DbSet<Order> Orders => Set<Order>();
    public DbSet<OrderItem> OrderItems => Set<OrderItem>();
    public DbSet<Payment> Payments => Set<Payment>();
    public DbSet<Discount> Discounts => Set<Discount>();
    public DbSet<GoodsReceipt> GoodsReceipts => Set<GoodsReceipt>();
    public DbSet<GoodsReceiptItem> GoodsReceiptItems => Set<GoodsReceiptItem>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        var utcDateSql = Database.IsSqlServer() ? "GETUTCDATE()" : "CURRENT_TIMESTAMP";

        // ── User ──
        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Email).HasMaxLength(256).IsRequired();
            entity.HasIndex(e => e.Email).IsUnique();
            entity.Property(e => e.PasswordHash).IsRequired();
            entity.Property(e => e.FullName).HasMaxLength(200).IsRequired();
            entity.Property(e => e.PhoneNumber).HasMaxLength(20);
            entity.Property(e => e.Role).HasConversion<int>();
            entity.Property(e => e.CreatedAt).HasDefaultValueSql(utcDateSql);

            entity.HasOne(e => e.Cart)
                  .WithOne(c => c.User)
                  .HasForeignKey<Cart>(c => c.UserId)
                  .OnDelete(DeleteBehavior.Cascade);
        });

        // ── Address ──
        modelBuilder.Entity<Address>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.ReceiverName).HasMaxLength(200).IsRequired();
            entity.Property(e => e.ReceiverPhone).HasMaxLength(20).IsRequired();
            entity.Property(e => e.StreetAddress).HasMaxLength(500).IsRequired();
            entity.Property(e => e.Ward).HasMaxLength(100).IsRequired();
            entity.Property(e => e.District).HasMaxLength(100).IsRequired();
            entity.Property(e => e.City).HasMaxLength(100).IsRequired();

            entity.HasOne(e => e.User)
                  .WithMany(u => u.Addresses)
                  .HasForeignKey(e => e.UserId)
                  .OnDelete(DeleteBehavior.Cascade);
        });

        // ── Category ──
        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Name).HasMaxLength(200).IsRequired();
            entity.Property(e => e.Slug).HasMaxLength(200).IsRequired();
            entity.HasIndex(e => e.Slug).IsUnique();
            entity.Property(e => e.Description).HasMaxLength(1000);

            entity.HasOne(e => e.Parent)
                  .WithMany(e => e.Children)
                  .HasForeignKey(e => e.ParentId)
                  .OnDelete(DeleteBehavior.Restrict);
        });

        // ── Author ──
        modelBuilder.Entity<Author>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Name).HasMaxLength(200).IsRequired();
            entity.Property(e => e.Biography).HasMaxLength(2000);
            entity.Property(e => e.Nationality).HasMaxLength(100);
            entity.Property(e => e.AvatarUrl).HasMaxLength(500);
        });

        // ── Publisher ──
        modelBuilder.Entity<Publisher>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Name).HasMaxLength(300).IsRequired();
            entity.Property(e => e.Address).HasMaxLength(500);
            entity.Property(e => e.ContactEmail).HasMaxLength(256);
        });

        // ── Book ──
        modelBuilder.Entity<Book>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.ISBN).HasMaxLength(20).IsRequired();
            entity.HasIndex(e => e.ISBN).IsUnique();
            entity.Property(e => e.Title).HasMaxLength(500).IsRequired();
            entity.Property(e => e.Description).HasMaxLength(4000);
            entity.Property(e => e.OriginalPrice).HasColumnType("decimal(18,2)");
            entity.Property(e => e.SalePrice).HasColumnType("decimal(18,2)");
            entity.Property(e => e.Language).HasMaxLength(10).HasDefaultValue("vi");
            entity.Property(e => e.CoverImageUrl).HasMaxLength(500);
            entity.Property(e => e.CreatedAt).HasDefaultValueSql(utcDateSql);

            entity.HasOne(e => e.Category)
                  .WithMany(c => c.Books)
                  .HasForeignKey(e => e.CategoryId)
                  .OnDelete(DeleteBehavior.SetNull);

            entity.HasOne(e => e.Publisher)
                  .WithMany(p => p.Books)
                  .HasForeignKey(e => e.PublisherId)
                  .OnDelete(DeleteBehavior.SetNull);
        });

        // ── BookAuthor (many-to-many join) ──
        modelBuilder.Entity<BookAuthor>(entity =>
        {
            entity.HasKey(e => new { e.BookId, e.AuthorId });

            entity.HasOne(e => e.Book)
                  .WithMany(b => b.BookAuthors)
                  .HasForeignKey(e => e.BookId)
                  .OnDelete(DeleteBehavior.Cascade);

            entity.HasOne(e => e.Author)
                  .WithMany(a => a.BookAuthors)
                  .HasForeignKey(e => e.AuthorId)
                  .OnDelete(DeleteBehavior.Cascade);
        });

        // ── Review ──
        modelBuilder.Entity<Review>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Rating).IsRequired();
            entity.Property(e => e.Comment).HasMaxLength(2000);
            entity.Property(e => e.AdminReply).HasMaxLength(2000);
            entity.Property(e => e.CreatedAt).HasDefaultValueSql(utcDateSql);
            entity.HasIndex(e => new { e.UserId, e.BookId }).IsUnique();

            entity.HasOne(e => e.User)
                  .WithMany(u => u.Reviews)
                  .HasForeignKey(e => e.UserId)
                  .OnDelete(DeleteBehavior.Restrict);

            entity.HasOne(e => e.Book)
                  .WithMany(b => b.Reviews)
                  .HasForeignKey(e => e.BookId)
                  .OnDelete(DeleteBehavior.Cascade);
        });

        // ── Cart ──
        modelBuilder.Entity<Cart>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.UserId).IsUnique();
            entity.Property(e => e.UpdatedAt).HasDefaultValueSql(utcDateSql);
        });

        // ── CartItem ──
        modelBuilder.Entity<CartItem>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => new { e.CartId, e.BookId }).IsUnique();

            entity.HasOne(e => e.Cart)
                  .WithMany(c => c.Items)
                  .HasForeignKey(e => e.CartId)
                  .OnDelete(DeleteBehavior.Cascade);

            entity.HasOne(e => e.Book)
                  .WithMany()
                  .HasForeignKey(e => e.BookId)
                  .OnDelete(DeleteBehavior.Cascade);
        });

        // ── Order ──
        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.OrderCode).HasMaxLength(50).IsRequired();
            entity.HasIndex(e => e.OrderCode).IsUnique();
            entity.Property(e => e.Status).HasConversion<int>();
            entity.Property(e => e.TotalAmount).HasColumnType("decimal(18,2)");
            entity.Property(e => e.DiscountAmount).HasColumnType("decimal(18,2)");
            entity.Property(e => e.ShippingFee).HasColumnType("decimal(18,2)");
            entity.Property(e => e.FinalAmount).HasColumnType("decimal(18,2)");
            entity.Property(e => e.Note).HasMaxLength(1000);
            entity.Property(e => e.OrderDate).HasDefaultValueSql(utcDateSql);

            entity.HasOne(e => e.User)
                  .WithMany(u => u.Orders)
                  .HasForeignKey(e => e.UserId)
                  .OnDelete(DeleteBehavior.Restrict);

            entity.HasOne(e => e.ShippingAddress)
                  .WithMany()
                  .HasForeignKey(e => e.ShippingAddressId)
                  .OnDelete(DeleteBehavior.Restrict);

            entity.HasOne(e => e.Payment)
                  .WithOne(p => p.Order)
                  .HasForeignKey<Payment>(p => p.OrderId)
                  .OnDelete(DeleteBehavior.Cascade);
        });

        // ── OrderItem ──
        modelBuilder.Entity<OrderItem>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.BookTitle).HasMaxLength(500).IsRequired();
            entity.Property(e => e.UnitPrice).HasColumnType("decimal(18,2)");
            entity.Property(e => e.LineTotal).HasColumnType("decimal(18,2)");

            entity.HasOne(e => e.Order)
                  .WithMany(o => o.Items)
                  .HasForeignKey(e => e.OrderId)
                  .OnDelete(DeleteBehavior.Cascade);

            entity.HasOne(e => e.Book)
                  .WithMany(b => b.OrderItems)
                  .HasForeignKey(e => e.BookId)
                  .OnDelete(DeleteBehavior.Restrict);
        });

        // ── Payment ──
        modelBuilder.Entity<Payment>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.TransactionCode).HasMaxLength(100);
            entity.Property(e => e.Method).HasConversion<int>();
            entity.Property(e => e.Amount).HasColumnType("decimal(18,2)");
            entity.Property(e => e.Status).HasConversion<int>();
            entity.Property(e => e.PaymentDate).HasDefaultValueSql(utcDateSql);
        });

        // ── Discount ──
        modelBuilder.Entity<Discount>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Code).HasMaxLength(50).IsRequired();
            entity.HasIndex(e => e.Code).IsUnique();
            entity.Property(e => e.DiscountPercent).HasColumnType("decimal(5,2)");
            entity.Property(e => e.MaxDiscountAmount).HasColumnType("decimal(18,2)");
            entity.Property(e => e.MinOrderAmount).HasColumnType("decimal(18,2)");
        });

        // ── GoodsReceipt ──
        modelBuilder.Entity<GoodsReceipt>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.ReceiptCode).HasMaxLength(50).IsRequired();
            entity.HasIndex(e => e.ReceiptCode).IsUnique();
            entity.Property(e => e.SupplierName).HasMaxLength(200).IsRequired();
            entity.Property(e => e.CreatedBy).HasMaxLength(200).IsRequired();
            entity.Property(e => e.TotalAmount).HasColumnType("decimal(18,2)");
            entity.Property(e => e.Note).HasMaxLength(1000);

            entity.HasMany(e => e.Items)
                  .WithOne(i => i.Receipt)
                  .HasForeignKey(i => i.ReceiptId)
                  .OnDelete(DeleteBehavior.Cascade);
        });

        // ── GoodsReceiptItem ──
        modelBuilder.Entity<GoodsReceiptItem>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.CostPrice).HasColumnType("decimal(18,2)");
            entity.Property(e => e.LineTotal).HasColumnType("decimal(18,2)");

            entity.HasOne(e => e.Book)
                  .WithMany()
                  .HasForeignKey(e => e.BookId)
                  .OnDelete(DeleteBehavior.Restrict);
        });
    }
}
