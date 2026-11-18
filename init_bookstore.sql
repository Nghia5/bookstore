-- =====================================================================
-- DATABASE SETUP & SEED SCRIPT FOR BOOKSTORE (SQL SERVER)
-- =====================================================================
USE [master];
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'BookstoreDb')
BEGIN
    CREATE DATABASE [BookstoreDb];
    PRINT 'Database BookstoreDb created successfully.';
END
GO

USE [BookstoreDb];
GO

-- 1. DROP EXISTING TABLES IF ANY
IF OBJECT_ID('dbo.OrderItems', 'U') IS NOT NULL DROP TABLE dbo.OrderItems;
IF OBJECT_ID('dbo.Payments', 'U') IS NOT NULL DROP TABLE dbo.Payments;
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders;
IF OBJECT_ID('dbo.CartItems', 'U') IS NOT NULL DROP TABLE dbo.CartItems;
IF OBJECT_ID('dbo.Carts', 'U') IS NOT NULL DROP TABLE dbo.Carts;
IF OBJECT_ID('dbo.Reviews', 'U') IS NOT NULL DROP TABLE dbo.Reviews;
IF OBJECT_ID('dbo.BookAuthors', 'U') IS NOT NULL DROP TABLE dbo.BookAuthors;
IF OBJECT_ID('dbo.Books', 'U') IS NOT NULL DROP TABLE dbo.Books;
IF OBJECT_ID('dbo.Discounts', 'U') IS NOT NULL DROP TABLE dbo.Discounts;
IF OBJECT_ID('dbo.Publishers', 'U') IS NOT NULL DROP TABLE dbo.Publishers;
IF OBJECT_ID('dbo.Authors', 'U') IS NOT NULL DROP TABLE dbo.Authors;
IF OBJECT_ID('dbo.Categories', 'U') IS NOT NULL DROP TABLE dbo.Categories;
IF OBJECT_ID('dbo.Addresses', 'U') IS NOT NULL DROP TABLE dbo.Addresses;
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL DROP TABLE dbo.Users;
GO

-- 2. CREATE TABLES
CREATE TABLE [dbo].[Users] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Email] NVARCHAR(256) NOT NULL UNIQUE,
    [PasswordHash] NVARCHAR(MAX) NOT NULL,
    [FullName] NVARCHAR(200) NOT NULL,
    [PhoneNumber] NVARCHAR(20) NULL,
    [Role] INT NOT NULL DEFAULT 0,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE [dbo].[Addresses] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserId] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[Users]([Id]) ON DELETE CASCADE,
    [ReceiverName] NVARCHAR(200) NOT NULL,
    [ReceiverPhone] NVARCHAR(20) NOT NULL,
    [StreetAddress] NVARCHAR(500) NOT NULL,
    [Ward] NVARCHAR(100) NOT NULL,
    [District] NVARCHAR(100) NOT NULL,
    [City] NVARCHAR(100) NOT NULL,
    [IsDefault] BIT NOT NULL DEFAULT 0
);

CREATE TABLE [dbo].[Categories] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(200) NOT NULL,
    [Slug] NVARCHAR(200) NOT NULL UNIQUE,
    [Description] NVARCHAR(1000) NULL,
    [ParentId] INT NULL FOREIGN KEY REFERENCES [dbo].[Categories]([Id])
);

CREATE TABLE [dbo].[Authors] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(200) NOT NULL,
    [Nationality] NVARCHAR(100) NULL,
    [Biography] NVARCHAR(2000) NULL,
    [AvatarUrl] NVARCHAR(500) NULL
);

CREATE TABLE [dbo].[Publishers] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(300) NOT NULL,
    [Address] NVARCHAR(500) NULL,
    [ContactEmail] NVARCHAR(256) NULL
);

CREATE TABLE [dbo].[Discounts] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Code] NVARCHAR(50) NOT NULL UNIQUE,
    [DiscountPercent] DECIMAL(18,2) NOT NULL,
    [MaxDiscountAmount] DECIMAL(18,2) NULL,
    [MinOrderAmount] DECIMAL(18,2) NULL,
    [StartDate] DATETIME2 NOT NULL,
    [EndDate] DATETIME2 NOT NULL,
    [UsageLimit] INT NULL,
    [TimesUsed] INT NOT NULL DEFAULT 0,
    [IsActive] BIT NOT NULL DEFAULT 1
);

CREATE TABLE [dbo].[Books] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ISBN] NVARCHAR(50) NOT NULL,
    [Title] NVARCHAR(500) NOT NULL,
    [Description] NVARCHAR(MAX) NULL,
    [OriginalPrice] DECIMAL(18,2) NOT NULL,
    [SalePrice] DECIMAL(18,2) NULL,
    [StockQuantity] INT NOT NULL DEFAULT 0,
    [PageCount] INT NULL,
    [PublishYear] INT NULL,
    [Language] NVARCHAR(50) NOT NULL DEFAULT 'vi',
    [CoverImageUrl] NVARCHAR(1000) NULL,
    [IsAvailable] BIT NOT NULL DEFAULT 1,
    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [CategoryId] INT NULL FOREIGN KEY REFERENCES [dbo].[Categories]([Id]) ON DELETE SET NULL,
    [PublisherId] INT NULL FOREIGN KEY REFERENCES [dbo].[Publishers]([Id]) ON DELETE SET NULL
);

CREATE TABLE [dbo].[BookAuthors] (
    [BookId] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[Books]([Id]) ON DELETE CASCADE,
    [AuthorId] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[Authors]([Id]) ON DELETE CASCADE,
    PRIMARY KEY ([BookId], [AuthorId])
);

CREATE TABLE [dbo].[Reviews] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserId] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[Users]([Id]),
    [BookId] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[Books]([Id]) ON DELETE CASCADE,
    [Rating] INT NOT NULL,
    [Comment] NVARCHAR(2000) NULL,
    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE [dbo].[Carts] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserId] INT NOT NULL UNIQUE FOREIGN KEY REFERENCES [dbo].[Users]([Id]) ON DELETE CASCADE,
    [UpdatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE [dbo].[CartItems] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [CartId] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[Carts]([Id]) ON DELETE CASCADE,
    [BookId] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[Books]([Id]) ON DELETE CASCADE,
    [Quantity] INT NOT NULL DEFAULT 1
);

CREATE TABLE [dbo].[Orders] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [OrderCode] NVARCHAR(50) NOT NULL UNIQUE,
    [UserId] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[Users]([Id]),
    [ShippingAddressId] INT NULL FOREIGN KEY REFERENCES [dbo].[Addresses]([Id]),
    [Status] INT NOT NULL DEFAULT 0,
    [TotalAmount] DECIMAL(18,2) NOT NULL,
    [DiscountAmount] DECIMAL(18,2) NOT NULL DEFAULT 0,
    [ShippingFee] DECIMAL(18,2) NOT NULL DEFAULT 0,
    [FinalAmount] DECIMAL(18,2) NOT NULL,
    [Note] NVARCHAR(1000) NULL,
    [OrderDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE [dbo].[OrderItems] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [OrderId] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[Orders]([Id]) ON DELETE CASCADE,
    [BookId] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[Books]([Id]),
    [BookTitle] NVARCHAR(500) NOT NULL,
    [UnitPrice] DECIMAL(18,2) NOT NULL,
    [Quantity] INT NOT NULL,
    [LineTotal] DECIMAL(18,2) NOT NULL
);

CREATE TABLE [dbo].[Payments] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [OrderId] INT NOT NULL UNIQUE FOREIGN KEY REFERENCES [dbo].[Orders]([Id]) ON DELETE CASCADE,
    [TransactionCode] NVARCHAR(100) NULL,
    [Method] INT NOT NULL DEFAULT 0,
    [Amount] DECIMAL(18,2) NOT NULL,
    [Status] INT NOT NULL DEFAULT 0,
    [PaymentDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);
GO

-- 3. INSERT USERS
SET IDENTITY_INSERT [dbo].[Users] ON;
INSERT INTO [dbo].[Users] ([Id], [Email], [PasswordHash], [FullName], [PhoneNumber], [Role], [IsActive])
VALUES 
(1, N'admin@bookstore.vn', N'dUwAmAhIfFxtkQ6axnzN+jjk5tmzza5oawif8aeWI+c=', N'Quản trị viên', N'0901234567', 3, 1),
(2, N'docgia@gmail.com', N'28dPV6Du3r2UxGK48vjnhuN/5n7mDygG4JN2sU2W2rM=', N'Nguyễn Văn Độc Giả', N'0987654321', 0, 1),
(3, N'nhanvien@bookstore.vn', N'aKr+Ok5dgYSsnSU3ieWoEI2zVz/bK9/1pcOFBcGKUgs=', N'Lê Thị Thu Ngân', N'0912345678', 1, 1);
SET IDENTITY_INSERT [dbo].[Users] OFF;
GO

-- 4. INSERT CATEGORIES
SET IDENTITY_INSERT [dbo].[Categories] ON;
INSERT INTO [dbo].[Categories] ([Id], [Name], [Slug], [Description]) VALUES (1, N'Văn học', N'van-hoc', N'Tiểu thuyết, truyện ngắn, thơ ca kinh điển và đương đại');
INSERT INTO [dbo].[Categories] ([Id], [Name], [Slug], [Description]) VALUES (2, N'Kinh tế & Kinh doanh', N'kinh-te', N'Kinh tế học, khởi nghiệp, tài chính, đầu tư và quản trị doanh nghiệp');
INSERT INTO [dbo].[Categories] ([Id], [Name], [Slug], [Description]) VALUES (3, N'Tâm lý & Kỹ năng sống', N'tam-ly-ky-nang', N'Phát triển bản thân, tư duy tích cực, quản trị cảm xúc và nghệ thuật giao tiếp');
INSERT INTO [dbo].[Categories] ([Id], [Name], [Slug], [Description]) VALUES (4, N'Công nghệ & Lập trình', N'cong-nghe-lap-trinh', N'Khoa học máy tính, trí tuệ nhân tạo, an toàn thông tin, DevOps và lập trình');
INSERT INTO [dbo].[Categories] ([Id], [Name], [Slug], [Description]) VALUES (5, N'Lịch sử & Triết học', N'lich-su-triet-hoc', N'Lịch sử thế giới, lịch sử Việt Nam, văn minh nhân loại và triết học');
INSERT INTO [dbo].[Categories] ([Id], [Name], [Slug], [Description]) VALUES (6, N'Văn học Thiếu nhi', N'thieu-nhi', N'Truyện tranh, cổ tích, đồng thoại nuôi dưỡng tâm hồn trẻ thơ');
INSERT INTO [dbo].[Categories] ([Id], [Name], [Slug], [Description]) VALUES (7, N'Khoa học & Vũ trụ', N'khoa-hoc', N'Vật lý thiên văn, sinh học, khám phá tự nhiên và khoa học đại chúng');
SET IDENTITY_INSERT [dbo].[Categories] OFF;
GO

