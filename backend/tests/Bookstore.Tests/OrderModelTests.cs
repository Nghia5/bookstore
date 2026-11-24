using Bookstore.Domain.Entities;
using Bookstore.Domain.Enums;
using Xunit;

namespace Bookstore.Tests;

public class OrderModelTests
{
    [Fact]
    public void Order_InitializesWithDefaultValues()
    {
        var order = new Order
        {
            OrderCode = "ORD-TEST-001",
            TotalAmount = 250000,
            FinalAmount = 250000,
            Status = OrderStatus.Pending
        };

        Assert.Equal("ORD-TEST-001", order.OrderCode);
        Assert.Equal(OrderStatus.Pending, order.Status);
        Assert.Equal(250000, order.FinalAmount);
    }
}
