using Bookstore.Domain.Entities;
using Xunit;

namespace Bookstore.Tests;

public class BookModelTests
{
    [Fact]
    public void GetFinalPrice_WithSalePrice_ReturnsSalePrice()
    {
        var book = new Book
        {
            Title = "Test Book",
            OriginalPrice = 100000,
            SalePrice = 80000
        };

        Assert.Equal(80000, book.GetFinalPrice());
    }

    [Fact]
    public void GetFinalPrice_WithoutSalePrice_ReturnsOriginalPrice()
    {
        var book = new Book
        {
            Title = "Test Book",
            OriginalPrice = 100000,
            SalePrice = null
        };

        Assert.Equal(100000, book.GetFinalPrice());
    }

    [Fact]
    public void IsInStock_WithSufficientQuantity_ReturnsTrue()
    {
        var book = new Book
        {
            Title = "Test Book",
            StockQuantity = 10,
            IsAvailable = true
        };

        Assert.True(book.IsInStock(5));
    }

    [Fact]
    public void IsInStock_WithInsufficientQuantity_ReturnsFalse()
    {
        var book = new Book
        {
            Title = "Test Book",
            StockQuantity = 3,
            IsAvailable = true
        };

        Assert.False(book.IsInStock(5));
    }

    [Fact]
    public void IsInStock_WhenNotAvailable_ReturnsFalse()
    {
        var book = new Book
        {
            Title = "Test Book",
            StockQuantity = 100,
            IsAvailable = false
        };

        Assert.False(book.IsInStock(1));
    }
}