-- 5. INSERT PUBLISHERS
SET IDENTITY_INSERT [dbo].[Publishers] ON;
INSERT INTO [dbo].[Publishers] ([Id], [Name], [Address], [ContactEmail]) VALUES (1, N'NXB Trẻ', N'161B Lý Chính Thắng, Q.3, TP.HCM', N'hopthu@nxbtre.com.vn');
INSERT INTO [dbo].[Publishers] ([Id], [Name], [Address], [ContactEmail]) VALUES (2, N'Công ty Cổ phần Văn hóa Nhã Nam', N'59 Đỗ Quang, Cầu Giấy, Hà Nội', N'contact@nhanam.vn');
INSERT INTO [dbo].[Publishers] ([Id], [Name], [Address], [ContactEmail]) VALUES (3, N'NXB Kim Đồng', N'55 Quang Trung, Hai Bà Trưng, Hà Nội', N'cskh@nxbkimdong.com.vn');
INSERT INTO [dbo].[Publishers] ([Id], [Name], [Address], [ContactEmail]) VALUES (4, N'First News - Trí Việt', N'11H Nguyễn Thị Minh Khai, Q.1, TP.HCM', N'triviet@firstnews.com.vn');
INSERT INTO [dbo].[Publishers] ([Id], [Name], [Address], [ContactEmail]) VALUES (5, N'NXB Thế Giới', N'46 Trần Hưng Đạo, Hoàn Kiếm, Hà Nội', N'thegioi@hn.vnn.vn');
INSERT INTO [dbo].[Publishers] ([Id], [Name], [Address], [ContactEmail]) VALUES (6, N'NXB Tổng Hợp TP.HCM', N'62 Nguyễn Thị Minh Khai, Q.1, TP.HCM', N'tonghop@nxbhcm.com.vn');
INSERT INTO [dbo].[Publishers] ([Id], [Name], [Address], [ContactEmail]) VALUES (7, N'Alpha Books', N'Tầng 3, Dream Center Home, 11A Tô Ngọc Vân, Hà Nội', N'info@alphabooks.vn');
INSERT INTO [dbo].[Publishers] ([Id], [Name], [Address], [ContactEmail]) VALUES (8, N'NXB Hội Nhà Văn', N'65 Nguyễn Du, Hai Bà Trưng, Hà Nội', N'nxbhnv@vnn.vn');
SET IDENTITY_INSERT [dbo].[Publishers] OFF;
GO

-- 6. INSERT AUTHORS
SET IDENTITY_INSERT [dbo].[Authors] ON;
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (1, N'Paulo Coelho', N'Brazil', N'Tác giả kiệt tác Nhà Giả Kim bán chạy toàn cầu.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (2, N'Dale Carnegie', N'Mỹ', N'Bậc thầy nghệ thuật giao tiếp và thuyết phục nhân tâm.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (3, N'Yuval Noah Harari', N'Israel', N'Sử gia lỗi lạc, tác giả bộ ba Sapiens, Homo Deus và 21 Bài Học.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (4, N'James Clear', N'Mỹ', N'Chuyên gia hàng đầu thế giới về thói quen nguyên tử Atomic Habits.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (5, N'Nguyễn Nhật Ánh', N'Việt Nam', N'Nhà văn của tuổi mới lớn với những tác phẩm trong trẻo đầy hoài niệm.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (6, N'Tô Hoài', N'Việt Nam', N'Cây đại thụ văn học thiếu nhi với Dế Mèn Phiêu Lưu Ký.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (7, N'Nguyên Phong', N'Việt Nam', N'GS. John Vu - nhà khoa học và dịch giả tâm linh huyền học nổi tiếng.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (8, N'Robert Kiyosaki', N'Mỹ', N'Tác giả bộ sách tài chính cá nhân Cha Giàu Cha Nghèo.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (9, N'Morgan Housel', N'Mỹ', N'Chuyên gia tài chính, tác giả Tâm Lý Học Về Tiền.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (10, N'Daniel Kahneman', N'Mỹ', N'Nhà tâm lý học đoạt giải Nobel Kinh tế, tác giả Tư Duy Nhanh Và Chậm.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (11, N'Antoine de Saint-Exupéry', N'Pháp', N'Nhà văn kiêm phi công, tác giả Hoàng Tử Bé bất hủ.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (12, N'George Orwell', N'Anh', N'Tiểu thuyết gia vĩ đại của Trại Súc Vật và 1984.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (13, N'Franz Kafka', N'Áo-Hung', N'Cây bút hiện sinh xuất chúng với Hóa Thân, Vụ Án.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (14, N'Haruki Murakami', N'Nhật Bản', N'Tiểu thuyết gia siêu thực đương đại nổi tiếng toàn cầu.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (15, N'Nguyễn Du', N'Việt Nam', N'Đại thi hào dân tộc, tác giả Truyện Kiều.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (16, N'Nam Cao', N'Việt Nam', N'Cây bút hiện thực phê phán xuất sắc của văn học Việt Nam.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (17, N'Vũ Trọng Phụng', N'Việt Nam', N'Ông vua phóng sự đất Bắc, tác giả Số Đỏ.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (18, N'Stephen Hawking', N'Anh', N'Nhà vật lý lý thuyết vĩ đại, tác giả Lược Sử Thời Gian.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (19, N'Robert C. Martin (Uncle Bob)', N'Mỹ', N'Chuyên gia phần mềm hàng đầu, tác giả Clean Code và Clean Architecture.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (20, N'Martin Fowler', N'Anh', N'Kiến trúc sư phần mềm, tác giả Refactoring.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (21, N'Andrew Ng', N'Mỹ', N'Tiên phong trong lĩnh vực Trí Tuệ Nhân Tạo và Deep Learning.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (22, N'Carl Sagan', N'Mỹ', N'Nhà thiên văn học huyền thoại, tác giả Vũ Trụ (Cosmos).');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (23, N'Rosie Nguyễn', N'Việt Nam', N'Tác giả cuốn sách gối đầu giường Tuổi Trẻ Đáng Giá Bao Nhiêu.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (24, N'Tony Buổi Sáng', N'Việt Nam', N'Tác giả bộ đôi sách truyền cảm hứng sống đẹp cho giới trẻ.');
INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES (25, N'Nguyễn Du', N'Việt Nam', N'Đại thi hào văn học cổ điển Việt Nam.');
SET IDENTITY_INSERT [dbo].[Authors] OFF;
GO

-- 7. INSERT DISCOUNTS
INSERT INTO [dbo].[Discounts] ([Code], [DiscountPercent], [MaxDiscountAmount], [MinOrderAmount], [StartDate], [EndDate], [UsageLimit], [TimesUsed], [IsActive])
VALUES 
(N'BOOKSTORE10', 10.00, 50000.00, 150000.00, '2026-01-01', '2026-12-31', 500, 12, 1),
(N'TRIENTHO20', 20.00, 100000.00, 300000.00, '2026-01-01', '2026-12-31', 200, 45, 1),
(N'FREESHIP', 100.00, 30000.00, 250000.00, '2026-01-01', '2026-12-31', 1000, 89, 1);
GO

-- 8. INSERT 200 BOOKS
SET IDENTITY_INSERT [dbo].[Books] ON;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (1, N'978-604-100-1000', N'Nhà Giả Kim (The Alchemist)', N'Cuộc phiêu lưu tìm kiếm kho báu và sứ mệnh cuộc đời của chàng chăn cừu Santiago.', 89000.00, 69000.00, 30, 180, 2019, N'vi', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 1, 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (2, N'978-604-101-1001', N'Hoàng Tử Bé (Le Petit Prince)', N'Câu chuyện ngụ ngôn giàu chất thơ về tình bạn, tình yêu và ý nghĩa của cuộc sống.', 75000.00, 59000.00, 43, 187, 2020, N'vi', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (3, N'978-604-102-1002', N'Mắt Biếc', N'Mối tình si của Ngạn dành cho cô bạn thời thơ ấu Hà Lan với đôi mắt biếc.', 110000.00, 88000.00, 56, 194, 2021, N'vi', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 1, 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (4, N'978-604-103-1003', N'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', N'Bức tranh hoài niệm tuổi thơ làng quê miền Trung với tình anh em và những rung động đầu đời.', 125000.00, 99000.00, 69, 201, 2022, N'vi', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80', 1, 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (5, N'978-604-104-1004', N'Cho Tôi Xin Một Vé Đi Tuổi Thơ', N'Tấm vé nhiệm màu đưa người lớn quay về với sự hồn nhiên, tinh nghịch của tuổi thơ.', 90000.00, 72000.00, 82, 208, 2023, N'vi', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 1, 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (6, N'978-604-105-1005', N'Cây Cam Ngọt Của Tôi', N'Câu chuyện cảm động rơi nước mắt về cậu bé Zezé 5 tuổi và cây cam ngọt trong sân.', 108000.00, 85000.00, 95, 215, 2024, N'vi', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (7, N'978-604-106-1006', N'Rừng Na Uy', N'Kiệt tác của Haruki Murakami về tuổi trẻ, tình yêu, sự cô đơn và mất mát.', 145000.00, 115000.00, 108, 222, 2019, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (8, N'978-604-107-1007', N'Chiến Binh Cầu Vồng', N'Hành trình theo đuổi con chữ đầy xúc động của 10 đứa trẻ nghèo trên đảo Belitong.', 119000.00, 95000.00, 121, 229, 2020, N'vi', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (9, N'978-604-108-1008', N'Không Gia Đình (Sans Famille)', N'Cuộc đời lưu lạc đầy thử thách nhưng ngời sáng nhân cách của cậu bé Rémi.', 160000.00, 128000.00, 134, 236, 2021, N'vi', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 1, 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (10, N'978-604-109-1009', N'Hai Số Phận (Kane and Abel)', N'Thiên tiểu thuyết kinh điển về cuộc đời đối đầu kịch tính của hai con người xuất chúng.', 195000.00, 155000.00, 147, 243, 2022, N'vi', N'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (11, N'978-604-110-1010', N'Trăm Năm Cô Đơn', N'Kiệt tác chủ nghĩa hiện thực huyền ảo về dòng họ Buendía qua bảy thế hệ.', 185000.00, 148000.00, 160, 250, 2023, N'vi', N'https://images.unsplash.com/photo-1553729459-efe14ef6055d?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (12, N'978-604-111-1011', N'1984', N'Bản cảnh báo mang tính tiên tri sâu sắc của George Orwell về một xã hội toàn trị.', 115000.00, 92000.00, 173, 257, 2024, N'vi', N'https://images.unsplash.com/photo-1491841573634-28140fc7ced7?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (13, N'978-604-112-1012', N'Trại Súc Vật (Animal Farm)', N'Truyện ngụ ngôn chính trị kinh điển châm biếm sâu cay những ảo tưởng quyền lực.', 79000.00, 65000.00, 186, 264, 2019, N'vi', N'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (14, N'978-604-113-1013', N'Số Đỏ', N'Kiệt tác châm biếm hiện thực xuất sắc nhất của văn học hiện đại Việt Nam.', 85000.00, 68000.00, 199, 271, 2020, N'vi', N'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80', 1, 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (15, N'978-604-114-1014', N'Chí Phèo & Tuyển Tập Truyện Ngắn Nam Cao', N'Tiếng kêu xé lòng đòi quyền làm người lương thiện của số phận người nông dân.', 95000.00, 76000.00, 32, 278, 2021, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (16, N'978-604-115-1015', N'Dế Mèn Phiêu Lưu Ký', N'Bài học nhân sinh đầu đời sâu sắc về tình bạn và tinh thần hiệp nghĩa.', 55000.00, 45000.00, 45, 285, 2022, N'vi', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 1, 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (17, N'978-604-116-1016', N'Hóa Thân (The Metamorphosis)', N'Kiệt tác hiện sinh của Franz Kafka về sự tha hóa và cô đơn tột cùng của con người.', 65000.00, 52000.00, 58, 292, 2023, N'vi', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (18, N'978-604-117-1017', N'Tiếng Chim Hót Trong Bụi Mận Gai', N'Bi tình sử lay động hàng triệu trái tim về tình yêu bị ngăn cách bởi định kiến.', 175000.00, 140000.00, 71, 299, 2024, N'vi', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (19, N'978-604-118-1018', N'Cuốn Theo Chiều Gió (Gone with the Wind)', N'Bản anh hùng ca bất hủ về sức sống mãnh liệt của nàng Scarlett O''Hara.', 260000.00, 208000.00, 84, 306, 2019, N'vi', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80', 1, 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (20, N'978-604-119-1019', N'Đồi Gió Hú (Wuthering Heights)', N'Mối tình nồng nàn, dữ dội và đầy ám ảnh giữa Heathcliff và Catherine.', 120000.00, 96000.00, 97, 313, 2020, N'vi', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (21, N'978-604-120-1020', N'Kiêu Hãnh Và Định Kiến (Pride and Prejudice)', N'Kiệt tác tình cảm lãng mạn kinh điển của nữ văn sĩ Jane Austen.', 135000.00, 108000.00, 110, 320, 2021, N'vi', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (22, N'978-604-121-1021', N'Những Người Khốn Khổ (Les Misérables)', N'Bức tranh hoành tráng về tình thương, công lý và sự cứu rỗi của Victor Hugo.', 290000.00, 230000.00, 123, 327, 2022, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (23, N'978-604-122-1022', N'Bắt Trẻ Đồng Xanh (The Catcher in the Rye)', N'Tâm sự nổi loạn và nỗi bơ vơ lạc lõng của chàng thiếu niên Holden Caulfield.', 95000.00, 78000.00, 136, 334, 2023, N'vi', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (24, N'978-604-123-1023', N'Tội Ác Và Trừng Phạt (Crime and Punishment)', N'Phân tích tâm lý bậc thầy của Dostoevsky về tội lỗi, lương tri và sự phục thiện.', 210000.00, 168000.00, 149, 341, 2024, N'vi', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 1, 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (25, N'978-604-124-1024', N'Bác Sĩ Zhivago', N'Bản tình ca da diết giữa bão táp chiến tranh và cách mạng nước Nga.', 220000.00, 176000.00, 162, 348, 2019, N'vi', N'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (26, N'978-604-125-1025', N'Ông Già Và Biển Cả (The Old Man and the Sea)', N'Bài ca ngợi ca ý chí bất khuất của con người trước thử thách nghiệt ngã.', 75000.00, 60000.00, 175, 355, 2020, N'vi', N'https://images.unsplash.com/photo-1553729459-efe14ef6055d?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (27, N'978-604-126-1026', N'Đường Xưa Mây Trắng', N'Cuộc đời Đức Phật Thích Ca qua ngòi bút thiền vị, an nhiên của Thích Nhất Hạnh.', 215000.00, 172000.00, 188, 362, 2021, N'vi', N'https://images.unsplash.com/photo-1491841573634-28140fc7ced7?auto=format&fit=crop&w=600&q=80', 1, 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (28, N'978-604-127-1027', N'Vợ Nhặt & Những Truyện Ngắn Hay', N'Bức tranh hiện thực xót xa nhưng ngời sáng tình thương trong nạn đói 1945.', 70000.00, 56000.00, 201, 369, 2022, N'vi', N'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80', 1, 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (29, N'978-604-128-1028', N'Hương Đồng Gió Nội', N'Tản văn dịu dàng về những nét đẹp văn hóa và ẩm thực Hà Nội xưa.', 85000.00, 68000.00, 34, 376, 2023, N'vi', N'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80', 1, 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (30, N'978-604-129-1029', N'Thương Nhớ Mười Hai', N'Những trang văn đẫm chất thơ về nỗi nhớ quê hương và nét sinh hoạt đất Bắc.', 99000.00, 79000.00, 47, 383, 2024, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (31, N'978-604-130-1030', N'Gió Đầu Mùa', N'Tập truyện ngắn tinh tế, nhẹ nhàng và đượm tình người của Thạch Lam.', 65000.00, 52000.00, 60, 390, 2019, N'vi', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (32, N'978-604-131-1031', N'Lão Hạc & Đời Thừa', N'Nỗi đau quằn quại của người trí thức nghèo trước hiện thực xã hội ngột ngạt.', 75000.00, 60000.00, 73, 397, 2020, N'vi', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 1, 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (33, N'978-604-132-1032', N'Truyện Kiều (Bản Hiệu Khảo Trọn Vẹn)', N'Kiệt tác thi ca đỉnh cao muôn đời của nền văn học dân tộc Việt Nam.', 150000.00, 120000.00, 86, 404, 2021, N'vi', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 1, 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (34, N'978-604-133-1033', N'Cánh Đồng Bất Tận', N'Những mảnh đời trôi dạt trên sông nước miền Tây qua ngòi bút Nguyễn Ngọc Tư.', 88000.00, 70000.00, 99, 411, 2022, N'vi', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80', 1, 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (35, N'978-604-134-1034', N'Hạ Đỏ', N'Mùa hè đầy ắp kỷ niệm thôn quê và mối tình đầu bâng khuâng tuổi mới lớn.', 82000.00, 65000.00, 112, 418, 2023, N'vi', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 1, 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (36, N'978-604-135-1035', N'Ngồi Khóc Trên Cây', N'Chuyện tình cảm động, trong sáng giữa núi rừng thơ mộng làng Đo Đo.', 105000.00, 84000.00, 125, 425, 2024, N'vi', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 1, 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (37, N'978-604-136-1036', N'Cô Gái Đến Từ Hôm Qua', N'Sợi dây duyên số kỳ lạ nối liền quá khứ tuổi thơ và tình yêu hiện tại.', 92000.00, 74000.00, 138, 432, 2019, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (38, N'978-604-137-1037', N'Bàn Có Năm Chỗ Ngồi', N'Tình bạn học trò ấm áp và những bài học sẻ chia đầu đời.', 72000.00, 58000.00, 151, 439, 2020, N'vi', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 1, 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (39, N'978-604-138-1038', N'Phía Sau Nghi Can X', N'Cuộc đấu trí nghẹt thở và câu chuyện tình si lay động của Keigo Higashino.', 118000.00, 95000.00, 164, 446, 2021, N'vi', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (40, N'978-604-139-1039', N'Điều Kỳ Diệu Của Tiệm Tạp Hóa Namiya', N'Hộp thư tư vấn kỳ lạ kết nối quá khứ và hiện tại để xoa dịu những vết thương lòng.', 125000.00, 100000.00, 177, 453, 2022, N'vi', N'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (41, N'978-604-140-1040', N'Chuông Nguyện Hồn Ai', N'Bản hùng ca về sự hy sinh và lý tưởng tự do của Ernest Hemingway.', 198000.00, 158000.00, 190, 460, 2023, N'vi', N'https://images.unsplash.com/photo-1553729459-efe14ef6055d?auto=format&fit=crop&w=600&q=80', 1, 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (42, N'978-604-141-1041', N'Tiếng Gọi Nơi Hoang Dã', N'Bản năng sinh tồn mãnh liệt của chú chó Buck giữa vùng đất băng giá phương Bắc.', 78000.00, 62000.00, 203, 467, 2024, N'vi', N'https://images.unsplash.com/photo-1491841573634-28140fc7ced7?auto=format&fit=crop&w=600&q=80', 1, 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (43, N'978-604-142-1042', N'Hành Trình Về Phương Đông', N'Chuyến đi thám hiểm khám phá những giá trị minh triết tâm linh Ấn Độ cổ xưa.', 128000.00, 102000.00, 36, 474, 2019, N'vi', N'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80', 1, 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (44, N'978-604-143-1043', N'Muôn Kiếp Nhân Sinh - Tập 2', N'Hồi kết về quy luật thức tỉnh tâm linh và tương lai của nhân loại.', 188000.00, 150000.00, 49, 481, 2020, N'vi', N'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80', 1, 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (45, N'978-604-144-1044', N'Dấu Chân Trên Cát', N'Hành trình tìm kiếm chân lý và sự giác ngộ qua nền văn minh Ai Cập cổ đại.', 138000.00, 110000.00, 62, 488, 2021, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (46, N'978-604-145-1045', N'Cha Giàu Cha Nghèo (Tập 1)', N'Cuốn sách dạy con làm giàu và tư duy tự do tài chính bán chạy nhất thế giới.', 125000.00, 99000.00, 75, 495, 2022, N'vi', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 1, 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (47, N'978-604-146-1046', N'Tâm Lý Học Về Tiền (The Psychology of Money)', N'Những bài học vĩnh cửu về sự giàu có, lòng tham và hạnh phúc tài chính.', 189000.00, 149000.00, 88, 502, 2023, N'vi', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (48, N'978-604-147-1047', N'Tư Duy Nhanh Và Chậm (Thinking, Fast and Slow)', N'Hai hệ thống tư duy chi phối mọi quyết định và phán đoán của con người.', 249000.00, 199000.00, 101, 509, 2024, N'vi', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (49, N'978-604-148-1048', N'Khởi Nghiệp Tinh Gọn (The Lean Startup)', N'Phương pháp xây dựng doanh nghiệp thành công bằng chu trình học hỏi nhanh.', 175000.00, 140000.00, 114, 516, 2019, N'vi', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (50, N'978-604-149-1049', N'Từ Tốt Đến Vĩ Đại (Good to Great)', N'Nghiên cứu kinh điển giải mã bí quyết đưa công ty bình thường vươn lên xuất chúng.', 190000.00, 152000.00, 127, 523, 2020, N'vi', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 1, 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (51, N'978-604-150-1050', N'Chiến Lược Đại Dương Xanh (Blue Ocean Strategy)', N'Cách tạo ra khoảng thị trường không có cạnh tranh và khiến đối thủ trở nên vô nghĩa.', 168000.00, 135000.00, 140, 530, 2021, N'vi', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (52, N'978-604-151-1051', N'Nhà Đầu Tư Thông Minh (The Intelligent Investor)', N'Kinh thánh về trường phái đầu tư giá trị của bậc thầy Benjamin Graham.', 290000.00, 230000.00, 153, 537, 2022, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (53, N'978-604-152-1052', N'Dốc Hết Trái Tim (Pour Your Heart Into It)', N'Hành trình xây dựng đế chế cà phê Starbucks từ tình yêu và sự tận tụy.', 155000.00, 124000.00, 166, 544, 2023, N'vi', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (54, N'978-604-153-1053', N'Cổ Phiếu Thường, Lợi Nhuận Phi Thường', N'Triết lý chọn cổ phiếu tăng trưởng đột phá của huyền thoại Philip Fisher.', 145000.00, 116000.00, 179, 551, 2024, N'vi', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (55, N'978-604-154-1054', N'Phi Lý Trí (Predictably Irrational)', N'Khám phá những động lực ẩn giấu đằng sau những quyết định mua sắm của chúng ta.', 165000.00, 132000.00, 192, 558, 2019, N'vi', N'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (56, N'978-604-155-1055', N'Dẫn Dắt Sự Thay Đổi (Leading Change)', N'Mô hình 8 bước chuyển đổi tổ chức của giáo sư Harvard John Kotter.', 140000.00, 112000.00, 205, 565, 2020, N'vi', N'https://images.unsplash.com/photo-1553729459-efe14ef6055d?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (57, N'978-604-156-1056', N'Nguyên Tắc (Principles) - Ray Dalio', N'Các nguyên tắc sống và làm việc đã giúp tạo nên quỹ đầu tư Bridgewater huyền thoại.', 380000.00, 304000.00, 38, 572, 2021, N'vi', N'https://images.unsplash.com/photo-1491841573634-28140fc7ced7?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (58, N'978-604-157-1057', N'Không Đến Một (Zero to One) - Peter Thiel', N'Bí quyết khởi nghiệp sáng tạo bằng cách tạo ra cái mới chưa từng có.', 148000.00, 118000.00, 51, 579, 2022, N'vi', N'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (59, N'978-604-158-1058', N'Nghệ Thuật Bán Hàng Bậc Cao', N'Bí quyết thuyết phục và chốt đơn đỉnh cao từ huyền thoại Zig Ziglar.', 138000.00, 110000.00, 64, 586, 2023, N'vi', N'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80', 1, 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (60, N'978-604-159-1059', N'Tuần Làm Việc 4 Giờ (The 4-Hour Workweek)', N'Tự động hóa thu nhập và tận hưởng cuộc sống tự do bất cứ nơi đâu.', 169000.00, 135000.00, 77, 593, 2024, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (61, N'978-604-160-1060', N'Người Giàu Có Nhất Thành Babylon', N'Những nguyên tắc quản lý tài chính trường tồn từ nền văn minh cổ đại.', 85000.00, 68000.00, 90, 600, 2019, N'vi', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 1, 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (62, N'978-604-161-1061', N'Bí Mật Tư Duy Triệu Phú', N'Cài đặt lại nhiệt kế tài chính trong tâm thức để đón nhận sự giàu có.', 120000.00, 96000.00, 103, 607, 2020, N'vi', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 1, 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (63, N'978-604-162-1062', N'Dạy Con Làm Giàu - Tập 2 (Sử Dụng Đồng Vốn)', N'Kim tứ đồ giải phóng bạn khỏi cạm bẫy làm thuê sang làm chủ đầu tư.', 135000.00, 108000.00, 116, 614, 2021, N'vi', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 1, 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (64, N'978-604-163-1063', N'Dạy Con Làm Giàu - Tập 3 (Hướng Dẫn Đầu Tư)', N'Cách các nhà đầu tư lão luyện biến đồng vốn thành cỗ máy sinh lời.', 145000.00, 116000.00, 129, 621, 2022, N'vi', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80', 1, 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (65, N'978-604-164-1064', N'Quản Trị Theo Phong Cách Intel (High Output Management)', N'Bí quyết tối ưu hóa hiệu suất làm việc đội nhóm của huyền thoại Andrew Grove.', 160000.00, 128000.00, 142, 628, 2023, N'vi', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (66, N'978-604-165-1065', N'Tỷ Phú Bán Giày (Delivering Happiness)', N'Văn hóa doanh nghiệp hướng tới niềm vui khách hàng của CEO Zappos Tony Hsieh.', 139000.00, 111000.00, 155, 185, 2024, N'vi', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 1, 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (67, N'978-604-166-1066', N'Để Xây Dựng Doanh Nghiệp Hiệu Quả (The E-Myth Revisited)', N'Vì sao hầu hết các doanh nghiệp nhỏ thất bại và cách khắc phục bền vững.', 130000.00, 104000.00, 168, 192, 2019, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (68, N'978-604-167-1067', N'Chiến Lược Giá (Priceless)', N'Nghệ thuật tâm lý học đằng sau việc định giá sản phẩm và dịch vụ.', 165000.00, 132000.00, 181, 199, 2020, N'vi', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (69, N'978-604-168-1068', N'Marketing Du Kích (Guerrilla Marketing)', N'Chiến lược quảng bá đạt hiệu quả tối đa với ngân sách tối thiểu.', 142000.00, 114000.00, 194, 206, 2021, N'vi', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (70, N'978-604-169-1069', N'Định Vị (Positioning: The Battle for Your Mind)', N'Chiếm lĩnh tâm trí khách hàng trước khi đối thủ kịp xuất hiện.', 150000.00, 120000.00, 207, 213, 2022, N'vi', N'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (71, N'978-604-170-1070', N'Tung Sản Phẩm (Launch) - Jeff Walker', N'Công thức tạo nên những đợt bùng nổ doanh số kỷ lục trong ngày ra mắt.', 158000.00, 126000.00, 40, 220, 2023, N'vi', N'https://images.unsplash.com/photo-1553729459-efe14ef6055d?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (72, N'978-604-171-1071', N'Kinh Tế Học Hài Hước (Freakonomics)', N'Góc nhìn kinh tế học dí dỏm giải thích những hiện tượng kỳ lạ trong đời sống.', 168000.00, 134000.00, 53, 227, 2024, N'vi', N'https://images.unsplash.com/photo-1491841573634-28140fc7ced7?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (73, N'978-604-172-1072', N'Kinh Tế Học Kỳ Quặc (SuperFreakonomics)', N'Tiếp tục giải mã bản chất hành vi con người bằng những con số bất ngờ.', 175000.00, 140000.00, 66, 234, 2019, N'vi', N'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (74, N'978-604-173-1073', N'Chiến Lược Kinh Doanh Tinh Gọn', N'Xây dựng mô hình kinh doanh nhanh nhạy thích ứng với kỷ nguyên số.', 145000.00, 116000.00, 79, 241, 2020, N'vi', N'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (75, N'978-604-174-1074', N'Blockchain - Bản Chất Của Cách Mạng Tài Chính', N'Toàn cảnh công nghệ chuỗi khối và tác động định hình lại hệ thống ngân hàng.', 185000.00, 148000.00, 92, 248, 2021, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (76, N'978-604-175-1075', N'Kinh Doanh Thời 4.0', N'Chiến lược chuyển đổi số và khai phá dữ liệu lớn để tăng trưởng bứt phá.', 160000.00, 128000.00, 105, 255, 2022, N'vi', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (77, N'978-604-176-1076', N'Thấu Hiểu Khách Hàng (Customer Understanding)', N'Phương pháp nghiên cứu insight khách hàng để tạo ra sản phẩm không thể từ chối.', 155000.00, 124000.00, 118, 262, 2023, N'vi', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (78, N'978-604-177-1077', N'Tối Ưu Hóa Chi Phí Vận Hành', N'Cắt giảm lãng phí và gia tăng biên lợi nhuận cho doanh nghiệp vừa và nhỏ.', 140000.00, 112000.00, 131, 269, 2024, N'vi', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (79, N'978-604-178-1078', N'Kỹ Năng Đàm Phán Thương Lượng Đỉnh Cao', N'Nghệ thuật đạt thỏa thuận đôi bên cùng có lợi trong mọi hợp đồng lớn.', 130000.00, 104000.00, 144, 276, 2019, N'vi', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80', 1, 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (80, N'978-604-179-1079', N'Lãnh Đạo Giỏi Không Cần Chức Quyền', N'Tạo sức ảnh hưởng tích cực từ chính năng lực và sự chân thành của bạn.', 148000.00, 118000.00, 157, 283, 2020, N'vi', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 1, 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (81, N'978-604-180-1080', N'Văn Hóa Tinh Gọn Trong Doanh Nghiệp', N'Xây dựng môi trường làm việc cởi mở, minh bạch và trao quyền tối đa.', 165000.00, 132000.00, 170, 290, 2021, N'vi', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (82, N'978-604-181-1081', N'Báo Cáo Tài Chính Dành Cho Người Không Chuyên', N'Đọc hiểu bảng cân đối kế toán và dòng tiền một cách dễ hiểu nhất.', 138000.00, 110000.00, 183, 297, 2022, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (83, N'978-604-182-1082', N'Quản Lý Dự Án Agile & Scrum Thực Chiến', N'Phương pháp triển khai dự án linh hoạt, giao hàng nhanh và đáp ứng tốt thay đổi.', 175000.00, 140000.00, 196, 304, 2023, N'vi', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (84, N'978-604-183-1083', N'Quản Trị Rủi Ro Trong Kinh Doanh', N'Xây dựng kịch bản ứng phó trước khủng hoảng kinh tế và biến động thị trường.', 160000.00, 128000.00, 209, 311, 2024, N'vi', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 1, 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (85, N'978-604-184-1084', N'Nghệ Thuật Xây Dựng Thương Hiệu Cá Nhân', N'Khẳng định uy tín và giá trị bản thân trong thị trường lao động cạnh tranh.', 125000.00, 100000.00, 42, 318, 2019, N'vi', N'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80', 1, 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (86, N'978-604-185-1085', N'Đắc Nhân Tâm', N'Nghệ thuật xử thế nhân văn thu phục lòng người trường tồn cùng năm tháng.', 96000.00, 75000.00, 55, 325, 2020, N'vi', N'https://images.unsplash.com/photo-1553729459-efe14ef6055d?auto=format&fit=crop&w=600&q=80', 1, 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (87, N'978-604-186-1086', N'Quẳng Gánh Lo Đi Và Vui Sống', N'Bí quyết hóa giải âu lo, làm chủ căng thẳng và tìm lại sự an nhiên nội tại.', 88000.00, 70000.00, 68, 332, 2021, N'vi', N'https://images.unsplash.com/photo-1491841573634-28140fc7ced7?auto=format&fit=crop&w=600&q=80', 1, 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (88, N'978-604-187-1087', N'Atomic Habits - Thay Đổi Tí Hon, Hiệu Quả Bất Ngờ', N'Phương pháp khoa học xây dựng thói quen tốt và triệt tiêu thói quen xấu.', 169000.00, 135000.00, 81, 339, 2022, N'vi', N'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80', 1, 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (89, N'978-604-188-1088', N'Tuổi Trẻ Đáng Giá Bao Nhiêu?', N'Cuốn sách truyền cảm hứng hành động, học tập và trải nghiệm cho người trẻ.', 95000.00, 76000.00, 94, 346, 2023, N'vi', N'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80', 1, 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (90, N'978-604-189-1089', N'Cà Phê Cùng Tony', N'Những câu chuyện ngắn hóm hỉnh rèn luyện tính tự lập, tác phong chuyên nghiệp.', 75000.00, 60000.00, 107, 353, 2024, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (91, N'978-604-190-1090', N'Trên Đường Băng', N'Tiếp thêm động lực cho tuổi trẻ cất cánh vươn mình ra biển lớn thế giới.', 82000.00, 65000.00, 120, 360, 2019, N'vi', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 1, 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (92, N'978-604-191-1091', N'Khi Hơi Thở Hóa Thinh Không (When Breath Becomes Air)', N'Hồi ký xúc động về ranh giới sinh tử của một bác sĩ phẫu thuật thần kinh tài hoa.', 125000.00, 100000.00, 133, 367, 2020, N'vi', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 1, 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (93, N'978-604-192-1092', N'Tìm Lại Lạc Quan (Man''s Search for Meaning)', N'Tìm ra ý nghĩa cuộc đời ngay giữa ngục tù thử thách khắc nghiệt nhất.', 115000.00, 92000.00, 146, 374, 2021, N'vi', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (94, N'978-604-193-1093', N'Sức Mạnh Của Hiện Tại (The Power of Now)', N'Buông bỏ quá khứ và lo âu tương lai để sống trọn vẹn trong từng khoảnh khắc.', 140000.00, 112000.00, 159, 381, 2022, N'vi', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80', 1, 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (95, N'978-604-194-1094', N'Một Cuộc Đời Đáng Sống (The Subtle Art of Not Giving a F*ck)', N'Học cách buông bỏ những điều phù phiếm để tập trung vào giá trị cốt lõi.', 135000.00, 108000.00, 172, 388, 2023, N'vi', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (96, N'978-604-195-1095', N'Dám Bị Ghét', N'Tâm lý học Adler khai mở can đảm để sống tự do và hạnh phúc đích thực.', 110000.00, 88000.00, 185, 395, 2024, N'vi', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 1, 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (97, N'978-604-196-1096', N'Dám Hạnh Phúc', N'Tiếp nối Dám Bị Ghét với những chỉ dẫn cụ thể để xây dựng các mối quan hệ hòa hợp.', 115000.00, 92000.00, 198, 402, 2019, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (98, N'978-604-197-1097', N'Tư Duy Ngược (Lateral Thinking)', N'Khai phóng tư duy sáng tạo bằng cách tiếp cận vấn đề từ góc nhìn bất ngờ.', 128000.00, 102000.00, 31, 409, 2020, N'vi', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (99, N'978-604-198-1098', N'Hiểu Về Trái Tim', N'Soi sáng những ngóc ngách tâm lý để chuyển hóa khổ đau thành an lạc.', 145000.00, 116000.00, 44, 416, 2021, N'vi', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 1, 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (100, N'978-604-199-1099', N'Hạnh Phúc Đích Thực', N'Nghệ thuật nuôi dưỡng bình an nội tâm và lòng từ bi trong cuộc sống.', 120000.00, 96000.00, 57, 423, 2022, N'vi', N'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80', 1, 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (101, N'978-604-200-1100', N'Sức Mạnh Của Tĩnh Lặng', N'Tìm về điểm tĩnh lặng bên trong để đưa ra những quyết định sáng suốt nhất.', 125000.00, 100000.00, 70, 430, 2023, N'vi', N'https://images.unsplash.com/photo-1553729459-efe14ef6055d?auto=format&fit=crop&w=600&q=80', 1, 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (102, N'978-604-201-1101', N'Tâm Lý Học Tội Phạm', N'Giải mã những động cơ hành vi và diễn biến tâm lý phức tạp của tội phạm.', 168000.00, 134000.00, 83, 437, 2024, N'vi', N'https://images.unsplash.com/photo-1491841573634-28140fc7ced7?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (103, N'978-604-202-1102', N'Nghệ Thuật Lắng Nghe', N'Lắng nghe chân thành là chiếc chìa khóa vạn năng mở cửa mọi trái tim.', 95000.00, 76000.00, 96, 444, 2019, N'vi', N'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80', 1, 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (104, N'978-604-203-1103', N'Trí Tuệ Cảm Xúc 2.0 (Emotional Intelligence 2.0)', N'Rèn luyện EQ để thành công trong sự nghiệp và thấu hiểu chính mình.', 142000.00, 114000.00, 109, 451, 2020, N'vi', N'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (105, N'978-604-204-1104', N'Đọc Vị Bất Kỳ Ai', N'Kỹ năng nhận biết tâm lý đối phương chỉ qua ngôn ngữ cơ thể và ánh mắt.', 98000.00, 78000.00, 122, 458, 2021, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (106, N'978-604-205-1105', N'Nghệ Thuật Giao Tiếp Để Thành Công', N'96 thủ thuật tinh tế giúp bạn tự tin tỏa sáng trong mọi cuộc trò chuyện.', 110000.00, 88000.00, 135, 465, 2022, N'vi', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 1, 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (107, N'978-604-206-1106', N'Thôi Miên Bằng Ngôn Từ', N'Sức mạnh của câu chữ trong việc thuyết phục và chạm đến cảm xúc người nghe.', 155000.00, 124000.00, 148, 472, 2023, N'vi', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (108, N'978-604-207-1107', N'Quản Lý Thời Gian Thông Minh', N'Sắp xếp thứ tự ưu tiên và đánh bại thói quen trì hoãn mỗi ngày.', 118000.00, 94000.00, 161, 479, 2024, N'vi', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (109, N'978-604-208-1108', N'Kỷ Luật Tự Giác (Self-Discipline)', N'Cầu nối duy nhất biến ước mơ trừu tượng thành kết quả hữu hình.', 130000.00, 104000.00, 174, 486, 2019, N'vi', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (110, N'978-604-209-1109', N'Chữa Lành Đứa Trẻ Bên Trong Bạn', N'Nhận diện những tổn thương thời thơ ấu để sống trọn vẹn và an yên.', 145000.00, 116000.00, 187, 493, 2020, N'vi', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (111, N'978-604-210-1110', N'Không Diệt Không Sinh Đừng Sợ Hãi', N'Cái nhìn sâu sắc xua tan nỗi sợ hãi cái chết và chia ly của Thiền sư Thích Nhất Hạnh.', 110000.00, 88000.00, 200, 500, 2021, N'vi', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 1, 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (112, N'978-604-211-1111', N'Bước Chậm Lại Giữa Thế Gian Vội Vã', N'Những lời khuyên an ủi tâm hồn giữa cuộc sống hiện đại đầy hối hả.', 98000.00, 78000.00, 33, 507, 2022, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (113, N'978-604-212-1112', N'Yêu Những Điều Không Hoàn Hảo', N'Bao dung với những khiếm khuyết của bản thân và những người xung quanh.', 105000.00, 84000.00, 46, 514, 2023, N'vi', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 1, 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (114, N'978-604-213-1113', N'Sống Thực Tế Giữa Đời Thực Dụng', N'Giữ cho mình một tâm hồn trong sáng mà không ngây thơ trước cám dỗ.', 112000.00, 89000.00, 59, 521, 2024, N'vi', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (115, N'978-604-214-1114', N'Tâm Lý Học Đám Đông (The Crowd)', N'Phân tích kinh điển của Gustave Le Bon về hành vi bầy đàn của số đông.', 135000.00, 108000.00, 72, 528, 2019, N'vi', N'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80', 1, 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (116, N'978-604-215-1115', N'Tư Duy Sâu (Deep Thinking)', N'Vượt qua sự hời hợt của kỷ nguyên số để rèn luyện năng lực tư duy bản chất.', 148000.00, 118000.00, 85, 535, 2020, N'vi', N'https://images.unsplash.com/photo-1553729459-efe14ef6055d?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (117, N'978-604-216-1116', N'Làm Chủ Cảm Xúc (Master Your Emotions)', N'Chiến lược quản trị giận dữ, thất vọng và xây dựng tinh thần lạc quan.', 125000.00, 100000.00, 98, 542, 2021, N'vi', N'https://images.unsplash.com/photo-1491841573634-28140fc7ced7?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (118, N'978-604-217-1117', N'Nghệ Thuật Tư Duy Rành Mạch', N'Nhận diện 52 lỗi tư duy phổ biến khiến chúng ta đưa ra quyết định sai lầm.', 140000.00, 112000.00, 111, 549, 2022, N'vi', N'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80', 1, 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (119, N'978-604-218-1118', N'Khí Chất Bao Nhiêu, Hạnh Phúc Bấy Nhiêu', N'Nuôi dưỡng sự độc lập, tự tin và kiêu hãnh của phụ nữ hiện đại.', 108000.00, 86000.00, 124, 556, 2023, N'vi', N'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (120, N'978-604-219-1119', N'Bạn Đắt Giá Bao Nhiêu?', N'Lời nhắc nhở giá trị bản thân không phụ thuộc vào ánh nhìn của người khác.', 115000.00, 92000.00, 137, 563, 2024, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (121, N'978-604-220-1120', N'Tìm Mình Trong Thế Giới Hậu Tuổi Thơ', N'Hành trình định vị bản thân và chữa lành cho những người trẻ chông chênh.', 128000.00, 102000.00, 150, 570, 2019, N'vi', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 1, 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (122, N'978-604-221-1121', N'Đừng Lựa Chọn An Nhàn Khi Còn Trẻ', N'Đánh thức khát vọng cống hiến và nỗ lực hết mình cho tương lai.', 95000.00, 76000.00, 163, 577, 2020, N'vi', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (123, N'978-604-222-1122', N'Học Cách Nói Không', N'Thiết lập ranh giới lành mạnh để bảo vệ thời gian và năng lượng của bạn.', 90000.00, 72000.00, 176, 584, 2021, N'vi', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 1, 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (124, N'978-604-223-1123', N'Nghệ Thuật Tối Giản Trong Cuộc Sống (Danshari)', N'Dọn dẹp không gian sống để mở rộng không gian tâm trí.', 102000.00, 81000.00, 189, 591, 2022, N'vi', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80', 1, 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (125, N'978-604-224-1124', N'Tự Tin Trong 60 Giây', N'Các bài tập thực hành kích hoạt sự tự tin ngay trước mỗi cuộc phỏng vấn quan trọng.', 85000.00, 68000.00, 202, 598, 2023, N'vi', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 1, 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (126, N'978-604-225-1125', N'Clean Code - Mã Sạch', N'Cẩm nang hướng dẫn viết code tinh gọn, dễ bảo trì cho kỹ sư phần mềm.', 295000.00, 236000.00, 35, 605, 2024, N'vi', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (127, N'978-604-226-1126', N'Clean Architecture - Kiến Trúc Phần Mềm Sạch', N'Quy tắc thiết kế cấu trúc hệ thống độc lập framework, database và UI.', 320000.00, 256000.00, 48, 612, 2019, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (128, N'978-604-227-1127', N'Refactoring - Tối Ưu Hóa Mã Nguồn Hiện Có', N'Nghệ thuật cải thiện thiết kế mã nguồn mà không làm thay đổi hành vi bên ngoài.', 310000.00, 248000.00, 61, 619, 2020, N'vi', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (129, N'978-604-228-1128', N'Design Patterns - 23 Mẫu Thiết Kế Hướng Đối Tượng', N'Kinh thánh về giải pháp kiến trúc giải quyết các bài toán thiết kế kinh điển.', 350000.00, 280000.00, 74, 626, 2021, N'vi', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (130, N'978-604-229-1129', N'Lập Trình .NET 10 & C# 14 Toàn Tập', N'Hướng dẫn toàn diện xây dựng Web API, Microservices với ASP.NET Core 10.', 280000.00, 224000.00, 87, 183, 2022, N'vi', N'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (131, N'978-604-230-1130', N'React 19 & Next.js Thực Chiến', N'Xây dựng ứng dụng web hiện đại với React Server Components và Tailwind CSS.', 260000.00, 208000.00, 100, 190, 2023, N'vi', N'https://images.unsplash.com/photo-1553729459-efe14ef6055d?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (132, N'978-604-231-1131', N'Học Sâu & Trí Tuệ Nhân Tạo (Deep Learning)', N'Giáo trình nền tảng về mạng nơ-ron, thị giác máy tính và xử lý ngôn ngữ tự nhiên.', 380000.00, 304000.00, 113, 197, 2024, N'vi', N'https://images.unsplash.com/photo-1491841573634-28140fc7ced7?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (133, N'978-604-232-1132', N'Nhập Môn Học Máy Với Python (Machine Learning with Python)', N'Thực hành xây dựng mô hình dự đoán với Scikit-Learn và TensorFlow.', 275000.00, 220000.00, 126, 204, 2019, N'vi', N'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (134, N'978-604-233-1133', N'Docker & Kubernetes Toàn Diện', N'Đóng gói container và điều phối cụm microservices trong môi trường Production.', 290000.00, 232000.00, 139, 211, 2020, N'vi', N'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (135, N'978-604-234-1134', N'DevOps Thực Chiến: CI/CD Với Jenkins & GitHub Actions', N'Xây dựng pipeline tự động hóa kiểm thử, đóng gói và triển khai đám mây.', 265000.00, 212000.00, 152, 218, 2021, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (136, N'978-604-235-1135', N'Cơ Sở Dữ Liệu SQL Server & T-SQL Nâng Cao', N'Tối ưu hóa truy vấn, lập chỉ mục Indexing và quản trị hiệu năng CSDL.', 250000.00, 200000.00, 165, 225, 2022, N'vi', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (137, N'978-604-236-1136', N'Thiết Kế Hệ Thống Quy Mô Lớn (System Design Interview)', N'Bí quyết kiến trúc hệ thống phục vụ hàng triệu người dùng đồng thời.', 330000.00, 264000.00, 178, 232, 2023, N'vi', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (138, N'978-604-237-1137', N'Lập Trình Microservices Với .NET & RabbitMQ', N'Xây dựng kiến trúc hướng sự kiện (Event-Driven) chịu tải cao.', 295000.00, 236000.00, 191, 239, 2024, N'vi', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (139, N'978-604-238-1138', N'An Toàn Thông Tin & Hacker Mũ Trắng', N'Các kỹ thuật kiểm thử xâm nhập (Penetration Testing) và phòng thủ mạng.', 240000.00, 192000.00, 204, 246, 2019, N'vi', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (140, N'978-604-239-1139', N'Cấu Trúc Dữ Liệu & Giải Thuật Thực Hành', N'Nền tảng vững chắc để vượt qua các kỳ phỏng vấn thuật toán tại các tập đoàn công nghệ.', 210000.00, 168000.00, 37, 253, 2020, N'vi', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (141, N'978-604-240-1140', N'Lập Trình Hướng Đối Tượng C++ Hiện Đại', N'Làm chủ con trỏ thông minh, bộ nhớ và các tính năng từ C++11 đến C++20.', 225000.00, 180000.00, 50, 260, 2021, N'vi', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (142, N'978-604-241-1141', N'Lập Trình Python Từ Cơ Bản Đến Nâng Cao', N'Ngôn ngữ đa năng cho phân tích dữ liệu, tự động hóa và phát triển web.', 195000.00, 156000.00, 63, 267, 2022, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (143, N'978-604-242-1142', N'Kỹ Nghệ Dữ Liệu (Data Engineering Essentials)', N'Xây dựng data pipeline ETL với Spark, Kafka và Airflow.', 310000.00, 248000.00, 76, 274, 2023, N'vi', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (144, N'978-604-243-1143', N'Phân Tích Dữ Liệu Với Pandas & SQL', N'Biến dữ liệu thô thành những báo cáo phân tích kinh doanh giá trị.', 235000.00, 188000.00, 89, 281, 2024, N'vi', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (145, N'978-604-244-1144', N'Cloud Computing Với AWS & Azure', N'Thiết kế hạ tầng đám mây không máy chủ (Serverless) chuẩn Well-Architected.', 315000.00, 252000.00, 102, 288, 2019, N'vi', N'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (146, N'978-604-245-1145', N'Lập Trình Di Động Flutter & Dart', N'Xây dựng ứng dụng native đa nền tảng iOS & Android chỉ với một mã nguồn.', 245000.00, 196000.00, 115, 295, 2020, N'vi', N'https://images.unsplash.com/photo-1553729459-efe14ef6055d?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (147, N'978-604-246-1146', N'Node.js & Express - Xây Dựng RESTful API', N'Tận dụng cơ chế non-blocking I/O để xây dựng backend tốc độ cao.', 215000.00, 172000.00, 128, 302, 2021, N'vi', N'https://images.unsplash.com/photo-1491841573634-28140fc7ced7?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (148, N'978-604-247-1147', N'TypeScript Cho Người Mới Bắt Đầu', N'Thêm sức mạnh type-safety cho dự án JavaScript của bạn.', 185000.00, 148000.00, 141, 309, 2022, N'vi', N'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (149, N'978-604-248-1148', N'Tối Ưu Hóa SEO Cho Lập Trình Viên Web', N'Kỹ thuật tối ưu hóa Core Web Vitals và cấu trúc dữ liệu cho công cụ tìm kiếm.', 170000.00, 136000.00, 154, 316, 2023, N'vi', N'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (150, N'978-604-249-1149', N'Kiểm Thử Phần Mềm Tự Động Với Selenium & Playwright', N'Viết kịch bản test E2E bảo đảm chất lượng phần mềm liên tục.', 220000.00, 176000.00, 167, 323, 2024, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (151, N'978-604-250-1150', N'Git & GitHub Thực Chiến Trong Doanh Nghiệp', N'Quy trình làm việc nhóm với Gitflow, Trunk-based và Pull Request.', 150000.00, 120000.00, 180, 330, 2019, N'vi', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (152, N'978-604-251-1151', N'GraphQL - Ngôn Ngữ Truy Vấn Dữ Liệu Thế Hệ Mới', N'Giải pháp thay thế linh hoạt cho kiến trúc REST API truyền thống.', 210000.00, 168000.00, 193, 337, 2020, N'vi', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (153, N'978-604-252-1152', N'Lập Trình Java Spring Boot 3', N'Phát triển ứng dụng doanh nghiệp ổn định và mở rộng mạnh mẽ.', 285000.00, 228000.00, 206, 344, 2021, N'vi', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (154, N'978-604-253-1153', N'Thuật Toán Xử Lý Ảnh Với OpenCV', N'Nhận diện khuôn mặt, phát hiện đối tượng trong video thời gian thực.', 260000.00, 208000.00, 39, 351, 2022, N'vi', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (155, N'978-604-254-1154', N'Xử Lý Ngôn Ngữ Tự Nhiên Với Transformers', N'Fine-tuning mô hình ngôn ngữ lớn (LLM) và ứng dụng hỏi đáp tự động.', 340000.00, 272000.00, 52, 358, 2023, N'vi', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (156, N'978-604-255-1155', N'Phát Triển Web UI Với Tailwind CSS', N'Xây dựng giao diện web phản hồi nhanh (Responsive) thần tốc.', 175000.00, 140000.00, 65, 365, 2024, N'vi', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (157, N'978-604-256-1156', N'Redis Trong Thực Tế: Caching & Message Queue', N'Tăng tốc độ hệ thống lên gấp 10 lần nhờ bộ nhớ đệm In-Memory.', 225000.00, 180000.00, 78, 372, 2019, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (158, N'978-604-257-1157', N'Quản Lý Cấu Hình Máy Chủ Với Ansible', N'Tự động hóa triển khai hạ tầng máy chủ hàng loạt bằng mã (IaC).', 210000.00, 168000.00, 91, 379, 2020, N'vi', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (159, N'978-604-258-1158', N'Lập Trình Linux & Shell Scripting', N'Khai phá sức mạnh dòng lệnh Bash để quản trị hệ thống chuyên nghiệp.', 190000.00, 152000.00, 104, 386, 2021, N'vi', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (160, N'978-604-259-1159', N'Kỹ Năng Giải Quyết Vấn Đề Cho Kỹ Sư Công Nghệ', N'Tư duy phản biện và phương pháp luận gỡ lỗi (Debugging) trong hệ thống phức tạp.', 165000.00, 132000.00, 117, 393, 2022, N'vi', N'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80', 1, 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (161, N'978-604-260-1160', N'Sapiens: Lược Sử Loài Người', N'Hành trình tiến hóa và thống trị hành tinh ngoạn mục của loài người.', 219000.00, 175000.00, 130, 400, 2023, N'vi', N'https://images.unsplash.com/photo-1553729459-efe14ef6055d?auto=format&fit=crop&w=600&q=80', 1, 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (162, N'978-604-261-1161', N'Homo Deus: Lược Sử Tương Lai', N'Những kịch bản tương lai khi nhân loại làm chủ công nghệ sinh học và AI.', 229000.00, 183000.00, 143, 407, 2024, N'vi', N'https://images.unsplash.com/photo-1491841573634-28140fc7ced7?auto=format&fit=crop&w=600&q=80', 1, 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (163, N'978-604-262-1162', N'21 Bài Học Cho Thế Kỷ 21', N'Những thách thức cấp bách về chính trị, công nghệ và bản sắc nhân loại.', 199000.00, 159000.00, 156, 414, 2019, N'vi', N'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80', 1, 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (164, N'978-604-263-1163', N'Súng, Vi Trùng Và Thép (Guns, Germs, and Steel)', N'Nghiên cứu về số phận các xã hội loài người dưới tác động của địa lý.', 235000.00, 188000.00, 169, 421, 2020, N'vi', N'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80', 1, 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (165, N'978-604-264-1164', N'Việt Nam Sử Lược', N'Bộ thông sử Việt Nam đầu tiên viết bằng chữ quốc ngữ của Trần Trọng Kim.', 165000.00, 132000.00, 182, 428, 2021, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 5, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (166, N'978-604-265-1165', N'Đại Việt Sử Ký Toàn Thư (Bản Rút Gọn)', N'Di sản sử học quý báu ghi chép lịch sử dân tộc từ thời Hồng Bàng.', 290000.00, 232000.00, 195, 435, 2022, N'vi', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 1, 5, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (167, N'978-604-266-1166', N'Lịch Sử Văn Minh Thế Giới', N'Hành trình phát triển rực rỡ của các nền văn minh phương Đông và phương Tây.', 320000.00, 256000.00, 208, 442, 2023, N'vi', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (168, N'978-604-267-1167', N'Cộng Hòa (The Republic) - Plato', N'Tác phẩm triết học kinh điển bàn về công lý, nhà nước lý tưởng và giáo dục.', 210000.00, 168000.00, 41, 449, 2024, N'vi', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (169, N'978-604-268-1168', N'Bàn Về Tự Do (On Liberty) - John Stuart Mill', N'Luận thuyết nền tảng bảo vệ tự do tư tưởng và quyền cá nhân.', 135000.00, 108000.00, 54, 456, 2019, N'vi', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (170, N'978-604-269-1169', N'Khế Ước Xã Hội (The Social Contract) - Rousseau', N'Tư tưởng triết học chính trị truyền cảm hứng cho cuộc Cách mạng Pháp.', 140000.00, 112000.00, 67, 463, 2020, N'vi', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (171, N'978-604-270-1170', N'Lịch Sử Triết Học Phương Tây', N'Toàn cảnh tư tưởng triết học từ Hy Lạp cổ đại đến thế kỷ 20 của Bertrand Russell.', 350000.00, 280000.00, 80, 470, 2021, N'vi', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (172, N'978-604-271-1171', N'Đạo Đức Kinh - Lão Tử', N'Minh triết phương Đông về lẽ vô vi và quy luật vận hành của trời đất.', 115000.00, 92000.00, 93, 477, 2022, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (173, N'978-604-272-1172', N'Luận Ngữ - Khổng Tử', N'Những lời dạy cốt lõi về nhân, nghĩa, lễ, trí của Nho gia.', 125000.00, 100000.00, 106, 484, 2023, N'vi', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (174, N'978-604-273-1173', N'Tư Mã Thiên - Sử Ký', N'Kiệt tác sử học và văn học vĩ đại ghi chép lịch sử Trung Hoa cổ đại.', 280000.00, 224000.00, 119, 491, 2024, N'vi', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (175, N'978-604-274-1174', N'Binh Pháp Tôn Tử', N'Nghệ thuật quân sự và triết lý chiến lược mưu lược đỉnh cao muôn đời.', 98000.00, 78000.00, 132, 498, 2019, N'vi', N'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (176, N'978-604-275-1175', N'Con Đường Tơ Lụa (The Silk Roads)', N'Một lịch sử mới của thế giới nhìn từ ngã tư các tuyến đường giao thương.', 265000.00, 212000.00, 145, 505, 2020, N'vi', N'https://images.unsplash.com/photo-1553729459-efe14ef6055d?auto=format&fit=crop&w=600&q=80', 1, 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (177, N'978-604-276-1176', N'Sử Lược Nước Mỹ', N'Hành trình từ thuộc địa trở thành siêu cường kinh tế của Hợp chủng quốc Hoa Kỳ.', 195000.00, 156000.00, 158, 512, 2021, N'vi', N'https://images.unsplash.com/photo-1491841573634-28140fc7ced7?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (178, N'978-604-277-1177', N'Đông Dương Cổ Đại', N'Khảo cứu công phu về khảo cổ học và các nền văn hóa cổ xưa trên bán đảo.', 180000.00, 144000.00, 171, 519, 2022, N'vi', N'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (179, N'978-604-278-1178', N'Lịch Sử Hà Nội Qua Những Con Đường', N'Ký ức ngàn năm Thăng Long soi chiếu qua từng con phố rêu phong.', 145000.00, 116000.00, 184, 526, 2023, N'vi', N'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (180, N'978-604-279-1179', N'Sài Gòn - Gia Định Xưa', N'Những trang sử và phong tục tập quán hào sảng của đất phương Nam.', 155000.00, 124000.00, 197, 533, 2024, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 5, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (181, N'978-604-280-1180', N'Những Nhân Vật Làm Thay Đổi Lịch Sử Thế Giới', N'Tiểu sử và tầm ảnh hưởng của 100 vĩ nhân định hình nhân loại.', 190000.00, 152000.00, 30, 540, 2019, N'vi', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (182, N'978-604-281-1181', N'Chiến Tranh Thế Giới Thứ Hai', N'Toàn cảnh cuộc chiến đẫm máu nhất trong lịch sử nhân loại.', 340000.00, 272000.00, 43, 547, 2020, N'vi', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (183, N'978-604-282-1182', N'Văn Minh Maya - Bí Ẩn Về Sự Suy Tàn', N'Khám phá khoa học thiên văn và sự biến mất kỳ lạ của đế chế Trung Mỹ.', 160000.00, 128000.00, 56, 554, 2021, N'vi', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (184, N'978-604-283-1183', N'Hy Lạp Cổ Đại - Cái Nôi Dân Chủ', N'Khám phá thần thoại, triết học và kiến trúc đỉnh cao của người Hy Lạp.', 175000.00, 140000.00, 69, 561, 2022, N'vi', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (185, N'978-604-284-1184', N'La Mã Cổ Đại - Từ Nền Cộng Hòa Tới Đế Chế', N'Sức mạnh quân sự và luật pháp kiến tạo nên đế chế vĩ đại bậc nhất thế giới.', 215000.00, 172000.00, 82, 568, 2023, N'vi', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 1, 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (186, N'978-604-285-1185', N'Dế Mèn Phiêu Lưu Ký (Ấn Bản Kỷ Niệm Bìa Cứng)', N'Phiên bản minh họa màu tuyệt đẹp của tác phẩm văn học thiếu nhi kinh điển.', 95000.00, 76000.00, 95, 575, 2024, N'vi', N'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80', 1, 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (187, N'978-604-286-1186', N'Chuyện Con Mèo Dạy Hải Âu Bay', N'Bài học sâu sắc về tình mẫu tử, lời hứa và lòng dũng cảm vượt qua định kiến.', 65000.00, 52000.00, 108, 582, 2019, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 6, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (188, N'978-604-287-1187', N'Góc Sân Và Khoảng Trời', N'Những vần thơ tuổi thơ trong trẻo, hồn nhiên của thần đồng thơ Trần Đăng Khoa.', 85000.00, 68000.00, 121, 589, 2020, N'vi', N'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80', 1, 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (189, N'978-604-288-1188', N'Bác Sĩ Dolittle & Những Động Vật Kỳ Lạ', N'Hành trình chữa bệnh đầy tiếng cười của vị bác sĩ hiểu được tiếng muông thú.', 75000.00, 60000.00, 134, 596, 2021, N'vi', N'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80', 1, 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (190, N'978-604-289-1189', N'Alice Ở Xứ Sở Thần Tiên (Alice in Wonderland)', N'Chuyến phiêu lưu vào hang thỏ kỳ diệu đầy màu sắc tưởng tượng.', 90000.00, 72000.00, 147, 603, 2022, N'vi', N'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80', 1, 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (191, N'978-604-290-1190', N'Peter Pan - Cậu Bé Không Bao Giờ Lớn', N'Vùng đất Neverland kỳ ảo nơi tuổi thơ được lưu giữ mãi mãi.', 80000.00, 64000.00, 160, 610, 2023, N'vi', N'https://images.unsplash.com/photo-1553729459-efe14ef6055d?auto=format&fit=crop&w=600&q=80', 1, 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (192, N'978-604-291-1191', N'Khu Vườn Bí Mật (The Secret Garden)', N'Sức mạnh diệu kỳ của thiên nhiên và tình bạn làm hồi sinh những trái tim cô độc.', 110000.00, 88000.00, 173, 617, 2024, N'vi', N'https://images.unsplash.com/photo-1491841573634-28140fc7ced7?auto=format&fit=crop&w=600&q=80', 1, 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (193, N'978-604-292-1192', N'Gió Qua Rặng Liễu (The Wind in the Willows)', N'Tình bạn ấm áp giữa bác Chuột Chũi, Chuột Nước và chàng Cóc ngổ ngáo.', 105000.00, 84000.00, 186, 624, 2019, N'vi', N'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80', 1, 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (194, N'978-604-293-1193', N'Pippi Tất Dài (Pippi Longstocking)', N'Cô bé tóc đỏ nghịch ngợm, khỏe nhất thế giới với trái tim hào hiệp.', 95000.00, 76000.00, 199, 181, 2020, N'vi', N'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80', 1, 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (195, N'978-604-294-1194', N'Charlie Và Nhà Máy Sôcôla', N'Tấm vé vàng mở ra thế giới ngọt ngào đầy bất ngờ của ngài Willy Wonka.', 85000.00, 68000.00, 32, 188, 2021, N'vi', N'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80', 1, 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (196, N'978-604-295-1195', N'Cô Bé Quàng Khăn Đỏ & Cổ Tích Grimm', N'Tuyển tập những câu chuyện cổ tích nuôi dưỡng ước mơ của mọi thế hệ.', 115000.00, 92000.00, 45, 195, 2022, N'vi', N'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80', 1, 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (197, N'978-604-296-1196', N'Cổ Tích Andersen Chọn Lọc', N'Nàng tiên cá, Chú vịt con xấu xí và những câu chuyện nhân ái bất hủ.', 120000.00, 96000.00, 58, 202, 2023, N'vi', N'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80', 1, 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (198, N'978-604-297-1197', N'Nghìn Lẻ Một Đêm (Ấn Bản Thiếu Nhi)', N'Kho tàng thần thoại Ả Rập với Aladdin, Ali Baba và Sinbad dũng cảm.', 135000.00, 108000.00, 71, 209, 2024, N'vi', N'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80', 1, 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (199, N'978-604-298-1198', N'Đất Rừng Phương Nam', N'Hành trình tìm cha đầy gian truân nhưng ấm áp nghĩa tình của cậu bé An.', 100000.00, 80000.00, 84, 216, 2019, N'vi', N'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80', 1, 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) VALUES (200, N'978-604-299-1199', N'Totto-chan Bên Cửa Sổ', N'Ngôi trường Tomoe mơ ước với phương pháp giáo dục tôn trọng cá tính trẻ thơ.', 108000.00, 86000.00, 97, 223, 2020, N'vi', N'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80', 1, 6, 2);
SET IDENTITY_INSERT [dbo].[Books] OFF;
GO

-- 9. LINK BOOK AUTHORS
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (1, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (2, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (3, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (4, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (5, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (6, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (7, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (8, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (9, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (10, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (11, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (12, 12);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (13, 12);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (14, 17);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (15, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (16, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (17, 13);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (18, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (19, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (20, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (21, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (22, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (23, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (24, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (25, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (26, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (27, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (28, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (29, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (30, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (31, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (32, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (33, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (34, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (35, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (36, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (37, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (38, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (39, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (40, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (41, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (42, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (43, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (44, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (45, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (46, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (47, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (48, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (49, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (50, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (51, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (52, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (53, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (54, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (55, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (56, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (57, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (58, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (59, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (60, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (61, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (62, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (63, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (64, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (65, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (66, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (67, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (68, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (69, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (70, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (71, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (72, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (73, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (74, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (75, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (76, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (77, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (78, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (79, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (80, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (81, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (82, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (83, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (84, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (85, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (86, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (87, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (88, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (89, 23);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (90, 24);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (91, 24);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (92, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (93, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (94, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (95, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (96, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (97, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (98, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (99, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (100, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (101, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (102, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (103, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (104, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (105, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (106, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (107, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (108, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (109, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (110, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (111, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (112, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (113, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (114, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (115, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (116, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (117, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (118, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (119, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (120, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (121, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (122, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (123, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (124, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (125, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (126, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (127, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (128, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (129, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (130, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (131, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (132, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (133, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (134, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (135, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (136, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (137, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (138, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (139, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (140, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (141, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (142, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (143, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (144, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (145, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (146, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (147, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (148, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (149, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (150, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (151, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (152, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (153, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (154, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (155, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (156, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (157, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (158, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (159, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (160, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (161, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (162, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (163, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (164, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (165, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (166, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (167, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (168, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (169, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (170, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (171, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (172, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (173, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (174, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (175, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (176, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (177, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (178, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (179, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (180, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (181, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (182, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (183, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (184, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (185, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (186, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (187, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (188, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (189, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (190, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (191, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (192, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (193, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (194, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (195, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (196, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (197, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (198, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (199, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (200, 8);
GO

-- 10. INSERT REVIEWS
INSERT INTO [dbo].[Reviews] ([UserId], [BookId], [Rating], [Comment], [CreatedAt])
VALUES 
(2, 1, 5, N'Một tác phẩm làm thay đổi cách tôi nhìn nhận số phận và ước mơ.', DATEADD(day, -10, GETUTCDATE())),
(2, 2, 5, N'Sách gối đầu giường về nghệ thuật sống và giao tiếp.', DATEADD(day, -8, GETUTCDATE())),
(2, 3, 5, N'Kiến thức sử học đồ sộ nhưng diễn đạt vô cùng hấp dẫn!', DATEADD(day, -5, GETUTCDATE())),
(2, 4, 5, N'Phương pháp xây dựng thói quen quá hay và thực tế.', DATEADD(day, -3, GETUTCDATE())),
(2, 5, 5, N'Bản dịch xuất sắc, in ấn đẹp, giao hàng rất nhanh.', DATEADD(day, -1, GETUTCDATE()));
GO

PRINT '=======================================================';
PRINT '   SEEDED SUCCESSFULLY 200 BOOKS INTO BOOKSTOREDB!    ';
PRINT '=======================================================';
