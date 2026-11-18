-- =====================================================================
-- SEED SCRIPT: EXPAND BOOKSTORE DATABASE TO 1000 BOOKS
-- =====================================================================
USE [BookstoreDb];
SET NOCOUNT ON;
GO

-- 1. INSERT PROMINENT AUTHORS (IDs 26 to 40)
SET IDENTITY_INSERT [dbo].[Authors] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 26)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (26, N'Victor Hugo', N'Pháp', N'Đại văn hào chủ nghĩa lãng mạn, tác giả Những Người Khốn Khổ và Nhà Thờ Đức Bà Paris.');
END;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 27)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (27, N'Arthur Conan Doyle', N'Anh', N'Bác sĩ kiêm nhà văn, cha đẻ của thám tử lừng danh Sherlock Holmes.');
END;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 28)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (28, N'Lev Tolstoy', N'Nga', N'Đại văn hào hiện thực vĩ đại, tác giả Chiến Tranh Và Hòa Bình, Anna Karenina.');
END;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 29)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (29, N'J.K. Rowling', N'Anh', N'Nữ văn sĩ người Anh, tác giả bộ truyện phù thủy huyền thoại Harry Potter.');
END;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 30)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (30, N'Dan Brown', N'Mỹ', N'Bậc thầy tiểu thuyết trinh thám trí tuệ và giải mã biểu tượng học.');
END;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 31)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (31, N'Walter Isaacson', N'Mỹ', N'Nhà viết tiểu sử kiệt xuất của Steve Jobs, Elon Musk, Leonardo da Vinci.');
END;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 32)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (32, N'Malcolm Gladwell', N'Canada', N'Nhà báo, tác giả các ấn phẩm tư duy kinh điển Điểm Bùng Phát, Những Kẻ Xuất Chúng.');
END;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 33)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (33, N'Thích Nhất Hạnh', N'Việt Nam', N'Thiền sư lỗi lạc quốc tế, tác giả Giận, An Lạc Từng Bước Chân, Hiểu Về Trái Tim.');
END;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 34)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (34, N'Marcus Aurelius', N'La Mã', N'Hoàng đế kiêm triết gia Khắc Kỷ lừng danh của đế chế La Mã cổ đại.');
END;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 35)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (35, N'Sun Tzu (Tôn Tử)', N'Trung Quốc', N'Danh tướng thời Xuân Thu, tác giả Binh Pháp Tôn Tử kinh điển.');
END;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 36)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (36, N'Robin Sharma', N'Canada', N'Chuyên gia phát triển bản thân và kỹ năng lãnh đạo hàng đầu thế giới.');
END;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 37)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (37, N'Brian Tracy', N'Mỹ', N'Bậc thầy đào tạo thành công, quản lý thời gian và đàm phán thương lượng.');
END;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 38)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (38, N'Cal Newport', N'Mỹ', N'Giáo sư khoa học máy tính tại ĐH Georgetown, tác giả Deep Work và Digital Minimalism.');
END;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 39)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (39, N'Donald Knuth', N'Mỹ', N'Huyền thoại khoa học máy tính, tác giả bộ sách The Art of Computer Programming.');
END;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = 40)
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES (40, N'Richard Feynman', N'Mỹ', N'Nhà vật lý lượng tử đoạt giải Nobel, tác giả Chắc Bạn Đùa Feynman!.');
END;
SET IDENTITY_INSERT [dbo].[Authors] OFF;
GO

-- 2. INSERT 800 NEW BOOKS (IDs 201 to 1000)
SET IDENTITY_INSERT [dbo].[Books] ON;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (201, N'978-604-010201', N'Những Người Khốn Khổ - Trọn Bộ 2 Tập', N'Bản hùng ca vĩ đại về tình người, lòng bao dung và sự cứu rỗi giữa xã hội nước Pháp thế kỷ 19.', 110000.00, 90000.00, 170, 200, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/d0/ba/09/17804041c2830c092d9b2278b8be9b58.jpg', 1, '2026-03-18 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (202, N'978-604-010202', N'Nhà Thờ Đức Bà Paris', N'Chuyện tình bi thương và cao thượng của chàng gù Quasimodo dành cho nàng Esmeralda.', 138000.00, 121000.00, 189, 330, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/df/fe/df/08a4a624353b4289b877cf3bced910e4.jpg', 1, '2026-06-06 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (203, N'978-604-010203', N'Chiến Tranh Và Hòa Bình - Trọn Bộ', N'Kiệt tác sử thi đồ sộ mô tả chân thực xã hội Nga thời kỳ chiến tranh Vệ quốc chống Napoleon.', 69000.00, 55000.00, 82, 555, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/81/9f/74/5f64c3144d59ac007b344589f12cfc8e.jpg', 1, '2026-08-16 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (204, N'978-604-010204', N'Anna Karenina', N'Bi kịch tình yêu và hôn nhân của giới quý tộc Nga, một trong những tiểu thuyết hiện thực hay nhất mọi thời đại.', 220000.00, 180000.00, 76, 272, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/a0/a3/2b/006dac88a54de6057ebc9e922069d2bd.jpg', 1, '2026-02-04 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (205, N'978-604-010205', N'Sherlock Holmes - Chiếc Nhẫn Tình Cờ', N'Vụ án đầu tiên mở màn tình bạn huyền thoại giữa Sherlock Holmes và bác sĩ Watson.', 110000.00, 97000.00, 49, 416, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5e/18/24/2a6154ba08df6ce6161c13f4303fa19e.jpg', 1, '2026-06-05 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (206, N'978-604-010206', N'Sherlock Holmes - Con Chó Của Dòng Họ Baskerville', N'Bí ẩn kinh hoàng về bóng ma chó săn khổng lồ rình rập trên đầm lầy hoang vắng xứ Dartmoor.', 85000.00, NULL, 17, 286, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/07/47/18/c2b4715eb2e56d0e33f4b6788532b182.jpg', 1, '2026-06-21 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (207, N'978-604-010207', N'Sherlock Holmes - Thung Lũng Khủng Khiếp', N'Vụ án mạng ly kỳ dẫn lối Holmes vén màn tổ chức tội phạm bí mật xuyên lục địa.', 175000.00, 140000.00, 231, 512, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/70/63/3d/c57040b46e074d49d9e2af573ecefd4e.jpg', 1, '2026-05-16 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (208, N'978-604-010208', N'Harry Potter Và Hòn Đá Phù Thủy', N'Chuyến tàu tốc hành đưa cậu bé Harry Potter bước vào thế giới phép thuật kỳ ảo Hogwarts.', 195000.00, 166000.00, 199, 616, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/1b/79/a2/96348da390aaa6f67b02213108f37a6e.jpg', 1, '2026-03-07 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (209, N'978-604-010209', N'Harry Potter Và Phòng Chứa Bí Mật', N'Bí mật ngàn năm dưới lòng Hogwarts thức giấc đe dọa tính mạng các phù thủy sinh gốc Muggle.', 220000.00, 187000.00, 198, 270, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5a/a1/cb/6d1c9e9875a9ac35d5a5a536f813f4ee.png', 1, '2026-10-15 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (210, N'978-604-010210', N'Harry Potter Và Tên Tù Nhân Ngục Azkaban', N'Bí ẩn về Sirius Black và cuộc đối đầu với những giám ngục Azkaban lạnh giá.', 85000.00, 70000.00, 146, 331, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/75/47/f1/8d0571eda17578c74710a18d81aad5a2.png', 1, '2026-10-07 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (211, N'978-604-010211', N'Harry Potter Và Chiếc Cốc Lửa', N'Giải đấu Tam Pháp Thuật đầy kịch tính đánh dấu sự trở lại đen tối của Chúa tể Voldemort.', 138000.00, 110000.00, 124, 347, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/55/44/5c/ef26b60328ea00db2ac6358b69a18935.jpg', 1, '2026-03-25 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (212, N'978-604-010212', N'Mật Mã Da Vinci', N'Cuộc truy lùng Chén Thánh nghẹt thở qua các biểu tượng ẩn giấu trong tranh của Leonardo da Vinci.', 195000.00, 172000.00, 100, 482, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/41/02/5e/3ef2506a5e3a7ce69c3b3f5fc6ea3401.jpg', 1, '2026-05-17 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (213, N'978-604-010213', N'Thiên Thần Và Ác Quỷ', N'Âm mưu phá hủy Vatican bằng phản vật chất của giáo phái bí ẩn Illuminati.', 110000.00, 88000.00, 174, 533, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/93/8e/2c/a5dd4c236a604246a2c7a79f11e7badb.jpg', 1, '2026-10-19 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (214, N'978-604-010214', N'Biểu Tượng Thất Truyền', N'Bí mật cổ xưa của hội Tam Điểm ẩn giấu tại thủ đô Washington D.C.', 280000.00, 246000.00, 55, 240, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/3d/b2/eb/395145ab859d548c23386223bc4f746d.png', 1, '2026-04-10 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (215, N'978-604-010215', N'Hỏa Ngục (Inferno)', N'Cuộc chạy đua ngăn chặn đại dịch toàn cầu dựa trên thi phẩm Địa Ngục của Dante.', 195000.00, 172000.00, 230, 480, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/65/4c/2da4aa944b6f280afbd694ac1a129682.jpeg', 1, '2026-01-03 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (216, N'978-604-010216', N'Rừng Na Uy', N'Khúc ca hoài niệm đầy day dứt về tuổi trẻ, tình yêu và nỗi cô đơn của những người trẻ tuổi Tokyo.', 85000.00, 68000.00, 114, 193, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/i/m/img011.u2751.d20170404.t142005.692809.jpg', 1, '2026-04-27 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (217, N'978-604-010217', N'Biên Niên Ký Chim Vặn Dây Cót', N'Hành trình siêu thực tìm kiếm người vợ mất tích đưa Toru Okada lặn sâu vào ký ức chiến tranh.', 250000.00, 200000.00, 46, 564, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5e/18/24/2a6154ba08df6ce6161c13f4303fa19e.jpg', 1, '2026-07-18 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (218, N'978-604-010218', N'Kafka Bên Bờ Biển', N'Chuyến trốn chạy định mệnh của cậu bé 15 tuổi Kafka Tamura hòa cùng thế giới huyền ảo của ông lão Nakata.', 110000.00, 99000.00, 230, 223, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236435314.jpg', 1, '2026-01-20 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (219, N'978-604-010219', N'1Q84 - Trọn Bộ 3 Tập', N'Thế giới song song với hai vầng trăng nơi Aomame và Tengo tìm lại mối liên kết định mệnh.', 220000.00, 194000.00, 208, 330, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/70/63/3d/c57040b46e074d49d9e2af573ecefd4e.jpg', 1, '2026-07-20 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (220, N'978-604-010220', N'Người Đua Diều', N'Câu chuyện cảm động về tình bạn, tội lỗi và sự chuộc tội trên đất nước Afghanistan nhiều biến động.', 85000.00, 68000.00, 89, 309, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936049952142.jpg', 1, '2026-08-04 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (221, N'978-604-010221', N'Trăm Năm Cô Đơn', N'Bản anh hùng ca của dòng họ Buendia tại ngôi làng Macondo huyền thoại của chủ nghĩa hiện thực huyền ảo.', 92000.00, 78000.00, 78, 502, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/5/5/554d80fa-8555-4093-b8c0-56e7d00b1a3f.jpg', 1, '2026-04-05 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (222, N'978-604-010222', N'Đồi Gió Hú', N'Mối tình nồng cháy nhưng đầy thù hận giữa Heathcliff và Catherine trên cánh đồng hoang Yorkshire.', 145000.00, 119000.00, 60, 351, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235240971.jpg', 1, '2026-06-06 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (223, N'978-604-010223', N'Kiêu Hãnh Và Định Kiến', N'Nghệ thuật ứng xử, sự kiêu hãnh và những định kiến trong tình yêu của Elizabeth Bennet và Ngài Darcy.', 75000.00, 60000.00, 156, 410, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235230019_1.jpg', 1, '2026-05-10 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (224, N'978-604-010224', N'Bá Tước Monte Cristo', N'Hành trình trả thù vĩ đại và tìm lại công lý của chàng thủy thủ Edmond Dantès.', 125000.00, 100000.00, 32, 652, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974178408.jpg', 1, '2026-09-12 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (225, N'978-604-010225', N'Ba Chàng Lính Ngự Lâm', N'Khẩu hiệu ''Một người vì mọi người, mọi người vì một người'' bất hủ của d''Artagnan và ba chàng ngự lâm quân.', 175000.00, 140000.00, 117, 203, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936203361674.jpg', 1, '2026-03-02 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (226, N'978-604-010226', N'Chuông Nguyện Hồn Ai', N'Tác phẩm khắc họa lòng dũng cảm, tình đồng đội và sự khốc liệt trong cuộc nội chiến Tây Ban Nha.', 69000.00, 59000.00, 23, 195, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235244177.jpg', 1, '2026-09-21 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (227, N'978-604-010227', N'Ông Già Và Biển Cả', N'Ý chí phi thường của con người trước thiên nhiên dữ dội: ''Con người có thể bị hủy diệt nhưng không thể bị đánh bại.''', 92000.00, NULL, 75, 246, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936049952142.jpg', 1, '2026-03-03 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (228, N'978-604-010228', N'Bắt Trẻ Đồng Xanh', N'Tiếng nói nổi loạn, chân thật và nhạy cảm của cậu thiếu niên Holden Caulfield giữa xã hội giả tạo.', 145000.00, 123000.00, 173, 361, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936203361674.jpg', 1, '2026-05-18 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (229, N'978-604-010229', N'Đại Gia Gatsby', N'Ảo mộng phù hoa của giấc mơ Mỹ và tình si vô vọng của chàng triệu phú Jay Gatsby.', 110000.00, NULL, 19, 585, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg', 1, '2026-07-18 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (230, N'978-604-010230', N'Cuốn Theo Chiều Gió', N'Bản tình ca bất hủ giữa nàng Scarlett O''Hara kiêu kỳ và Rhett Butler phong trần trong khói lửa nội chiến Mỹ.', 250000.00, 225000.00, 194, 668, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/df/fe/df/08a4a624353b4289b877cf3bced910e4.jpg', 1, '2026-03-15 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (231, N'978-604-010231', N'Giết Con Chim Nhại', N'Bài học sâu sắc về lòng nhân ái, công lý và sự bình đẳng chủng tộc qua góc nhìn của cô bé Scout.', 220000.00, 180000.00, 154, 414, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/81/9f/74/5f64c3144d59ac007b344589f12cfc8e.jpg', 1, '2026-07-17 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (232, N'978-604-010232', N'Dịch Hạch', N'Sự đoàn kết và phẩm giá con người kiên cường đối mặt với bệnh dịch và sự phi lý của cuộc đời.', 69000.00, NULL, 65, 491, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5e/18/24/2a6154ba08df6ce6161c13f4303fa19e.jpg', 1, '2026-10-12 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (233, N'978-604-010233', N'Người Xa Lạ', N'Tác phẩm mở đường cho chủ nghĩa hiện sinh về sự thờ ơ và phi lý của xã hội hiện đại.', 110000.00, 99000.00, 238, 661, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974099192.jpg', 1, '2026-02-02 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (234, N'978-604-010234', N'Số Đỏ', N'Kiệt tác trào phúng đỉnh cao của văn học Việt Nam về xã hội tư sản thực dân nửa mùa Âu hóa.', 98000.00, 78000.00, 239, 271, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/b/n/bn01do-1.u2769.d20170607.t182835.572283_2.jpg', 1, '2026-09-06 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (235, N'978-604-010235', N'Giông Tố', N'Bức tranh xã hội ngột ngạt, tàn bạo với bi kịch gia đình và sự tha hóa của đồng tiền.', 69000.00, NULL, 228, 456, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974152507.jpg', 1, '2026-09-06 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (236, N'978-604-010236', N'Tắt Đèn', N'Bi kịch cùng cực và tinh thần phản kháng quật khởi của chị Dậu dưới ách sưu cao thuế nặng.', 195000.00, NULL, 148, 635, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974178408.jpg', 1, '2026-06-25 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (237, N'978-604-010237', N'Chí Phèo & Những Truyện Ngắn Chọn Lọc', N'Tiếng kêu xé ruột đòi quyền làm người lương thiện của số phận người nông dân bị bần cùng hóa.', 250000.00, 200000.00, 39, 364, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235230019_1.jpg', 1, '2026-10-09 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (238, N'978-604-010238', N'Vợ Nhặt & Tác Phẩm Kinh Điển', N'Tình người ấm áp, khát vọng sống và niềm tin vào tương lai giữa nạn đói kinh hoàng 1945.', 92000.00, NULL, 29, 323, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235249561.jpg', 1, '2026-01-09 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (239, N'978-604-010239', N'Lão Hạc', N'Tình phụ tử cảm động và nhân cách trong sạch của một lão nông nghèo thà chết chứ không bán rẻ lương tâm.', 250000.00, 212000.00, 63, 196, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235244177.jpg', 1, '2026-02-02 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (240, N'978-604-010240', N'Nỗi Buồn Chiến Tranh', N'Góc nhìn nhân văn sâu sắc về nỗi đau âm ỉ của những người bước ra từ khói lửa chiến trường.', 98000.00, 80000.00, 248, 277, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235249561.jpg', 1, '2026-08-13 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (241, N'978-604-010241', N'Cánh Đồng Bất Tận', N'Những mảnh đời trôi dạt trên sông nước miền Tây qua ngòi bút đượm buồn và chan chứa trắc ẩn.', 125000.00, 102000.00, 66, 320, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235244177.jpg', 1, '2026-08-05 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (242, N'978-604-010242', N'Bến Không Chồng', N'Số phận những người phụ nữ làng Đông mòn mỏi chờ đợi người thân sau chiến tranh.', 160000.00, 141000.00, 203, 240, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-02-06 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (243, N'978-604-010243', N'Mùa Lá Rụng Trong Vườn', N'Sự va đập giữa các giá trị đạo đức truyền thống và lối sống hiện đại trong gia đình ông Ánh.', 280000.00, 252000.00, 96, 425, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-08-02 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (244, N'978-604-010244', N'Truyện Kiều - Ấn Bản Đặc Biệt', N'Kiệt tác văn học trung đại Việt Nam của Đại thi hào Nguyễn Du với tranh minh họa mỹ thuật.', 92000.00, 83000.00, 174, 495, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg', 1, '2026-07-16 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (245, N'978-604-010245', N'Hoa Tiên & Thơ Văn Nguyễn Du', N'Tuyển tập những áng thơ tuyệt tác bất hủ của đại thi hào văn học dân tộc.', 280000.00, 224000.00, 64, 376, 2022, N'en', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-04-03 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (246, N'978-604-010246', N'Gió Đầu Mùa', N'Những truyện ngắn tinh tế, nhẹ nhàng và giàu chất thơ về tình yêu thương con người của Thạch Lam.', 98000.00, 80000.00, 95, 442, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/t/h/the-psychology-of-money.jpg', 1, '2026-06-01 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (247, N'978-604-010247', N'Nắng Trong Vườn', N'Nét đẹp giản dị, trong ngần của con người và cảnh sắc Hà Nội xưa.', 92000.00, 74000.00, 223, 658, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/i/m/image_230367.jpg', 1, '2026-10-14 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (248, N'978-604-010248', N'Hà Nội Băm Sáu Phố Phường', N'Tùy bút ẩm thực và phong vị văn hóa tao nhã của mảnh đất nghìn năm văn hiến.', 75000.00, 61000.00, 164, 166, 2022, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-01-18 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (249, N'978-604-010249', N'Những Người Khốn Khổ - Trọn Bộ 2 Tập (Tái bản có bổ sung)', N'Bản hùng ca vĩ đại về tình người, lòng bao dung và sự cứu rỗi giữa xã hội nước Pháp thế kỷ 19.', 280000.00, 230000.00, 230, 490, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251400267.jpg', 1, '2026-04-27 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (250, N'978-604-010250', N'Nhà Thờ Đức Bà Paris (Tái bản có bổ sung)', N'Chuyện tình bi thương và cao thượng của chàng gù Quasimodo dành cho nàng Esmeralda.', 145000.00, 116000.00, 207, 574, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403589.jpg', 1, '2026-04-01 10:00:00', 1, 7);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (251, N'978-604-010251', N'Chiến Tranh Và Hòa Bình - Trọn Bộ (Tái bản có bổ sung)', N'Kiệt tác sử thi đồ sộ mô tả chân thực xã hội Nga thời kỳ chiến tranh Vệ quốc chống Napoleon.', 98000.00, 88000.00, 216, 277, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-10-25 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (252, N'978-604-010252', N'Anna Karenina (Tái bản có bổ sung)', N'Bi kịch tình yêu và hôn nhân của giới quý tộc Nga, một trong những tiểu thuyết hiện thực hay nhất mọi thời đại.', 85000.00, 75000.00, 69, 253, 2020, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-02-08 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (253, N'978-604-010253', N'Sherlock Holmes - Chiếc Nhẫn Tình Cờ (Tái bản có bổ sung)', N'Vụ án đầu tiên mở màn tình bạn huyền thoại giữa Sherlock Holmes và bác sĩ Watson.', 280000.00, 252000.00, 50, 323, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-05-16 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (254, N'978-604-010254', N'Sherlock Holmes - Con Chó Của Dòng Họ Baskerville (Tái bản có bổ sung)', N'Bí ẩn kinh hoàng về bóng ma chó săn khổng lồ rình rập trên đầm lầy hoang vắng xứ Dartmoor.', 98000.00, 86000.00, 29, 244, 2023, N'en', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-01-10 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (255, N'978-604-010255', N'Sherlock Holmes - Thung Lũng Khủng Khiếp (Tái bản có bổ sung)', N'Vụ án mạng ly kỳ dẫn lối Holmes vén màn tổ chức tội phạm bí mật xuyên lục địa.', 69000.00, 55000.00, 236, 664, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-02-10 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (256, N'978-604-010256', N'Harry Potter Và Hòn Đá Phù Thủy (Tái bản có bổ sung)', N'Chuyến tàu tốc hành đưa cậu bé Harry Potter bước vào thế giới phép thuật kỳ ảo Hogwarts.', 280000.00, NULL, 49, 500, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-03-05 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (257, N'978-604-010257', N'Harry Potter Và Phòng Chứa Bí Mật (Tái bản có bổ sung)', N'Bí mật ngàn năm dưới lòng Hogwarts thức giấc đe dọa tính mạng các phù thủy sinh gốc Muggle.', 75000.00, 68000.00, 85, 260, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-06-14 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (258, N'978-604-010258', N'Harry Potter Và Tên Tù Nhân Ngục Azkaban (Tái bản có bổ sung)', N'Bí ẩn về Sirius Black và cuộc đối đầu với những giám ngục Azkaban lạnh giá.', 110000.00, 94000.00, 214, 490, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-10-22 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (259, N'978-604-010259', N'Harry Potter Và Chiếc Cốc Lửa (Tái bản có bổ sung)', N'Giải đấu Tam Pháp Thuật đầy kịch tính đánh dấu sự trở lại đen tối của Chúa tể Voldemort.', 75000.00, 66000.00, 62, 639, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402773.jpg', 1, '2026-04-03 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (260, N'978-604-010260', N'Mật Mã Da Vinci (Tái bản có bổ sung)', N'Cuộc truy lùng Chén Thánh nghẹt thở qua các biểu tượng ẩn giấu trong tranh của Leonardo da Vinci.', 138000.00, 124000.00, 55, 234, 2020, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-02-05 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (261, N'978-604-010261', N'Thiên Thần Và Ác Quỷ (Tái bản có bổ sung)', N'Âm mưu phá hủy Vatican bằng phản vật chất của giáo phái bí ẩn Illuminati.', 92000.00, 83000.00, 211, 536, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-10-15 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (262, N'978-604-010262', N'Biểu Tượng Thất Truyền (Tái bản có bổ sung)', N'Bí mật cổ xưa của hội Tam Điểm ẩn giấu tại thủ đô Washington D.C.', 125000.00, 110000.00, 34, 444, 2019, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-08-01 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (263, N'978-604-010263', N'Hỏa Ngục (Inferno) (Tái bản có bổ sung)', N'Cuộc chạy đua ngăn chặn đại dịch toàn cầu dựa trên thi phẩm Địa Ngục của Dante.', 145000.00, 116000.00, 64, 539, 2020, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-09-23 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (264, N'978-604-010264', N'Rừng Na Uy (Tái bản có bổ sung)', N'Khúc ca hoài niệm đầy day dứt về tuổi trẻ, tình yêu và nỗi cô đơn của những người trẻ tuổi Tokyo.', 145000.00, NULL, 234, 219, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-10-24 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (265, N'978-604-010265', N'Biên Niên Ký Chim Vặn Dây Cót (Tái bản có bổ sung)', N'Hành trình siêu thực tìm kiếm người vợ mất tích đưa Toru Okada lặn sâu vào ký ức chiến tranh.', 220000.00, 176000.00, 219, 266, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-06-19 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (266, N'978-604-010266', N'Kafka Bên Bờ Biển (Tái bản có bổ sung)', N'Chuyến trốn chạy định mệnh của cậu bé 15 tuổi Kafka Tamura hòa cùng thế giới huyền ảo của ông lão Nakata.', 160000.00, NULL, 189, 420, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-02-26 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (267, N'978-604-010267', N'1Q84 - Trọn Bộ 3 Tập (Tái bản có bổ sung)', N'Thế giới song song với hai vầng trăng nơi Aomame và Tengo tìm lại mối liên kết định mệnh.', 98000.00, 78000.00, 97, 654, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/t/h/the-psychology-of-money.jpg', 1, '2026-04-04 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (268, N'978-604-010268', N'Người Đua Diều (Tái bản có bổ sung)', N'Câu chuyện cảm động về tình bạn, tội lỗi và sự chuộc tội trên đất nước Afghanistan nhiều biến động.', 145000.00, NULL, 116, 515, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/i/m/image_230367.jpg', 1, '2026-07-21 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (269, N'978-604-010269', N'Trăm Năm Cô Đơn (Tái bản có bổ sung)', N'Bản anh hùng ca của dòng họ Buendia tại ngôi làng Macondo huyền thoại của chủ nghĩa hiện thực huyền ảo.', 280000.00, 230000.00, 67, 338, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-05-15 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (270, N'978-604-010270', N'Đồi Gió Hú (Tái bản có bổ sung)', N'Mối tình nồng cháy nhưng đầy thù hận giữa Heathcliff và Catherine trên cánh đồng hoang Yorkshire.', 250000.00, NULL, 219, 421, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251400267.jpg', 1, '2026-09-10 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (271, N'978-604-010271', N'Kiêu Hãnh Và Định Kiến (Tái bản có bổ sung)', N'Nghệ thuật ứng xử, sự kiêu hãnh và những định kiến trong tình yêu của Elizabeth Bennet và Ngài Darcy.', 110000.00, 94000.00, 138, 254, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403589.jpg', 1, '2026-08-05 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (272, N'978-604-010272', N'Bá Tước Monte Cristo (Tái bản có bổ sung)', N'Hành trình trả thù vĩ đại và tìm lại công lý của chàng thủy thủ Edmond Dantès.', 75000.00, NULL, 171, 453, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-02-10 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (273, N'978-604-010273', N'Ba Chàng Lính Ngự Lâm (Tái bản có bổ sung)', N'Khẩu hiệu ''Một người vì mọi người, mọi người vì một người'' bất hủ của d''Artagnan và ba chàng ngự lâm quân.', 75000.00, NULL, 225, 253, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-08-09 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (274, N'978-604-010274', N'Chuông Nguyện Hồn Ai (Tái bản có bổ sung)', N'Tác phẩm khắc họa lòng dũng cảm, tình đồng đội và sự khốc liệt trong cuộc nội chiến Tây Ban Nha.', 69000.00, 59000.00, 215, 602, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-02-04 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (275, N'978-604-010275', N'Ông Già Và Biển Cả (Tái bản có bổ sung)', N'Ý chí phi thường của con người trước thiên nhiên dữ dội: ''Con người có thể bị hủy diệt nhưng không thể bị đánh bại.''', 69000.00, 62000.00, 40, 499, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-04-11 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (276, N'978-604-010276', N'Bắt Trẻ Đồng Xanh (Tái bản có bổ sung)', N'Tiếng nói nổi loạn, chân thật và nhạy cảm của cậu thiếu niên Holden Caulfield giữa xã hội giả tạo.', 110000.00, 88000.00, 215, 174, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-10-01 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (277, N'978-604-010277', N'Đại Gia Gatsby (Tái bản có bổ sung)', N'Ảo mộng phù hoa của giấc mơ Mỹ và tình si vô vọng của chàng triệu phú Jay Gatsby.', 98000.00, 80000.00, 39, 349, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-09-09 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (278, N'978-604-010278', N'Cuốn Theo Chiều Gió (Tái bản có bổ sung)', N'Bản tình ca bất hủ giữa nàng Scarlett O''Hara kiêu kỳ và Rhett Butler phong trần trong khói lửa nội chiến Mỹ.', 160000.00, 136000.00, 64, 403, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/t/h/the-psychology-of-money.jpg', 1, '2026-03-19 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (279, N'978-604-010279', N'Giết Con Chim Nhại (Tái bản có bổ sung)', N'Bài học sâu sắc về lòng nhân ái, công lý và sự bình đẳng chủng tộc qua góc nhìn của cô bé Scout.', 195000.00, 166000.00, 150, 183, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/i/m/image_230367.jpg', 1, '2026-05-14 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (280, N'978-604-010280', N'Dịch Hạch (Tái bản có bổ sung)', N'Sự đoàn kết và phẩm giá con người kiên cường đối mặt với bệnh dịch và sự phi lý của cuộc đời.', 92000.00, 74000.00, 91, 569, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-09-10 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (281, N'978-604-010281', N'Người Xa Lạ (Tái bản có bổ sung)', N'Tác phẩm mở đường cho chủ nghĩa hiện sinh về sự thờ ơ và phi lý của xã hội hiện đại.', 92000.00, 83000.00, 23, 636, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251400267.jpg', 1, '2026-01-05 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (282, N'978-604-010282', N'Số Đỏ (Tái bản có bổ sung)', N'Kiệt tác trào phúng đỉnh cao của văn học Việt Nam về xã hội tư sản thực dân nửa mùa Âu hóa.', 92000.00, 83000.00, 173, 526, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403589.jpg', 1, '2026-01-08 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (283, N'978-604-010283', N'Giông Tố (Tái bản có bổ sung)', N'Bức tranh xã hội ngột ngạt, tàn bạo với bi kịch gia đình và sự tha hóa của đồng tiền.', 85000.00, 75000.00, 240, 423, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-08-05 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (284, N'978-604-010284', N'Tắt Đèn (Tái bản có bổ sung)', N'Bi kịch cùng cực và tinh thần phản kháng quật khởi của chị Dậu dưới ách sưu cao thuế nặng.', 250000.00, 225000.00, 127, 216, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-01-17 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (285, N'978-604-010285', N'Chí Phèo & Những Truyện Ngắn Chọn Lọc (Tái bản có bổ sung)', N'Tiếng kêu xé ruột đòi quyền làm người lương thiện của số phận người nông dân bị bần cùng hóa.', 138000.00, 124000.00, 238, 641, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-05-12 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (286, N'978-604-010286', N'Vợ Nhặt & Tác Phẩm Kinh Điển (Tái bản có bổ sung)', N'Tình người ấm áp, khát vọng sống và niềm tin vào tương lai giữa nạn đói kinh hoàng 1945.', 110000.00, 88000.00, 93, 281, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-09-07 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (287, N'978-604-010287', N'Lão Hạc (Tái bản có bổ sung)', N'Tình phụ tử cảm động và nhân cách trong sạch của một lão nông nghèo thà chết chứ không bán rẻ lương tâm.', 69000.00, 55000.00, 95, 593, 2020, N'en', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-10-04 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (288, N'978-604-010288', N'Nỗi Buồn Chiến Tranh (Tái bản có bổ sung)', N'Góc nhìn nhân văn sâu sắc về nỗi đau âm ỉ của những người bước ra từ khói lửa chiến trường.', 220000.00, 187000.00, 35, 250, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-05-02 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (289, N'978-604-010289', N'Cánh Đồng Bất Tận (Tái bản có bổ sung)', N'Những mảnh đời trôi dạt trên sông nước miền Tây qua ngòi bút đượm buồn và chan chứa trắc ẩn.', 75000.00, 68000.00, 88, 287, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-09-04 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (290, N'978-604-010290', N'Bến Không Chồng (Tái bản có bổ sung)', N'Số phận những người phụ nữ làng Đông mòn mỏi chờ đợi người thân sau chiến tranh.', 125000.00, 112000.00, 75, 658, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-09-12 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (291, N'978-604-010291', N'Mùa Lá Rụng Trong Vườn (Tái bản có bổ sung)', N'Sự va đập giữa các giá trị đạo đức truyền thống và lối sống hiện đại trong gia đình ông Ánh.', 220000.00, NULL, 176, 676, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-02-03 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (292, N'978-604-010292', N'Truyện Kiều - Ấn Bản Đặc Biệt (Tái bản có bổ sung)', N'Kiệt tác văn học trung đại Việt Nam của Đại thi hào Nguyễn Du với tranh minh họa mỹ thuật.', 92000.00, 81000.00, 188, 331, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-07-13 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (293, N'978-604-010293', N'Hoa Tiên & Thơ Văn Nguyễn Du (Tái bản có bổ sung)', N'Tuyển tập những áng thơ tuyệt tác bất hủ của đại thi hào văn học dân tộc.', 175000.00, 140000.00, 214, 427, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-10-24 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (294, N'978-604-010294', N'Gió Đầu Mùa (Tái bản có bổ sung)', N'Những truyện ngắn tinh tế, nhẹ nhàng và giàu chất thơ về tình yêu thương con người của Thạch Lam.', 175000.00, 144000.00, 76, 224, 2023, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-05-11 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (295, N'978-604-010295', N'Nắng Trong Vườn (Tái bản có bổ sung)', N'Nét đẹp giản dị, trong ngần của con người và cảnh sắc Hà Nội xưa.', 220000.00, 180000.00, 80, 512, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-01-15 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (296, N'978-604-010296', N'Hà Nội Băm Sáu Phố Phường (Tái bản có bổ sung)', N'Tùy bút ẩm thực và phong vị văn hóa tao nhã của mảnh đất nghìn năm văn hiến.', 138000.00, NULL, 225, 302, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-09-13 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (297, N'978-604-010297', N'Những Người Khốn Khổ - Trọn Bộ 2 Tập - Ấn bản kỷ niệm', N'Bản hùng ca vĩ đại về tình người, lòng bao dung và sự cứu rỗi giữa xã hội nước Pháp thế kỷ 19.', 92000.00, 74000.00, 150, 318, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-10-23 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (298, N'978-604-010298', N'Nhà Thờ Đức Bà Paris - Ấn bản kỷ niệm', N'Chuyện tình bi thương và cao thượng của chàng gù Quasimodo dành cho nàng Esmeralda.', 69000.00, 59000.00, 67, 666, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-05-09 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (299, N'978-604-010299', N'Chiến Tranh Và Hòa Bình - Trọn Bộ - Ấn bản kỷ niệm', N'Kiệt tác sử thi đồ sộ mô tả chân thực xã hội Nga thời kỳ chiến tranh Vệ quốc chống Napoleon.', 92000.00, 75000.00, 31, 492, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-06-24 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (300, N'978-604-010300', N'Anna Karenina - Ấn bản kỷ niệm', N'Bi kịch tình yêu và hôn nhân của giới quý tộc Nga, một trong những tiểu thuyết hiện thực hay nhất mọi thời đại.', 125000.00, 102000.00, 23, 211, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-02-25 10:00:00', 1, 2);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (301, N'978-604-010301', N'Sherlock Holmes - Chiếc Nhẫn Tình Cờ - Ấn bản kỷ niệm', N'Vụ án đầu tiên mở màn tình bạn huyền thoại giữa Sherlock Holmes và bác sĩ Watson.', 145000.00, 119000.00, 39, 194, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-08-14 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (302, N'978-604-010302', N'Sherlock Holmes - Con Chó Của Dòng Họ Baskerville - Ấn bản kỷ niệm', N'Bí ẩn kinh hoàng về bóng ma chó săn khổng lồ rình rập trên đầm lầy hoang vắng xứ Dartmoor.', 280000.00, NULL, 115, 169, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-01-09 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (303, N'978-604-010303', N'Sherlock Holmes - Thung Lũng Khủng Khiếp - Ấn bản kỷ niệm', N'Vụ án mạng ly kỳ dẫn lối Holmes vén màn tổ chức tội phạm bí mật xuyên lục địa.', 98000.00, 83000.00, 224, 264, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-10-21 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (304, N'978-604-010304', N'Harry Potter Và Hòn Đá Phù Thủy - Ấn bản kỷ niệm', N'Chuyến tàu tốc hành đưa cậu bé Harry Potter bước vào thế giới phép thuật kỳ ảo Hogwarts.', 145000.00, 116000.00, 174, 318, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-07-04 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (305, N'978-604-010305', N'Harry Potter Và Phòng Chứa Bí Mật - Ấn bản kỷ niệm', N'Bí mật ngàn năm dưới lòng Hogwarts thức giấc đe dọa tính mạng các phù thủy sinh gốc Muggle.', 220000.00, 194000.00, 198, 257, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410198.jpg', 1, '2026-05-07 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (306, N'978-604-010306', N'Harry Potter Và Tên Tù Nhân Ngục Azkaban - Ấn bản kỷ niệm', N'Bí ẩn về Sirius Black và cuộc đối đầu với những giám ngục Azkaban lạnh giá.', 110000.00, 97000.00, 158, 285, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-07-03 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (307, N'978-604-010307', N'Harry Potter Và Chiếc Cốc Lửa - Ấn bản kỷ niệm', N'Giải đấu Tam Pháp Thuật đầy kịch tính đánh dấu sự trở lại đen tối của Chúa tể Voldemort.', 160000.00, 131000.00, 87, 632, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-08-18 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (308, N'978-604-010308', N'Mật Mã Da Vinci - Ấn bản kỷ niệm', N'Cuộc truy lùng Chén Thánh nghẹt thở qua các biểu tượng ẩn giấu trong tranh của Leonardo da Vinci.', 92000.00, NULL, 124, 291, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-09-23 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (309, N'978-604-010309', N'Thiên Thần Và Ác Quỷ - Ấn bản kỷ niệm', N'Âm mưu phá hủy Vatican bằng phản vật chất của giáo phái bí ẩn Illuminati.', 145000.00, 116000.00, 230, 678, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-09-25 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (310, N'978-604-010310', N'Biểu Tượng Thất Truyền - Ấn bản kỷ niệm', N'Bí mật cổ xưa của hội Tam Điểm ẩn giấu tại thủ đô Washington D.C.', 195000.00, NULL, 210, 230, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-04-02 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (311, N'978-604-010311', N'Hỏa Ngục (Inferno) - Ấn bản kỷ niệm', N'Cuộc chạy đua ngăn chặn đại dịch toàn cầu dựa trên thi phẩm Địa Ngục của Dante.', 145000.00, NULL, 166, 453, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-02-27 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (312, N'978-604-010312', N'Rừng Na Uy - Ấn bản kỷ niệm', N'Khúc ca hoài niệm đầy day dứt về tuổi trẻ, tình yêu và nỗi cô đơn của những người trẻ tuổi Tokyo.', 85000.00, 76000.00, 186, 204, 2021, N'en', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-06-18 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (313, N'978-604-010313', N'Biên Niên Ký Chim Vặn Dây Cót - Ấn bản kỷ niệm', N'Hành trình siêu thực tìm kiếm người vợ mất tích đưa Toru Okada lặn sâu vào ký ức chiến tranh.', 110000.00, 94000.00, 18, 232, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-03-07 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (314, N'978-604-010314', N'Kafka Bên Bờ Biển - Ấn bản kỷ niệm', N'Chuyến trốn chạy định mệnh của cậu bé 15 tuổi Kafka Tamura hòa cùng thế giới huyền ảo của ông lão Nakata.', 145000.00, 116000.00, 238, 165, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-03-16 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (315, N'978-604-010315', N'1Q84 - Trọn Bộ 3 Tập - Ấn bản kỷ niệm', N'Thế giới song song với hai vầng trăng nơi Aomame và Tengo tìm lại mối liên kết định mệnh.', 85000.00, 76000.00, 209, 300, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-01-05 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (316, N'978-604-010316', N'Người Đua Diều - Ấn bản kỷ niệm', N'Câu chuyện cảm động về tình bạn, tội lỗi và sự chuộc tội trên đất nước Afghanistan nhiều biến động.', 75000.00, 66000.00, 128, 480, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-08-20 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (317, N'978-604-010317', N'Trăm Năm Cô Đơn - Ấn bản kỷ niệm', N'Bản anh hùng ca của dòng họ Buendia tại ngôi làng Macondo huyền thoại của chủ nghĩa hiện thực huyền ảo.', 138000.00, 124000.00, 230, 595, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-06-06 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (318, N'978-604-010318', N'Đồi Gió Hú - Ấn bản kỷ niệm', N'Mối tình nồng cháy nhưng đầy thù hận giữa Heathcliff và Catherine trên cánh đồng hoang Yorkshire.', 250000.00, 200000.00, 161, 538, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-02-28 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (319, N'978-604-010319', N'Kiêu Hãnh Và Định Kiến - Ấn bản kỷ niệm', N'Nghệ thuật ứng xử, sự kiêu hãnh và những định kiến trong tình yêu của Elizabeth Bennet và Ngài Darcy.', 138000.00, 124000.00, 81, 208, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-03-17 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (320, N'978-604-010320', N'Bá Tước Monte Cristo - Ấn bản kỷ niệm', N'Hành trình trả thù vĩ đại và tìm lại công lý của chàng thủy thủ Edmond Dantès.', 138000.00, 124000.00, 213, 520, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-04-28 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (321, N'978-604-010321', N'Ba Chàng Lính Ngự Lâm - Ấn bản kỷ niệm', N'Khẩu hiệu ''Một người vì mọi người, mọi người vì một người'' bất hủ của d''Artagnan và ba chàng ngự lâm quân.', 280000.00, 238000.00, 210, 306, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-03-27 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (322, N'978-604-010322', N'Chuông Nguyện Hồn Ai - Ấn bản kỷ niệm', N'Tác phẩm khắc họa lòng dũng cảm, tình đồng đội và sự khốc liệt trong cuộc nội chiến Tây Ban Nha.', 98000.00, 80000.00, 33, 355, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-07-01 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (323, N'978-604-010323', N'Ông Già Và Biển Cả - Ấn bản kỷ niệm', N'Ý chí phi thường của con người trước thiên nhiên dữ dội: ''Con người có thể bị hủy diệt nhưng không thể bị đánh bại.''', 98000.00, 78000.00, 49, 319, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-03-02 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (324, N'978-604-010324', N'Bắt Trẻ Đồng Xanh - Ấn bản kỷ niệm', N'Tiếng nói nổi loạn, chân thật và nhạy cảm của cậu thiếu niên Holden Caulfield giữa xã hội giả tạo.', 138000.00, 121000.00, 144, 592, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-05-16 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (325, N'978-604-010325', N'Đại Gia Gatsby - Ấn bản kỷ niệm', N'Ảo mộng phù hoa của giấc mơ Mỹ và tình si vô vọng của chàng triệu phú Jay Gatsby.', 250000.00, 205000.00, 78, 515, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-04-23 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (326, N'978-604-010326', N'Cuốn Theo Chiều Gió - Ấn bản kỷ niệm', N'Bản tình ca bất hủ giữa nàng Scarlett O''Hara kiêu kỳ và Rhett Butler phong trần trong khói lửa nội chiến Mỹ.', 110000.00, 94000.00, 161, 265, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-04-19 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (327, N'978-604-010327', N'Giết Con Chim Nhại - Ấn bản kỷ niệm', N'Bài học sâu sắc về lòng nhân ái, công lý và sự bình đẳng chủng tộc qua góc nhìn của cô bé Scout.', 85000.00, 75000.00, 57, 286, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-05-23 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (328, N'978-604-010328', N'Dịch Hạch - Ấn bản kỷ niệm', N'Sự đoàn kết và phẩm giá con người kiên cường đối mặt với bệnh dịch và sự phi lý của cuộc đời.', 85000.00, 68000.00, 187, 224, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-09-17 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (329, N'978-604-010329', N'Người Xa Lạ - Ấn bản kỷ niệm', N'Tác phẩm mở đường cho chủ nghĩa hiện sinh về sự thờ ơ và phi lý của xã hội hiện đại.', 98000.00, 80000.00, 24, 281, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124012.jpg', 1, '2026-04-16 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (330, N'978-604-010330', N'Số Đỏ - Ấn bản kỷ niệm', N'Kiệt tác trào phúng đỉnh cao của văn học Việt Nam về xã hội tư sản thực dân nửa mùa Âu hóa.', 175000.00, 154000.00, 240, 576, 2024, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-01-08 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (331, N'978-604-010331', N'Giông Tố - Ấn bản kỷ niệm', N'Bức tranh xã hội ngột ngạt, tàn bạo với bi kịch gia đình và sự tha hóa của đồng tiền.', 75000.00, 61000.00, 190, 223, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-09-01 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (332, N'978-604-010332', N'Tắt Đèn - Ấn bản kỷ niệm', N'Bi kịch cùng cực và tinh thần phản kháng quật khởi của chị Dậu dưới ách sưu cao thuế nặng.', 125000.00, 112000.00, 52, 341, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-02-02 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (333, N'978-604-010333', N'Chí Phèo & Những Truyện Ngắn Chọn Lọc - Ấn bản kỷ niệm', N'Tiếng kêu xé ruột đòi quyền làm người lương thiện của số phận người nông dân bị bần cùng hóa.', 280000.00, 224000.00, 230, 219, 2023, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-02-13 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (334, N'978-604-010334', N'Vợ Nhặt & Tác Phẩm Kinh Điển - Ấn bản kỷ niệm', N'Tình người ấm áp, khát vọng sống và niềm tin vào tương lai giữa nạn đói kinh hoàng 1945.', 69000.00, 59000.00, 227, 404, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-01-07 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (335, N'978-604-010335', N'Lão Hạc - Ấn bản kỷ niệm', N'Tình phụ tử cảm động và nhân cách trong sạch của một lão nông nghèo thà chết chứ không bán rẻ lương tâm.', 110000.00, 99000.00, 98, 297, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-04-28 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (336, N'978-604-010336', N'Nỗi Buồn Chiến Tranh - Ấn bản kỷ niệm', N'Góc nhìn nhân văn sâu sắc về nỗi đau âm ỉ của những người bước ra từ khói lửa chiến trường.', 138000.00, 121000.00, 74, 208, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-05-12 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (337, N'978-604-010337', N'Cánh Đồng Bất Tận - Ấn bản kỷ niệm', N'Những mảnh đời trôi dạt trên sông nước miền Tây qua ngòi bút đượm buồn và chan chứa trắc ẩn.', 280000.00, 246000.00, 142, 478, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-03-10 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (338, N'978-604-010338', N'Bến Không Chồng - Ấn bản kỷ niệm', N'Số phận những người phụ nữ làng Đông mòn mỏi chờ đợi người thân sau chiến tranh.', 250000.00, 212000.00, 220, 535, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-08-11 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (339, N'978-604-010339', N'Mùa Lá Rụng Trong Vườn - Ấn bản kỷ niệm', N'Sự va đập giữa các giá trị đạo đức truyền thống và lối sống hiện đại trong gia đình ông Ánh.', 280000.00, 238000.00, 106, 649, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-05-28 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (340, N'978-604-010340', N'Truyện Kiều - Ấn Bản Đặc Biệt - Ấn bản kỷ niệm', N'Kiệt tác văn học trung đại Việt Nam của Đại thi hào Nguyễn Du với tranh minh họa mỹ thuật.', 250000.00, NULL, 99, 282, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-09-11 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (341, N'978-604-010341', N'Hoa Tiên & Thơ Văn Nguyễn Du - Ấn bản kỷ niệm', N'Tuyển tập những áng thơ tuyệt tác bất hủ của đại thi hào văn học dân tộc.', 160000.00, 131000.00, 33, 325, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-03-04 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (342, N'978-604-010342', N'Gió Đầu Mùa - Ấn bản kỷ niệm', N'Những truyện ngắn tinh tế, nhẹ nhàng và giàu chất thơ về tình yêu thương con người của Thạch Lam.', 98000.00, 83000.00, 32, 473, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-05-10 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (343, N'978-604-010343', N'Nắng Trong Vườn - Ấn bản kỷ niệm', N'Nét đẹp giản dị, trong ngần của con người và cảnh sắc Hà Nội xưa.', 110000.00, 94000.00, 114, 534, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-07-19 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (344, N'978-604-010344', N'Hà Nội Băm Sáu Phố Phường - Ấn bản kỷ niệm', N'Tùy bút ẩm thực và phong vị văn hóa tao nhã của mảnh đất nghìn năm văn hiến.', 145000.00, 130000.00, 218, 352, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-04-02 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (345, N'978-604-010345', N'Những Người Khốn Khổ - Trọn Bộ 2 Tập (Bìa cứng mỹ thuật)', N'Bản hùng ca vĩ đại về tình người, lòng bao dung và sự cứu rỗi giữa xã hội nước Pháp thế kỷ 19.', 98000.00, 80000.00, 107, 675, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-09-09 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (346, N'978-604-010346', N'Nhà Thờ Đức Bà Paris (Bìa cứng mỹ thuật)', N'Chuyện tình bi thương và cao thượng của chàng gù Quasimodo dành cho nàng Esmeralda.', 85000.00, 75000.00, 133, 586, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-01-27 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (347, N'978-604-010347', N'Chiến Tranh Và Hòa Bình - Trọn Bộ (Bìa cứng mỹ thuật)', N'Kiệt tác sử thi đồ sộ mô tả chân thực xã hội Nga thời kỳ chiến tranh Vệ quốc chống Napoleon.', 175000.00, 158000.00, 250, 429, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-03-24 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (348, N'978-604-010348', N'Anna Karenina (Bìa cứng mỹ thuật)', N'Bi kịch tình yêu và hôn nhân của giới quý tộc Nga, một trong những tiểu thuyết hiện thực hay nhất mọi thời đại.', 145000.00, 116000.00, 110, 674, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-09-17 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (349, N'978-604-010349', N'Sherlock Holmes - Chiếc Nhẫn Tình Cờ (Bìa cứng mỹ thuật)', N'Vụ án đầu tiên mở màn tình bạn huyền thoại giữa Sherlock Holmes và bác sĩ Watson.', 69000.00, 57000.00, 187, 646, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124012.jpg', 1, '2026-04-21 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (350, N'978-604-010350', N'Sherlock Holmes - Con Chó Của Dòng Họ Baskerville (Bìa cứng mỹ thuật)', N'Bí ẩn kinh hoàng về bóng ma chó săn khổng lồ rình rập trên đầm lầy hoang vắng xứ Dartmoor.', 250000.00, 225000.00, 216, 586, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-07-22 10:00:00', 1, 3);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (351, N'978-604-010351', N'Sherlock Holmes - Thung Lũng Khủng Khiếp (Bìa cứng mỹ thuật)', N'Vụ án mạng ly kỳ dẫn lối Holmes vén màn tổ chức tội phạm bí mật xuyên lục địa.', 69000.00, 59000.00, 27, 605, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-01-06 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (352, N'978-604-010352', N'Harry Potter Và Hòn Đá Phù Thủy (Bìa cứng mỹ thuật)', N'Chuyến tàu tốc hành đưa cậu bé Harry Potter bước vào thế giới phép thuật kỳ ảo Hogwarts.', 250000.00, 205000.00, 241, 563, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-04-02 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (353, N'978-604-010353', N'Harry Potter Và Phòng Chứa Bí Mật (Bìa cứng mỹ thuật)', N'Bí mật ngàn năm dưới lòng Hogwarts thức giấc đe dọa tính mạng các phù thủy sinh gốc Muggle.', 250000.00, 220000.00, 146, 424, 2020, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-08-09 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (354, N'978-604-010354', N'Harry Potter Và Tên Tù Nhân Ngục Azkaban (Bìa cứng mỹ thuật)', N'Bí ẩn về Sirius Black và cuộc đối đầu với những giám ngục Azkaban lạnh giá.', 220000.00, 180000.00, 152, 629, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-03-17 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (355, N'978-604-010355', N'Harry Potter Và Chiếc Cốc Lửa (Bìa cứng mỹ thuật)', N'Giải đấu Tam Pháp Thuật đầy kịch tính đánh dấu sự trở lại đen tối của Chúa tể Voldemort.', 195000.00, 172000.00, 216, 454, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-07-15 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (356, N'978-604-010356', N'Mật Mã Da Vinci (Bìa cứng mỹ thuật)', N'Cuộc truy lùng Chén Thánh nghẹt thở qua các biểu tượng ẩn giấu trong tranh của Leonardo da Vinci.', 280000.00, NULL, 236, 370, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-03-11 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (357, N'978-604-010357', N'Thiên Thần Và Ác Quỷ (Bìa cứng mỹ thuật)', N'Âm mưu phá hủy Vatican bằng phản vật chất của giáo phái bí ẩn Illuminati.', 98000.00, 83000.00, 138, 234, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124012.jpg', 1, '2026-01-12 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (358, N'978-604-010358', N'Biểu Tượng Thất Truyền (Bìa cứng mỹ thuật)', N'Bí mật cổ xưa của hội Tam Điểm ẩn giấu tại thủ đô Washington D.C.', 110000.00, 94000.00, 196, 625, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-09-14 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (359, N'978-604-010359', N'Hỏa Ngục (Inferno) (Bìa cứng mỹ thuật)', N'Cuộc chạy đua ngăn chặn đại dịch toàn cầu dựa trên thi phẩm Địa Ngục của Dante.', 175000.00, NULL, 212, 673, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-08-04 10:00:00', 1, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (360, N'978-604-010360', N'Rừng Na Uy (Bìa cứng mỹ thuật)', N'Khúc ca hoài niệm đầy day dứt về tuổi trẻ, tình yêu và nỗi cô đơn của những người trẻ tuổi Tokyo.', 92000.00, 83000.00, 50, 665, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg', 1, '2026-10-25 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (361, N'978-604-010361', N'Biên Niên Ký Chim Vặn Dây Cót (Bìa cứng mỹ thuật)', N'Hành trình siêu thực tìm kiếm người vợ mất tích đưa Toru Okada lặn sâu vào ký ức chiến tranh.', 160000.00, 141000.00, 64, 394, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-03-26 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (362, N'978-604-010362', N'Kafka Bên Bờ Biển (Bìa cứng mỹ thuật)', N'Chuyến trốn chạy định mệnh của cậu bé 15 tuổi Kafka Tamura hòa cùng thế giới huyền ảo của ông lão Nakata.', 75000.00, 60000.00, 153, 205, 2022, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703578.jpg', 1, '2026-05-07 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (363, N'978-604-010363', N'1Q84 - Trọn Bộ 3 Tập (Bìa cứng mỹ thuật)', N'Thế giới song song với hai vầng trăng nơi Aomame và Tengo tìm lại mối liên kết định mệnh.', 145000.00, NULL, 29, 256, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703585.jpg', 1, '2026-07-14 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (364, N'978-604-010364', N'Người Đua Diều (Bìa cứng mỹ thuật)', N'Câu chuyện cảm động về tình bạn, tội lỗi và sự chuộc tội trên đất nước Afghanistan nhiều biến động.', 220000.00, 198000.00, 78, 499, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236427357.jpg', 1, '2026-07-17 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (365, N'978-604-010365', N'Trăm Năm Cô Đơn (Bìa cứng mỹ thuật)', N'Bản anh hùng ca của dòng họ Buendia tại ngôi làng Macondo huyền thoại của chủ nghĩa hiện thực huyền ảo.', 110000.00, 90000.00, 187, 589, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426787.jpg', 1, '2026-02-10 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (366, N'978-604-010366', N'Đồi Gió Hú (Bìa cứng mỹ thuật)', N'Mối tình nồng cháy nhưng đầy thù hận giữa Heathcliff và Catherine trên cánh đồng hoang Yorkshire.', 110000.00, 90000.00, 144, 222, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703592.jpg', 1, '2026-05-10 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (367, N'978-604-010367', N'Kiêu Hãnh Và Định Kiến (Bìa cứng mỹ thuật)', N'Nghệ thuật ứng xử, sự kiêu hãnh và những định kiến trong tình yêu của Elizabeth Bennet và Ngài Darcy.', 92000.00, 78000.00, 18, 515, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg', 1, '2026-09-07 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (368, N'978-604-010368', N'Bá Tước Monte Cristo (Bìa cứng mỹ thuật)', N'Hành trình trả thù vĩ đại và tìm lại công lý của chàng thủy thủ Edmond Dantès.', 75000.00, 66000.00, 240, 596, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-06-26 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (369, N'978-604-010369', N'Ba Chàng Lính Ngự Lâm (Bìa cứng mỹ thuật)', N'Khẩu hiệu ''Một người vì mọi người, mọi người vì một người'' bất hủ của d''Artagnan và ba chàng ngự lâm quân.', 98000.00, 86000.00, 101, 210, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703578.jpg', 1, '2026-05-09 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (370, N'978-604-010370', N'Chuông Nguyện Hồn Ai (Bìa cứng mỹ thuật)', N'Tác phẩm khắc họa lòng dũng cảm, tình đồng đội và sự khốc liệt trong cuộc nội chiến Tây Ban Nha.', 110000.00, NULL, 79, 190, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703585.jpg', 1, '2026-06-16 10:00:00', 1, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (371, N'978-604-010371', N'Ông Già Và Biển Cả (Bìa cứng mỹ thuật)', N'Ý chí phi thường của con người trước thiên nhiên dữ dội: ''Con người có thể bị hủy diệt nhưng không thể bị đánh bại.''', 175000.00, 140000.00, 73, 574, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236427357.jpg', 1, '2026-04-20 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (372, N'978-604-010372', N'Bắt Trẻ Đồng Xanh (Bìa cứng mỹ thuật)', N'Tiếng nói nổi loạn, chân thật và nhạy cảm của cậu thiếu niên Holden Caulfield giữa xã hội giả tạo.', 69000.00, 55000.00, 63, 585, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426787.jpg', 1, '2026-08-07 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (373, N'978-604-010373', N'Đại Gia Gatsby (Bìa cứng mỹ thuật)', N'Ảo mộng phù hoa của giấc mơ Mỹ và tình si vô vọng của chàng triệu phú Jay Gatsby.', 145000.00, 123000.00, 136, 437, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554102.jpg', 1, '2026-07-12 10:00:00', 1, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (374, N'978-604-010374', N'Cuốn Theo Chiều Gió (Bìa cứng mỹ thuật)', N'Bản tình ca bất hủ giữa nàng Scarlett O''Hara kiêu kỳ và Rhett Butler phong trần trong khói lửa nội chiến Mỹ.', 98000.00, 83000.00, 209, 238, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554102.jpg', 1, '2026-10-28 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (375, N'978-604-010375', N'Giết Con Chim Nhại (Bìa cứng mỹ thuật)', N'Bài học sâu sắc về lòng nhân ái, công lý và sự bình đẳng chủng tộc qua góc nhìn của cô bé Scout.', 250000.00, 205000.00, 22, 266, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703592.jpg', 1, '2026-10-24 10:00:00', 1, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (376, N'978-604-010376', N'Dịch Hạch (Bìa cứng mỹ thuật)', N'Sự đoàn kết và phẩm giá con người kiên cường đối mặt với bệnh dịch và sự phi lý của cuộc đời.', 69000.00, 62000.00, 125, 280, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-04-18 10:00:00', 1, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (377, N'978-604-010377', N'Người Xa Lạ (Bìa cứng mỹ thuật)', N'Tác phẩm mở đường cho chủ nghĩa hiện sinh về sự thờ ơ và phi lý của xã hội hiện đại.', 220000.00, 176000.00, 52, 505, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703578.jpg', 1, '2026-04-14 10:00:00', 1, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (378, N'978-604-010378', N'Số Đỏ (Bìa cứng mỹ thuật)', N'Kiệt tác trào phúng đỉnh cao của văn học Việt Nam về xã hội tư sản thực dân nửa mùa Âu hóa.', 175000.00, 149000.00, 203, 368, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703585.jpg', 1, '2026-03-21 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (379, N'978-604-010379', N'Giông Tố (Bìa cứng mỹ thuật)', N'Bức tranh xã hội ngột ngạt, tàn bạo với bi kịch gia đình và sự tha hóa của đồng tiền.', 69000.00, 62000.00, 48, 193, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236427357.jpg', 1, '2026-07-18 10:00:00', 1, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (380, N'978-604-010380', N'Tắt Đèn (Bìa cứng mỹ thuật)', N'Bi kịch cùng cực và tinh thần phản kháng quật khởi của chị Dậu dưới ách sưu cao thuế nặng.', 69000.00, 59000.00, 250, 174, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426787.jpg', 1, '2026-10-04 10:00:00', 1, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (381, N'978-604-020381', N'Khởi Nghiệp Tinh Gọn (The Lean Startup)', N'Phương pháp xây dựng doanh nghiệp đổi mới sáng tạo, thử nghiệm nhanh và tối ưu hóa chi phí.', 160000.00, 128000.00, 81, 668, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554102.jpg', 1, '2026-09-15 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (382, N'978-604-020382', N'Từ Không Đến Một (Zero to One)', N'Bí quyết kiến tạo những sản phẩm độc bản và xây dựng doanh nghiệp thống lĩnh tương lai.', 220000.00, 180000.00, 138, 234, 2019, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703592.jpg', 1, '2026-10-13 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (383, N'978-604-020383', N'Gã Nghiện Giày (Shoe Dog)', N'Hồi ký truyền cảm hứng về hành trình xây dựng đế chế thể thao Nike từ hai bàn tay trắng.', 92000.00, 74000.00, 228, 530, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg', 1, '2026-05-22 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (384, N'978-604-020384', N'Từ Tốt Đến Vĩ Đại (Good to Great)', N'Nghiên cứu kinh điển giải mã bí quyết giúp các công ty bình thường vươn lên thành vĩ đại trường tồn.', 92000.00, 83000.00, 248, 160, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-02-03 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (385, N'978-604-020385', N'Xây Dựng Để Trường Tồn (Built to Last)', N'Những thói quen thành công của các tập đoàn có tầm nhìn vĩ đại qua hàng thập kỷ.', 98000.00, 83000.00, 15, 528, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/65/4c/2da4aa944b6f280afbd694ac1a129682.jpeg', 1, '2026-09-15 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (386, N'978-604-020386', N'Nhà Đầu Tư Thông Minh (The Intelligent Investor)', N'Cẩm nang đầu tư giá trị kinh điển của Benjamin Graham được Warren Buffett khuyên đọc.', 220000.00, 176000.00, 95, 466, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235222533.jpg', 1, '2026-02-16 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (387, N'978-604-020387', N'Cổ Phiếu Thường Lợi Nhuận Phi Thường', N'Chiến lược lựa chọn doanh nghiệp tăng trưởng xuất sắc của huyền thoại Philip Fisher.', 69000.00, 57000.00, 67, 658, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230004561.jpg', 1, '2026-09-02 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (388, N'978-604-020388', N'Bước Đi Ngẫu Nhiên Trên Phố Wall', N'Hướng dẫn đầu tư tài chính thông minh, cân bằng rủi ro và xây dựng danh mục bền vững.', 125000.00, 102000.00, 86, 361, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425155.jpg', 1, '2026-05-03 10:00:00', 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (389, N'978-604-020389', N'Tâm Lý Học Về Tiền - Những Bài Học Bất Biến', N'Cách con người đưa ra quyết định tài chính và bản chất thực sự của sự thịnh vượng.', 110000.00, 88000.00, 27, 284, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425124.jpg', 1, '2026-03-25 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (390, N'978-604-020390', N'Chiến Lược Đại Dương Xanh', N'Cách thức tạo lập khoảng trống thị trường vô tranh và vô hiệu hóa đối thủ cạnh tranh.', 175000.00, 149000.00, 196, 560, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425131.jpg', 1, '2026-01-21 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (391, N'978-604-020391', N'Marketing 5.0 - Công Nghệ Vị Nhân Sinh', N'Chiến lược tiếp thị ứng dụng trí tuệ nhân tạo, tự động hóa và phân tích dữ liệu lớn.', 125000.00, 112000.00, 81, 635, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425148.jpg', 1, '2026-01-04 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (392, N'978-604-020392', N'22 Quy Luật Bất Biến Trong Marketing', N'Những nguyên lý cốt lõi bất di bất dịch định hình thành bại của mọi chiến dịch tiếp thị.', 138000.00, 110000.00, 85, 312, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230005032.jpg', 1, '2026-05-26 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (393, N'978-604-020393', N'Nghệ Thuật Lan Truyền (Contagious)', N'Tại sao sản phẩm, ý tưởng và hành vi lại có sức lan tỏa mạnh mẽ trong cộng đồng.', 220000.00, 176000.00, 142, 582, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425155.jpg', 1, '2026-04-12 10:00:00', 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (394, N'978-604-020394', N'Bán Niềm Tin Mua Sự Trung Thành', N'Bí quyết xây dựng trải nghiệm khách hàng vượt trội để biến người mua thành đại sứ thương hiệu.', 85000.00, 70000.00, 246, 335, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230006789.jpg', 1, '2026-09-14 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (395, N'978-604-020395', N'Quảng Cáo Theo Phong Cách Ogilvy', N'Bậc thầy David Ogilvy chia sẻ bí quyết viết thông điệp quảng cáo thuyết phục hàng triệu người.', 110000.00, 88000.00, 71, 566, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425124.jpg', 1, '2026-02-28 10:00:00', 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (396, N'978-604-020396', N'Dốc Hết Trái Tim - Xây Dựng Đế Chế Starbucks', N'Hành trình Howard Schultz biến quán cà phê nhỏ Seattle thành thương hiệu toàn cầu.', 85000.00, 76000.00, 115, 525, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230007890.jpg', 1, '2026-03-04 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (397, N'978-604-020397', N'Steve Jobs - Tiểu Sử Độc Quyền', N'Chân dung chân thực về thiên tài công nghệ đã định hình lại 6 ngành công nghiệp thế giới.', 220000.00, 176000.00, 116, 320, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426001.jpg', 1, '2026-03-09 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (398, N'978-604-020398', N'Elon Musk - Kẻ Kiến Tạo Tương Lai', N'Hành trình liều lĩnh của người sáng lập Tesla, SpaceX và giấc mơ đưa nhân loại lên sao Hỏa.', 220000.00, NULL, 190, 666, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230005032.jpg', 1, '2026-06-25 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (399, N'978-604-020399', N'Tái Tạo Tổ Chức (Reinventing Organizations)', N'Mô hình quản trị doanh nghiệp tự chủ, minh bạch và phát triển toàn diện con người.', 145000.00, 130000.00, 102, 206, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235241848.jpg', 1, '2026-03-21 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (400, N'978-604-020400', N'OKRs - Đo Lường Điều Quan Trọng', N'Phương pháp quản trị mục tiêu then chốt được Google, Intel và các tập đoàn hàng đầu tin dùng.', 125000.00, 112000.00, 125, 206, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg', 1, '2026-03-02 10:00:00', 2, 8);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (401, N'978-604-020401', N'Bán Hàng Cho Người Khổng Lồ', N'Chiến thuật chốt các hợp đồng B2B giá trị triệu đô với các tập đoàn đa quốc gia.', 175000.00, 144000.00, 222, 316, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/d0/ba/09/17804041c2830c092d9b2278b8be9b58.jpg', 1, '2026-04-08 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (402, N'978-604-020402', N'Nghệ Thuật Bán Hàng Bậc Cao', N'Phương pháp tiếp cận, thuyết phục và xây dựng mối quan hệ tin cậy với khách hàng khó tính.', 195000.00, 172000.00, 117, 517, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/df/fe/df/08a4a624353b4289b877cf3bced910e4.jpg', 1, '2026-10-21 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (403, N'978-604-020403', N'Kỹ Năng Đàm Phán Thương Lượng Đỉnh Cao', N'Bí quyết đàm phán win-win đem lại lợi thế tối đa trong mọi cuộc thương thảo thương mại.', 85000.00, NULL, 80, 302, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/81/9f/74/5f64c3144d59ac007b344589f12cfc8e.jpg', 1, '2026-04-04 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (404, N'978-604-020404', N'Người Giàu Có Nhất Thành Babylon', N'Những bài học tiết kiệm, đầu tư và giữ tiền thông minh từ nền văn minh cổ đại.', 98000.00, 78000.00, 54, 251, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/a0/a3/2b/006dac88a54de6057ebc9e922069d2bd.jpg', 1, '2026-05-18 10:00:00', 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (405, N'978-604-020405', N'Cha Giàu Cha Nghèo - Tập 1: Để Không Có Tiền Vẫn Tạo Ra Tiền', N'Tư duy tài chính đột phá về tài sản, tiêu sản và tự do tài chính cá nhân.', 175000.00, 140000.00, 128, 659, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5e/18/24/2a6154ba08df6ce6161c13f4303fa19e.jpg', 1, '2026-07-07 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (406, N'978-604-020406', N'Cha Giàu Cha Nghèo - Tập 2: Sử Dụng Đồng Vốn', N'Bí quyết chuyển dịch từ nhóm người làm thuê sang nhóm chủ doanh nghiệp và nhà đầu tư.', 138000.00, 117000.00, 49, 221, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/07/47/18/c2b4715eb2e56d0e33f4b6788532b182.jpg', 1, '2026-07-25 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (407, N'978-604-020407', N'Cha Giàu Cha Nghèo - Tập 3: Hướng Dẫn Đầu Tư', N'Cẩm nang hướng dẫn cách tư duy và hành động như một nhà đầu tư chuyên nghiệp.', 175000.00, 158000.00, 96, 403, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/70/63/3d/c57040b46e074d49d9e2af573ecefd4e.jpg', 1, '2026-07-04 10:00:00', 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (408, N'978-604-020408', N'Cha Giàu Cha Nghèo - Tập 4: Nghỉ Hưu Sớm Nghỉ Hưu Giàu', N'Lộ trình đạt độc lập tài chính và tự do cuộc sống ở độ tuổi thanh xuân.', 160000.00, NULL, 105, 336, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/1b/79/a2/96348da390aaa6f67b02213108f37a6e.jpg', 1, '2026-06-16 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (409, N'978-604-020409', N'Cha Giàu Cha Nghèo - Tập 5: Doanh Nghiệp Của Thế Kỷ 21', N'Mô hình kinh doanh mạng lưới và kinh tế kết nối hiện đại.', 160000.00, 131000.00, 207, 347, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5a/a1/cb/6d1c9e9875a9ac35d5a5a536f813f4ee.png', 1, '2026-06-05 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (410, N'978-604-020410', N'Thuật Quản Trị Vốn Dành Cho Nhà Đầu Tư', N'Cách phân bổ dòng tiền, quản trị rủi ro thanh khoản và bảo toàn lợi nhuận bền vững.', 98000.00, 80000.00, 150, 419, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/75/47/f1/8d0571eda17578c74710a18d81aad5a2.png', 1, '2026-02-26 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (411, N'978-604-020411', N'Báo Cáo Tài Chính Dưới Góc Nhìn Của Warren Buffett', N'Hướng dẫn phân tích bảng cân đối kế toán và báo cáo lưu chuyển tiền tệ chuẩn xác.', 138000.00, 124000.00, 177, 426, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/55/44/5c/ef26b60328ea00db2ac6358b69a18935.jpg', 1, '2026-07-05 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (412, N'978-604-020412', N'Tư Duy Đặt Cược - Nghệ Thuật Quyết Định', N'Cách các cao thủ poker và nhà đầu tư ra quyết định chính xác trong môi trường bất định.', 75000.00, 66000.00, 57, 202, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/41/02/5e/3ef2506a5e3a7ce69c3b3f5fc6ea3401.jpg', 1, '2026-06-03 10:00:00', 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (413, N'978-604-020413', N'Bản Đồ Chiến Lược Doanh Nghiệp', N'Công cụ biến tầm nhìn trừu tượng thành các bước hành động cụ thể cho toàn bộ nhân sự.', 220000.00, NULL, 168, 476, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/93/8e/2c/a5dd4c236a604246a2c7a79f11e7badb.jpg', 1, '2026-03-13 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (414, N'978-604-020414', N'Văn Hóa Doanh Nghiệp Thời Kỳ Bất Định', N'Cách giữ chân nhân tài và duy trì sức bật tổ chức vượt qua các cuộc khủng hoảng kinh tế.', 145000.00, 116000.00, 190, 548, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/3d/b2/eb/395145ab859d548c23386223bc4f746d.png', 1, '2026-07-27 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (415, N'978-604-020415', N'Khởi Nghiệp Tinh Gọn (The Lean Startup) (Tái bản có bổ sung)', N'Phương pháp xây dựng doanh nghiệp đổi mới sáng tạo, thử nghiệm nhanh và tối ưu hóa chi phí.', 110000.00, 94000.00, 126, 437, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/65/4c/2da4aa944b6f280afbd694ac1a129682.jpeg', 1, '2026-05-05 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (416, N'978-604-020416', N'Từ Không Đến Một (Zero to One) (Tái bản có bổ sung)', N'Bí quyết kiến tạo những sản phẩm độc bản và xây dựng doanh nghiệp thống lĩnh tương lai.', 85000.00, 72000.00, 250, 478, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/i/m/img011.u2751.d20170404.t142005.692809.jpg', 1, '2026-06-04 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (417, N'978-604-020417', N'Gã Nghiện Giày (Shoe Dog) (Tái bản có bổ sung)', N'Hồi ký truyền cảm hứng về hành trình xây dựng đế chế thể thao Nike từ hai bàn tay trắng.', 110000.00, 90000.00, 133, 579, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5e/18/24/2a6154ba08df6ce6161c13f4303fa19e.jpg', 1, '2026-10-22 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (418, N'978-604-020418', N'Từ Tốt Đến Vĩ Đại (Good to Great) (Tái bản có bổ sung)', N'Nghiên cứu kinh điển giải mã bí quyết giúp các công ty bình thường vươn lên thành vĩ đại trường tồn.', 138000.00, 117000.00, 200, 581, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236435314.jpg', 1, '2026-07-13 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (419, N'978-604-020419', N'Xây Dựng Để Trường Tồn (Built to Last) (Tái bản có bổ sung)', N'Những thói quen thành công của các tập đoàn có tầm nhìn vĩ đại qua hàng thập kỷ.', 138000.00, 113000.00, 96, 601, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/70/63/3d/c57040b46e074d49d9e2af573ecefd4e.jpg', 1, '2026-04-25 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (420, N'978-604-020420', N'Nhà Đầu Tư Thông Minh (The Intelligent Investor) (Tái bản có bổ sung)', N'Cẩm nang đầu tư giá trị kinh điển của Benjamin Graham được Warren Buffett khuyên đọc.', 195000.00, 160000.00, 91, 227, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936049952142.jpg', 1, '2026-09-24 10:00:00', 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (421, N'978-604-020421', N'Cổ Phiếu Thường Lợi Nhuận Phi Thường (Tái bản có bổ sung)', N'Chiến lược lựa chọn doanh nghiệp tăng trưởng xuất sắc của huyền thoại Philip Fisher.', 280000.00, 224000.00, 113, 644, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/5/5/554d80fa-8555-4093-b8c0-56e7d00b1a3f.jpg', 1, '2026-10-04 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (422, N'978-604-020422', N'Bước Đi Ngẫu Nhiên Trên Phố Wall (Tái bản có bổ sung)', N'Hướng dẫn đầu tư tài chính thông minh, cân bằng rủi ro và xây dựng danh mục bền vững.', 138000.00, NULL, 224, 588, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235240971.jpg', 1, '2026-04-19 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (423, N'978-604-020423', N'Tâm Lý Học Về Tiền - Những Bài Học Bất Biến (Tái bản có bổ sung)', N'Cách con người đưa ra quyết định tài chính và bản chất thực sự của sự thịnh vượng.', 110000.00, 94000.00, 83, 445, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235230019_1.jpg', 1, '2026-01-08 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (424, N'978-604-020424', N'Chiến Lược Đại Dương Xanh (Tái bản có bổ sung)', N'Cách thức tạo lập khoảng trống thị trường vô tranh và vô hiệu hóa đối thủ cạnh tranh.', 69000.00, 59000.00, 131, 520, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974178408.jpg', 1, '2026-05-07 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (425, N'978-604-020425', N'Marketing 5.0 - Công Nghệ Vị Nhân Sinh (Tái bản có bổ sung)', N'Chiến lược tiếp thị ứng dụng trí tuệ nhân tạo, tự động hóa và phân tích dữ liệu lớn.', 110000.00, 90000.00, 204, 592, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936203361674.jpg', 1, '2026-10-20 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (426, N'978-604-020426', N'22 Quy Luật Bất Biến Trong Marketing (Tái bản có bổ sung)', N'Những nguyên lý cốt lõi bất di bất dịch định hình thành bại của mọi chiến dịch tiếp thị.', 110000.00, 94000.00, 32, 573, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235244177.jpg', 1, '2026-03-23 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (427, N'978-604-020427', N'Nghệ Thuật Lan Truyền (Contagious) (Tái bản có bổ sung)', N'Tại sao sản phẩm, ý tưởng và hành vi lại có sức lan tỏa mạnh mẽ trong cộng đồng.', 98000.00, 80000.00, 149, 625, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936049952142.jpg', 1, '2026-08-26 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (428, N'978-604-020428', N'Bán Niềm Tin Mua Sự Trung Thành (Tái bản có bổ sung)', N'Bí quyết xây dựng trải nghiệm khách hàng vượt trội để biến người mua thành đại sứ thương hiệu.', 110000.00, 97000.00, 225, 525, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936203361674.jpg', 1, '2026-03-21 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (429, N'978-604-020429', N'Quảng Cáo Theo Phong Cách Ogilvy (Tái bản có bổ sung)', N'Bậc thầy David Ogilvy chia sẻ bí quyết viết thông điệp quảng cáo thuyết phục hàng triệu người.', 145000.00, 130000.00, 88, 269, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg', 1, '2026-09-03 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (430, N'978-604-020430', N'Dốc Hết Trái Tim - Xây Dựng Đế Chế Starbucks (Tái bản có bổ sung)', N'Hành trình Howard Schultz biến quán cà phê nhỏ Seattle thành thương hiệu toàn cầu.', 92000.00, 75000.00, 19, 208, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/df/fe/df/08a4a624353b4289b877cf3bced910e4.jpg', 1, '2026-06-01 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (431, N'978-604-020431', N'Steve Jobs - Tiểu Sử Độc Quyền (Tái bản có bổ sung)', N'Chân dung chân thực về thiên tài công nghệ đã định hình lại 6 ngành công nghiệp thế giới.', 175000.00, 140000.00, 123, 610, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/81/9f/74/5f64c3144d59ac007b344589f12cfc8e.jpg', 1, '2026-01-10 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (432, N'978-604-020432', N'Elon Musk - Kẻ Kiến Tạo Tương Lai (Tái bản có bổ sung)', N'Hành trình liều lĩnh của người sáng lập Tesla, SpaceX và giấc mơ đưa nhân loại lên sao Hỏa.', 85000.00, 68000.00, 216, 165, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5e/18/24/2a6154ba08df6ce6161c13f4303fa19e.jpg', 1, '2026-03-26 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (433, N'978-604-020433', N'Tái Tạo Tổ Chức (Reinventing Organizations) (Tái bản có bổ sung)', N'Mô hình quản trị doanh nghiệp tự chủ, minh bạch và phát triển toàn diện con người.', 250000.00, 200000.00, 155, 527, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974099192.jpg', 1, '2026-05-12 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (434, N'978-604-020434', N'OKRs - Đo Lường Điều Quan Trọng (Tái bản có bổ sung)', N'Phương pháp quản trị mục tiêu then chốt được Google, Intel và các tập đoàn hàng đầu tin dùng.', 125000.00, 110000.00, 97, 160, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/b/n/bn01do-1.u2769.d20170607.t182835.572283_2.jpg', 1, '2026-10-19 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (435, N'978-604-020435', N'Bán Hàng Cho Người Khổng Lồ (Tái bản có bổ sung)', N'Chiến thuật chốt các hợp đồng B2B giá trị triệu đô với các tập đoàn đa quốc gia.', 125000.00, 102000.00, 138, 356, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974152507.jpg', 1, '2026-08-07 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (436, N'978-604-020436', N'Nghệ Thuật Bán Hàng Bậc Cao (Tái bản có bổ sung)', N'Phương pháp tiếp cận, thuyết phục và xây dựng mối quan hệ tin cậy với khách hàng khó tính.', 280000.00, 246000.00, 119, 268, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974178408.jpg', 1, '2026-05-27 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (437, N'978-604-020437', N'Kỹ Năng Đàm Phán Thương Lượng Đỉnh Cao (Tái bản có bổ sung)', N'Bí quyết đàm phán win-win đem lại lợi thế tối đa trong mọi cuộc thương thảo thương mại.', 125000.00, 110000.00, 40, 458, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235230019_1.jpg', 1, '2026-10-10 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (438, N'978-604-020438', N'Người Giàu Có Nhất Thành Babylon (Tái bản có bổ sung)', N'Những bài học tiết kiệm, đầu tư và giữ tiền thông minh từ nền văn minh cổ đại.', 160000.00, 131000.00, 62, 673, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235249561.jpg', 1, '2026-06-14 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (439, N'978-604-020439', N'Cha Giàu Cha Nghèo - Tập 1: Để Không Có Tiền Vẫn Tạo Ra Tiền (Tái bản có bổ sung)', N'Tư duy tài chính đột phá về tài sản, tiêu sản và tự do tài chính cá nhân.', 145000.00, 116000.00, 143, 609, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235244177.jpg', 1, '2026-09-05 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (440, N'978-604-020440', N'Cha Giàu Cha Nghèo - Tập 2: Sử Dụng Đồng Vốn (Tái bản có bổ sung)', N'Bí quyết chuyển dịch từ nhóm người làm thuê sang nhóm chủ doanh nghiệp và nhà đầu tư.', 145000.00, 119000.00, 131, 604, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235249561.jpg', 1, '2026-05-22 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (441, N'978-604-020441', N'Cha Giàu Cha Nghèo - Tập 3: Hướng Dẫn Đầu Tư (Tái bản có bổ sung)', N'Cẩm nang hướng dẫn cách tư duy và hành động như một nhà đầu tư chuyên nghiệp.', 138000.00, 113000.00, 82, 612, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235244177.jpg', 1, '2026-03-26 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (442, N'978-604-020442', N'Cha Giàu Cha Nghèo - Tập 4: Nghỉ Hưu Sớm Nghỉ Hưu Giàu (Tái bản có bổ sung)', N'Lộ trình đạt độc lập tài chính và tự do cuộc sống ở độ tuổi thanh xuân.', 250000.00, 205000.00, 204, 577, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-07-03 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (443, N'978-604-020443', N'Cha Giàu Cha Nghèo - Tập 5: Doanh Nghiệp Của Thế Kỷ 21 (Tái bản có bổ sung)', N'Mô hình kinh doanh mạng lưới và kinh tế kết nối hiện đại.', 85000.00, 75000.00, 141, 304, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-05-04 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (444, N'978-604-020444', N'Thuật Quản Trị Vốn Dành Cho Nhà Đầu Tư (Tái bản có bổ sung)', N'Cách phân bổ dòng tiền, quản trị rủi ro thanh khoản và bảo toàn lợi nhuận bền vững.', 220000.00, NULL, 18, 511, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg', 1, '2026-03-13 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (445, N'978-604-020445', N'Báo Cáo Tài Chính Dưới Góc Nhìn Của Warren Buffett (Tái bản có bổ sung)', N'Hướng dẫn phân tích bảng cân đối kế toán và báo cáo lưu chuyển tiền tệ chuẩn xác.', 110000.00, 94000.00, 136, 646, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-09-17 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (446, N'978-604-020446', N'Tư Duy Đặt Cược - Nghệ Thuật Quyết Định (Tái bản có bổ sung)', N'Cách các cao thủ poker và nhà đầu tư ra quyết định chính xác trong môi trường bất định.', 175000.00, NULL, 104, 304, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/t/h/the-psychology-of-money.jpg', 1, '2026-07-09 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (447, N'978-604-020447', N'Bản Đồ Chiến Lược Doanh Nghiệp (Tái bản có bổ sung)', N'Công cụ biến tầm nhìn trừu tượng thành các bước hành động cụ thể cho toàn bộ nhân sự.', 69000.00, 57000.00, 78, 387, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/i/m/image_230367.jpg', 1, '2026-02-15 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (448, N'978-604-020448', N'Văn Hóa Doanh Nghiệp Thời Kỳ Bất Định (Tái bản có bổ sung)', N'Cách giữ chân nhân tài và duy trì sức bật tổ chức vượt qua các cuộc khủng hoảng kinh tế.', 280000.00, NULL, 123, 534, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-09-07 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (449, N'978-604-020449', N'Khởi Nghiệp Tinh Gọn (The Lean Startup) - Ấn bản kỷ niệm', N'Phương pháp xây dựng doanh nghiệp đổi mới sáng tạo, thử nghiệm nhanh và tối ưu hóa chi phí.', 280000.00, 238000.00, 57, 486, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251400267.jpg', 1, '2026-05-25 10:00:00', 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (450, N'978-604-020450', N'Từ Không Đến Một (Zero to One) - Ấn bản kỷ niệm', N'Bí quyết kiến tạo những sản phẩm độc bản và xây dựng doanh nghiệp thống lĩnh tương lai.', 85000.00, 75000.00, 178, 162, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403589.jpg', 1, '2026-01-20 10:00:00', 2, 8);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (451, N'978-604-020451', N'Gã Nghiện Giày (Shoe Dog) - Ấn bản kỷ niệm', N'Hồi ký truyền cảm hứng về hành trình xây dựng đế chế thể thao Nike từ hai bàn tay trắng.', 69000.00, 55000.00, 76, 229, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-10-04 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (452, N'978-604-020452', N'Từ Tốt Đến Vĩ Đại (Good to Great) - Ấn bản kỷ niệm', N'Nghiên cứu kinh điển giải mã bí quyết giúp các công ty bình thường vươn lên thành vĩ đại trường tồn.', 138000.00, 117000.00, 66, 339, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-09-20 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (453, N'978-604-020453', N'Xây Dựng Để Trường Tồn (Built to Last) - Ấn bản kỷ niệm', N'Những thói quen thành công của các tập đoàn có tầm nhìn vĩ đại qua hàng thập kỷ.', 69000.00, 57000.00, 62, 195, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-08-12 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (454, N'978-604-020454', N'Nhà Đầu Tư Thông Minh (The Intelligent Investor) - Ấn bản kỷ niệm', N'Cẩm nang đầu tư giá trị kinh điển của Benjamin Graham được Warren Buffett khuyên đọc.', 110000.00, 97000.00, 56, 591, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-03-19 10:00:00', 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (455, N'978-604-020455', N'Cổ Phiếu Thường Lợi Nhuận Phi Thường - Ấn bản kỷ niệm', N'Chiến lược lựa chọn doanh nghiệp tăng trưởng xuất sắc của huyền thoại Philip Fisher.', 175000.00, 144000.00, 250, 591, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-04-19 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (456, N'978-604-020456', N'Bước Đi Ngẫu Nhiên Trên Phố Wall - Ấn bản kỷ niệm', N'Hướng dẫn đầu tư tài chính thông minh, cân bằng rủi ro và xây dựng danh mục bền vững.', 160000.00, NULL, 120, 186, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-04-13 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (457, N'978-604-020457', N'Tâm Lý Học Về Tiền - Những Bài Học Bất Biến - Ấn bản kỷ niệm', N'Cách con người đưa ra quyết định tài chính và bản chất thực sự của sự thịnh vượng.', 138000.00, 117000.00, 28, 453, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-06-27 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (458, N'978-604-020458', N'Chiến Lược Đại Dương Xanh - Ấn bản kỷ niệm', N'Cách thức tạo lập khoảng trống thị trường vô tranh và vô hiệu hóa đối thủ cạnh tranh.', 175000.00, 144000.00, 217, 284, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-02-11 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (459, N'978-604-020459', N'Marketing 5.0 - Công Nghệ Vị Nhân Sinh - Ấn bản kỷ niệm', N'Chiến lược tiếp thị ứng dụng trí tuệ nhân tạo, tự động hóa và phân tích dữ liệu lớn.', 175000.00, 154000.00, 204, 392, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402773.jpg', 1, '2026-06-21 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (460, N'978-604-020460', N'22 Quy Luật Bất Biến Trong Marketing - Ấn bản kỷ niệm', N'Những nguyên lý cốt lõi bất di bất dịch định hình thành bại của mọi chiến dịch tiếp thị.', 145000.00, 119000.00, 216, 507, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-08-24 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (461, N'978-604-020461', N'Nghệ Thuật Lan Truyền (Contagious) - Ấn bản kỷ niệm', N'Tại sao sản phẩm, ý tưởng và hành vi lại có sức lan tỏa mạnh mẽ trong cộng đồng.', 98000.00, 78000.00, 91, 312, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-03-11 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (462, N'978-604-020462', N'Bán Niềm Tin Mua Sự Trung Thành - Ấn bản kỷ niệm', N'Bí quyết xây dựng trải nghiệm khách hàng vượt trội để biến người mua thành đại sứ thương hiệu.', 175000.00, 154000.00, 145, 542, 2020, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-09-16 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (463, N'978-604-020463', N'Quảng Cáo Theo Phong Cách Ogilvy - Ấn bản kỷ niệm', N'Bậc thầy David Ogilvy chia sẻ bí quyết viết thông điệp quảng cáo thuyết phục hàng triệu người.', 220000.00, 194000.00, 45, 385, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-05-05 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (464, N'978-604-020464', N'Dốc Hết Trái Tim - Xây Dựng Đế Chế Starbucks - Ấn bản kỷ niệm', N'Hành trình Howard Schultz biến quán cà phê nhỏ Seattle thành thương hiệu toàn cầu.', 75000.00, 66000.00, 246, 248, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-05-27 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (465, N'978-604-020465', N'Steve Jobs - Tiểu Sử Độc Quyền - Ấn bản kỷ niệm', N'Chân dung chân thực về thiên tài công nghệ đã định hình lại 6 ngành công nghiệp thế giới.', 220000.00, 198000.00, 107, 348, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-04-06 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (466, N'978-604-020466', N'Elon Musk - Kẻ Kiến Tạo Tương Lai - Ấn bản kỷ niệm', N'Hành trình liều lĩnh của người sáng lập Tesla, SpaceX và giấc mơ đưa nhân loại lên sao Hỏa.', 195000.00, 160000.00, 204, 407, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-08-08 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (467, N'978-604-020467', N'Tái Tạo Tổ Chức (Reinventing Organizations) - Ấn bản kỷ niệm', N'Mô hình quản trị doanh nghiệp tự chủ, minh bạch và phát triển toàn diện con người.', 69000.00, 61000.00, 223, 672, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/t/h/the-psychology-of-money.jpg', 1, '2026-09-13 10:00:00', 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (468, N'978-604-020468', N'OKRs - Đo Lường Điều Quan Trọng - Ấn bản kỷ niệm', N'Phương pháp quản trị mục tiêu then chốt được Google, Intel và các tập đoàn hàng đầu tin dùng.', 250000.00, 205000.00, 217, 552, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/i/m/image_230367.jpg', 1, '2026-04-05 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (469, N'978-604-020469', N'Bán Hàng Cho Người Khổng Lồ - Ấn bản kỷ niệm', N'Chiến thuật chốt các hợp đồng B2B giá trị triệu đô với các tập đoàn đa quốc gia.', 175000.00, 149000.00, 21, 540, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-08-15 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (470, N'978-604-020470', N'Nghệ Thuật Bán Hàng Bậc Cao - Ấn bản kỷ niệm', N'Phương pháp tiếp cận, thuyết phục và xây dựng mối quan hệ tin cậy với khách hàng khó tính.', 250000.00, 200000.00, 238, 334, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251400267.jpg', 1, '2026-06-05 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (471, N'978-604-020471', N'Kỹ Năng Đàm Phán Thương Lượng Đỉnh Cao - Ấn bản kỷ niệm', N'Bí quyết đàm phán win-win đem lại lợi thế tối đa trong mọi cuộc thương thảo thương mại.', 175000.00, 140000.00, 64, 560, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403589.jpg', 1, '2026-03-21 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (472, N'978-604-020472', N'Người Giàu Có Nhất Thành Babylon - Ấn bản kỷ niệm', N'Những bài học tiết kiệm, đầu tư và giữ tiền thông minh từ nền văn minh cổ đại.', 280000.00, NULL, 114, 445, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-02-25 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (473, N'978-604-020473', N'Cha Giàu Cha Nghèo - Tập 1: Để Không Có Tiền Vẫn Tạo Ra Tiền - Ấn bản kỷ niệm', N'Tư duy tài chính đột phá về tài sản, tiêu sản và tự do tài chính cá nhân.', 175000.00, NULL, 55, 587, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-08-24 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (474, N'978-604-020474', N'Cha Giàu Cha Nghèo - Tập 2: Sử Dụng Đồng Vốn - Ấn bản kỷ niệm', N'Bí quyết chuyển dịch từ nhóm người làm thuê sang nhóm chủ doanh nghiệp và nhà đầu tư.', 175000.00, 158000.00, 178, 524, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-04-21 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (475, N'978-604-020475', N'Cha Giàu Cha Nghèo - Tập 3: Hướng Dẫn Đầu Tư - Ấn bản kỷ niệm', N'Cẩm nang hướng dẫn cách tư duy và hành động như một nhà đầu tư chuyên nghiệp.', 145000.00, 116000.00, 250, 574, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-10-08 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (476, N'978-604-020476', N'Cha Giàu Cha Nghèo - Tập 4: Nghỉ Hưu Sớm Nghỉ Hưu Giàu - Ấn bản kỷ niệm', N'Lộ trình đạt độc lập tài chính và tự do cuộc sống ở độ tuổi thanh xuân.', 145000.00, 123000.00, 79, 577, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-03-27 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (477, N'978-604-020477', N'Cha Giàu Cha Nghèo - Tập 5: Doanh Nghiệp Của Thế Kỷ 21 - Ấn bản kỷ niệm', N'Mô hình kinh doanh mạng lưới và kinh tế kết nối hiện đại.', 195000.00, 172000.00, 134, 382, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-05-04 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (478, N'978-604-020478', N'Thuật Quản Trị Vốn Dành Cho Nhà Đầu Tư - Ấn bản kỷ niệm', N'Cách phân bổ dòng tiền, quản trị rủi ro thanh khoản và bảo toàn lợi nhuận bền vững.', 145000.00, 123000.00, 75, 653, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/t/h/the-psychology-of-money.jpg', 1, '2026-07-27 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (479, N'978-604-020479', N'Báo Cáo Tài Chính Dưới Góc Nhìn Của Warren Buffett - Ấn bản kỷ niệm', N'Hướng dẫn phân tích bảng cân đối kế toán và báo cáo lưu chuyển tiền tệ chuẩn xác.', 75000.00, 60000.00, 249, 376, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/i/m/image_230367.jpg', 1, '2026-01-21 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (480, N'978-604-020480', N'Tư Duy Đặt Cược - Nghệ Thuật Quyết Định - Ấn bản kỷ niệm', N'Cách các cao thủ poker và nhà đầu tư ra quyết định chính xác trong môi trường bất định.', 75000.00, 61000.00, 17, 251, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-05-08 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (481, N'978-604-020481', N'Bản Đồ Chiến Lược Doanh Nghiệp - Ấn bản kỷ niệm', N'Công cụ biến tầm nhìn trừu tượng thành các bước hành động cụ thể cho toàn bộ nhân sự.', 69000.00, NULL, 164, 329, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251400267.jpg', 1, '2026-10-02 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (482, N'978-604-020482', N'Văn Hóa Doanh Nghiệp Thời Kỳ Bất Định - Ấn bản kỷ niệm', N'Cách giữ chân nhân tài và duy trì sức bật tổ chức vượt qua các cuộc khủng hoảng kinh tế.', 98000.00, NULL, 187, 582, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403589.jpg', 1, '2026-08-01 10:00:00', 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (483, N'978-604-020483', N'Khởi Nghiệp Tinh Gọn (The Lean Startup) (Bìa cứng mỹ thuật)', N'Phương pháp xây dựng doanh nghiệp đổi mới sáng tạo, thử nghiệm nhanh và tối ưu hóa chi phí.', 160000.00, 136000.00, 200, 272, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-08-06 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (484, N'978-604-020484', N'Từ Không Đến Một (Zero to One) (Bìa cứng mỹ thuật)', N'Bí quyết kiến tạo những sản phẩm độc bản và xây dựng doanh nghiệp thống lĩnh tương lai.', 138000.00, 117000.00, 45, 404, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-07-09 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (485, N'978-604-020485', N'Gã Nghiện Giày (Shoe Dog) (Bìa cứng mỹ thuật)', N'Hồi ký truyền cảm hứng về hành trình xây dựng đế chế thể thao Nike từ hai bàn tay trắng.', 85000.00, 68000.00, 85, 229, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-04-21 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (486, N'978-604-020486', N'Từ Tốt Đến Vĩ Đại (Good to Great) (Bìa cứng mỹ thuật)', N'Nghiên cứu kinh điển giải mã bí quyết giúp các công ty bình thường vươn lên thành vĩ đại trường tồn.', 138000.00, 124000.00, 181, 179, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-06-06 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (487, N'978-604-020487', N'Xây Dựng Để Trường Tồn (Built to Last) (Bìa cứng mỹ thuật)', N'Những thói quen thành công của các tập đoàn có tầm nhìn vĩ đại qua hàng thập kỷ.', 195000.00, 160000.00, 24, 282, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-10-24 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (488, N'978-604-020488', N'Nhà Đầu Tư Thông Minh (The Intelligent Investor) (Bìa cứng mỹ thuật)', N'Cẩm nang đầu tư giá trị kinh điển của Benjamin Graham được Warren Buffett khuyên đọc.', 160000.00, 131000.00, 49, 379, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-10-26 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (489, N'978-604-020489', N'Cổ Phiếu Thường Lợi Nhuận Phi Thường (Bìa cứng mỹ thuật)', N'Chiến lược lựa chọn doanh nghiệp tăng trưởng xuất sắc của huyền thoại Philip Fisher.', 175000.00, NULL, 90, 595, 2022, N'en', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-02-07 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (490, N'978-604-020490', N'Bước Đi Ngẫu Nhiên Trên Phố Wall (Bìa cứng mỹ thuật)', N'Hướng dẫn đầu tư tài chính thông minh, cân bằng rủi ro và xây dựng danh mục bền vững.', 280000.00, 230000.00, 143, 442, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-06-16 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (491, N'978-604-020491', N'Tâm Lý Học Về Tiền - Những Bài Học Bất Biến (Bìa cứng mỹ thuật)', N'Cách con người đưa ra quyết định tài chính và bản chất thực sự của sự thịnh vượng.', 92000.00, 74000.00, 103, 487, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-08-25 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (492, N'978-604-020492', N'Chiến Lược Đại Dương Xanh (Bìa cứng mỹ thuật)', N'Cách thức tạo lập khoảng trống thị trường vô tranh và vô hiệu hóa đối thủ cạnh tranh.', 98000.00, NULL, 73, 269, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-09-11 10:00:00', 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (493, N'978-604-020493', N'Marketing 5.0 - Công Nghệ Vị Nhân Sinh (Bìa cứng mỹ thuật)', N'Chiến lược tiếp thị ứng dụng trí tuệ nhân tạo, tự động hóa và phân tích dữ liệu lớn.', 250000.00, 220000.00, 203, 292, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-04-25 10:00:00', 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (494, N'978-604-020494', N'22 Quy Luật Bất Biến Trong Marketing (Bìa cứng mỹ thuật)', N'Những nguyên lý cốt lõi bất di bất dịch định hình thành bại của mọi chiến dịch tiếp thị.', 145000.00, NULL, 202, 360, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-02-28 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (495, N'978-604-020495', N'Nghệ Thuật Lan Truyền (Contagious) (Bìa cứng mỹ thuật)', N'Tại sao sản phẩm, ý tưởng và hành vi lại có sức lan tỏa mạnh mẽ trong cộng đồng.', 250000.00, NULL, 77, 444, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-03-10 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (496, N'978-604-020496', N'Bán Niềm Tin Mua Sự Trung Thành (Bìa cứng mỹ thuật)', N'Bí quyết xây dựng trải nghiệm khách hàng vượt trội để biến người mua thành đại sứ thương hiệu.', 175000.00, 154000.00, 33, 353, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-05-27 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (497, N'978-604-020497', N'Quảng Cáo Theo Phong Cách Ogilvy (Bìa cứng mỹ thuật)', N'Bậc thầy David Ogilvy chia sẻ bí quyết viết thông điệp quảng cáo thuyết phục hàng triệu người.', 250000.00, 220000.00, 165, 538, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-05-04 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (498, N'978-604-020498', N'Dốc Hết Trái Tim - Xây Dựng Đế Chế Starbucks (Bìa cứng mỹ thuật)', N'Hành trình Howard Schultz biến quán cà phê nhỏ Seattle thành thương hiệu toàn cầu.', 280000.00, 238000.00, 182, 601, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-02-27 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (499, N'978-604-020499', N'Steve Jobs - Tiểu Sử Độc Quyền (Bìa cứng mỹ thuật)', N'Chân dung chân thực về thiên tài công nghệ đã định hình lại 6 ngành công nghiệp thế giới.', 110000.00, 94000.00, 73, 210, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-05-12 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (500, N'978-604-020500', N'Elon Musk - Kẻ Kiến Tạo Tương Lai (Bìa cứng mỹ thuật)', N'Hành trình liều lĩnh của người sáng lập Tesla, SpaceX và giấc mơ đưa nhân loại lên sao Hỏa.', 92000.00, 83000.00, 204, 390, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-09-13 10:00:00', 2, 5);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (501, N'978-604-020501', N'Tái Tạo Tổ Chức (Reinventing Organizations) (Bìa cứng mỹ thuật)', N'Mô hình quản trị doanh nghiệp tự chủ, minh bạch và phát triển toàn diện con người.', 280000.00, 230000.00, 195, 364, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-06-08 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (502, N'978-604-020502', N'OKRs - Đo Lường Điều Quan Trọng (Bìa cứng mỹ thuật)', N'Phương pháp quản trị mục tiêu then chốt được Google, Intel và các tập đoàn hàng đầu tin dùng.', 110000.00, 99000.00, 171, 375, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-01-09 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (503, N'978-604-020503', N'Bán Hàng Cho Người Khổng Lồ (Bìa cứng mỹ thuật)', N'Chiến thuật chốt các hợp đồng B2B giá trị triệu đô với các tập đoàn đa quốc gia.', 85000.00, 68000.00, 62, 570, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-07-11 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (504, N'978-604-020504', N'Nghệ Thuật Bán Hàng Bậc Cao (Bìa cứng mỹ thuật)', N'Phương pháp tiếp cận, thuyết phục và xây dựng mối quan hệ tin cậy với khách hàng khó tính.', 110000.00, 90000.00, 152, 393, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-05-13 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (505, N'978-604-020505', N'Kỹ Năng Đàm Phán Thương Lượng Đỉnh Cao (Bìa cứng mỹ thuật)', N'Bí quyết đàm phán win-win đem lại lợi thế tối đa trong mọi cuộc thương thảo thương mại.', 69000.00, 59000.00, 84, 525, 2023, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410198.jpg', 1, '2026-08-25 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (506, N'978-604-020506', N'Người Giàu Có Nhất Thành Babylon (Bìa cứng mỹ thuật)', N'Những bài học tiết kiệm, đầu tư và giữ tiền thông minh từ nền văn minh cổ đại.', 138000.00, 121000.00, 37, 663, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-01-08 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (507, N'978-604-020507', N'Cha Giàu Cha Nghèo - Tập 1: Để Không Có Tiền Vẫn Tạo Ra Tiền (Bìa cứng mỹ thuật)', N'Tư duy tài chính đột phá về tài sản, tiêu sản và tự do tài chính cá nhân.', 250000.00, NULL, 146, 166, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-09-08 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (508, N'978-604-020508', N'Cha Giàu Cha Nghèo - Tập 2: Sử Dụng Đồng Vốn (Bìa cứng mỹ thuật)', N'Bí quyết chuyển dịch từ nhóm người làm thuê sang nhóm chủ doanh nghiệp và nhà đầu tư.', 98000.00, 80000.00, 140, 496, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-03-20 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (509, N'978-604-020509', N'Cha Giàu Cha Nghèo - Tập 3: Hướng Dẫn Đầu Tư (Bìa cứng mỹ thuật)', N'Cẩm nang hướng dẫn cách tư duy và hành động như một nhà đầu tư chuyên nghiệp.', 145000.00, 130000.00, 106, 372, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-03-13 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (510, N'978-604-020510', N'Cha Giàu Cha Nghèo - Tập 4: Nghỉ Hưu Sớm Nghỉ Hưu Giàu (Bìa cứng mỹ thuật)', N'Lộ trình đạt độc lập tài chính và tự do cuộc sống ở độ tuổi thanh xuân.', 280000.00, 224000.00, 214, 579, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-01-16 10:00:00', 2, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (511, N'978-604-020511', N'Cha Giàu Cha Nghèo - Tập 5: Doanh Nghiệp Của Thế Kỷ 21 (Bìa cứng mỹ thuật)', N'Mô hình kinh doanh mạng lưới và kinh tế kết nối hiện đại.', 110000.00, 90000.00, 158, 545, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-02-24 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (512, N'978-604-020512', N'Thuật Quản Trị Vốn Dành Cho Nhà Đầu Tư (Bìa cứng mỹ thuật)', N'Cách phân bổ dòng tiền, quản trị rủi ro thanh khoản và bảo toàn lợi nhuận bền vững.', 98000.00, 83000.00, 80, 317, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-07-18 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (513, N'978-604-020513', N'Báo Cáo Tài Chính Dưới Góc Nhìn Của Warren Buffett (Bìa cứng mỹ thuật)', N'Hướng dẫn phân tích bảng cân đối kế toán và báo cáo lưu chuyển tiền tệ chuẩn xác.', 220000.00, 198000.00, 241, 246, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-08-21 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (514, N'978-604-020514', N'Tư Duy Đặt Cược - Nghệ Thuật Quyết Định (Bìa cứng mỹ thuật)', N'Cách các cao thủ poker và nhà đầu tư ra quyết định chính xác trong môi trường bất định.', 85000.00, 76000.00, 105, 430, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-05-19 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (515, N'978-604-020515', N'Bản Đồ Chiến Lược Doanh Nghiệp (Bìa cứng mỹ thuật)', N'Công cụ biến tầm nhìn trừu tượng thành các bước hành động cụ thể cho toàn bộ nhân sự.', 110000.00, NULL, 235, 363, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-04-25 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (516, N'978-604-020516', N'Văn Hóa Doanh Nghiệp Thời Kỳ Bất Định (Bìa cứng mỹ thuật)', N'Cách giữ chân nhân tài và duy trì sức bật tổ chức vượt qua các cuộc khủng hoảng kinh tế.', 69000.00, 59000.00, 126, 540, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-01-03 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (517, N'978-604-020517', N'Khởi Nghiệp Tinh Gọn (The Lean Startup) - Tập 5', N'Phương pháp xây dựng doanh nghiệp đổi mới sáng tạo, thử nghiệm nhanh và tối ưu hóa chi phí.', 175000.00, 140000.00, 140, 481, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-04-25 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (518, N'978-604-020518', N'Từ Không Đến Một (Zero to One) - Tập 5', N'Bí quyết kiến tạo những sản phẩm độc bản và xây dựng doanh nghiệp thống lĩnh tương lai.', 110000.00, 94000.00, 248, 285, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-01-06 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (519, N'978-604-020519', N'Gã Nghiện Giày (Shoe Dog) - Tập 5', N'Hồi ký truyền cảm hứng về hành trình xây dựng đế chế thể thao Nike từ hai bàn tay trắng.', 110000.00, 94000.00, 155, 285, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-05-08 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (520, N'978-604-020520', N'Từ Tốt Đến Vĩ Đại (Good to Great) - Tập 5', N'Nghiên cứu kinh điển giải mã bí quyết giúp các công ty bình thường vươn lên thành vĩ đại trường tồn.', 220000.00, 180000.00, 25, 414, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-06-14 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (521, N'978-604-020521', N'Xây Dựng Để Trường Tồn (Built to Last) - Tập 5', N'Những thói quen thành công của các tập đoàn có tầm nhìn vĩ đại qua hàng thập kỷ.', 250000.00, 212000.00, 202, 236, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-05-15 10:00:00', 2, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (522, N'978-604-020522', N'Nhà Đầu Tư Thông Minh (The Intelligent Investor) - Tập 5', N'Cẩm nang đầu tư giá trị kinh điển của Benjamin Graham được Warren Buffett khuyên đọc.', 195000.00, 166000.00, 228, 583, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-07-26 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (523, N'978-604-020523', N'Cổ Phiếu Thường Lợi Nhuận Phi Thường - Tập 5', N'Chiến lược lựa chọn doanh nghiệp tăng trưởng xuất sắc của huyền thoại Philip Fisher.', 280000.00, 224000.00, 104, 333, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-04-10 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (524, N'978-604-020524', N'Bước Đi Ngẫu Nhiên Trên Phố Wall - Tập 5', N'Hướng dẫn đầu tư tài chính thông minh, cân bằng rủi ro và xây dựng danh mục bền vững.', 195000.00, NULL, 233, 203, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-10-28 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (525, N'978-604-020525', N'Tâm Lý Học Về Tiền - Những Bài Học Bất Biến - Tập 5', N'Cách con người đưa ra quyết định tài chính và bản chất thực sự của sự thịnh vượng.', 92000.00, 83000.00, 217, 220, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-01-17 10:00:00', 2, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (526, N'978-604-020526', N'Chiến Lược Đại Dương Xanh - Tập 5', N'Cách thức tạo lập khoảng trống thị trường vô tranh và vô hiệu hóa đối thủ cạnh tranh.', 125000.00, 110000.00, 17, 429, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-07-09 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (527, N'978-604-020527', N'Marketing 5.0 - Công Nghệ Vị Nhân Sinh - Tập 5', N'Chiến lược tiếp thị ứng dụng trí tuệ nhân tạo, tự động hóa và phân tích dữ liệu lớn.', 220000.00, 194000.00, 59, 374, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-05-22 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (528, N'978-604-020528', N'22 Quy Luật Bất Biến Trong Marketing - Tập 5', N'Những nguyên lý cốt lõi bất di bất dịch định hình thành bại của mọi chiến dịch tiếp thị.', 220000.00, 187000.00, 214, 671, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-01-25 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (529, N'978-604-020529', N'Nghệ Thuật Lan Truyền (Contagious) - Tập 5', N'Tại sao sản phẩm, ý tưởng và hành vi lại có sức lan tỏa mạnh mẽ trong cộng đồng.', 195000.00, 156000.00, 186, 306, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124012.jpg', 1, '2026-10-12 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (530, N'978-604-020530', N'Bán Niềm Tin Mua Sự Trung Thành - Tập 5', N'Bí quyết xây dựng trải nghiệm khách hàng vượt trội để biến người mua thành đại sứ thương hiệu.', 175000.00, 140000.00, 203, 457, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-03-12 10:00:00', 2, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (531, N'978-604-020531', N'Quảng Cáo Theo Phong Cách Ogilvy - Tập 5', N'Bậc thầy David Ogilvy chia sẻ bí quyết viết thông điệp quảng cáo thuyết phục hàng triệu người.', 220000.00, 187000.00, 117, 353, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-01-08 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (532, N'978-604-020532', N'Dốc Hết Trái Tim - Xây Dựng Đế Chế Starbucks - Tập 5', N'Hành trình Howard Schultz biến quán cà phê nhỏ Seattle thành thương hiệu toàn cầu.', 92000.00, NULL, 100, 373, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-09-03 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (533, N'978-604-020533', N'Steve Jobs - Tiểu Sử Độc Quyền - Tập 5', N'Chân dung chân thực về thiên tài công nghệ đã định hình lại 6 ngành công nghiệp thế giới.', 85000.00, 68000.00, 48, 419, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-02-01 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (534, N'978-604-020534', N'Elon Musk - Kẻ Kiến Tạo Tương Lai - Tập 5', N'Hành trình liều lĩnh của người sáng lập Tesla, SpaceX và giấc mơ đưa nhân loại lên sao Hỏa.', 75000.00, 60000.00, 164, 276, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-04-12 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (535, N'978-604-020535', N'Tái Tạo Tổ Chức (Reinventing Organizations) - Tập 5', N'Mô hình quản trị doanh nghiệp tự chủ, minh bạch và phát triển toàn diện con người.', 92000.00, 83000.00, 19, 401, 2023, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-01-18 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (536, N'978-604-020536', N'OKRs - Đo Lường Điều Quan Trọng - Tập 5', N'Phương pháp quản trị mục tiêu then chốt được Google, Intel và các tập đoàn hàng đầu tin dùng.', 98000.00, 80000.00, 131, 323, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-02-07 10:00:00', 2, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (537, N'978-604-020537', N'Bán Hàng Cho Người Khổng Lồ - Tập 5', N'Chiến thuật chốt các hợp đồng B2B giá trị triệu đô với các tập đoàn đa quốc gia.', 75000.00, 66000.00, 37, 248, 2022, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-02-24 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (538, N'978-604-020538', N'Nghệ Thuật Bán Hàng Bậc Cao - Tập 5', N'Phương pháp tiếp cận, thuyết phục và xây dựng mối quan hệ tin cậy với khách hàng khó tính.', 195000.00, 160000.00, 29, 446, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-06-22 10:00:00', 2, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (539, N'978-604-020539', N'Kỹ Năng Đàm Phán Thương Lượng Đỉnh Cao - Tập 5', N'Bí quyết đàm phán win-win đem lại lợi thế tối đa trong mọi cuộc thương thảo thương mại.', 125000.00, 102000.00, 55, 586, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-01-25 10:00:00', 2, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (540, N'978-604-020540', N'Người Giàu Có Nhất Thành Babylon - Tập 5', N'Những bài học tiết kiệm, đầu tư và giữ tiền thông minh từ nền văn minh cổ đại.', 75000.00, 60000.00, 236, 186, 2023, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-05-13 10:00:00', 2, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (541, N'978-604-030541', N'Atomic Habits - Thay Đổi Tí Hon Hiệu Quả Bất Ngờ', N'Hệ thống xây dựng thói quen tốt và loại bỏ thói quen xấu dựa trên khoa học hành vi.', 98000.00, 80000.00, 220, 259, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-05-12 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (542, N'978-604-030542', N'Sức Mạnh Của Thói Quen (The Power of Habit)', N'Vòng lặp thói quen: Gợi ý, Hành động, Phần thưởng và bí quyết tái lập trình não bộ.', 195000.00, NULL, 64, 436, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-05-14 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (543, N'978-604-030543', N'Deep Work - Làm Ra Làm Chơi Ra Chơi', N'Nghệ thuật tập trung cao độ trong một thế giới đầy xao nhãng để tạo ra giá trị đột phá.', 145000.00, 130000.00, 222, 434, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-09-18 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (544, N'978-604-030544', N'Digital Minimalism - Sống Tối Giản Thời Công Nghệ', N'Cách giải phóng bản thân khỏi nghiện mạng xã hội và lấy lại sự tập trung thanh thản.', 160000.00, 131000.00, 29, 566, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-07-27 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (545, N'978-604-030545', N'Tư Duy Nhanh Và Chậm (Thinking, Fast and Slow)', N'Hai hệ thống tư duy chi phối mọi quyết định và những cạm bẫy định kiến nhận thức.', 125000.00, 100000.00, 148, 277, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-04-25 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (546, N'978-604-030546', N'7 Thói Quen Để Thành Đạt (The 7 Habits)', N'Nguyên lý phát triển nhân cách toàn diện và năng lực lãnh đạo từ bên trong.', 145000.00, 128000.00, 135, 397, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-09-13 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (547, N'978-604-030547', N'Đắc Nhân Tâm (Khổ Lớn Đặc Biệt)', N'Nghệ thuật thu phục lòng người, tạo dựng thiện cảm và xây dựng quan hệ bền vững.', 175000.00, 144000.00, 246, 189, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-01-03 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (548, N'978-604-030548', N'Quẳng Gánh Lo Đi Và Vui Sống', N'Bí quyết xua tan âu lo, làm chủ căng thẳng và tận hưởng cuộc sống trọn vẹn mỗi ngày.', 92000.00, NULL, 142, 225, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-10-26 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (549, N'978-604-030549', N'Khéo Ăn Nói Sẽ Có Được Thiên Hạ', N'Kỹ năng giao tiếp ứng biến linh hoạt trong công sở, gia đình và các mối quan hệ xã hội.', 98000.00, NULL, 161, 532, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124012.jpg', 1, '2026-08-01 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (550, N'978-604-030550', N'Nghệ Thuật Lắng Nghe Trong Giao Tiếp', N'Sức mạnh của sự tĩnh lặng và thấu hiểu chiều sâu cảm xúc đối phương.', 175000.00, 140000.00, 63, 579, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-08-15 10:00:00', 3, 3);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (551, N'978-604-030551', N'Đọc Vị Bất Kỳ Ai - Để Không Bị Thao Túng', N'Nhận biết ngôn ngữ cơ thể, vi biểu cảm và nắm bắt tâm lý người đối diện chuẩn xác.', 110000.00, 88000.00, 31, 489, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-01-23 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (552, N'978-604-030552', N'Thôi Miên Bằng Ngôn Từ', N'Nghệ thuật sử dụng từ ngữ ma lực để lay động cảm xúc và thuyết phục người nghe.', 138000.00, 117000.00, 220, 473, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-04-14 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (553, N'978-604-030553', N'Câu Lạc Bộ 5 Giờ Sáng', N'Thói quen làm chủ buổi sáng để nâng tầm cuộc sống, kích hoạt năng lượng và sự sáng tạo.', 145000.00, 119000.00, 166, 620, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-02-24 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (554, N'978-604-030554', N'Nhà Sư Bán Chiếc Ferrari', N'Hành trình tìm về chân giá trị cuộc sống, bình an tâm hồn và ý nghĩa đích thực của sự tồn tại.', 220000.00, 187000.00, 162, 452, 2019, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-07-17 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (555, N'978-604-030555', N'Thuật Thao Túng Tâm Lý & Nhận Diện Thao Túng', N'Cách nhận biết các chiêu trò gaslighting và bảo vệ ranh giới cá nhân lành mạnh.', 195000.00, 176000.00, 202, 611, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-02-02 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (556, N'978-604-030556', N'Sức Bền (Grit) - Sức Mạnh Của Niềm Đam Mê', N'Tại sao sự kiên trì bền bỉ lại quyết định thành công hơn tài năng bẩm sinh.', 250000.00, 220000.00, 42, 455, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-09-16 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (557, N'978-604-030557', N'Kỷ Luật Tự Giác - Vũ Khí Của Kẻ Mạnh', N'Cách chiến thắng sự trì hoãn và duy trì thói quen tự giác sắt đá.', 75000.00, 66000.00, 154, 308, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124012.jpg', 1, '2026-09-11 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (558, N'978-604-030558', N'Hoàn Thành Mọi Việc Không Hề Khó (GTD)', N'Phương pháp tổ chức công việc và dọn dẹp tâm trí để đạt hiệu suất tối đa.', 220000.00, 198000.00, 99, 428, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-05-09 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (559, N'978-604-030559', N'Làm Chủ Tư Duy Thay Đổi Vận Mệnh', N'Phương pháp lập trình ngôn ngữ tư duy NLP để khai phóng tiềm năng ẩn giấu.', 280000.00, 238000.00, 38, 449, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-02-14 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (560, N'978-604-030560', N'An Lạc Từng Bước Chân', N'Thực hành chánh niệm trong từng hơi thở, bước đi để tìm thấy an lạc giữa cuộc sống bộn bề.', 110000.00, 90000.00, 113, 357, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg', 1, '2026-09-26 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (561, N'978-604-030561', N'Giận - Chuyển Hóa Cơn Giận Bằng Yêu Thương', N'Phương thuốc diệu kỳ làm dịu tâm can và chuyển hóa năng lượng tiêu cực.', 69000.00, 59000.00, 126, 183, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-08-24 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (562, N'978-604-030562', N'Hiểu Về Trái Tim', N'Tác phẩm soi rọi từng ngõ ngách cảm xúc: Yêu, Ghét, Đau Khổ, Bao Dung và Hạnh Phúc.', 145000.00, 123000.00, 114, 165, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703578.jpg', 1, '2026-10-06 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (563, N'978-604-030563', N'Không Diệt Không Sinh Đừng Sợ Hãi', N'Lời khai thị nhẹ nhàng về sự vô thường của kiếp nhân sinh và giải phóng nỗi sợ cái chết.', 280000.00, 252000.00, 202, 293, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703585.jpg', 1, '2026-01-27 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (564, N'978-604-030564', N'Nghệ Thuật Sống Khắc Kỷ', N'Triết lý sống kiên cường, thản nhiên trước nghịch cảnh và làm chủ những gì trong tầm kiểm soát.', 145000.00, NULL, 65, 361, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236427357.jpg', 1, '2026-09-15 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (565, N'978-604-030565', N'Suy Tưởng (Meditations - Marcus Aurelius)', N'Nhật ký nội tâm của vị hoàng đế La Mã về nghĩa vụ, sự khiêm nhường và kỷ luật tự thân.', 125000.00, 110000.00, 76, 179, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426787.jpg', 1, '2026-09-01 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (566, N'978-604-030566', N'Chủ Nghĩa Tối Giản Trong Lối Sống', N'Bỏ bớt đồ đạc để giải phóng không gian, dọn dẹp tâm trí để chào đón niềm vui bình dị.', 85000.00, 70000.00, 165, 193, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703592.jpg', 1, '2026-06-12 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (567, N'978-604-030567', N'Tìm Lại Chính Mình', N'Hành trình chữa lành những tổn thương thơ ấu và thiết lập mối liên kết sâu sắc với bản ngã.', 92000.00, 81000.00, 219, 360, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg', 1, '2026-06-06 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (568, N'978-604-030568', N'Cân Bằng Cảm Xúc Lúc Bão Giông', N'Cách thức xoa dịu những cơn hoảng loạn, âu lo và lấy lại sự tự tin nội tại.', 98000.00, 78000.00, 59, 384, 2023, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-07-01 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (569, N'978-604-030569', N'Atomic Habits - Thay Đổi Tí Hon Hiệu Quả Bất Ngờ (Tái bản có bổ sung)', N'Hệ thống xây dựng thói quen tốt và loại bỏ thói quen xấu dựa trên khoa học hành vi.', 92000.00, 75000.00, 151, 413, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703578.jpg', 1, '2026-02-21 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (570, N'978-604-030570', N'Sức Mạnh Của Thói Quen (The Power of Habit) (Tái bản có bổ sung)', N'Vòng lặp thói quen: Gợi ý, Hành động, Phần thưởng và bí quyết tái lập trình não bộ.', 110000.00, 94000.00, 81, 411, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703585.jpg', 1, '2026-09-24 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (571, N'978-604-030571', N'Deep Work - Làm Ra Làm Chơi Ra Chơi (Tái bản có bổ sung)', N'Nghệ thuật tập trung cao độ trong một thế giới đầy xao nhãng để tạo ra giá trị đột phá.', 195000.00, 172000.00, 30, 190, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236427357.jpg', 1, '2026-05-23 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (572, N'978-604-030572', N'Digital Minimalism - Sống Tối Giản Thời Công Nghệ (Tái bản có bổ sung)', N'Cách giải phóng bản thân khỏi nghiện mạng xã hội và lấy lại sự tập trung thanh thản.', 98000.00, 80000.00, 102, 437, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426787.jpg', 1, '2026-04-09 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (573, N'978-604-030573', N'Tư Duy Nhanh Và Chậm (Thinking, Fast and Slow) (Tái bản có bổ sung)', N'Hai hệ thống tư duy chi phối mọi quyết định và những cạm bẫy định kiến nhận thức.', 125000.00, 112000.00, 174, 423, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554102.jpg', 1, '2026-10-14 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (574, N'978-604-030574', N'7 Thói Quen Để Thành Đạt (The 7 Habits) (Tái bản có bổ sung)', N'Nguyên lý phát triển nhân cách toàn diện và năng lực lãnh đạo từ bên trong.', 85000.00, 70000.00, 110, 450, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554102.jpg', 1, '2026-10-20 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (575, N'978-604-030575', N'Đắc Nhân Tâm (Khổ Lớn Đặc Biệt) (Tái bản có bổ sung)', N'Nghệ thuật thu phục lòng người, tạo dựng thiện cảm và xây dựng quan hệ bền vững.', 250000.00, 212000.00, 15, 637, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703592.jpg', 1, '2026-06-15 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (576, N'978-604-030576', N'Quẳng Gánh Lo Đi Và Vui Sống (Tái bản có bổ sung)', N'Bí quyết xua tan âu lo, làm chủ căng thẳng và tận hưởng cuộc sống trọn vẹn mỗi ngày.', 98000.00, NULL, 23, 417, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-02-20 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (577, N'978-604-030577', N'Khéo Ăn Nói Sẽ Có Được Thiên Hạ (Tái bản có bổ sung)', N'Kỹ năng giao tiếp ứng biến linh hoạt trong công sở, gia đình và các mối quan hệ xã hội.', 145000.00, 116000.00, 45, 161, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703578.jpg', 1, '2026-05-10 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (578, N'978-604-030578', N'Nghệ Thuật Lắng Nghe Trong Giao Tiếp (Tái bản có bổ sung)', N'Sức mạnh của sự tĩnh lặng và thấu hiểu chiều sâu cảm xúc đối phương.', 138000.00, 110000.00, 162, 207, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703585.jpg', 1, '2026-07-11 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (579, N'978-604-030579', N'Đọc Vị Bất Kỳ Ai - Để Không Bị Thao Túng (Tái bản có bổ sung)', N'Nhận biết ngôn ngữ cơ thể, vi biểu cảm và nắm bắt tâm lý người đối diện chuẩn xác.', 220000.00, 180000.00, 202, 430, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236427357.jpg', 1, '2026-07-21 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (580, N'978-604-030580', N'Thôi Miên Bằng Ngôn Từ (Tái bản có bổ sung)', N'Nghệ thuật sử dụng từ ngữ ma lực để lay động cảm xúc và thuyết phục người nghe.', 125000.00, 102000.00, 233, 261, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426787.jpg', 1, '2026-01-23 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (581, N'978-604-030581', N'Câu Lạc Bộ 5 Giờ Sáng (Tái bản có bổ sung)', N'Thói quen làm chủ buổi sáng để nâng tầm cuộc sống, kích hoạt năng lượng và sự sáng tạo.', 75000.00, NULL, 40, 195, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554102.jpg', 1, '2026-04-13 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (582, N'978-604-030582', N'Nhà Sư Bán Chiếc Ferrari (Tái bản có bổ sung)', N'Hành trình tìm về chân giá trị cuộc sống, bình an tâm hồn và ý nghĩa đích thực của sự tồn tại.', 280000.00, 224000.00, 235, 369, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703592.jpg', 1, '2026-08-16 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (583, N'978-604-030583', N'Thuật Thao Túng Tâm Lý & Nhận Diện Thao Túng (Tái bản có bổ sung)', N'Cách nhận biết các chiêu trò gaslighting và bảo vệ ranh giới cá nhân lành mạnh.', 75000.00, NULL, 213, 525, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg', 1, '2026-06-22 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (584, N'978-604-030584', N'Sức Bền (Grit) - Sức Mạnh Của Niềm Đam Mê (Tái bản có bổ sung)', N'Tại sao sự kiên trì bền bỉ lại quyết định thành công hơn tài năng bẩm sinh.', 175000.00, 144000.00, 97, 312, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-06-13 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (585, N'978-604-030585', N'Kỷ Luật Tự Giác - Vũ Khí Của Kẻ Mạnh (Tái bản có bổ sung)', N'Cách chiến thắng sự trì hoãn và duy trì thói quen tự giác sắt đá.', 125000.00, 110000.00, 151, 630, 2021, N'en', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/65/4c/2da4aa944b6f280afbd694ac1a129682.jpeg', 1, '2026-03-21 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (586, N'978-604-030586', N'Hoàn Thành Mọi Việc Không Hề Khó (GTD) (Tái bản có bổ sung)', N'Phương pháp tổ chức công việc và dọn dẹp tâm trí để đạt hiệu suất tối đa.', 220000.00, 194000.00, 155, 377, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235222533.jpg', 1, '2026-10-16 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (587, N'978-604-030587', N'Làm Chủ Tư Duy Thay Đổi Vận Mệnh (Tái bản có bổ sung)', N'Phương pháp lập trình ngôn ngữ tư duy NLP để khai phóng tiềm năng ẩn giấu.', 250000.00, 220000.00, 125, 555, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230004561.jpg', 1, '2026-06-05 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (588, N'978-604-030588', N'An Lạc Từng Bước Chân (Tái bản có bổ sung)', N'Thực hành chánh niệm trong từng hơi thở, bước đi để tìm thấy an lạc giữa cuộc sống bộn bề.', 85000.00, 75000.00, 240, 186, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425155.jpg', 1, '2026-04-02 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (589, N'978-604-030589', N'Giận - Chuyển Hóa Cơn Giận Bằng Yêu Thương (Tái bản có bổ sung)', N'Phương thuốc diệu kỳ làm dịu tâm can và chuyển hóa năng lượng tiêu cực.', 145000.00, 123000.00, 165, 658, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425124.jpg', 1, '2026-10-26 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (590, N'978-604-030590', N'Hiểu Về Trái Tim (Tái bản có bổ sung)', N'Tác phẩm soi rọi từng ngõ ngách cảm xúc: Yêu, Ghét, Đau Khổ, Bao Dung và Hạnh Phúc.', 145000.00, 119000.00, 227, 220, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425131.jpg', 1, '2026-05-26 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (591, N'978-604-030591', N'Không Diệt Không Sinh Đừng Sợ Hãi (Tái bản có bổ sung)', N'Lời khai thị nhẹ nhàng về sự vô thường của kiếp nhân sinh và giải phóng nỗi sợ cái chết.', 98000.00, 88000.00, 88, 424, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425148.jpg', 1, '2026-07-15 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (592, N'978-604-030592', N'Nghệ Thuật Sống Khắc Kỷ (Tái bản có bổ sung)', N'Triết lý sống kiên cường, thản nhiên trước nghịch cảnh và làm chủ những gì trong tầm kiểm soát.', 75000.00, 61000.00, 49, 265, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230005032.jpg', 1, '2026-03-13 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (593, N'978-604-030593', N'Suy Tưởng (Meditations - Marcus Aurelius) (Tái bản có bổ sung)', N'Nhật ký nội tâm của vị hoàng đế La Mã về nghĩa vụ, sự khiêm nhường và kỷ luật tự thân.', 280000.00, 230000.00, 238, 227, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425155.jpg', 1, '2026-01-03 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (594, N'978-604-030594', N'Chủ Nghĩa Tối Giản Trong Lối Sống (Tái bản có bổ sung)', N'Bỏ bớt đồ đạc để giải phóng không gian, dọn dẹp tâm trí để chào đón niềm vui bình dị.', 75000.00, 66000.00, 179, 166, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230006789.jpg', 1, '2026-01-18 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (595, N'978-604-030595', N'Tìm Lại Chính Mình (Tái bản có bổ sung)', N'Hành trình chữa lành những tổn thương thơ ấu và thiết lập mối liên kết sâu sắc với bản ngã.', 125000.00, 112000.00, 19, 348, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425124.jpg', 1, '2026-02-19 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (596, N'978-604-030596', N'Cân Bằng Cảm Xúc Lúc Bão Giông (Tái bản có bổ sung)', N'Cách thức xoa dịu những cơn hoảng loạn, âu lo và lấy lại sự tự tin nội tại.', 138000.00, 121000.00, 227, 495, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230007890.jpg', 1, '2026-06-23 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (597, N'978-604-030597', N'Atomic Habits - Thay Đổi Tí Hon Hiệu Quả Bất Ngờ - Ấn bản kỷ niệm', N'Hệ thống xây dựng thói quen tốt và loại bỏ thói quen xấu dựa trên khoa học hành vi.', 138000.00, 113000.00, 15, 171, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426001.jpg', 1, '2026-05-03 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (598, N'978-604-030598', N'Sức Mạnh Của Thói Quen (The Power of Habit) - Ấn bản kỷ niệm', N'Vòng lặp thói quen: Gợi ý, Hành động, Phần thưởng và bí quyết tái lập trình não bộ.', 138000.00, 121000.00, 24, 310, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230005032.jpg', 1, '2026-03-03 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (599, N'978-604-030599', N'Deep Work - Làm Ra Làm Chơi Ra Chơi - Ấn bản kỷ niệm', N'Nghệ thuật tập trung cao độ trong một thế giới đầy xao nhãng để tạo ra giá trị đột phá.', 125000.00, 100000.00, 204, 315, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235241848.jpg', 1, '2026-03-03 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (600, N'978-604-030600', N'Digital Minimalism - Sống Tối Giản Thời Công Nghệ - Ấn bản kỷ niệm', N'Cách giải phóng bản thân khỏi nghiện mạng xã hội và lấy lại sự tập trung thanh thản.', 220000.00, 180000.00, 243, 561, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg', 1, '2026-01-24 10:00:00', 3, 4);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (601, N'978-604-030601', N'Tư Duy Nhanh Và Chậm (Thinking, Fast and Slow) - Ấn bản kỷ niệm', N'Hai hệ thống tư duy chi phối mọi quyết định và những cạm bẫy định kiến nhận thức.', 175000.00, NULL, 133, 418, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/d0/ba/09/17804041c2830c092d9b2278b8be9b58.jpg', 1, '2026-02-10 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (602, N'978-604-030602', N'7 Thói Quen Để Thành Đạt (The 7 Habits) - Ấn bản kỷ niệm', N'Nguyên lý phát triển nhân cách toàn diện và năng lực lãnh đạo từ bên trong.', 110000.00, 94000.00, 241, 162, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/df/fe/df/08a4a624353b4289b877cf3bced910e4.jpg', 1, '2026-07-21 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (603, N'978-604-030603', N'Đắc Nhân Tâm (Khổ Lớn Đặc Biệt) - Ấn bản kỷ niệm', N'Nghệ thuật thu phục lòng người, tạo dựng thiện cảm và xây dựng quan hệ bền vững.', 175000.00, 144000.00, 77, 600, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/81/9f/74/5f64c3144d59ac007b344589f12cfc8e.jpg', 1, '2026-09-05 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (604, N'978-604-030604', N'Quẳng Gánh Lo Đi Và Vui Sống - Ấn bản kỷ niệm', N'Bí quyết xua tan âu lo, làm chủ căng thẳng và tận hưởng cuộc sống trọn vẹn mỗi ngày.', 280000.00, NULL, 74, 255, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/a0/a3/2b/006dac88a54de6057ebc9e922069d2bd.jpg', 1, '2026-09-12 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (605, N'978-604-030605', N'Khéo Ăn Nói Sẽ Có Được Thiên Hạ - Ấn bản kỷ niệm', N'Kỹ năng giao tiếp ứng biến linh hoạt trong công sở, gia đình và các mối quan hệ xã hội.', 75000.00, NULL, 54, 402, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5e/18/24/2a6154ba08df6ce6161c13f4303fa19e.jpg', 1, '2026-05-18 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (606, N'978-604-030606', N'Nghệ Thuật Lắng Nghe Trong Giao Tiếp - Ấn bản kỷ niệm', N'Sức mạnh của sự tĩnh lặng và thấu hiểu chiều sâu cảm xúc đối phương.', 145000.00, 123000.00, 71, 431, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/07/47/18/c2b4715eb2e56d0e33f4b6788532b182.jpg', 1, '2026-07-21 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (607, N'978-604-030607', N'Đọc Vị Bất Kỳ Ai - Để Không Bị Thao Túng - Ấn bản kỷ niệm', N'Nhận biết ngôn ngữ cơ thể, vi biểu cảm và nắm bắt tâm lý người đối diện chuẩn xác.', 280000.00, 230000.00, 219, 450, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/70/63/3d/c57040b46e074d49d9e2af573ecefd4e.jpg', 1, '2026-05-18 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (608, N'978-604-030608', N'Thôi Miên Bằng Ngôn Từ - Ấn bản kỷ niệm', N'Nghệ thuật sử dụng từ ngữ ma lực để lay động cảm xúc và thuyết phục người nghe.', 125000.00, 106000.00, 96, 235, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/1b/79/a2/96348da390aaa6f67b02213108f37a6e.jpg', 1, '2026-08-24 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (609, N'978-604-030609', N'Câu Lạc Bộ 5 Giờ Sáng - Ấn bản kỷ niệm', N'Thói quen làm chủ buổi sáng để nâng tầm cuộc sống, kích hoạt năng lượng và sự sáng tạo.', 220000.00, NULL, 190, 234, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5a/a1/cb/6d1c9e9875a9ac35d5a5a536f813f4ee.png', 1, '2026-01-02 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (610, N'978-604-030610', N'Nhà Sư Bán Chiếc Ferrari - Ấn bản kỷ niệm', N'Hành trình tìm về chân giá trị cuộc sống, bình an tâm hồn và ý nghĩa đích thực của sự tồn tại.', 250000.00, 200000.00, 36, 447, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/75/47/f1/8d0571eda17578c74710a18d81aad5a2.png', 1, '2026-04-13 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (611, N'978-604-030611', N'Thuật Thao Túng Tâm Lý & Nhận Diện Thao Túng - Ấn bản kỷ niệm', N'Cách nhận biết các chiêu trò gaslighting và bảo vệ ranh giới cá nhân lành mạnh.', 220000.00, 187000.00, 192, 178, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/55/44/5c/ef26b60328ea00db2ac6358b69a18935.jpg', 1, '2026-08-12 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (612, N'978-604-030612', N'Sức Bền (Grit) - Sức Mạnh Của Niềm Đam Mê - Ấn bản kỷ niệm', N'Tại sao sự kiên trì bền bỉ lại quyết định thành công hơn tài năng bẩm sinh.', 75000.00, NULL, 98, 396, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/41/02/5e/3ef2506a5e3a7ce69c3b3f5fc6ea3401.jpg', 1, '2026-07-16 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (613, N'978-604-030613', N'Kỷ Luật Tự Giác - Vũ Khí Của Kẻ Mạnh - Ấn bản kỷ niệm', N'Cách chiến thắng sự trì hoãn và duy trì thói quen tự giác sắt đá.', 125000.00, 110000.00, 146, 574, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/93/8e/2c/a5dd4c236a604246a2c7a79f11e7badb.jpg', 1, '2026-10-24 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (614, N'978-604-030614', N'Hoàn Thành Mọi Việc Không Hề Khó (GTD) - Ấn bản kỷ niệm', N'Phương pháp tổ chức công việc và dọn dẹp tâm trí để đạt hiệu suất tối đa.', 195000.00, 166000.00, 58, 416, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/3d/b2/eb/395145ab859d548c23386223bc4f746d.png', 1, '2026-02-14 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (615, N'978-604-030615', N'Làm Chủ Tư Duy Thay Đổi Vận Mệnh - Ấn bản kỷ niệm', N'Phương pháp lập trình ngôn ngữ tư duy NLP để khai phóng tiềm năng ẩn giấu.', 195000.00, 166000.00, 19, 187, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/65/4c/2da4aa944b6f280afbd694ac1a129682.jpeg', 1, '2026-10-27 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (616, N'978-604-030616', N'An Lạc Từng Bước Chân - Ấn bản kỷ niệm', N'Thực hành chánh niệm trong từng hơi thở, bước đi để tìm thấy an lạc giữa cuộc sống bộn bề.', 125000.00, 112000.00, 53, 667, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/i/m/img011.u2751.d20170404.t142005.692809.jpg', 1, '2026-06-20 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (617, N'978-604-030617', N'Giận - Chuyển Hóa Cơn Giận Bằng Yêu Thương - Ấn bản kỷ niệm', N'Phương thuốc diệu kỳ làm dịu tâm can và chuyển hóa năng lượng tiêu cực.', 92000.00, 83000.00, 213, 280, 2020, N'en', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5e/18/24/2a6154ba08df6ce6161c13f4303fa19e.jpg', 1, '2026-04-03 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (618, N'978-604-030618', N'Hiểu Về Trái Tim - Ấn bản kỷ niệm', N'Tác phẩm soi rọi từng ngõ ngách cảm xúc: Yêu, Ghét, Đau Khổ, Bao Dung và Hạnh Phúc.', 220000.00, 180000.00, 107, 377, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236435314.jpg', 1, '2026-04-08 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (619, N'978-604-030619', N'Không Diệt Không Sinh Đừng Sợ Hãi - Ấn bản kỷ niệm', N'Lời khai thị nhẹ nhàng về sự vô thường của kiếp nhân sinh và giải phóng nỗi sợ cái chết.', 85000.00, 76000.00, 124, 166, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/70/63/3d/c57040b46e074d49d9e2af573ecefd4e.jpg', 1, '2026-02-19 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (620, N'978-604-030620', N'Nghệ Thuật Sống Khắc Kỷ - Ấn bản kỷ niệm', N'Triết lý sống kiên cường, thản nhiên trước nghịch cảnh và làm chủ những gì trong tầm kiểm soát.', 98000.00, 78000.00, 196, 507, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936049952142.jpg', 1, '2026-04-16 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (621, N'978-604-030621', N'Suy Tưởng (Meditations - Marcus Aurelius) - Ấn bản kỷ niệm', N'Nhật ký nội tâm của vị hoàng đế La Mã về nghĩa vụ, sự khiêm nhường và kỷ luật tự thân.', 250000.00, 220000.00, 90, 216, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/5/5/554d80fa-8555-4093-b8c0-56e7d00b1a3f.jpg', 1, '2026-08-25 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (622, N'978-604-030622', N'Chủ Nghĩa Tối Giản Trong Lối Sống - Ấn bản kỷ niệm', N'Bỏ bớt đồ đạc để giải phóng không gian, dọn dẹp tâm trí để chào đón niềm vui bình dị.', 92000.00, 83000.00, 62, 237, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235240971.jpg', 1, '2026-04-04 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (623, N'978-604-030623', N'Tìm Lại Chính Mình - Ấn bản kỷ niệm', N'Hành trình chữa lành những tổn thương thơ ấu và thiết lập mối liên kết sâu sắc với bản ngã.', 195000.00, 160000.00, 42, 629, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235230019_1.jpg', 1, '2026-04-09 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (624, N'978-604-030624', N'Cân Bằng Cảm Xúc Lúc Bão Giông - Ấn bản kỷ niệm', N'Cách thức xoa dịu những cơn hoảng loạn, âu lo và lấy lại sự tự tin nội tại.', 110000.00, 88000.00, 220, 477, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974178408.jpg', 1, '2026-08-12 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (625, N'978-604-030625', N'Atomic Habits - Thay Đổi Tí Hon Hiệu Quả Bất Ngờ (Bìa cứng mỹ thuật)', N'Hệ thống xây dựng thói quen tốt và loại bỏ thói quen xấu dựa trên khoa học hành vi.', 75000.00, 66000.00, 88, 522, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936203361674.jpg', 1, '2026-02-20 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (626, N'978-604-030626', N'Sức Mạnh Của Thói Quen (The Power of Habit) (Bìa cứng mỹ thuật)', N'Vòng lặp thói quen: Gợi ý, Hành động, Phần thưởng và bí quyết tái lập trình não bộ.', 85000.00, 75000.00, 248, 646, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235244177.jpg', 1, '2026-04-24 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (627, N'978-604-030627', N'Deep Work - Làm Ra Làm Chơi Ra Chơi (Bìa cứng mỹ thuật)', N'Nghệ thuật tập trung cao độ trong một thế giới đầy xao nhãng để tạo ra giá trị đột phá.', 98000.00, 83000.00, 62, 435, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936049952142.jpg', 1, '2026-08-17 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (628, N'978-604-030628', N'Digital Minimalism - Sống Tối Giản Thời Công Nghệ (Bìa cứng mỹ thuật)', N'Cách giải phóng bản thân khỏi nghiện mạng xã hội và lấy lại sự tập trung thanh thản.', 110000.00, 99000.00, 31, 430, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936203361674.jpg', 1, '2026-07-27 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (629, N'978-604-030629', N'Tư Duy Nhanh Và Chậm (Thinking, Fast and Slow) (Bìa cứng mỹ thuật)', N'Hai hệ thống tư duy chi phối mọi quyết định và những cạm bẫy định kiến nhận thức.', 69000.00, 55000.00, 113, 623, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg', 1, '2026-09-03 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (630, N'978-604-030630', N'7 Thói Quen Để Thành Đạt (The 7 Habits) (Bìa cứng mỹ thuật)', N'Nguyên lý phát triển nhân cách toàn diện và năng lực lãnh đạo từ bên trong.', 75000.00, 61000.00, 143, 283, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/df/fe/df/08a4a624353b4289b877cf3bced910e4.jpg', 1, '2026-01-16 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (631, N'978-604-030631', N'Đắc Nhân Tâm (Khổ Lớn Đặc Biệt) (Bìa cứng mỹ thuật)', N'Nghệ thuật thu phục lòng người, tạo dựng thiện cảm và xây dựng quan hệ bền vững.', 138000.00, 113000.00, 108, 593, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/81/9f/74/5f64c3144d59ac007b344589f12cfc8e.jpg', 1, '2026-06-17 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (632, N'978-604-030632', N'Quẳng Gánh Lo Đi Và Vui Sống (Bìa cứng mỹ thuật)', N'Bí quyết xua tan âu lo, làm chủ căng thẳng và tận hưởng cuộc sống trọn vẹn mỗi ngày.', 220000.00, NULL, 101, 392, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5e/18/24/2a6154ba08df6ce6161c13f4303fa19e.jpg', 1, '2026-01-16 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (633, N'978-604-030633', N'Khéo Ăn Nói Sẽ Có Được Thiên Hạ (Bìa cứng mỹ thuật)', N'Kỹ năng giao tiếp ứng biến linh hoạt trong công sở, gia đình và các mối quan hệ xã hội.', 125000.00, 112000.00, 227, 343, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974099192.jpg', 1, '2026-09-02 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (634, N'978-604-030634', N'Nghệ Thuật Lắng Nghe Trong Giao Tiếp (Bìa cứng mỹ thuật)', N'Sức mạnh của sự tĩnh lặng và thấu hiểu chiều sâu cảm xúc đối phương.', 280000.00, 246000.00, 114, 584, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/b/n/bn01do-1.u2769.d20170607.t182835.572283_2.jpg', 1, '2026-07-28 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (635, N'978-604-030635', N'Đọc Vị Bất Kỳ Ai - Để Không Bị Thao Túng (Bìa cứng mỹ thuật)', N'Nhận biết ngôn ngữ cơ thể, vi biểu cảm và nắm bắt tâm lý người đối diện chuẩn xác.', 69000.00, 59000.00, 75, 649, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974152507.jpg', 1, '2026-03-15 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (636, N'978-604-030636', N'Thôi Miên Bằng Ngôn Từ (Bìa cứng mỹ thuật)', N'Nghệ thuật sử dụng từ ngữ ma lực để lay động cảm xúc và thuyết phục người nghe.', 250000.00, NULL, 146, 333, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974178408.jpg', 1, '2026-06-23 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (637, N'978-604-030637', N'Câu Lạc Bộ 5 Giờ Sáng (Bìa cứng mỹ thuật)', N'Thói quen làm chủ buổi sáng để nâng tầm cuộc sống, kích hoạt năng lượng và sự sáng tạo.', 280000.00, 252000.00, 229, 291, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235230019_1.jpg', 1, '2026-01-03 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (638, N'978-604-030638', N'Nhà Sư Bán Chiếc Ferrari (Bìa cứng mỹ thuật)', N'Hành trình tìm về chân giá trị cuộc sống, bình an tâm hồn và ý nghĩa đích thực của sự tồn tại.', 175000.00, 144000.00, 124, 198, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235249561.jpg', 1, '2026-03-26 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (639, N'978-604-030639', N'Thuật Thao Túng Tâm Lý & Nhận Diện Thao Túng (Bìa cứng mỹ thuật)', N'Cách nhận biết các chiêu trò gaslighting và bảo vệ ranh giới cá nhân lành mạnh.', 250000.00, 212000.00, 110, 487, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235244177.jpg', 1, '2026-10-24 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (640, N'978-604-030640', N'Sức Bền (Grit) - Sức Mạnh Của Niềm Đam Mê (Bìa cứng mỹ thuật)', N'Tại sao sự kiên trì bền bỉ lại quyết định thành công hơn tài năng bẩm sinh.', 175000.00, 154000.00, 234, 567, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235249561.jpg', 1, '2026-02-12 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (641, N'978-604-030641', N'Kỷ Luật Tự Giác - Vũ Khí Của Kẻ Mạnh (Bìa cứng mỹ thuật)', N'Cách chiến thắng sự trì hoãn và duy trì thói quen tự giác sắt đá.', 69000.00, NULL, 175, 441, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235244177.jpg', 1, '2026-04-22 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (642, N'978-604-030642', N'Hoàn Thành Mọi Việc Không Hề Khó (GTD) (Bìa cứng mỹ thuật)', N'Phương pháp tổ chức công việc và dọn dẹp tâm trí để đạt hiệu suất tối đa.', 145000.00, NULL, 204, 474, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-02-04 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (643, N'978-604-030643', N'Làm Chủ Tư Duy Thay Đổi Vận Mệnh (Bìa cứng mỹ thuật)', N'Phương pháp lập trình ngôn ngữ tư duy NLP để khai phóng tiềm năng ẩn giấu.', 125000.00, 102000.00, 100, 250, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-05-05 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (644, N'978-604-030644', N'An Lạc Từng Bước Chân (Bìa cứng mỹ thuật)', N'Thực hành chánh niệm trong từng hơi thở, bước đi để tìm thấy an lạc giữa cuộc sống bộn bề.', 280000.00, 246000.00, 139, 199, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg', 1, '2026-05-26 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (645, N'978-604-030645', N'Giận - Chuyển Hóa Cơn Giận Bằng Yêu Thương (Bìa cứng mỹ thuật)', N'Phương thuốc diệu kỳ làm dịu tâm can và chuyển hóa năng lượng tiêu cực.', 92000.00, 78000.00, 230, 505, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-10-22 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (646, N'978-604-030646', N'Hiểu Về Trái Tim (Bìa cứng mỹ thuật)', N'Tác phẩm soi rọi từng ngõ ngách cảm xúc: Yêu, Ghét, Đau Khổ, Bao Dung và Hạnh Phúc.', 110000.00, 90000.00, 167, 487, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/t/h/the-psychology-of-money.jpg', 1, '2026-08-15 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (647, N'978-604-030647', N'Không Diệt Không Sinh Đừng Sợ Hãi (Bìa cứng mỹ thuật)', N'Lời khai thị nhẹ nhàng về sự vô thường của kiếp nhân sinh và giải phóng nỗi sợ cái chết.', 145000.00, 123000.00, 45, 212, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/i/m/image_230367.jpg', 1, '2026-07-18 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (648, N'978-604-030648', N'Nghệ Thuật Sống Khắc Kỷ (Bìa cứng mỹ thuật)', N'Triết lý sống kiên cường, thản nhiên trước nghịch cảnh và làm chủ những gì trong tầm kiểm soát.', 220000.00, 198000.00, 164, 605, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-02-03 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (649, N'978-604-030649', N'Suy Tưởng (Meditations - Marcus Aurelius) (Bìa cứng mỹ thuật)', N'Nhật ký nội tâm của vị hoàng đế La Mã về nghĩa vụ, sự khiêm nhường và kỷ luật tự thân.', 92000.00, NULL, 67, 228, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251400267.jpg', 1, '2026-03-12 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (650, N'978-604-030650', N'Chủ Nghĩa Tối Giản Trong Lối Sống (Bìa cứng mỹ thuật)', N'Bỏ bớt đồ đạc để giải phóng không gian, dọn dẹp tâm trí để chào đón niềm vui bình dị.', 175000.00, 158000.00, 170, 667, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403589.jpg', 1, '2026-08-14 10:00:00', 3, 8);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (651, N'978-604-030651', N'Tìm Lại Chính Mình (Bìa cứng mỹ thuật)', N'Hành trình chữa lành những tổn thương thơ ấu và thiết lập mối liên kết sâu sắc với bản ngã.', 92000.00, 83000.00, 229, 260, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-07-21 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (652, N'978-604-030652', N'Cân Bằng Cảm Xúc Lúc Bão Giông (Bìa cứng mỹ thuật)', N'Cách thức xoa dịu những cơn hoảng loạn, âu lo và lấy lại sự tự tin nội tại.', 175000.00, 154000.00, 179, 635, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-08-13 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (653, N'978-604-030653', N'Atomic Habits - Thay Đổi Tí Hon Hiệu Quả Bất Ngờ - Tập 5', N'Hệ thống xây dựng thói quen tốt và loại bỏ thói quen xấu dựa trên khoa học hành vi.', 280000.00, 252000.00, 174, 665, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-06-16 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (654, N'978-604-030654', N'Sức Mạnh Của Thói Quen (The Power of Habit) - Tập 5', N'Vòng lặp thói quen: Gợi ý, Hành động, Phần thưởng và bí quyết tái lập trình não bộ.', 175000.00, 144000.00, 103, 342, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-02-18 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (655, N'978-604-030655', N'Deep Work - Làm Ra Làm Chơi Ra Chơi - Tập 5', N'Nghệ thuật tập trung cao độ trong một thế giới đầy xao nhãng để tạo ra giá trị đột phá.', 85000.00, 75000.00, 154, 394, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-02-21 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (656, N'978-604-030656', N'Digital Minimalism - Sống Tối Giản Thời Công Nghệ - Tập 5', N'Cách giải phóng bản thân khỏi nghiện mạng xã hội và lấy lại sự tập trung thanh thản.', 110000.00, 99000.00, 41, 202, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-04-22 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (657, N'978-604-030657', N'Tư Duy Nhanh Và Chậm (Thinking, Fast and Slow) - Tập 5', N'Hai hệ thống tư duy chi phối mọi quyết định và những cạm bẫy định kiến nhận thức.', 98000.00, 83000.00, 110, 678, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-06-15 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (658, N'978-604-030658', N'7 Thói Quen Để Thành Đạt (The 7 Habits) - Tập 5', N'Nguyên lý phát triển nhân cách toàn diện và năng lực lãnh đạo từ bên trong.', 280000.00, 238000.00, 109, 450, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-08-24 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (659, N'978-604-030659', N'Đắc Nhân Tâm (Khổ Lớn Đặc Biệt) - Tập 5', N'Nghệ thuật thu phục lòng người, tạo dựng thiện cảm và xây dựng quan hệ bền vững.', 75000.00, 66000.00, 237, 182, 2024, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402773.jpg', 1, '2026-03-15 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (660, N'978-604-030660', N'Quẳng Gánh Lo Đi Và Vui Sống - Tập 5', N'Bí quyết xua tan âu lo, làm chủ căng thẳng và tận hưởng cuộc sống trọn vẹn mỗi ngày.', 280000.00, 252000.00, 61, 321, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-07-06 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (661, N'978-604-030661', N'Khéo Ăn Nói Sẽ Có Được Thiên Hạ - Tập 5', N'Kỹ năng giao tiếp ứng biến linh hoạt trong công sở, gia đình và các mối quan hệ xã hội.', 250000.00, 205000.00, 141, 612, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-10-21 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (662, N'978-604-030662', N'Nghệ Thuật Lắng Nghe Trong Giao Tiếp - Tập 5', N'Sức mạnh của sự tĩnh lặng và thấu hiểu chiều sâu cảm xúc đối phương.', 220000.00, 194000.00, 137, 504, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-09-05 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (663, N'978-604-030663', N'Đọc Vị Bất Kỳ Ai - Để Không Bị Thao Túng - Tập 5', N'Nhận biết ngôn ngữ cơ thể, vi biểu cảm và nắm bắt tâm lý người đối diện chuẩn xác.', 145000.00, 116000.00, 123, 530, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-08-12 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (664, N'978-604-030664', N'Thôi Miên Bằng Ngôn Từ - Tập 5', N'Nghệ thuật sử dụng từ ngữ ma lực để lay động cảm xúc và thuyết phục người nghe.', 92000.00, 83000.00, 195, 272, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-03-04 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (665, N'978-604-030665', N'Câu Lạc Bộ 5 Giờ Sáng - Tập 5', N'Thói quen làm chủ buổi sáng để nâng tầm cuộc sống, kích hoạt năng lượng và sự sáng tạo.', 280000.00, 246000.00, 212, 628, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-01-03 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (666, N'978-604-030666', N'Nhà Sư Bán Chiếc Ferrari - Tập 5', N'Hành trình tìm về chân giá trị cuộc sống, bình an tâm hồn và ý nghĩa đích thực của sự tồn tại.', 175000.00, 149000.00, 104, 478, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-04-01 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (667, N'978-604-030667', N'Thuật Thao Túng Tâm Lý & Nhận Diện Thao Túng - Tập 5', N'Cách nhận biết các chiêu trò gaslighting và bảo vệ ranh giới cá nhân lành mạnh.', 195000.00, 156000.00, 51, 236, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/t/h/the-psychology-of-money.jpg', 1, '2026-10-16 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (668, N'978-604-030668', N'Sức Bền (Grit) - Sức Mạnh Của Niềm Đam Mê - Tập 5', N'Tại sao sự kiên trì bền bỉ lại quyết định thành công hơn tài năng bẩm sinh.', 98000.00, 78000.00, 199, 489, 2023, N'en', N'https://cdn1.fahasa.com/media/catalog/product/i/m/image_230367.jpg', 1, '2026-09-21 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (669, N'978-604-030669', N'Kỷ Luật Tự Giác - Vũ Khí Của Kẻ Mạnh - Tập 5', N'Cách chiến thắng sự trì hoãn và duy trì thói quen tự giác sắt đá.', 280000.00, 246000.00, 121, 423, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-02-28 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (670, N'978-604-030670', N'Hoàn Thành Mọi Việc Không Hề Khó (GTD) - Tập 5', N'Phương pháp tổ chức công việc và dọn dẹp tâm trí để đạt hiệu suất tối đa.', 160000.00, 144000.00, 89, 241, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251400267.jpg', 1, '2026-09-28 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (671, N'978-604-030671', N'Làm Chủ Tư Duy Thay Đổi Vận Mệnh - Tập 5', N'Phương pháp lập trình ngôn ngữ tư duy NLP để khai phóng tiềm năng ẩn giấu.', 145000.00, 130000.00, 89, 575, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403589.jpg', 1, '2026-02-21 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (672, N'978-604-030672', N'An Lạc Từng Bước Chân - Tập 5', N'Thực hành chánh niệm trong từng hơi thở, bước đi để tìm thấy an lạc giữa cuộc sống bộn bề.', 175000.00, 149000.00, 153, 651, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-08-16 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (673, N'978-604-030673', N'Giận - Chuyển Hóa Cơn Giận Bằng Yêu Thương - Tập 5', N'Phương thuốc diệu kỳ làm dịu tâm can và chuyển hóa năng lượng tiêu cực.', 250000.00, 200000.00, 91, 410, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-07-28 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (674, N'978-604-030674', N'Hiểu Về Trái Tim - Tập 5', N'Tác phẩm soi rọi từng ngõ ngách cảm xúc: Yêu, Ghét, Đau Khổ, Bao Dung và Hạnh Phúc.', 75000.00, 64000.00, 116, 259, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-09-28 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (675, N'978-604-030675', N'Không Diệt Không Sinh Đừng Sợ Hãi - Tập 5', N'Lời khai thị nhẹ nhàng về sự vô thường của kiếp nhân sinh và giải phóng nỗi sợ cái chết.', 160000.00, 131000.00, 111, 606, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-04-27 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (676, N'978-604-030676', N'Nghệ Thuật Sống Khắc Kỷ - Tập 5', N'Triết lý sống kiên cường, thản nhiên trước nghịch cảnh và làm chủ những gì trong tầm kiểm soát.', 75000.00, NULL, 19, 357, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-07-18 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (677, N'978-604-030677', N'Suy Tưởng (Meditations - Marcus Aurelius) - Tập 5', N'Nhật ký nội tâm của vị hoàng đế La Mã về nghĩa vụ, sự khiêm nhường và kỷ luật tự thân.', 145000.00, 128000.00, 87, 215, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-05-01 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (678, N'978-604-030678', N'Chủ Nghĩa Tối Giản Trong Lối Sống - Tập 5', N'Bỏ bớt đồ đạc để giải phóng không gian, dọn dẹp tâm trí để chào đón niềm vui bình dị.', 110000.00, 99000.00, 95, 389, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/t/h/the-psychology-of-money.jpg', 1, '2026-06-05 10:00:00', 3, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (679, N'978-604-030679', N'Tìm Lại Chính Mình - Tập 5', N'Hành trình chữa lành những tổn thương thơ ấu và thiết lập mối liên kết sâu sắc với bản ngã.', 195000.00, NULL, 140, 310, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/i/m/image_230367.jpg', 1, '2026-02-25 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (680, N'978-604-030680', N'Cân Bằng Cảm Xúc Lúc Bão Giông - Tập 5', N'Cách thức xoa dịu những cơn hoảng loạn, âu lo và lấy lại sự tự tin nội tại.', 69000.00, 61000.00, 243, 287, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-10-18 10:00:00', 3, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (681, N'978-604-030681', N'Atomic Habits - Thay Đổi Tí Hon Hiệu Quả Bất Ngờ - Tập 6', N'Hệ thống xây dựng thói quen tốt và loại bỏ thói quen xấu dựa trên khoa học hành vi.', 145000.00, 130000.00, 50, 519, 2021, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251400267.jpg', 1, '2026-09-10 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (682, N'978-604-030682', N'Sức Mạnh Của Thói Quen (The Power of Habit) - Tập 6', N'Vòng lặp thói quen: Gợi ý, Hành động, Phần thưởng và bí quyết tái lập trình não bộ.', 220000.00, 176000.00, 77, 521, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403589.jpg', 1, '2026-04-23 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (683, N'978-604-030683', N'Deep Work - Làm Ra Làm Chơi Ra Chơi - Tập 6', N'Nghệ thuật tập trung cao độ trong một thế giới đầy xao nhãng để tạo ra giá trị đột phá.', 98000.00, 88000.00, 235, 625, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-01-24 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (684, N'978-604-030684', N'Digital Minimalism - Sống Tối Giản Thời Công Nghệ - Tập 6', N'Cách giải phóng bản thân khỏi nghiện mạng xã hội và lấy lại sự tập trung thanh thản.', 98000.00, NULL, 36, 374, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-07-19 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (685, N'978-604-030685', N'Tư Duy Nhanh Và Chậm (Thinking, Fast and Slow) - Tập 6', N'Hai hệ thống tư duy chi phối mọi quyết định và những cạm bẫy định kiến nhận thức.', 280000.00, 224000.00, 221, 259, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-05-02 10:00:00', 3, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (686, N'978-604-030686', N'7 Thói Quen Để Thành Đạt (The 7 Habits) - Tập 6', N'Nguyên lý phát triển nhân cách toàn diện và năng lực lãnh đạo từ bên trong.', 98000.00, 88000.00, 57, 396, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-02-25 10:00:00', 3, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (687, N'978-604-030687', N'Đắc Nhân Tâm (Khổ Lớn Đặc Biệt) - Tập 6', N'Nghệ thuật thu phục lòng người, tạo dựng thiện cảm và xây dựng quan hệ bền vững.', 175000.00, 144000.00, 238, 510, 2023, N'en', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-06-24 10:00:00', 3, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (688, N'978-604-030688', N'Quẳng Gánh Lo Đi Và Vui Sống - Tập 6', N'Bí quyết xua tan âu lo, làm chủ căng thẳng và tận hưởng cuộc sống trọn vẹn mỗi ngày.', 138000.00, NULL, 160, 240, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-08-22 10:00:00', 3, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (689, N'978-604-030689', N'Khéo Ăn Nói Sẽ Có Được Thiên Hạ - Tập 6', N'Kỹ năng giao tiếp ứng biến linh hoạt trong công sở, gia đình và các mối quan hệ xã hội.', 98000.00, 78000.00, 51, 636, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-07-20 10:00:00', 3, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (690, N'978-604-030690', N'Nghệ Thuật Lắng Nghe Trong Giao Tiếp - Tập 6', N'Sức mạnh của sự tĩnh lặng và thấu hiểu chiều sâu cảm xúc đối phương.', 195000.00, 166000.00, 164, 537, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-04-02 10:00:00', 3, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (691, N'978-604-040691', N'Clean Code - Mã Sạch Trong Lập Trình', N'Quy chuẩn viết code dễ đọc, dễ bảo trì và loại bỏ code smell của huyền thoại Uncle Bob.', 85000.00, 76000.00, 167, 447, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-04-18 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (692, N'978-604-040692', N'Clean Architecture - Kiến Trúc Phần Mềm Sạch', N'Cấu trúc hệ thống phần mềm độc lập với framework, UI, cơ sở dữ liệu và ngoại vi.', 138000.00, 121000.00, 123, 312, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-03-10 10:00:00', 4, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (693, N'978-604-040693', N'Refactoring - Cải Thiện Thiết Kế Mã Nguồn Hiện Có', N'Kỹ thuật tái cấu trúc code an toàn với các mẫu chuyển đổi kinh điển của Martin Fowler.', 250000.00, 212000.00, 92, 411, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-08-19 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (694, N'978-604-040694', N'The Pragmatic Programmer - Lập Trình Viên Thực Dụng', N'Lời khuyên thực chiến quý giá từ tư duy nghề nghiệp đến kỹ thuật coding đỉnh cao.', 125000.00, NULL, 41, 250, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-07-14 10:00:00', 4, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (695, N'978-604-040695', N'Head First Design Patterns - Các Mẫu Thiết Kế', N'Học các mẫu thiết kế hướng đối tượng qua hình ảnh trực quan, dí dỏm và dễ tiếp thu.', 220000.00, 176000.00, 110, 292, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-02-28 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (696, N'978-604-040696', N'Designing Data-Intensive Applications', N'Cuốn sách gối đầu giường về thiết kế hệ thống dữ liệu phân tán quy mô lớn.', 85000.00, 75000.00, 53, 195, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-03-12 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (697, N'978-604-040697', N'Building Microservices - Thiết Kế Hệ Thống Độc Lập', N'Kiến trúc microservice toàn diện: Phân tách domain, giao tiếp API, bảo mật và deploy.', 138000.00, 117000.00, 245, 525, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-05-20 10:00:00', 4, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (698, N'978-604-040698', N'Microservices Patterns - Mẫu Kiến Trúc Thực Chiến', N'Giải quyết các thách thức phân tán: Saga pattern, CQRS, Event Sourcing và Transactional Outbox.', 75000.00, NULL, 126, 198, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-08-08 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (699, N'978-604-040699', N'Machine Learning Yearning - Cẩm Nang Thực Chiến', N'Andrew Ng chia sẻ kinh nghiệm định hướng và tối ưu hóa dự án học máy thực tế.', 125000.00, 100000.00, 227, 174, 2021, N'en', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-07-17 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (700, N'978-604-040700', N'Deep Learning - Học Sâu Với Python & PyTorch', N'Toàn thư về mạng nơ-ron nhân tạo, CNN, RNN, Transformer và Generative AI.', 92000.00, 74000.00, 247, 268, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-10-20 10:00:00', 4, 1);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (701, N'978-604-040701', N'Prompt Engineering Thực Chiến Cho Lập Trình Viên', N'Khai thác tối đa sức mạnh của LLM, ChatGPT và Gemini trong quy trình phát triển phần mềm.', 85000.00, 72000.00, 51, 590, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-04-28 10:00:00', 4, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (702, N'978-604-040702', N'Data Science Từ Con Số 0', N'Nền tảng toán học, thống kê, giải thuật và phân tích dữ liệu ứng dụng bằng Python.', 110000.00, 99000.00, 73, 672, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-02-23 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (703, N'978-604-040703', N'Lập Trình Python Nâng Cao & Tối Ưu Hiệu Năng', N'Làm chủ Generators, Concurrency, Asyncio, Metaprogramming và tối ưu bộ nhớ.', 145000.00, 123000.00, 193, 428, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-06-17 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (704, N'978-604-040704', N'C# 12 & .NET 8/9/10 Thực Chiến', N'Xây dựng Web API, Microservices và ứng dụng Cloud-native hiện đại với nền tảng .NET.', 125000.00, 100000.00, 180, 353, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-08-01 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (705, N'978-604-040705', N'Lập Trình Rust - Từ Cơ Bản Đến Hệ Thống An Toàn', N'Khái niệm Ownership, Borrowing, Lifetimes và lập trình hệ thống không lo rò rỉ bộ nhớ.', 110000.00, NULL, 174, 251, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410198.jpg', 1, '2026-10-12 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (706, N'978-604-040706', N'Golang Cho Hệ Thống Hiệu Năng Cao', N'Xây dựng các backend chịu tải lớn, đồng thời cao với Goroutines và Channels.', 175000.00, 158000.00, 96, 272, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-04-12 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (707, N'978-604-040707', N'Docker & Kubernetes Toàn Thư', N'Đóng gói ứng dụng container và quản trị điều phối cụm server sản xuất quy mô lớn.', 145000.00, 130000.00, 60, 392, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-09-07 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (708, N'978-604-040708', N'DevOps & CI/CD Hiện Đại Với GitHub Actions', N'Tự động hóa kiểm thử, build và triển khai phần mềm liên tục lên hạ tầng Cloud.', 138000.00, 113000.00, 155, 373, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-03-14 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (709, N'978-604-040709', N'An Toàn Thông Tin & Phòng Ngự Mã Độc', N'Nguyên lý an ninh mạng, kiểm thử xâm nhập (Penetration Testing) và bảo mật ứng dụng Web.', 110000.00, 97000.00, 123, 594, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-06-18 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (710, N'978-604-040710', N'Kiến Trúc Cloud-Native Với AWS & Azure', N'Thiết kế các giải pháp điện toán đám mây co giãn linh hoạt, chịu lỗi cao và tối ưu chi phí.', 138000.00, 121000.00, 214, 608, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-10-03 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (711, N'978-604-040711', N'The Art of Computer Programming - Tập 1: Giải Thuật Căn Bản', N'Bộ sách kinh điển vĩ đại của Donald Knuth về cấu trúc dữ liệu và giải thuật toán học.', 175000.00, 158000.00, 129, 445, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-08-06 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (712, N'978-604-040712', N'The Art of Computer Programming - Tập 2: Giải Thuật Bán Số Học', N'Nghiên cứu chuyên sâu về số học ngẫu nhiên và phép toán số học máy tính.', 125000.00, NULL, 155, 658, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-06-12 10:00:00', 4, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (713, N'978-604-040713', N'The Art of Computer Programming - Tập 3: Sắp Xếp & Tìm Kiếm', N'Toàn thư về các thuật toán sắp xếp và tra cứu dữ liệu tối ưu nhất.', 195000.00, 176000.00, 186, 666, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-01-10 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (714, N'978-604-040714', N'CODE - Ngôn Ngữ Ẩn Giấu Đằng Sau Máy Tính', N'Hành trình giải thích sinh động cách phần cứng và phần mềm máy tính thực sự hoạt động.', 280000.00, NULL, 57, 371, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-09-14 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (715, N'978-604-040715', N'Clean Code - Mã Sạch Trong Lập Trình (Tái bản có bổ sung)', N'Quy chuẩn viết code dễ đọc, dễ bảo trì và loại bỏ code smell của huyền thoại Uncle Bob.', 125000.00, 102000.00, 66, 584, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-02-18 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (716, N'978-604-040716', N'Clean Architecture - Kiến Trúc Phần Mềm Sạch (Tái bản có bổ sung)', N'Cấu trúc hệ thống phần mềm độc lập với framework, UI, cơ sở dữ liệu và ngoại vi.', 110000.00, 99000.00, 219, 319, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-10-15 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (717, N'978-604-040717', N'Refactoring - Cải Thiện Thiết Kế Mã Nguồn Hiện Có (Tái bản có bổ sung)', N'Kỹ thuật tái cấu trúc code an toàn với các mẫu chuyển đổi kinh điển của Martin Fowler.', 280000.00, 224000.00, 242, 341, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-02-21 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (718, N'978-604-040718', N'The Pragmatic Programmer - Lập Trình Viên Thực Dụng (Tái bản có bổ sung)', N'Lời khuyên thực chiến quý giá từ tư duy nghề nghiệp đến kỹ thuật coding đỉnh cao.', 85000.00, NULL, 229, 400, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-03-27 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (719, N'978-604-040719', N'Head First Design Patterns - Các Mẫu Thiết Kế (Tái bản có bổ sung)', N'Học các mẫu thiết kế hướng đối tượng qua hình ảnh trực quan, dí dỏm và dễ tiếp thu.', 160000.00, 141000.00, 100, 485, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-02-19 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (720, N'978-604-040720', N'Designing Data-Intensive Applications (Tái bản có bổ sung)', N'Cuốn sách gối đầu giường về thiết kế hệ thống dữ liệu phân tán quy mô lớn.', 220000.00, 198000.00, 124, 375, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-10-19 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (721, N'978-604-040721', N'Building Microservices - Thiết Kế Hệ Thống Độc Lập (Tái bản có bổ sung)', N'Kiến trúc microservice toàn diện: Phân tách domain, giao tiếp API, bảo mật và deploy.', 175000.00, 154000.00, 30, 227, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-05-17 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (722, N'978-604-040722', N'Microservices Patterns - Mẫu Kiến Trúc Thực Chiến (Tái bản có bổ sung)', N'Giải quyết các thách thức phân tán: Saga pattern, CQRS, Event Sourcing và Transactional Outbox.', 85000.00, 75000.00, 84, 652, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-10-26 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (723, N'978-604-040723', N'Machine Learning Yearning - Cẩm Nang Thực Chiến (Tái bản có bổ sung)', N'Andrew Ng chia sẻ kinh nghiệm định hướng và tối ưu hóa dự án học máy thực tế.', 138000.00, 110000.00, 234, 340, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-04-11 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (724, N'978-604-040724', N'Deep Learning - Học Sâu Với Python & PyTorch (Tái bản có bổ sung)', N'Toàn thư về mạng nơ-ron nhân tạo, CNN, RNN, Transformer và Generative AI.', 75000.00, 66000.00, 185, 361, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-10-07 10:00:00', 4, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (725, N'978-604-040725', N'Prompt Engineering Thực Chiến Cho Lập Trình Viên (Tái bản có bổ sung)', N'Khai thác tối đa sức mạnh của LLM, ChatGPT và Gemini trong quy trình phát triển phần mềm.', 110000.00, 90000.00, 121, 358, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-10-18 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (726, N'978-604-040726', N'Data Science Từ Con Số 0 (Tái bản có bổ sung)', N'Nền tảng toán học, thống kê, giải thuật và phân tích dữ liệu ứng dụng bằng Python.', 145000.00, NULL, 44, 649, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-04-17 10:00:00', 4, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (727, N'978-604-040727', N'Lập Trình Python Nâng Cao & Tối Ưu Hiệu Năng (Tái bản có bổ sung)', N'Làm chủ Generators, Concurrency, Asyncio, Metaprogramming và tối ưu bộ nhớ.', 160000.00, NULL, 51, 653, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-06-19 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (728, N'978-604-040728', N'C# 12 & .NET 8/9/10 Thực Chiến (Tái bản có bổ sung)', N'Xây dựng Web API, Microservices và ứng dụng Cloud-native hiện đại với nền tảng .NET.', 98000.00, 78000.00, 64, 431, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-08-05 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (729, N'978-604-040729', N'Lập Trình Rust - Từ Cơ Bản Đến Hệ Thống An Toàn (Tái bản có bổ sung)', N'Khái niệm Ownership, Borrowing, Lifetimes và lập trình hệ thống không lo rò rỉ bộ nhớ.', 175000.00, 140000.00, 49, 222, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124012.jpg', 1, '2026-03-25 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (730, N'978-604-040730', N'Golang Cho Hệ Thống Hiệu Năng Cao (Tái bản có bổ sung)', N'Xây dựng các backend chịu tải lớn, đồng thời cao với Goroutines và Channels.', 160000.00, NULL, 192, 640, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-07-08 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (731, N'978-604-040731', N'Docker & Kubernetes Toàn Thư (Tái bản có bổ sung)', N'Đóng gói ứng dụng container và quản trị điều phối cụm server sản xuất quy mô lớn.', 125000.00, 106000.00, 30, 615, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-09-06 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (732, N'978-604-040732', N'DevOps & CI/CD Hiện Đại Với GitHub Actions (Tái bản có bổ sung)', N'Tự động hóa kiểm thử, build và triển khai phần mềm liên tục lên hạ tầng Cloud.', 110000.00, 97000.00, 143, 324, 2021, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-07-22 10:00:00', 4, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (733, N'978-604-040733', N'An Toàn Thông Tin & Phòng Ngự Mã Độc (Tái bản có bổ sung)', N'Nguyên lý an ninh mạng, kiểm thử xâm nhập (Penetration Testing) và bảo mật ứng dụng Web.', 75000.00, NULL, 131, 491, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-05-25 10:00:00', 4, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (734, N'978-604-040734', N'Kiến Trúc Cloud-Native Với AWS & Azure (Tái bản có bổ sung)', N'Thiết kế các giải pháp điện toán đám mây co giãn linh hoạt, chịu lỗi cao và tối ưu chi phí.', 220000.00, 187000.00, 230, 225, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-10-03 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (735, N'978-604-040735', N'The Art of Computer Programming - Tập 1: Giải Thuật Căn Bản (Tái bản có bổ sung)', N'Bộ sách kinh điển vĩ đại của Donald Knuth về cấu trúc dữ liệu và giải thuật toán học.', 280000.00, NULL, 181, 336, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-06-24 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (736, N'978-604-040736', N'The Art of Computer Programming - Tập 2: Giải Thuật Bán Số Học (Tái bản có bổ sung)', N'Nghiên cứu chuyên sâu về số học ngẫu nhiên và phép toán số học máy tính.', 160000.00, 131000.00, 235, 627, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-07-25 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (737, N'978-604-040737', N'The Art of Computer Programming - Tập 3: Sắp Xếp & Tìm Kiếm (Tái bản có bổ sung)', N'Toàn thư về các thuật toán sắp xếp và tra cứu dữ liệu tối ưu nhất.', 280000.00, 252000.00, 192, 481, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-06-16 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (738, N'978-604-040738', N'CODE - Ngôn Ngữ Ẩn Giấu Đằng Sau Máy Tính (Tái bản có bổ sung)', N'Hành trình giải thích sinh động cách phần cứng và phần mềm máy tính thực sự hoạt động.', 98000.00, 78000.00, 40, 387, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-02-08 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (739, N'978-604-040739', N'Clean Code - Mã Sạch Trong Lập Trình - Ấn bản kỷ niệm', N'Quy chuẩn viết code dễ đọc, dễ bảo trì và loại bỏ code smell của huyền thoại Uncle Bob.', 85000.00, 76000.00, 192, 337, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-08-21 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (740, N'978-604-040740', N'Clean Architecture - Kiến Trúc Phần Mềm Sạch - Ấn bản kỷ niệm', N'Cấu trúc hệ thống phần mềm độc lập với framework, UI, cơ sở dữ liệu và ngoại vi.', 110000.00, 97000.00, 34, 391, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-02-14 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (741, N'978-604-040741', N'Refactoring - Cải Thiện Thiết Kế Mã Nguồn Hiện Có - Ấn bản kỷ niệm', N'Kỹ thuật tái cấu trúc code an toàn với các mẫu chuyển đổi kinh điển của Martin Fowler.', 92000.00, 74000.00, 36, 537, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-04-22 10:00:00', 4, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (742, N'978-604-040742', N'The Pragmatic Programmer - Lập Trình Viên Thực Dụng - Ấn bản kỷ niệm', N'Lời khuyên thực chiến quý giá từ tư duy nghề nghiệp đến kỹ thuật coding đỉnh cao.', 75000.00, 68000.00, 83, 514, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-02-07 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (743, N'978-604-040743', N'Head First Design Patterns - Các Mẫu Thiết Kế - Ấn bản kỷ niệm', N'Học các mẫu thiết kế hướng đối tượng qua hình ảnh trực quan, dí dỏm và dễ tiếp thu.', 69000.00, 59000.00, 33, 263, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-10-11 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (744, N'978-604-040744', N'Designing Data-Intensive Applications - Ấn bản kỷ niệm', N'Cuốn sách gối đầu giường về thiết kế hệ thống dữ liệu phân tán quy mô lớn.', 125000.00, 112000.00, 180, 239, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-04-03 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (745, N'978-604-040745', N'Building Microservices - Thiết Kế Hệ Thống Độc Lập - Ấn bản kỷ niệm', N'Kiến trúc microservice toàn diện: Phân tách domain, giao tiếp API, bảo mật và deploy.', 145000.00, 123000.00, 44, 321, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-03-25 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (746, N'978-604-040746', N'Microservices Patterns - Mẫu Kiến Trúc Thực Chiến - Ấn bản kỷ niệm', N'Giải quyết các thách thức phân tán: Saga pattern, CQRS, Event Sourcing và Transactional Outbox.', 69000.00, 57000.00, 106, 626, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-10-13 10:00:00', 4, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (747, N'978-604-040747', N'Machine Learning Yearning - Cẩm Nang Thực Chiến - Ấn bản kỷ niệm', N'Andrew Ng chia sẻ kinh nghiệm định hướng và tối ưu hóa dự án học máy thực tế.', 280000.00, 246000.00, 191, 614, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-01-01 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (748, N'978-604-040748', N'Deep Learning - Học Sâu Với Python & PyTorch - Ấn bản kỷ niệm', N'Toàn thư về mạng nơ-ron nhân tạo, CNN, RNN, Transformer và Generative AI.', 195000.00, 160000.00, 170, 169, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-08-24 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (749, N'978-604-040749', N'Prompt Engineering Thực Chiến Cho Lập Trình Viên - Ấn bản kỷ niệm', N'Khai thác tối đa sức mạnh của LLM, ChatGPT và Gemini trong quy trình phát triển phần mềm.', 98000.00, 78000.00, 249, 307, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124012.jpg', 1, '2026-10-13 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (750, N'978-604-040750', N'Data Science Từ Con Số 0 - Ấn bản kỷ niệm', N'Nền tảng toán học, thống kê, giải thuật và phân tích dữ liệu ứng dụng bằng Python.', 195000.00, 166000.00, 170, 411, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-06-13 10:00:00', 4, 1);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (751, N'978-604-040751', N'Lập Trình Python Nâng Cao & Tối Ưu Hiệu Năng - Ấn bản kỷ niệm', N'Làm chủ Generators, Concurrency, Asyncio, Metaprogramming và tối ưu bộ nhớ.', 69000.00, NULL, 72, 394, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-05-11 10:00:00', 4, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (752, N'978-604-040752', N'C# 12 & .NET 8/9/10 Thực Chiến - Ấn bản kỷ niệm', N'Xây dựng Web API, Microservices và ứng dụng Cloud-native hiện đại với nền tảng .NET.', 195000.00, 172000.00, 237, 259, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-05-04 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (753, N'978-604-040753', N'Lập Trình Rust - Từ Cơ Bản Đến Hệ Thống An Toàn - Ấn bản kỷ niệm', N'Khái niệm Ownership, Borrowing, Lifetimes và lập trình hệ thống không lo rò rỉ bộ nhớ.', 250000.00, NULL, 247, 294, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-01-23 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (754, N'978-604-040754', N'Golang Cho Hệ Thống Hiệu Năng Cao - Ấn bản kỷ niệm', N'Xây dựng các backend chịu tải lớn, đồng thời cao với Goroutines và Channels.', 250000.00, 212000.00, 50, 434, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-07-25 10:00:00', 4, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (755, N'978-604-040755', N'Docker & Kubernetes Toàn Thư - Ấn bản kỷ niệm', N'Đóng gói ứng dụng container và quản trị điều phối cụm server sản xuất quy mô lớn.', 125000.00, 110000.00, 126, 241, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-03-25 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (756, N'978-604-040756', N'DevOps & CI/CD Hiện Đại Với GitHub Actions - Ấn bản kỷ niệm', N'Tự động hóa kiểm thử, build và triển khai phần mềm liên tục lên hạ tầng Cloud.', 69000.00, 57000.00, 150, 647, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-10-15 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (757, N'978-604-040757', N'An Toàn Thông Tin & Phòng Ngự Mã Độc - Ấn bản kỷ niệm', N'Nguyên lý an ninh mạng, kiểm thử xâm nhập (Penetration Testing) và bảo mật ứng dụng Web.', 98000.00, 83000.00, 19, 451, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124012.jpg', 1, '2026-09-10 10:00:00', 4, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (758, N'978-604-040758', N'Kiến Trúc Cloud-Native Với AWS & Azure - Ấn bản kỷ niệm', N'Thiết kế các giải pháp điện toán đám mây co giãn linh hoạt, chịu lỗi cao và tối ưu chi phí.', 75000.00, 68000.00, 126, 213, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-10-06 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (759, N'978-604-040759', N'The Art of Computer Programming - Tập 1: Giải Thuật Căn Bản - Ấn bản kỷ niệm', N'Bộ sách kinh điển vĩ đại của Donald Knuth về cấu trúc dữ liệu và giải thuật toán học.', 160000.00, 141000.00, 167, 344, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-04-20 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (760, N'978-604-040760', N'The Art of Computer Programming - Tập 2: Giải Thuật Bán Số Học - Ấn bản kỷ niệm', N'Nghiên cứu chuyên sâu về số học ngẫu nhiên và phép toán số học máy tính.', 138000.00, 121000.00, 198, 263, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg', 1, '2026-03-09 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (761, N'978-604-040761', N'The Art of Computer Programming - Tập 3: Sắp Xếp & Tìm Kiếm - Ấn bản kỷ niệm', N'Toàn thư về các thuật toán sắp xếp và tra cứu dữ liệu tối ưu nhất.', 92000.00, 78000.00, 65, 165, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-07-14 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (762, N'978-604-040762', N'CODE - Ngôn Ngữ Ẩn Giấu Đằng Sau Máy Tính - Ấn bản kỷ niệm', N'Hành trình giải thích sinh động cách phần cứng và phần mềm máy tính thực sự hoạt động.', 220000.00, NULL, 54, 308, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703578.jpg', 1, '2026-03-20 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (763, N'978-604-040763', N'Clean Code - Mã Sạch Trong Lập Trình (Bìa cứng mỹ thuật)', N'Quy chuẩn viết code dễ đọc, dễ bảo trì và loại bỏ code smell của huyền thoại Uncle Bob.', 125000.00, 100000.00, 159, 208, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703585.jpg', 1, '2026-07-16 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (764, N'978-604-040764', N'Clean Architecture - Kiến Trúc Phần Mềm Sạch (Bìa cứng mỹ thuật)', N'Cấu trúc hệ thống phần mềm độc lập với framework, UI, cơ sở dữ liệu và ngoại vi.', 220000.00, 194000.00, 122, 277, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236427357.jpg', 1, '2026-07-20 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (765, N'978-604-040765', N'Refactoring - Cải Thiện Thiết Kế Mã Nguồn Hiện Có (Bìa cứng mỹ thuật)', N'Kỹ thuật tái cấu trúc code an toàn với các mẫu chuyển đổi kinh điển của Martin Fowler.', 110000.00, 99000.00, 165, 645, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426787.jpg', 1, '2026-05-04 10:00:00', 4, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (766, N'978-604-040766', N'The Pragmatic Programmer - Lập Trình Viên Thực Dụng (Bìa cứng mỹ thuật)', N'Lời khuyên thực chiến quý giá từ tư duy nghề nghiệp đến kỹ thuật coding đỉnh cao.', 280000.00, 246000.00, 230, 256, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703592.jpg', 1, '2026-06-04 10:00:00', 4, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (767, N'978-604-040767', N'Head First Design Patterns - Các Mẫu Thiết Kế (Bìa cứng mỹ thuật)', N'Học các mẫu thiết kế hướng đối tượng qua hình ảnh trực quan, dí dỏm và dễ tiếp thu.', 110000.00, 97000.00, 119, 292, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg', 1, '2026-02-26 10:00:00', 4, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (768, N'978-604-040768', N'Designing Data-Intensive Applications (Bìa cứng mỹ thuật)', N'Cuốn sách gối đầu giường về thiết kế hệ thống dữ liệu phân tán quy mô lớn.', 138000.00, 113000.00, 156, 348, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-04-02 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (769, N'978-604-040769', N'Building Microservices - Thiết Kế Hệ Thống Độc Lập (Bìa cứng mỹ thuật)', N'Kiến trúc microservice toàn diện: Phân tách domain, giao tiếp API, bảo mật và deploy.', 175000.00, 154000.00, 100, 322, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703578.jpg', 1, '2026-08-15 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (770, N'978-604-040770', N'Microservices Patterns - Mẫu Kiến Trúc Thực Chiến (Bìa cứng mỹ thuật)', N'Giải quyết các thách thức phân tán: Saga pattern, CQRS, Event Sourcing và Transactional Outbox.', 138000.00, 121000.00, 219, 210, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703585.jpg', 1, '2026-06-12 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (771, N'978-604-040771', N'Machine Learning Yearning - Cẩm Nang Thực Chiến (Bìa cứng mỹ thuật)', N'Andrew Ng chia sẻ kinh nghiệm định hướng và tối ưu hóa dự án học máy thực tế.', 98000.00, NULL, 23, 272, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236427357.jpg', 1, '2026-05-05 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (772, N'978-604-040772', N'Deep Learning - Học Sâu Với Python & PyTorch (Bìa cứng mỹ thuật)', N'Toàn thư về mạng nơ-ron nhân tạo, CNN, RNN, Transformer và Generative AI.', 85000.00, 75000.00, 167, 520, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426787.jpg', 1, '2026-08-07 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (773, N'978-604-040773', N'Prompt Engineering Thực Chiến Cho Lập Trình Viên (Bìa cứng mỹ thuật)', N'Khai thác tối đa sức mạnh của LLM, ChatGPT và Gemini trong quy trình phát triển phần mềm.', 125000.00, 100000.00, 180, 263, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554102.jpg', 1, '2026-07-15 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (774, N'978-604-040774', N'Data Science Từ Con Số 0 (Bìa cứng mỹ thuật)', N'Nền tảng toán học, thống kê, giải thuật và phân tích dữ liệu ứng dụng bằng Python.', 138000.00, 121000.00, 61, 332, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554102.jpg', 1, '2026-03-24 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (775, N'978-604-040775', N'Lập Trình Python Nâng Cao & Tối Ưu Hiệu Năng (Bìa cứng mỹ thuật)', N'Làm chủ Generators, Concurrency, Asyncio, Metaprogramming và tối ưu bộ nhớ.', 85000.00, 72000.00, 249, 635, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703592.jpg', 1, '2026-06-06 10:00:00', 4, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (776, N'978-604-040776', N'C# 12 & .NET 8/9/10 Thực Chiến (Bìa cứng mỹ thuật)', N'Xây dựng Web API, Microservices và ứng dụng Cloud-native hiện đại với nền tảng .NET.', 195000.00, 166000.00, 159, 672, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-06-21 10:00:00', 4, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (777, N'978-604-040777', N'Lập Trình Rust - Từ Cơ Bản Đến Hệ Thống An Toàn (Bìa cứng mỹ thuật)', N'Khái niệm Ownership, Borrowing, Lifetimes và lập trình hệ thống không lo rò rỉ bộ nhớ.', 69000.00, 61000.00, 64, 672, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703578.jpg', 1, '2026-09-05 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (778, N'978-604-040778', N'Golang Cho Hệ Thống Hiệu Năng Cao (Bìa cứng mỹ thuật)', N'Xây dựng các backend chịu tải lớn, đồng thời cao với Goroutines và Channels.', 195000.00, 156000.00, 77, 577, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703585.jpg', 1, '2026-03-19 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (779, N'978-604-040779', N'Docker & Kubernetes Toàn Thư (Bìa cứng mỹ thuật)', N'Đóng gói ứng dụng container và quản trị điều phối cụm server sản xuất quy mô lớn.', 138000.00, 110000.00, 147, 192, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236427357.jpg', 1, '2026-04-13 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (780, N'978-604-040780', N'DevOps & CI/CD Hiện Đại Với GitHub Actions (Bìa cứng mỹ thuật)', N'Tự động hóa kiểm thử, build và triển khai phần mềm liên tục lên hạ tầng Cloud.', 175000.00, 144000.00, 72, 430, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426787.jpg', 1, '2026-04-28 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (781, N'978-604-040781', N'An Toàn Thông Tin & Phòng Ngự Mã Độc (Bìa cứng mỹ thuật)', N'Nguyên lý an ninh mạng, kiểm thử xâm nhập (Penetration Testing) và bảo mật ứng dụng Web.', 175000.00, 144000.00, 156, 581, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554102.jpg', 1, '2026-04-17 10:00:00', 4, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (782, N'978-604-040782', N'Kiến Trúc Cloud-Native Với AWS & Azure (Bìa cứng mỹ thuật)', N'Thiết kế các giải pháp điện toán đám mây co giãn linh hoạt, chịu lỗi cao và tối ưu chi phí.', 98000.00, 88000.00, 49, 249, 2024, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703592.jpg', 1, '2026-09-12 10:00:00', 4, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (783, N'978-604-040783', N'The Art of Computer Programming - Tập 1: Giải Thuật Căn Bản (Bìa cứng mỹ thuật)', N'Bộ sách kinh điển vĩ đại của Donald Knuth về cấu trúc dữ liệu và giải thuật toán học.', 125000.00, 110000.00, 48, 577, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg', 1, '2026-01-08 10:00:00', 4, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (784, N'978-604-040784', N'The Art of Computer Programming - Tập 2: Giải Thuật Bán Số Học (Bìa cứng mỹ thuật)', N'Nghiên cứu chuyên sâu về số học ngẫu nhiên và phép toán số học máy tính.', 195000.00, NULL, 122, 618, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-04-01 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (785, N'978-604-040785', N'The Art of Computer Programming - Tập 3: Sắp Xếp & Tìm Kiếm (Bìa cứng mỹ thuật)', N'Toàn thư về các thuật toán sắp xếp và tra cứu dữ liệu tối ưu nhất.', 250000.00, 205000.00, 89, 254, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/65/4c/2da4aa944b6f280afbd694ac1a129682.jpeg', 1, '2026-01-12 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (786, N'978-604-040786', N'CODE - Ngôn Ngữ Ẩn Giấu Đằng Sau Máy Tính (Bìa cứng mỹ thuật)', N'Hành trình giải thích sinh động cách phần cứng và phần mềm máy tính thực sự hoạt động.', 75000.00, 64000.00, 179, 366, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235222533.jpg', 1, '2026-03-14 10:00:00', 4, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (787, N'978-604-040787', N'Clean Code - Mã Sạch Trong Lập Trình - Tập 5', N'Quy chuẩn viết code dễ đọc, dễ bảo trì và loại bỏ code smell của huyền thoại Uncle Bob.', 125000.00, 100000.00, 107, 412, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230004561.jpg', 1, '2026-10-13 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (788, N'978-604-040788', N'Clean Architecture - Kiến Trúc Phần Mềm Sạch - Tập 5', N'Cấu trúc hệ thống phần mềm độc lập với framework, UI, cơ sở dữ liệu và ngoại vi.', 138000.00, 121000.00, 34, 341, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425155.jpg', 1, '2026-03-23 10:00:00', 4, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (789, N'978-604-040789', N'Refactoring - Cải Thiện Thiết Kế Mã Nguồn Hiện Có - Tập 5', N'Kỹ thuật tái cấu trúc code an toàn với các mẫu chuyển đổi kinh điển của Martin Fowler.', 195000.00, 176000.00, 89, 468, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425124.jpg', 1, '2026-09-13 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (790, N'978-604-040790', N'The Pragmatic Programmer - Lập Trình Viên Thực Dụng - Tập 5', N'Lời khuyên thực chiến quý giá từ tư duy nghề nghiệp đến kỹ thuật coding đỉnh cao.', 160000.00, 131000.00, 60, 300, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425131.jpg', 1, '2026-06-15 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (791, N'978-604-040791', N'Head First Design Patterns - Các Mẫu Thiết Kế - Tập 5', N'Học các mẫu thiết kế hướng đối tượng qua hình ảnh trực quan, dí dỏm và dễ tiếp thu.', 145000.00, 123000.00, 27, 224, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425148.jpg', 1, '2026-08-10 10:00:00', 4, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (792, N'978-604-040792', N'Designing Data-Intensive Applications - Tập 5', N'Cuốn sách gối đầu giường về thiết kế hệ thống dữ liệu phân tán quy mô lớn.', 98000.00, 88000.00, 111, 544, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230005032.jpg', 1, '2026-07-19 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (793, N'978-604-040793', N'Building Microservices - Thiết Kế Hệ Thống Độc Lập - Tập 5', N'Kiến trúc microservice toàn diện: Phân tách domain, giao tiếp API, bảo mật và deploy.', 175000.00, 149000.00, 249, 561, 2023, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425155.jpg', 1, '2026-04-02 10:00:00', 4, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (794, N'978-604-040794', N'Microservices Patterns - Mẫu Kiến Trúc Thực Chiến - Tập 5', N'Giải quyết các thách thức phân tán: Saga pattern, CQRS, Event Sourcing và Transactional Outbox.', 280000.00, 230000.00, 196, 581, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230006789.jpg', 1, '2026-01-13 10:00:00', 4, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (795, N'978-604-040795', N'Machine Learning Yearning - Cẩm Nang Thực Chiến - Tập 5', N'Andrew Ng chia sẻ kinh nghiệm định hướng và tối ưu hóa dự án học máy thực tế.', 85000.00, 68000.00, 244, 666, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425124.jpg', 1, '2026-07-14 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (796, N'978-604-040796', N'Deep Learning - Học Sâu Với Python & PyTorch - Tập 5', N'Toàn thư về mạng nơ-ron nhân tạo, CNN, RNN, Transformer và Generative AI.', 280000.00, 224000.00, 151, 401, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230007890.jpg', 1, '2026-10-01 10:00:00', 4, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (797, N'978-604-040797', N'Prompt Engineering Thực Chiến Cho Lập Trình Viên - Tập 5', N'Khai thác tối đa sức mạnh của LLM, ChatGPT và Gemini trong quy trình phát triển phần mềm.', 138000.00, 110000.00, 151, 679, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426001.jpg', 1, '2026-01-25 10:00:00', 4, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (798, N'978-604-040798', N'Data Science Từ Con Số 0 - Tập 5', N'Nền tảng toán học, thống kê, giải thuật và phân tích dữ liệu ứng dụng bằng Python.', 138000.00, 110000.00, 83, 668, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230005032.jpg', 1, '2026-07-01 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (799, N'978-604-040799', N'Lập Trình Python Nâng Cao & Tối Ưu Hiệu Năng - Tập 5', N'Làm chủ Generators, Concurrency, Asyncio, Metaprogramming và tối ưu bộ nhớ.', 98000.00, 80000.00, 122, 397, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235241848.jpg', 1, '2026-09-22 10:00:00', 4, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (800, N'978-604-040800', N'C# 12 & .NET 8/9/10 Thực Chiến - Tập 5', N'Xây dựng Web API, Microservices và ứng dụng Cloud-native hiện đại với nền tảng .NET.', 125000.00, 102000.00, 46, 576, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg', 1, '2026-04-21 10:00:00', 4, 7);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (801, N'978-604-040801', N'Lập Trình Rust - Từ Cơ Bản Đến Hệ Thống An Toàn - Tập 5', N'Khái niệm Ownership, Borrowing, Lifetimes và lập trình hệ thống không lo rò rỉ bộ nhớ.', 69000.00, 55000.00, 165, 442, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/d0/ba/09/17804041c2830c092d9b2278b8be9b58.jpg', 1, '2026-03-13 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (802, N'978-604-040802', N'Golang Cho Hệ Thống Hiệu Năng Cao - Tập 5', N'Xây dựng các backend chịu tải lớn, đồng thời cao với Goroutines và Channels.', 280000.00, 230000.00, 175, 584, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/df/fe/df/08a4a624353b4289b877cf3bced910e4.jpg', 1, '2026-06-05 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (803, N'978-604-040803', N'Docker & Kubernetes Toàn Thư - Tập 5', N'Đóng gói ứng dụng container và quản trị điều phối cụm server sản xuất quy mô lớn.', 75000.00, 64000.00, 72, 198, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/81/9f/74/5f64c3144d59ac007b344589f12cfc8e.jpg', 1, '2026-08-04 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (804, N'978-604-040804', N'DevOps & CI/CD Hiện Đại Với GitHub Actions - Tập 5', N'Tự động hóa kiểm thử, build và triển khai phần mềm liên tục lên hạ tầng Cloud.', 138000.00, NULL, 186, 560, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/a0/a3/2b/006dac88a54de6057ebc9e922069d2bd.jpg', 1, '2026-03-26 10:00:00', 4, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (805, N'978-604-040805', N'An Toàn Thông Tin & Phòng Ngự Mã Độc - Tập 5', N'Nguyên lý an ninh mạng, kiểm thử xâm nhập (Penetration Testing) và bảo mật ứng dụng Web.', 110000.00, 99000.00, 18, 266, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5e/18/24/2a6154ba08df6ce6161c13f4303fa19e.jpg', 1, '2026-06-18 10:00:00', 4, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (806, N'978-604-040806', N'Kiến Trúc Cloud-Native Với AWS & Azure - Tập 5', N'Thiết kế các giải pháp điện toán đám mây co giãn linh hoạt, chịu lỗi cao và tối ưu chi phí.', 145000.00, NULL, 73, 336, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/07/47/18/c2b4715eb2e56d0e33f4b6788532b182.jpg', 1, '2026-06-20 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (807, N'978-604-040807', N'The Art of Computer Programming - Tập 1: Giải Thuật Căn Bản - Tập 5', N'Bộ sách kinh điển vĩ đại của Donald Knuth về cấu trúc dữ liệu và giải thuật toán học.', 280000.00, 246000.00, 202, 643, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/70/63/3d/c57040b46e074d49d9e2af573ecefd4e.jpg', 1, '2026-06-08 10:00:00', 4, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (808, N'978-604-040808', N'The Art of Computer Programming - Tập 2: Giải Thuật Bán Số Học - Tập 5', N'Nghiên cứu chuyên sâu về số học ngẫu nhiên và phép toán số học máy tính.', 138000.00, 113000.00, 213, 676, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/1b/79/a2/96348da390aaa6f67b02213108f37a6e.jpg', 1, '2026-10-07 10:00:00', 4, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (809, N'978-604-040809', N'The Art of Computer Programming - Tập 3: Sắp Xếp & Tìm Kiếm - Tập 5', N'Toàn thư về các thuật toán sắp xếp và tra cứu dữ liệu tối ưu nhất.', 220000.00, 187000.00, 114, 677, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5a/a1/cb/6d1c9e9875a9ac35d5a5a536f813f4ee.png', 1, '2026-07-22 10:00:00', 4, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (810, N'978-604-040810', N'CODE - Ngôn Ngữ Ẩn Giấu Đằng Sau Máy Tính - Tập 5', N'Hành trình giải thích sinh động cách phần cứng và phần mềm máy tính thực sự hoạt động.', 92000.00, NULL, 145, 219, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/75/47/f1/8d0571eda17578c74710a18d81aad5a2.png', 1, '2026-05-15 10:00:00', 4, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (811, N'978-604-050811', N'Sapiens - Lược Sử Loài Người (Bản Đặc Biệt)', N'Hành trình loài vượn người tầm thường thảo nguyên châu Phi trở thành bá chủ Trái Đất.', 110000.00, 99000.00, 123, 345, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/55/44/5c/ef26b60328ea00db2ac6358b69a18935.jpg', 1, '2026-07-02 10:00:00', 5, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (812, N'978-604-050812', N'Homo Deus - Lược Sử Tương Lai', N'Dự báo tương lai khi con người làm chủ công nghệ sinh học và trí tuệ nhân tạo.', 92000.00, 74000.00, 123, 620, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/41/02/5e/3ef2506a5e3a7ce69c3b3f5fc6ea3401.jpg', 1, '2026-01-07 10:00:00', 5, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (813, N'978-604-050813', N'21 Bài Học Cho Thế Kỷ 21', N'Những câu hỏi cấp thiết về công nghệ, chính trị, tôn giáo và sự sống còn thời đại số.', 75000.00, 68000.00, 164, 567, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/93/8e/2c/a5dd4c236a604246a2c7a79f11e7badb.jpg', 1, '2026-09-28 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (814, N'978-604-050814', N'Súng, Vi Trùng Và Thép - Định Mệnh Các Xã Hội', N'Giải mã tại sao các nền văn minh Á-Âu lại phát triển vượt bậc so với các châu lục khác.', 110000.00, 94000.00, 88, 333, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/3d/b2/eb/395145ab859d548c23386223bc4f746d.png', 1, '2026-01-28 10:00:00', 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (815, N'978-604-050815', N'Việt Nam Sử Lược - Trần Trọng Kim', N'Bộ thông sử Việt Nam đầu tiên viết bằng chữ quốc ngữ, mạch lạc và súc tích.', 92000.00, 81000.00, 84, 549, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/65/4c/2da4aa944b6f280afbd694ac1a129682.jpeg', 1, '2026-01-18 10:00:00', 5, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (816, N'978-604-050816', N'Đại Việt Sử Ký Toàn Thư - Trọn Bộ', N'Bộ quốc sử vĩ đại ghi chép lịch sử nước Việt từ thời Hồng Bàng đến thời Hậu Lê.', 145000.00, 123000.00, 119, 453, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/i/m/img011.u2751.d20170404.t142005.692809.jpg', 1, '2026-01-25 10:00:00', 5, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (817, N'978-604-050817', N'Lịch Sử Văn Minh Thế Giới', N'Toàn cảnh các nền văn minh Lưỡng Hà, Ai Cập, Hy Lạp, La Mã, Ấn Độ và Trung Hoa.', 110000.00, 99000.00, 116, 318, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5e/18/24/2a6154ba08df6ce6161c13f4303fa19e.jpg', 1, '2026-09-08 10:00:00', 5, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (818, N'978-604-050818', N'Con Đường Tơ Lụa - Lịch Sử Mới Của Thế Giới', N'Mạng lưới giao thương Á-Âu đã định hình sự chuyển dịch quyền lực và văn hóa nhân loại.', 138000.00, 124000.00, 34, 261, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236435314.jpg', 1, '2026-04-11 10:00:00', 5, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (819, N'978-604-050819', N'Binh Pháp Tôn Tử & Tam Thập Lục Kế', N'Bậc thầy mưu lược quân sự Tôn Vũ với nghệ thuật bất chiến tự nhiên thành.', 138000.00, 124000.00, 155, 608, 2024, N'en', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/70/63/3d/c57040b46e074d49d9e2af573ecefd4e.jpg', 1, '2026-04-19 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (820, N'978-604-050820', N'Đạo Đức Kinh - Lão Tử', N'Triết lý Vô vi, hòa hợp với tự nhiên và sự uyển chuyển như nước của Đạo gia phương Đông.', 92000.00, 74000.00, 103, 368, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936049952142.jpg', 1, '2026-04-13 10:00:00', 5, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (821, N'978-604-050821', N'Nam Hoa Kinh - Trang Tử', N'Những câu chuyện ngụ ngôn thâm thúy về tự do tuyệt đối của tâm hồn giữa cõi nhân gian.', 195000.00, 156000.00, 114, 318, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/5/5/554d80fa-8555-4093-b8c0-56e7d00b1a3f.jpg', 1, '2026-04-17 10:00:00', 5, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (822, N'978-604-050822', N'Cộng Hòa (Plato)', N'Tác phẩm nền tảng của triết học chính trị phương Tây về công lý và nhà nước lý tưởng.', 110000.00, 94000.00, 221, 666, 2024, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235240971.jpg', 1, '2026-03-20 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (823, N'978-604-050823', N'Bàn Về Khế Ước Xã Hội (Rousseau)', N'Tư tưởng tự do dân chủ và chủ quyền nhân dân mở đường cho Cách mạng Pháp.', 160000.00, 144000.00, 55, 525, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235230019_1.jpg', 1, '2026-01-13 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (824, N'978-604-050824', N'Nhập Môn Triết Học Phương Tây', N'Hành trình tư tưởng từ Socrates, Plato, Descartes, Kant đến Nietzsche và Sartre.', 195000.00, NULL, 170, 376, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974178408.jpg', 1, '2026-08-22 10:00:00', 5, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (825, N'978-604-050825', N'Lý Quang Diệu - Hồi Ký Xây Dựng Đất Nước', N'Hành trình biến hòn đảo nhỏ nghèo nàn Singapore thành kỳ quan phát triển của thế giới.', 250000.00, 220000.00, 164, 497, 2019, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936203361674.jpg', 1, '2026-04-22 10:00:00', 5, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (826, N'978-604-050826', N'Sapiens - Lược Sử Loài Người (Bản Đặc Biệt) (Tái bản có bổ sung)', N'Hành trình loài vượn người tầm thường thảo nguyên châu Phi trở thành bá chủ Trái Đất.', 75000.00, 68000.00, 140, 245, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235244177.jpg', 1, '2026-06-10 10:00:00', 5, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (827, N'978-604-050827', N'Homo Deus - Lược Sử Tương Lai (Tái bản có bổ sung)', N'Dự báo tương lai khi con người làm chủ công nghệ sinh học và trí tuệ nhân tạo.', 175000.00, 140000.00, 187, 628, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936049952142.jpg', 1, '2026-10-23 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (828, N'978-604-050828', N'21 Bài Học Cho Thế Kỷ 21 (Tái bản có bổ sung)', N'Những câu hỏi cấp thiết về công nghệ, chính trị, tôn giáo và sự sống còn thời đại số.', 145000.00, 116000.00, 215, 471, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936203361674.jpg', 1, '2026-03-21 10:00:00', 5, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (829, N'978-604-050829', N'Súng, Vi Trùng Và Thép - Định Mệnh Các Xã Hội (Tái bản có bổ sung)', N'Giải mã tại sao các nền văn minh Á-Âu lại phát triển vượt bậc so với các châu lục khác.', 250000.00, 200000.00, 119, 400, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg', 1, '2026-09-22 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (830, N'978-604-050830', N'Việt Nam Sử Lược - Trần Trọng Kim (Tái bản có bổ sung)', N'Bộ thông sử Việt Nam đầu tiên viết bằng chữ quốc ngữ, mạch lạc và súc tích.', 110000.00, NULL, 164, 625, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/df/fe/df/08a4a624353b4289b877cf3bced910e4.jpg', 1, '2026-07-24 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (831, N'978-604-050831', N'Đại Việt Sử Ký Toàn Thư - Trọn Bộ (Tái bản có bổ sung)', N'Bộ quốc sử vĩ đại ghi chép lịch sử nước Việt từ thời Hồng Bàng đến thời Hậu Lê.', 125000.00, 102000.00, 218, 270, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/81/9f/74/5f64c3144d59ac007b344589f12cfc8e.jpg', 1, '2026-03-16 10:00:00', 5, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (832, N'978-604-050832', N'Lịch Sử Văn Minh Thế Giới (Tái bản có bổ sung)', N'Toàn cảnh các nền văn minh Lưỡng Hà, Ai Cập, Hy Lạp, La Mã, Ấn Độ và Trung Hoa.', 195000.00, 172000.00, 103, 436, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5e/18/24/2a6154ba08df6ce6161c13f4303fa19e.jpg', 1, '2026-07-15 10:00:00', 5, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (833, N'978-604-050833', N'Con Đường Tơ Lụa - Lịch Sử Mới Của Thế Giới (Tái bản có bổ sung)', N'Mạng lưới giao thương Á-Âu đã định hình sự chuyển dịch quyền lực và văn hóa nhân loại.', 160000.00, 136000.00, 207, 647, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974099192.jpg', 1, '2026-08-17 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (834, N'978-604-050834', N'Binh Pháp Tôn Tử & Tam Thập Lục Kế (Tái bản có bổ sung)', N'Bậc thầy mưu lược quân sự Tôn Vũ với nghệ thuật bất chiến tự nhiên thành.', 138000.00, 121000.00, 121, 248, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/b/n/bn01do-1.u2769.d20170607.t182835.572283_2.jpg', 1, '2026-04-22 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (835, N'978-604-050835', N'Đạo Đức Kinh - Lão Tử (Tái bản có bổ sung)', N'Triết lý Vô vi, hòa hợp với tự nhiên và sự uyển chuyển như nước của Đạo gia phương Đông.', 125000.00, 102000.00, 110, 374, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974152507.jpg', 1, '2026-10-23 10:00:00', 5, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (836, N'978-604-050836', N'Nam Hoa Kinh - Trang Tử (Tái bản có bổ sung)', N'Những câu chuyện ngụ ngôn thâm thúy về tự do tuyệt đối của tâm hồn giữa cõi nhân gian.', 145000.00, 123000.00, 243, 335, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8934974178408.jpg', 1, '2026-03-09 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (837, N'978-604-050837', N'Cộng Hòa (Plato) (Tái bản có bổ sung)', N'Tác phẩm nền tảng của triết học chính trị phương Tây về công lý và nhà nước lý tưởng.', 110000.00, 94000.00, 76, 464, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235230019_1.jpg', 1, '2026-07-08 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (838, N'978-604-050838', N'Bàn Về Khế Ước Xã Hội (Rousseau) (Tái bản có bổ sung)', N'Tư tưởng tự do dân chủ và chủ quyền nhân dân mở đường cho Cách mạng Pháp.', 220000.00, NULL, 179, 277, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235249561.jpg', 1, '2026-05-03 10:00:00', 5, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (839, N'978-604-050839', N'Nhập Môn Triết Học Phương Tây (Tái bản có bổ sung)', N'Hành trình tư tưởng từ Socrates, Plato, Descartes, Kant đến Nietzsche và Sartre.', 85000.00, 68000.00, 157, 595, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235244177.jpg', 1, '2026-01-02 10:00:00', 5, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (840, N'978-604-050840', N'Lý Quang Diệu - Hồi Ký Xây Dựng Đất Nước (Tái bản có bổ sung)', N'Hành trình biến hòn đảo nhỏ nghèo nàn Singapore thành kỳ quan phát triển của thế giới.', 220000.00, 176000.00, 205, 197, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235249561.jpg', 1, '2026-08-05 10:00:00', 5, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (841, N'978-604-050841', N'Sapiens - Lược Sử Loài Người (Bản Đặc Biệt) - Ấn bản kỷ niệm', N'Hành trình loài vượn người tầm thường thảo nguyên châu Phi trở thành bá chủ Trái Đất.', 160000.00, 131000.00, 154, 332, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235244177.jpg', 1, '2026-01-07 10:00:00', 5, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (842, N'978-604-050842', N'Homo Deus - Lược Sử Tương Lai - Ấn bản kỷ niệm', N'Dự báo tương lai khi con người làm chủ công nghệ sinh học và trí tuệ nhân tạo.', 195000.00, 172000.00, 71, 245, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-05-17 10:00:00', 5, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (843, N'978-604-050843', N'21 Bài Học Cho Thế Kỷ 21 - Ấn bản kỷ niệm', N'Những câu hỏi cấp thiết về công nghệ, chính trị, tôn giáo và sự sống còn thời đại số.', 145000.00, 130000.00, 152, 413, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-06-10 10:00:00', 5, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (844, N'978-604-050844', N'Súng, Vi Trùng Và Thép - Định Mệnh Các Xã Hội - Ấn bản kỷ niệm', N'Giải mã tại sao các nền văn minh Á-Âu lại phát triển vượt bậc so với các châu lục khác.', 92000.00, 78000.00, 184, 595, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg', 1, '2026-05-27 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (845, N'978-604-050845', N'Việt Nam Sử Lược - Trần Trọng Kim - Ấn bản kỷ niệm', N'Bộ thông sử Việt Nam đầu tiên viết bằng chữ quốc ngữ, mạch lạc và súc tích.', 138000.00, 124000.00, 195, 451, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-03-02 10:00:00', 5, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (846, N'978-604-050846', N'Đại Việt Sử Ký Toàn Thư - Trọn Bộ - Ấn bản kỷ niệm', N'Bộ quốc sử vĩ đại ghi chép lịch sử nước Việt từ thời Hồng Bàng đến thời Hậu Lê.', 138000.00, 117000.00, 179, 425, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/t/h/the-psychology-of-money.jpg', 1, '2026-07-16 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (847, N'978-604-050847', N'Lịch Sử Văn Minh Thế Giới - Ấn bản kỷ niệm', N'Toàn cảnh các nền văn minh Lưỡng Hà, Ai Cập, Hy Lạp, La Mã, Ấn Độ và Trung Hoa.', 75000.00, 60000.00, 150, 189, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/i/m/image_230367.jpg', 1, '2026-02-20 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (848, N'978-604-050848', N'Con Đường Tơ Lụa - Lịch Sử Mới Của Thế Giới - Ấn bản kỷ niệm', N'Mạng lưới giao thương Á-Âu đã định hình sự chuyển dịch quyền lực và văn hóa nhân loại.', 195000.00, 166000.00, 153, 646, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-10-16 10:00:00', 5, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (849, N'978-604-050849', N'Binh Pháp Tôn Tử & Tam Thập Lục Kế - Ấn bản kỷ niệm', N'Bậc thầy mưu lược quân sự Tôn Vũ với nghệ thuật bất chiến tự nhiên thành.', 250000.00, 220000.00, 44, 271, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251400267.jpg', 1, '2026-02-20 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (850, N'978-604-050850', N'Đạo Đức Kinh - Lão Tử - Ấn bản kỷ niệm', N'Triết lý Vô vi, hòa hợp với tự nhiên và sự uyển chuyển như nước của Đạo gia phương Đông.', 92000.00, 74000.00, 219, 530, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403589.jpg', 1, '2026-03-07 10:00:00', 5, 8);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (851, N'978-604-050851', N'Nam Hoa Kinh - Trang Tử - Ấn bản kỷ niệm', N'Những câu chuyện ngụ ngôn thâm thúy về tự do tuyệt đối của tâm hồn giữa cõi nhân gian.', 138000.00, 113000.00, 86, 563, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-08-21 10:00:00', 5, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (852, N'978-604-050852', N'Cộng Hòa (Plato) - Ấn bản kỷ niệm', N'Tác phẩm nền tảng của triết học chính trị phương Tây về công lý và nhà nước lý tưởng.', 98000.00, 80000.00, 85, 323, 2019, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-03-07 10:00:00', 5, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (853, N'978-604-050853', N'Bàn Về Khế Ước Xã Hội (Rousseau) - Ấn bản kỷ niệm', N'Tư tưởng tự do dân chủ và chủ quyền nhân dân mở đường cho Cách mạng Pháp.', 69000.00, 57000.00, 199, 517, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-01-02 10:00:00', 5, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (854, N'978-604-050854', N'Nhập Môn Triết Học Phương Tây - Ấn bản kỷ niệm', N'Hành trình tư tưởng từ Socrates, Plato, Descartes, Kant đến Nietzsche và Sartre.', 280000.00, 246000.00, 245, 348, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-04-13 10:00:00', 5, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (855, N'978-604-050855', N'Lý Quang Diệu - Hồi Ký Xây Dựng Đất Nước - Ấn bản kỷ niệm', N'Hành trình biến hòn đảo nhỏ nghèo nàn Singapore thành kỳ quan phát triển của thế giới.', 250000.00, 205000.00, 179, 170, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-03-23 10:00:00', 5, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (856, N'978-604-050856', N'Sapiens - Lược Sử Loài Người (Bản Đặc Biệt) (Bìa cứng mỹ thuật)', N'Hành trình loài vượn người tầm thường thảo nguyên châu Phi trở thành bá chủ Trái Đất.', 75000.00, 61000.00, 90, 319, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-02-06 10:00:00', 5, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (857, N'978-604-050857', N'Homo Deus - Lược Sử Tương Lai (Bìa cứng mỹ thuật)', N'Dự báo tương lai khi con người làm chủ công nghệ sinh học và trí tuệ nhân tạo.', 138000.00, 121000.00, 227, 590, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-01-17 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (858, N'978-604-050858', N'21 Bài Học Cho Thế Kỷ 21 (Bìa cứng mỹ thuật)', N'Những câu hỏi cấp thiết về công nghệ, chính trị, tôn giáo và sự sống còn thời đại số.', 220000.00, 198000.00, 73, 238, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-01-02 10:00:00', 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (859, N'978-604-050859', N'Súng, Vi Trùng Và Thép - Định Mệnh Các Xã Hội (Bìa cứng mỹ thuật)', N'Giải mã tại sao các nền văn minh Á-Âu lại phát triển vượt bậc so với các châu lục khác.', 98000.00, 88000.00, 235, 419, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402773.jpg', 1, '2026-03-18 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (860, N'978-604-050860', N'Việt Nam Sử Lược - Trần Trọng Kim (Bìa cứng mỹ thuật)', N'Bộ thông sử Việt Nam đầu tiên viết bằng chữ quốc ngữ, mạch lạc và súc tích.', 85000.00, 68000.00, 198, 551, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-09-21 10:00:00', 5, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (861, N'978-604-050861', N'Đại Việt Sử Ký Toàn Thư - Trọn Bộ (Bìa cứng mỹ thuật)', N'Bộ quốc sử vĩ đại ghi chép lịch sử nước Việt từ thời Hồng Bàng đến thời Hậu Lê.', 175000.00, 144000.00, 82, 342, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-02-10 10:00:00', 5, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (862, N'978-604-050862', N'Lịch Sử Văn Minh Thế Giới (Bìa cứng mỹ thuật)', N'Toàn cảnh các nền văn minh Lưỡng Hà, Ai Cập, Hy Lạp, La Mã, Ấn Độ và Trung Hoa.', 250000.00, NULL, 220, 641, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-01-22 10:00:00', 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (863, N'978-604-050863', N'Con Đường Tơ Lụa - Lịch Sử Mới Của Thế Giới (Bìa cứng mỹ thuật)', N'Mạng lưới giao thương Á-Âu đã định hình sự chuyển dịch quyền lực và văn hóa nhân loại.', 69000.00, 57000.00, 85, 287, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-02-21 10:00:00', 5, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (864, N'978-604-050864', N'Binh Pháp Tôn Tử & Tam Thập Lục Kế (Bìa cứng mỹ thuật)', N'Bậc thầy mưu lược quân sự Tôn Vũ với nghệ thuật bất chiến tự nhiên thành.', 98000.00, 88000.00, 46, 479, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-01-17 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (865, N'978-604-050865', N'Đạo Đức Kinh - Lão Tử (Bìa cứng mỹ thuật)', N'Triết lý Vô vi, hòa hợp với tự nhiên và sự uyển chuyển như nước của Đạo gia phương Đông.', 138000.00, 117000.00, 69, 673, 2023, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-05-10 10:00:00', 5, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (866, N'978-604-050866', N'Nam Hoa Kinh - Trang Tử (Bìa cứng mỹ thuật)', N'Những câu chuyện ngụ ngôn thâm thúy về tự do tuyệt đối của tâm hồn giữa cõi nhân gian.', 75000.00, 61000.00, 168, 461, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-05-16 10:00:00', 5, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (867, N'978-604-050867', N'Cộng Hòa (Plato) (Bìa cứng mỹ thuật)', N'Tác phẩm nền tảng của triết học chính trị phương Tây về công lý và nhà nước lý tưởng.', 145000.00, 130000.00, 114, 393, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/t/h/the-psychology-of-money.jpg', 1, '2026-05-07 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (868, N'978-604-050868', N'Bàn Về Khế Ước Xã Hội (Rousseau) (Bìa cứng mỹ thuật)', N'Tư tưởng tự do dân chủ và chủ quyền nhân dân mở đường cho Cách mạng Pháp.', 85000.00, 76000.00, 64, 390, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/i/m/image_230367.jpg', 1, '2026-09-21 10:00:00', 5, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (869, N'978-604-050869', N'Nhập Môn Triết Học Phương Tây (Bìa cứng mỹ thuật)', N'Hành trình tư tưởng từ Socrates, Plato, Descartes, Kant đến Nietzsche và Sartre.', 220000.00, NULL, 227, 576, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-04-20 10:00:00', 5, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (870, N'978-604-050870', N'Lý Quang Diệu - Hồi Ký Xây Dựng Đất Nước (Bìa cứng mỹ thuật)', N'Hành trình biến hòn đảo nhỏ nghèo nàn Singapore thành kỳ quan phát triển của thế giới.', 138000.00, 110000.00, 132, 209, 2021, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251400267.jpg', 1, '2026-03-03 10:00:00', 5, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (871, N'978-604-050871', N'Sapiens - Lược Sử Loài Người (Bản Đặc Biệt) - Tập 5', N'Hành trình loài vượn người tầm thường thảo nguyên châu Phi trở thành bá chủ Trái Đất.', 125000.00, 110000.00, 174, 633, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403589.jpg', 1, '2026-04-16 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (872, N'978-604-050872', N'Homo Deus - Lược Sử Tương Lai - Tập 5', N'Dự báo tương lai khi con người làm chủ công nghệ sinh học và trí tuệ nhân tạo.', 138000.00, NULL, 207, 630, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-07-01 10:00:00', 5, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (873, N'978-604-050873', N'21 Bài Học Cho Thế Kỷ 21 - Tập 5', N'Những câu hỏi cấp thiết về công nghệ, chính trị, tôn giáo và sự sống còn thời đại số.', 250000.00, 205000.00, 164, 550, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-08-26 10:00:00', 5, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (874, N'978-604-050874', N'Súng, Vi Trùng Và Thép - Định Mệnh Các Xã Hội - Tập 5', N'Giải mã tại sao các nền văn minh Á-Âu lại phát triển vượt bậc so với các châu lục khác.', 85000.00, 68000.00, 20, 236, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403756.jpg', 1, '2026-06-10 10:00:00', 5, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (875, N'978-604-050875', N'Việt Nam Sử Lược - Trần Trọng Kim - Tập 5', N'Bộ thông sử Việt Nam đầu tiên viết bằng chữ quốc ngữ, mạch lạc và súc tích.', 250000.00, 200000.00, 207, 411, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410716.jpg', 1, '2026-10-05 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (876, N'978-604-050876', N'Đại Việt Sử Ký Toàn Thư - Trọn Bộ - Tập 5', N'Bộ quốc sử vĩ đại ghi chép lịch sử nước Việt từ thời Hồng Bàng đến thời Hậu Lê.', 138000.00, 124000.00, 87, 381, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-10-28 10:00:00', 5, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (877, N'978-604-050877', N'Lịch Sử Văn Minh Thế Giới - Tập 5', N'Toàn cảnh các nền văn minh Lưỡng Hà, Ai Cập, Hy Lạp, La Mã, Ấn Độ và Trung Hoa.', 138000.00, 113000.00, 228, 335, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/d/a/day_con_lam_giau__tap_1_9_2018_08_03_15_23_14.jpg', 1, '2026-01-02 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (878, N'978-604-050878', N'Con Đường Tơ Lụa - Lịch Sử Mới Của Thế Giới - Tập 5', N'Mạng lưới giao thương Á-Âu đã định hình sự chuyển dịch quyền lực và văn hóa nhân loại.', 69000.00, 59000.00, 77, 457, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/t/h/the-psychology-of-money.jpg', 1, '2026-01-20 10:00:00', 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (879, N'978-604-050879', N'Binh Pháp Tôn Tử & Tam Thập Lục Kế - Tập 5', N'Bậc thầy mưu lược quân sự Tôn Vũ với nghệ thuật bất chiến tự nhiên thành.', 220000.00, 180000.00, 72, 186, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/i/m/image_230367.jpg', 1, '2026-03-13 10:00:00', 5, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (880, N'978-604-050880', N'Đạo Đức Kinh - Lão Tử - Tập 5', N'Triết lý Vô vi, hòa hợp với tự nhiên và sự uyển chuyển như nước của Đạo gia phương Đông.', 110000.00, 99000.00, 157, 304, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402247.jpg', 1, '2026-06-26 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (881, N'978-604-050881', N'Nam Hoa Kinh - Trang Tử - Tập 5', N'Những câu chuyện ngụ ngôn thâm thúy về tự do tuyệt đối của tâm hồn giữa cõi nhân gian.', 75000.00, 60000.00, 146, 508, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251400267.jpg', 1, '2026-03-21 10:00:00', 5, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (882, N'978-604-050882', N'Cộng Hòa (Plato) - Tập 5', N'Tác phẩm nền tảng của triết học chính trị phương Tây về công lý và nhà nước lý tưởng.', 160000.00, NULL, 235, 520, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251403589.jpg', 1, '2026-09-27 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (883, N'978-604-050883', N'Bàn Về Khế Ước Xã Hội (Rousseau) - Tập 5', N'Tư tưởng tự do dân chủ và chủ quyền nhân dân mở đường cho Cách mạng Pháp.', 250000.00, 220000.00, 227, 576, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251402513.jpg', 1, '2026-05-28 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (884, N'978-604-050884', N'Nhập Môn Triết Học Phương Tây - Tập 5', N'Hành trình tư tưởng từ Socrates, Plato, Descartes, Kant đến Nietzsche và Sartre.', 110000.00, 94000.00, 83, 516, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554270.jpg', 1, '2026-10-23 10:00:00', 5, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (885, N'978-604-050885', N'Lý Quang Diệu - Hồi Ký Xây Dựng Đất Nước - Tập 5', N'Hành trình biến hòn đảo nhỏ nghèo nàn Singapore thành kỳ quan phát triển của thế giới.', 250000.00, 212000.00, 182, 582, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', 1, '2026-08-19 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (886, N'978-604-050886', N'Sapiens - Lược Sử Loài Người (Bản Đặc Biệt) - Tập 6', N'Hành trình loài vượn người tầm thường thảo nguyên châu Phi trở thành bá chủ Trái Đất.', 125000.00, 100000.00, 86, 235, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-03-13 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (887, N'978-604-050887', N'Homo Deus - Lược Sử Tương Lai - Tập 6', N'Dự báo tương lai khi con người làm chủ công nghệ sinh học và trí tuệ nhân tạo.', 85000.00, 75000.00, 228, 272, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-08-27 10:00:00', 5, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (888, N'978-604-050888', N'21 Bài Học Cho Thế Kỷ 21 - Tập 6', N'Những câu hỏi cấp thiết về công nghệ, chính trị, tôn giáo và sự sống còn thời đại số.', 250000.00, 225000.00, 247, 327, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-03-21 10:00:00', 5, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (889, N'978-604-050889', N'Súng, Vi Trùng Và Thép - Định Mệnh Các Xã Hội - Tập 6', N'Giải mã tại sao các nền văn minh Á-Âu lại phát triển vượt bậc so với các châu lục khác.', 125000.00, NULL, 54, 556, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-06-16 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (890, N'978-604-050890', N'Việt Nam Sử Lược - Trần Trọng Kim - Tập 6', N'Bộ thông sử Việt Nam đầu tiên viết bằng chữ quốc ngữ, mạch lạc và súc tích.', 195000.00, NULL, 172, 598, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-03-14 10:00:00', 5, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (891, N'978-604-050891', N'Đại Việt Sử Ký Toàn Thư - Trọn Bộ - Tập 6', N'Bộ quốc sử vĩ đại ghi chép lịch sử nước Việt từ thời Hồng Bàng đến thời Hậu Lê.', 175000.00, 158000.00, 36, 177, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-07-19 10:00:00', 5, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (892, N'978-604-050892', N'Lịch Sử Văn Minh Thế Giới - Tập 6', N'Toàn cảnh các nền văn minh Lưỡng Hà, Ai Cập, Hy Lạp, La Mã, Ấn Độ và Trung Hoa.', 85000.00, 75000.00, 202, 636, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-07-24 10:00:00', 5, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (893, N'978-604-050893', N'Con Đường Tơ Lụa - Lịch Sử Mới Của Thế Giới - Tập 6', N'Mạng lưới giao thương Á-Âu đã định hình sự chuyển dịch quyền lực và văn hóa nhân loại.', 138000.00, 113000.00, 145, 475, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-04-08 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (894, N'978-604-050894', N'Binh Pháp Tôn Tử & Tam Thập Lục Kế - Tập 6', N'Bậc thầy mưu lược quân sự Tôn Vũ với nghệ thuật bất chiến tự nhiên thành.', 92000.00, 74000.00, 158, 262, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-10-01 10:00:00', 5, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (895, N'978-604-050895', N'Đạo Đức Kinh - Lão Tử - Tập 6', N'Triết lý Vô vi, hòa hợp với tự nhiên và sự uyển chuyển như nước của Đạo gia phương Đông.', 69000.00, NULL, 86, 210, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-03-28 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (896, N'978-604-050896', N'Nam Hoa Kinh - Trang Tử - Tập 6', N'Những câu chuyện ngụ ngôn thâm thúy về tự do tuyệt đối của tâm hồn giữa cõi nhân gian.', 145000.00, 119000.00, 128, 323, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-10-25 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (897, N'978-604-050897', N'Cộng Hòa (Plato) - Tập 6', N'Tác phẩm nền tảng của triết học chính trị phương Tây về công lý và nhà nước lý tưởng.', 195000.00, 172000.00, 79, 271, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-02-14 10:00:00', 5, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (898, N'978-604-050898', N'Bàn Về Khế Ước Xã Hội (Rousseau) - Tập 6', N'Tư tưởng tự do dân chủ và chủ quyền nhân dân mở đường cho Cách mạng Pháp.', 110000.00, 94000.00, 246, 392, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-02-20 10:00:00', 5, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (899, N'978-604-050899', N'Nhập Môn Triết Học Phương Tây - Tập 6', N'Hành trình tư tưởng từ Socrates, Plato, Descartes, Kant đến Nietzsche và Sartre.', 280000.00, 238000.00, 171, 643, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-03-08 10:00:00', 5, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (900, N'978-604-050900', N'Lý Quang Diệu - Hồi Ký Xây Dựng Đất Nước - Tập 6', N'Hành trình biến hòn đảo nhỏ nghèo nàn Singapore thành kỳ quan phát triển của thế giới.', 138000.00, 113000.00, 187, 536, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-01-22 10:00:00', 5, 4);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (901, N'978-604-060901', N'Dế Mèn Phiêu Lưu Ký (Ấn Bản Kỷ Niệm)', N'Chuyến du hành khám phá thế giới rộng lớn và bài học kết nghĩa anh em của Dế Mèn.', 138000.00, 113000.00, 48, 605, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-10-20 10:00:00', 6, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (902, N'978-604-060902', N'Chuyện Hoa Chuyện Quả', N'Những câu chuyện cổ tích giải thích nguồn gốc các loài hoa quả thơm ngọt nước Nam.', 75000.00, 64000.00, 78, 592, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-05-06 10:00:00', 6, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (903, N'978-604-060903', N'Góc Sân Và Khoảng Trời - Trần Đăng Khoa', N'Những vần thơ hồn nhiên, trong trẻo như giọt sương mai của thần đồng thơ ca đất Việt.', 160000.00, 131000.00, 26, 580, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-05-20 10:00:00', 6, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (904, N'978-604-060904', N'Hoàng Tử Bé (Le Petit Prince)', N'Câu chuyện ngụ ngôn triết lý cảm động về tình bạn, hoa hồng và con mắt của trái tim.', 69000.00, 59000.00, 124, 357, 2022, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-07-05 10:00:00', 6, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (905, N'978-604-060905', N'Alice Ở Xứ Sở Thần Tiên', N'Cuộc phiêu lưu kỳ thú của cô bé Alice rơi vào hang thỏ tới thế giới phép thuật ngộ nghĩnh.', 250000.00, 212000.00, 109, 508, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935251410198.jpg', 1, '2026-01-12 10:00:00', 6, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (906, N'978-604-060906', N'Những Cuộc Phiêu Lưu Của Tom Sawyer', N'Trò nghịch ngợm đáng yêu và lòng dũng cảm của chú bé Tom bên dòng sông Mississippi.', 85000.00, 72000.00, 164, 511, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-05-12 10:00:00', 6, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (907, N'978-604-060907', N'Đảo Giấu Vàng - Robert Louis Stevenson', N'Hành trình vượt đại dương tìm kho báu chôn giấu của thuyền trưởng Flint và cậu bé Jim Hawkins.', 138000.00, 113000.00, 48, 666, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-08-02 10:00:00', 6, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (908, N'978-604-060908', N'Totto-chan Bên Cửa Sổ', N'Trường tiểu học Tomoe kỳ diệu nơi các em học sinh được tự do phát triển nhân cách và năng khiếu.', 75000.00, 66000.00, 71, 241, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-02-09 10:00:00', 6, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (909, N'978-604-060909', N'Không Gia Đình - Hector Malot', N'Cuộc đời phiêu bạt đầy nghị lực và lòng hiếu thảo của chú bé mồ côi Remi.', 280000.00, 238000.00, 134, 402, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-07-05 10:00:00', 6, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (910, N'978-604-060910', N'Trong Gia Đình - Hector Malot', N'Nghị lực phi thường của cô bé Perrine vượt qua nghèo khó để tìm lại cội nguồn gia đình.', 85000.00, 70000.00, 184, 309, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-08-13 10:00:00', 6, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (911, N'978-604-060911', N'Dế Mèn Phiêu Lưu Ký (Ấn Bản Kỷ Niệm) (Tái bản có bổ sung)', N'Chuyến du hành khám phá thế giới rộng lớn và bài học kết nghĩa anh em của Dế Mèn.', 69000.00, 57000.00, 37, 529, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-01-22 10:00:00', 6, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (912, N'978-604-060912', N'Chuyện Hoa Chuyện Quả (Tái bản có bổ sung)', N'Những câu chuyện cổ tích giải thích nguồn gốc các loài hoa quả thơm ngọt nước Nam.', 175000.00, 149000.00, 21, 529, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-07-11 10:00:00', 6, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (913, N'978-604-060913', N'Góc Sân Và Khoảng Trời - Trần Đăng Khoa (Tái bản có bổ sung)', N'Những vần thơ hồn nhiên, trong trẻo như giọt sương mai của thần đồng thơ ca đất Việt.', 125000.00, 106000.00, 158, 603, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-09-10 10:00:00', 6, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (914, N'978-604-060914', N'Hoàng Tử Bé (Le Petit Prince) (Tái bản có bổ sung)', N'Câu chuyện ngụ ngôn triết lý cảm động về tình bạn, hoa hồng và con mắt của trái tim.', 250000.00, 200000.00, 23, 544, 2019, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-04-20 10:00:00', 6, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (915, N'978-604-060915', N'Alice Ở Xứ Sở Thần Tiên (Tái bản có bổ sung)', N'Cuộc phiêu lưu kỳ thú của cô bé Alice rơi vào hang thỏ tới thế giới phép thuật ngộ nghĩnh.', 92000.00, 75000.00, 26, 564, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-08-19 10:00:00', 6, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (916, N'978-604-060916', N'Những Cuộc Phiêu Lưu Của Tom Sawyer (Tái bản có bổ sung)', N'Trò nghịch ngợm đáng yêu và lòng dũng cảm của chú bé Tom bên dòng sông Mississippi.', 160000.00, 128000.00, 217, 224, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-07-25 10:00:00', 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (917, N'978-604-060917', N'Đảo Giấu Vàng - Robert Louis Stevenson (Tái bản có bổ sung)', N'Hành trình vượt đại dương tìm kho báu chôn giấu của thuyền trưởng Flint và cậu bé Jim Hawkins.', 138000.00, 121000.00, 61, 300, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554287.jpg', 1, '2026-04-14 10:00:00', 6, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (918, N'978-604-060918', N'Totto-chan Bên Cửa Sổ (Tái bản có bổ sung)', N'Trường tiểu học Tomoe kỳ diệu nơi các em học sinh được tự do phát triển nhân cách và năng khiếu.', 98000.00, NULL, 100, 407, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235218208.jpg', 1, '2026-10-11 10:00:00', 6, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (919, N'978-604-060919', N'Không Gia Đình - Hector Malot (Tái bản có bổ sung)', N'Cuộc đời phiêu bạt đầy nghị lực và lòng hiếu thảo của chú bé mồ côi Remi.', 195000.00, 166000.00, 109, 397, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', 1, '2026-06-23 10:00:00', 6, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (920, N'978-604-060920', N'Trong Gia Đình - Hector Malot (Tái bản có bổ sung)', N'Nghị lực phi thường của cô bé Perrine vượt qua nghèo khó để tìm lại cội nguồn gia đình.', 220000.00, 176000.00, 129, 590, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/e0/76/78/626e3627a59538c5e0d22a23a7f69909.jpg', 1, '2026-09-26 10:00:00', 6, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (921, N'978-604-060921', N'Dế Mèn Phiêu Lưu Ký (Ấn Bản Kỷ Niệm) - Ấn bản kỷ niệm', N'Chuyến du hành khám phá thế giới rộng lớn và bài học kết nghĩa anh em của Dế Mèn.', 160000.00, 131000.00, 180, 335, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/z/4/z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 1, '2026-03-16 10:00:00', 6, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (922, N'978-604-060922', N'Chuyện Hoa Chuyện Quả - Ấn bản kỷ niệm', N'Những câu chuyện cổ tích giải thích nguồn gốc các loài hoa quả thơm ngọt nước Nam.', 98000.00, 80000.00, 122, 672, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', 1, '2026-07-04 10:00:00', 6, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (923, N'978-604-060923', N'Góc Sân Và Khoảng Trời - Trần Đăng Khoa - Ấn bản kỷ niệm', N'Những vần thơ hồn nhiên, trong trẻo như giọt sương mai của thần đồng thơ ca đất Việt.', 85000.00, 76000.00, 161, 574, 2024, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/84/c4/f767858c27891823eb5c998a44b76a08.jpg', 1, '2026-10-09 10:00:00', 6, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (924, N'978-604-060924', N'Hoàng Tử Bé (Le Petit Prince) - Ấn bản kỷ niệm', N'Câu chuyện ngụ ngôn triết lý cảm động về tình bạn, hoa hồng và con mắt của trái tim.', 69000.00, 62000.00, 46, 678, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088550180.jpg', 1, '2026-01-09 10:00:00', 6, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (925, N'978-604-060925', N'Alice Ở Xứ Sở Thần Tiên - Ấn bản kỷ niệm', N'Cuộc phiêu lưu kỳ thú của cô bé Alice rơi vào hang thỏ tới thế giới phép thuật ngộ nghĩnh.', 145000.00, 130000.00, 150, 519, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-10-11 10:00:00', 6, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (926, N'978-604-060926', N'Những Cuộc Phiêu Lưu Của Tom Sawyer - Ấn bản kỷ niệm', N'Trò nghịch ngợm đáng yêu và lòng dũng cảm của chú bé Tom bên dòng sông Mississippi.', 138000.00, NULL, 81, 354, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-08-03 10:00:00', 6, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (927, N'978-604-060927', N'Đảo Giấu Vàng - Robert Louis Stevenson - Ấn bản kỷ niệm', N'Hành trình vượt đại dương tìm kho báu chôn giấu của thuyền trưởng Flint và cậu bé Jim Hawkins.', 138000.00, 113000.00, 243, 269, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-02-11 10:00:00', 6, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (928, N'978-604-060928', N'Totto-chan Bên Cửa Sổ - Ấn bản kỷ niệm', N'Trường tiểu học Tomoe kỳ diệu nơi các em học sinh được tự do phát triển nhân cách và năng khiếu.', 145000.00, 119000.00, 187, 538, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-06-09 10:00:00', 6, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (929, N'978-604-060929', N'Không Gia Đình - Hector Malot - Ấn bản kỷ niệm', N'Cuộc đời phiêu bạt đầy nghị lực và lòng hiếu thảo của chú bé mồ côi Remi.', 195000.00, 160000.00, 123, 286, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124012.jpg', 1, '2026-02-10 10:00:00', 6, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (930, N'978-604-060930', N'Trong Gia Đình - Hector Malot - Ấn bản kỷ niệm', N'Nghị lực phi thường của cô bé Perrine vượt qua nghèo khó để tìm lại cội nguồn gia đình.', 125000.00, 106000.00, 177, 629, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-05-22 10:00:00', 6, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (931, N'978-604-060931', N'Dế Mèn Phiêu Lưu Ký (Ấn Bản Kỷ Niệm) (Bìa cứng mỹ thuật)', N'Chuyến du hành khám phá thế giới rộng lớn và bài học kết nghĩa anh em của Dế Mèn.', 98000.00, 86000.00, 62, 587, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-10-05 10:00:00', 6, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (932, N'978-604-060932', N'Chuyện Hoa Chuyện Quả (Bìa cứng mỹ thuật)', N'Những câu chuyện cổ tích giải thích nguồn gốc các loài hoa quả thơm ngọt nước Nam.', 125000.00, 100000.00, 140, 508, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-08-23 10:00:00', 6, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (933, N'978-604-060933', N'Góc Sân Và Khoảng Trời - Trần Đăng Khoa (Bìa cứng mỹ thuật)', N'Những vần thơ hồn nhiên, trong trẻo như giọt sương mai của thần đồng thơ ca đất Việt.', 69000.00, NULL, 66, 433, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-06-21 10:00:00', 6, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (934, N'978-604-060934', N'Hoàng Tử Bé (Le Petit Prince) (Bìa cứng mỹ thuật)', N'Câu chuyện ngụ ngôn triết lý cảm động về tình bạn, hoa hồng và con mắt của trái tim.', 85000.00, 75000.00, 115, 502, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-07-18 10:00:00', 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (935, N'978-604-060935', N'Alice Ở Xứ Sở Thần Tiên (Bìa cứng mỹ thuật)', N'Cuộc phiêu lưu kỳ thú của cô bé Alice rơi vào hang thỏ tới thế giới phép thuật ngộ nghĩnh.', 138000.00, 117000.00, 47, 467, 2024, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-04-18 10:00:00', 6, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (936, N'978-604-060936', N'Những Cuộc Phiêu Lưu Của Tom Sawyer (Bìa cứng mỹ thuật)', N'Trò nghịch ngợm đáng yêu và lòng dũng cảm của chú bé Tom bên dòng sông Mississippi.', 85000.00, 72000.00, 55, 293, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-06-21 10:00:00', 6, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (937, N'978-604-060937', N'Đảo Giấu Vàng - Robert Louis Stevenson (Bìa cứng mỹ thuật)', N'Hành trình vượt đại dương tìm kho báu chôn giấu của thuyền trưởng Flint và cậu bé Jim Hawkins.', 138000.00, 117000.00, 70, 413, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-02-11 10:00:00', 6, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (938, N'978-604-060938', N'Totto-chan Bên Cửa Sổ (Bìa cứng mỹ thuật)', N'Trường tiểu học Tomoe kỳ diệu nơi các em học sinh được tự do phát triển nhân cách và năng khiếu.', 195000.00, 160000.00, 164, 277, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-09-04 10:00:00', 6, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (939, N'978-604-060939', N'Không Gia Đình - Hector Malot (Bìa cứng mỹ thuật)', N'Cuộc đời phiêu bạt đầy nghị lực và lòng hiếu thảo của chú bé mồ côi Remi.', 250000.00, 225000.00, 190, 427, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-08-05 10:00:00', 6, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (940, N'978-604-060940', N'Trong Gia Đình - Hector Malot (Bìa cứng mỹ thuật)', N'Nghị lực phi thường của cô bé Perrine vượt qua nghèo khó để tìm lại cội nguồn gia đình.', 69000.00, 57000.00, 210, 396, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-02-13 10:00:00', 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (941, N'978-604-060941', N'Dế Mèn Phiêu Lưu Ký (Ấn Bản Kỷ Niệm) - Tập 5', N'Chuyến du hành khám phá thế giới rộng lớn và bài học kết nghĩa anh em của Dế Mèn.', 75000.00, 60000.00, 123, 205, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-10-26 10:00:00', 6, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (942, N'978-604-060942', N'Chuyện Hoa Chuyện Quả - Tập 5', N'Những câu chuyện cổ tích giải thích nguồn gốc các loài hoa quả thơm ngọt nước Nam.', 145000.00, 119000.00, 190, 172, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-06-08 10:00:00', 6, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (943, N'978-604-060943', N'Góc Sân Và Khoảng Trời - Trần Đăng Khoa - Tập 5', N'Những vần thơ hồn nhiên, trong trẻo như giọt sương mai của thần đồng thơ ca đất Việt.', 195000.00, 166000.00, 111, 593, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-08-07 10:00:00', 6, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (944, N'978-604-060944', N'Hoàng Tử Bé (Le Petit Prince) - Tập 5', N'Câu chuyện ngụ ngôn triết lý cảm động về tình bạn, hoa hồng và con mắt của trái tim.', 110000.00, 97000.00, 248, 180, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-03-20 10:00:00', 6, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (945, N'978-604-060945', N'Alice Ở Xứ Sở Thần Tiên - Tập 5', N'Cuộc phiêu lưu kỳ thú của cô bé Alice rơi vào hang thỏ tới thế giới phép thuật ngộ nghĩnh.', 98000.00, 86000.00, 208, 448, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-08-14 10:00:00', 6, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (946, N'978-604-060946', N'Những Cuộc Phiêu Lưu Của Tom Sawyer - Tập 5', N'Trò nghịch ngợm đáng yêu và lòng dũng cảm của chú bé Tom bên dòng sông Mississippi.', 92000.00, NULL, 121, 387, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-02-17 10:00:00', 6, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (947, N'978-604-060947', N'Đảo Giấu Vàng - Robert Louis Stevenson - Tập 5', N'Hành trình vượt đại dương tìm kho báu chôn giấu của thuyền trưởng Flint và cậu bé Jim Hawkins.', 92000.00, NULL, 191, 573, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-03-03 10:00:00', 6, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (948, N'978-604-060948', N'Totto-chan Bên Cửa Sổ - Tập 5', N'Trường tiểu học Tomoe kỳ diệu nơi các em học sinh được tự do phát triển nhân cách và năng khiếu.', 145000.00, 128000.00, 178, 429, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-07-19 10:00:00', 6, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (949, N'978-604-060949', N'Không Gia Đình - Hector Malot - Tập 5', N'Cuộc đời phiêu bạt đầy nghị lực và lòng hiếu thảo của chú bé mồ côi Remi.', 138000.00, 110000.00, 183, 656, 2021, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124012.jpg', 1, '2026-03-23 10:00:00', 6, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (950, N'978-604-060950', N'Trong Gia Đình - Hector Malot - Tập 5', N'Nghị lực phi thường của cô bé Perrine vượt qua nghèo khó để tìm lại cội nguồn gia đình.', 175000.00, 140000.00, 53, 500, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-03-16 10:00:00', 6, 8);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (951, N'978-604-070951', N'Lược Sử Thời Gian - Stephen Hawking', N'Kiệt tác vật lý vũ trụ giải thích Big Bang, Lỗ đen và bản chất của không - thời gian.', 195000.00, 156000.00, 55, 483, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-10-24 10:00:00', 7, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (952, N'978-604-070952', N'Vũ Trụ (Cosmos) - Carl Sagan', N'Bản giao hưởng kỳ vĩ về 15 tỷ năm tiến hóa vũ trụ và vị thế của loài người giữa các vì sao.', 220000.00, 187000.00, 45, 648, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813354.jpg', 1, '2026-10-02 10:00:00', 7, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (953, N'978-604-070953', N'Vũ Trụ Trong Vỏ Hạt Dẻ', N'Học thuyết M, siêu dây và cuộc truy tìm Lý thuyết Vạn vật thống nhất vũ trụ.', 110000.00, 99000.00, 54, 363, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813347.jpg', 1, '2026-09-10 10:00:00', 7, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (954, N'978-604-070954', N'Giai Điệu Bí Ẩn - Con Người Đã Tạo Ra Vũ Trụ Ra Sao', N'Sự tương quan kỳ diệu giữa hằng số vũ trụ và sự tồn tại của sự sống thông minh.', 69000.00, 55000.00, 45, 669, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074123565.jpg', 1, '2026-03-11 10:00:00', 7, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (955, N'978-604-070955', N'Bản Thiết Kế Vĩ Đại (The Grand Design)', N'Vũ trụ tự hình thành từ hư vô theo các quy luật vật lý lượng tử mà không cần phép màu.', 69000.00, 59000.00, 124, 518, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074121288.jpg', 1, '2026-03-22 10:00:00', 7, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (956, N'978-604-070956', N'Vật Lý Thiên Văn Cho Người Vội Vã (Neil deGrasse Tyson)', N'Những hiểu biết cốt lõi về vũ trụ được giải thích súc tích, hóm hỉnh và dễ hiểu.', 69000.00, NULL, 195, 354, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813408.jpg', 1, '2026-08-19 10:00:00', 7, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (957, N'978-604-070957', N'Chắc Bạn Đùa, Feynman!', N'Hồi ức hài hước, lập dị và đam mê khám phá của nhà vật lý lượng tử thiên tài Richard Feynman.', 85000.00, 72000.00, 134, 271, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124012.jpg', 1, '2026-08-21 10:00:00', 7, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (958, N'978-604-070958', N'Nguồn Gốc Các Loài - Charles Darwin', N'Cuốn sách làm rung chuyển thế giới với học thuyết tiến hóa qua chọn lọc tự nhiên.', 110000.00, 99000.00, 32, 620, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935074124500.jpg', 1, '2026-05-27 10:00:00', 7, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (959, N'978-604-070959', N'Thế Giới Lượng Tử Kỳ Thú', N'Khám phá nguyên lý bất định, hiện tượng chồng chập và máy tính lượng tử tương lai.', 160000.00, 131000.00, 180, 527, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', 1, '2026-06-10 10:00:00', 7, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (960, N'978-604-070960', N'Tương Lai Của Nhân Loại - Michio Kaku', N'Hành trình di cư lên sao Hỏa, du hành liên sao và viễn cảnh bất tử công nghệ.', 280000.00, 224000.00, 65, 330, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg', 1, '2026-02-21 10:00:00', 7, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (961, N'978-604-070961', N'Lược Sử Thời Gian - Stephen Hawking (Tái bản có bổ sung)', N'Kiệt tác vật lý vũ trụ giải thích Big Bang, Lỗ đen và bản chất của không - thời gian.', 250000.00, 212000.00, 142, 402, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-07-23 10:00:00', 7, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (962, N'978-604-070962', N'Vũ Trụ (Cosmos) - Carl Sagan (Tái bản có bổ sung)', N'Bản giao hưởng kỳ vĩ về 15 tỷ năm tiến hóa vũ trụ và vị thế của loài người giữa các vì sao.', 250000.00, 205000.00, 59, 526, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703578.jpg', 1, '2026-08-04 10:00:00', 7, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (963, N'978-604-070963', N'Vũ Trụ Trong Vỏ Hạt Dẻ (Tái bản có bổ sung)', N'Học thuyết M, siêu dây và cuộc truy tìm Lý thuyết Vạn vật thống nhất vũ trụ.', 195000.00, 156000.00, 20, 330, 2023, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703585.jpg', 1, '2026-06-11 10:00:00', 7, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (964, N'978-604-070964', N'Giai Điệu Bí Ẩn - Con Người Đã Tạo Ra Vũ Trụ Ra Sao (Tái bản có bổ sung)', N'Sự tương quan kỳ diệu giữa hằng số vũ trụ và sự tồn tại của sự sống thông minh.', 69000.00, 62000.00, 65, 538, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236427357.jpg', 1, '2026-06-01 10:00:00', 7, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (965, N'978-604-070965', N'Bản Thiết Kế Vĩ Đại (The Grand Design) (Tái bản có bổ sung)', N'Vũ trụ tự hình thành từ hư vô theo các quy luật vật lý lượng tử mà không cần phép màu.', 160000.00, 141000.00, 98, 616, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426787.jpg', 1, '2026-03-07 10:00:00', 7, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (966, N'978-604-070966', N'Vật Lý Thiên Văn Cho Người Vội Vã (Neil deGrasse Tyson) (Tái bản có bổ sung)', N'Những hiểu biết cốt lõi về vũ trụ được giải thích súc tích, hóm hỉnh và dễ hiểu.', 85000.00, NULL, 210, 379, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703592.jpg', 1, '2026-07-05 10:00:00', 7, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (967, N'978-604-070967', N'Chắc Bạn Đùa, Feynman! (Tái bản có bổ sung)', N'Hồi ức hài hước, lập dị và đam mê khám phá của nhà vật lý lượng tử thiên tài Richard Feynman.', 92000.00, 78000.00, 216, 373, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg', 1, '2026-09-27 10:00:00', 7, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (968, N'978-604-070968', N'Nguồn Gốc Các Loài - Charles Darwin (Tái bản có bổ sung)', N'Cuốn sách làm rung chuyển thế giới với học thuyết tiến hóa qua chọn lọc tự nhiên.', 160000.00, 136000.00, 58, 448, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-02-08 10:00:00', 7, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (969, N'978-604-070969', N'Thế Giới Lượng Tử Kỳ Thú (Tái bản có bổ sung)', N'Khám phá nguyên lý bất định, hiện tượng chồng chập và máy tính lượng tử tương lai.', 125000.00, 110000.00, 140, 597, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703578.jpg', 1, '2026-05-20 10:00:00', 7, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (970, N'978-604-070970', N'Tương Lai Của Nhân Loại - Michio Kaku (Tái bản có bổ sung)', N'Hành trình di cư lên sao Hỏa, du hành liên sao và viễn cảnh bất tử công nghệ.', 85000.00, NULL, 95, 353, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703585.jpg', 1, '2026-10-09 10:00:00', 7, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (971, N'978-604-070971', N'Lược Sử Thời Gian - Stephen Hawking - Ấn bản kỷ niệm', N'Kiệt tác vật lý vũ trụ giải thích Big Bang, Lỗ đen và bản chất của không - thời gian.', 145000.00, 119000.00, 46, 586, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236427357.jpg', 1, '2026-05-27 10:00:00', 7, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (972, N'978-604-070972', N'Vũ Trụ (Cosmos) - Carl Sagan - Ấn bản kỷ niệm', N'Bản giao hưởng kỳ vĩ về 15 tỷ năm tiến hóa vũ trụ và vị thế của loài người giữa các vì sao.', 280000.00, 230000.00, 212, 164, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426787.jpg', 1, '2026-04-09 10:00:00', 7, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (973, N'978-604-070973', N'Vũ Trụ Trong Vỏ Hạt Dẻ - Ấn bản kỷ niệm', N'Học thuyết M, siêu dây và cuộc truy tìm Lý thuyết Vạn vật thống nhất vũ trụ.', 175000.00, 154000.00, 200, 326, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554102.jpg', 1, '2026-09-02 10:00:00', 7, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (974, N'978-604-070974', N'Giai Điệu Bí Ẩn - Con Người Đã Tạo Ra Vũ Trụ Ra Sao - Ấn bản kỷ niệm', N'Sự tương quan kỳ diệu giữa hằng số vũ trụ và sự tồn tại của sự sống thông minh.', 220000.00, 198000.00, 18, 585, 2024, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554102.jpg', 1, '2026-08-07 10:00:00', 7, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (975, N'978-604-070975', N'Bản Thiết Kế Vĩ Đại (The Grand Design) - Ấn bản kỷ niệm', N'Vũ trụ tự hình thành từ hư vô theo các quy luật vật lý lượng tử mà không cần phép màu.', 125000.00, 100000.00, 189, 431, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703592.jpg', 1, '2026-07-10 10:00:00', 7, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (976, N'978-604-070976', N'Vật Lý Thiên Văn Cho Người Vội Vã (Neil deGrasse Tyson) - Ấn bản kỷ niệm', N'Những hiểu biết cốt lõi về vũ trụ được giải thích súc tích, hóm hỉnh và dễ hiểu.', 250000.00, 205000.00, 42, 564, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-02-16 10:00:00', 7, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (977, N'978-604-070977', N'Chắc Bạn Đùa, Feynman! - Ấn bản kỷ niệm', N'Hồi ức hài hước, lập dị và đam mê khám phá của nhà vật lý lượng tử thiên tài Richard Feynman.', 125000.00, NULL, 227, 221, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703578.jpg', 1, '2026-06-14 10:00:00', 7, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (978, N'978-604-070978', N'Nguồn Gốc Các Loài - Charles Darwin - Ấn bản kỷ niệm', N'Cuốn sách làm rung chuyển thế giới với học thuyết tiến hóa qua chọn lọc tự nhiên.', 98000.00, 78000.00, 97, 363, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703585.jpg', 1, '2026-04-14 10:00:00', 7, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (979, N'978-604-070979', N'Thế Giới Lượng Tử Kỳ Thú - Ấn bản kỷ niệm', N'Khám phá nguyên lý bất định, hiện tượng chồng chập và máy tính lượng tử tương lai.', 92000.00, 78000.00, 133, 233, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236427357.jpg', 1, '2026-08-10 10:00:00', 7, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (980, N'978-604-070980', N'Tương Lai Của Nhân Loại - Michio Kaku - Ấn bản kỷ niệm', N'Hành trình di cư lên sao Hỏa, du hành liên sao và viễn cảnh bất tử công nghệ.', 145000.00, 119000.00, 177, 623, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426787.jpg', 1, '2026-04-06 10:00:00', 7, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (981, N'978-604-070981', N'Lược Sử Thời Gian - Stephen Hawking (Bìa cứng mỹ thuật)', N'Kiệt tác vật lý vũ trụ giải thích Big Bang, Lỗ đen và bản chất của không - thời gian.', 280000.00, 238000.00, 128, 485, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935088554102.jpg', 1, '2026-09-24 10:00:00', 7, 1);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (982, N'978-604-070982', N'Vũ Trụ (Cosmos) - Carl Sagan (Bìa cứng mỹ thuật)', N'Bản giao hưởng kỳ vĩ về 15 tỷ năm tiến hóa vũ trụ và vị thế của loài người giữa các vì sao.', 175000.00, 158000.00, 173, 211, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703592.jpg', 1, '2026-02-02 10:00:00', 7, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (983, N'978-604-070983', N'Vũ Trụ Trong Vỏ Hạt Dẻ (Bìa cứng mỹ thuật)', N'Học thuyết M, siêu dây và cuộc truy tìm Lý thuyết Vạn vật thống nhất vũ trụ.', 92000.00, 81000.00, 172, 277, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg', 1, '2026-07-08 10:00:00', 7, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (984, N'978-604-070984', N'Giai Điệu Bí Ẩn - Con Người Đã Tạo Ra Vũ Trụ Ra Sao (Bìa cứng mỹ thuật)', N'Sự tương quan kỳ diệu giữa hằng số vũ trụ và sự tồn tại của sự sống thông minh.', 175000.00, 140000.00, 131, 200, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703561.jpg', 1, '2026-01-19 10:00:00', 7, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (985, N'978-604-070985', N'Bản Thiết Kế Vĩ Đại (The Grand Design) (Bìa cứng mỹ thuật)', N'Vũ trụ tự hình thành từ hư vô theo các quy luật vật lý lượng tử mà không cần phép màu.', 220000.00, 194000.00, 72, 410, 2020, N'vi', N'https://salt.tikicdn.com/cache/750x750/ts/product/a5/65/4c/2da4aa944b6f280afbd694ac1a129682.jpeg', 1, '2026-03-15 10:00:00', 7, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (986, N'978-604-070986', N'Vật Lý Thiên Văn Cho Người Vội Vã (Neil deGrasse Tyson) (Bìa cứng mỹ thuật)', N'Những hiểu biết cốt lõi về vũ trụ được giải thích súc tích, hóm hỉnh và dễ hiểu.', 195000.00, 172000.00, 72, 651, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235222533.jpg', 1, '2026-04-03 10:00:00', 7, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (987, N'978-604-070987', N'Chắc Bạn Đùa, Feynman! (Bìa cứng mỹ thuật)', N'Hồi ức hài hước, lập dị và đam mê khám phá của nhà vật lý lượng tử thiên tài Richard Feynman.', 160000.00, NULL, 34, 166, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230004561.jpg', 1, '2026-04-04 10:00:00', 7, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (988, N'978-604-070988', N'Nguồn Gốc Các Loài - Charles Darwin (Bìa cứng mỹ thuật)', N'Cuốn sách làm rung chuyển thế giới với học thuyết tiến hóa qua chọn lọc tự nhiên.', 160000.00, 136000.00, 191, 546, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425155.jpg', 1, '2026-03-19 10:00:00', 7, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (989, N'978-604-070989', N'Thế Giới Lượng Tử Kỳ Thú (Bìa cứng mỹ thuật)', N'Khám phá nguyên lý bất định, hiện tượng chồng chập và máy tính lượng tử tương lai.', 160000.00, NULL, 176, 447, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425124.jpg', 1, '2026-01-15 10:00:00', 7, 6);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (990, N'978-604-070990', N'Tương Lai Của Nhân Loại - Michio Kaku (Bìa cứng mỹ thuật)', N'Hành trình di cư lên sao Hỏa, du hành liên sao và viễn cảnh bất tử công nghệ.', 175000.00, 149000.00, 98, 624, 2022, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425131.jpg', 1, '2026-10-02 10:00:00', 7, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (991, N'978-604-070991', N'Lược Sử Thời Gian - Stephen Hawking - Tập 5', N'Kiệt tác vật lý vũ trụ giải thích Big Bang, Lỗ đen và bản chất của không - thời gian.', 220000.00, NULL, 64, 185, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425148.jpg', 1, '2026-04-09 10:00:00', 7, 8);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (992, N'978-604-070992', N'Vũ Trụ (Cosmos) - Carl Sagan - Tập 5', N'Bản giao hưởng kỳ vĩ về 15 tỷ năm tiến hóa vũ trụ và vị thế của loài người giữa các vì sao.', 280000.00, 224000.00, 16, 509, 2023, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230005032.jpg', 1, '2026-08-21 10:00:00', 7, 2);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (993, N'978-604-070993', N'Vũ Trụ Trong Vỏ Hạt Dẻ - Tập 5', N'Học thuyết M, siêu dây và cuộc truy tìm Lý thuyết Vạn vật thống nhất vũ trụ.', 195000.00, 160000.00, 150, 414, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425155.jpg', 1, '2026-03-11 10:00:00', 7, 7);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (994, N'978-604-070994', N'Giai Điệu Bí Ẩn - Con Người Đã Tạo Ra Vũ Trụ Ra Sao - Tập 5', N'Sự tương quan kỳ diệu giữa hằng số vũ trụ và sự tồn tại của sự sống thông minh.', 138000.00, 124000.00, 154, 477, 2020, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230006789.jpg', 1, '2026-09-08 10:00:00', 7, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (995, N'978-604-070995', N'Bản Thiết Kế Vĩ Đại (The Grand Design) - Tập 5', N'Vũ trụ tự hình thành từ hư vô theo các quy luật vật lý lượng tử mà không cần phép màu.', 75000.00, 61000.00, 231, 435, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236425124.jpg', 1, '2026-10-15 10:00:00', 7, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (996, N'978-604-070996', N'Vật Lý Thiên Văn Cho Người Vội Vã (Neil deGrasse Tyson) - Tập 5', N'Những hiểu biết cốt lõi về vũ trụ được giải thích súc tích, hóm hỉnh và dễ hiểu.', 92000.00, 81000.00, 205, 663, 2019, N'en', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230007890.jpg', 1, '2026-07-11 10:00:00', 7, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (997, N'978-604-070997', N'Chắc Bạn Đùa, Feynman! - Tập 5', N'Hồi ức hài hước, lập dị và đam mê khám phá của nhà vật lý lượng tử thiên tài Richard Feynman.', 125000.00, 112000.00, 103, 482, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935236426001.jpg', 1, '2026-06-17 10:00:00', 7, 5);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (998, N'978-604-070998', N'Nguồn Gốc Các Loài - Charles Darwin - Tập 5', N'Cuốn sách làm rung chuyển thế giới với học thuyết tiến hóa qua chọn lọc tự nhiên.', 110000.00, 90000.00, 241, 410, 2019, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935230005032.jpg', 1, '2026-10-25 10:00:00', 7, 3);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (999, N'978-604-070999', N'Thế Giới Lượng Tử Kỳ Thú - Tập 5', N'Khám phá nguyên lý bất định, hiện tượng chồng chập và máy tính lượng tử tương lai.', 175000.00, 140000.00, 214, 450, 2021, N'vi', N'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235241848.jpg', 1, '2026-08-14 10:00:00', 7, 4);
INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES (1000, N'978-604-071000', N'Tương Lai Của Nhân Loại - Michio Kaku - Tập 5', N'Hành trình di cư lên sao Hỏa, du hành liên sao và viễn cảnh bất tử công nghệ.', 98000.00, 80000.00, 147, 505, 2021, N'vi', N'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg', 1, '2026-07-17 10:00:00', 7, 7);
COMMIT TRANSACTION;
SET IDENTITY_INSERT [dbo].[Books] OFF;
GO

-- 3. INSERT BOOK-AUTHOR RELATIONSHIPS
BEGIN TRANSACTION;
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (201, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (202, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (203, 28);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (204, 28);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (205, 27);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (206, 27);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (207, 27);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (208, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (209, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (210, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (211, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (211, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (212, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (212, 25);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (213, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (214, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (215, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (216, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (216, 28);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (217, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (218, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (219, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (220, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (220, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (221, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (222, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (223, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (224, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (225, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (226, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (227, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (228, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (229, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (230, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (231, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (232, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (233, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (234, 17);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (235, 17);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (236, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (237, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (238, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (239, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (240, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (241, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (242, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (243, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (244, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (245, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (246, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (247, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (248, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (249, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (250, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (251, 28);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (251, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (252, 28);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (253, 27);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (254, 27);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (255, 27);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (256, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (257, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (257, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (258, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (259, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (260, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (260, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (261, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (261, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (262, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (263, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (264, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (265, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (266, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (267, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (268, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (269, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (270, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (271, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (272, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (273, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (274, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (274, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (275, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (275, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (276, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (277, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (278, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (279, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (280, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (281, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (282, 17);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (283, 17);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (284, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (285, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (286, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (287, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (287, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (288, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (289, 5);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (290, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (291, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (291, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (292, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (293, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (293, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (294, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (295, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (295, 28);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (296, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (297, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (298, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (299, 28);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (300, 28);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (301, 27);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (302, 27);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (303, 27);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (304, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (305, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (306, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (307, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (308, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (309, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (310, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (310, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (311, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (312, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (313, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (314, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (315, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (316, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (317, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (318, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (318, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (319, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (320, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (321, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (322, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (323, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (324, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (325, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (326, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (327, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (327, 25);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (328, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (329, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (330, 17);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (331, 17);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (331, 35);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (332, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (333, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (334, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (334, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (335, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (336, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (337, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (338, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (339, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (340, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (341, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (342, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (343, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (344, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (345, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (346, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (347, 28);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (348, 28);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (349, 27);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (350, 27);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (351, 27);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (352, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (353, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (354, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (355, 29);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (356, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (357, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (358, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (359, 30);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (360, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (361, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (362, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (363, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (364, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (365, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (366, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (367, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (368, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (369, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (370, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (371, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (372, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (373, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (374, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (375, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (376, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (377, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (378, 17);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (379, 17);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (380, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (381, 31);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (382, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (383, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (384, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (385, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (386, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (386, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (387, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (388, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (388, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (389, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (390, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (391, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (392, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (393, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (394, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (395, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (396, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (397, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (398, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (399, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (400, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (401, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (402, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (403, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (404, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (405, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (405, 35);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (406, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (406, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (407, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (408, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (409, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (410, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (411, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (412, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (413, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (413, 28);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (414, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (415, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (416, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (417, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (418, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (419, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (420, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (421, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (422, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (423, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (424, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (425, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (426, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (427, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (428, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (429, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (430, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (431, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (432, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (433, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (434, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (435, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (436, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (437, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (438, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (439, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (440, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (441, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (442, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (443, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (444, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (445, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (446, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (447, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (448, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (449, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (450, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (451, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (452, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (453, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (454, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (455, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (456, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (457, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (458, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (459, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (460, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (461, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (462, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (463, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (463, 17);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (464, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (465, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (466, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (467, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (468, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (469, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (470, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (471, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (472, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (473, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (474, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (475, 8);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (476, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (476, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (477, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (478, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (479, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (480, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (481, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (482, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (482, 24);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (483, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (484, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (484, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (485, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (486, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (487, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (488, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (489, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (490, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (491, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (492, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (493, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (494, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (495, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (495, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (496, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (497, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (497, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (498, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (499, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (500, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (501, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (502, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (502, 13);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (503, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (504, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (505, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (506, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (507, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (508, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (509, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (510, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (511, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (511, 17);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (512, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (513, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (514, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (514, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (515, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (515, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (516, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (517, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (518, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (519, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (520, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (521, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (522, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (523, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (524, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (524, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (525, 9);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (526, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (527, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (528, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (529, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (530, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (531, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (532, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (533, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (534, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (535, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (536, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (537, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (538, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (539, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (540, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (541, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (542, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (543, 38);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (544, 38);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (545, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (546, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (547, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (547, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (548, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (549, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (550, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (551, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (551, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (552, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (552, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (553, 36);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (554, 36);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (555, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (556, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (557, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (558, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (559, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (560, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (561, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (562, 33);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (563, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (564, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (565, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (566, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (567, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (568, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (569, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (570, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (571, 38);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (572, 38);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (573, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (574, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (575, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (576, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (577, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (578, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (578, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (579, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (580, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (581, 36);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (581, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (582, 36);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (583, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (584, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (585, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (585, 36);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (586, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (587, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (588, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (588, 36);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (589, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (590, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (591, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (591, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (592, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (593, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (594, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (595, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (596, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (597, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (598, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (599, 38);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (600, 38);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (601, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (602, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (603, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (604, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (605, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (606, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (607, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (608, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (609, 36);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (609, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (610, 36);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (611, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (611, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (612, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (613, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (614, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (615, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (616, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (617, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (618, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (619, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (620, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (621, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (621, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (622, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (623, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (624, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (625, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (626, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (627, 38);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (627, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (628, 38);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (629, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (630, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (631, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (632, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (633, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (634, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (635, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (635, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (636, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (637, 36);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (638, 36);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (639, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (640, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (640, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (641, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (642, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (643, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (644, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (645, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (646, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (647, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (648, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (649, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (650, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (651, 33);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (652, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (653, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (653, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (654, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (655, 38);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (656, 38);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (657, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (658, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (659, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (660, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (661, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (662, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (663, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (664, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (665, 36);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (666, 36);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (667, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (668, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (669, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (670, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (671, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (672, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (673, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (674, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (675, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (676, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (677, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (678, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (679, 33);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (680, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (681, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (682, 4);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (682, 25);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (683, 38);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (684, 38);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (685, 10);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (686, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (687, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (688, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (689, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (690, 2);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (691, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (692, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (693, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (694, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (695, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (696, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (697, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (698, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (699, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (699, 25);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (700, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (701, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (702, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (703, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (704, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (705, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (706, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (707, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (708, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (709, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (710, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (711, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (712, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (713, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (714, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (715, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (716, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (717, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (718, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (719, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (719, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (720, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (721, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (722, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (723, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (724, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (725, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (726, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (727, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (728, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (729, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (730, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (731, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (731, 24);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (732, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (732, 40);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (733, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (734, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (735, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (736, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (737, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (737, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (738, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (739, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (740, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (741, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (741, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (742, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (743, 19);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (744, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (745, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (746, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (747, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (747, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (748, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (749, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (750, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (751, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (752, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (753, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (754, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (755, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (755, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (756, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (757, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (757, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (758, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (759, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (760, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (760, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (761, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (762, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (763, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (764, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (765, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (766, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (766, 28);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (767, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (768, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (768, 37);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (769, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (770, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (771, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (772, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (773, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (774, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (774, 12);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (775, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (776, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (777, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (778, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (779, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (780, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (781, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (782, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (783, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (784, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (784, 34);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (785, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (786, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (787, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (788, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (789, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (789, 32);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (790, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (791, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (792, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (793, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (794, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (795, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (796, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (797, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (798, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (799, 21);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (799, 38);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (800, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (801, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (801, 12);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (802, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (803, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (804, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (805, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (806, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (807, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (808, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (809, 39);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (810, 19);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (811, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (812, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (813, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (814, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (815, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (816, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (817, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (818, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (819, 35);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (820, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (820, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (821, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (822, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (823, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (824, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (825, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (826, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (827, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (828, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (829, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (830, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (831, 15);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (832, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (833, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (833, 20);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (834, 35);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (835, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (836, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (837, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (838, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (839, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (840, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (841, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (842, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (843, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (844, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (845, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (846, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (847, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (848, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (849, 35);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (850, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (851, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (852, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (852, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (853, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (854, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (855, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (856, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (857, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (858, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (859, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (860, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (861, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (861, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (862, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (863, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (864, 35);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (865, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (866, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (866, 25);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (867, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (868, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (869, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (870, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (870, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (871, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (872, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (873, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (874, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (875, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (876, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (877, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (878, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (879, 35);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (879, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (880, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (881, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (882, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (883, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (884, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (885, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (886, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (887, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (888, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (889, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (889, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (890, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (891, 15);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (892, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (893, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (894, 35);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (895, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (896, 7);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (897, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (898, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (899, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (899, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (900, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (901, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (902, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (903, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (904, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (905, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (906, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (907, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (908, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (909, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (910, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (911, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (912, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (913, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (914, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (915, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (916, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (917, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (918, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (919, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (920, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (921, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (922, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (923, 6);
COMMIT TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (924, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (924, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (925, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (926, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (927, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (928, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (929, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (929, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (930, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (931, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (932, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (933, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (934, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (934, 16);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (935, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (936, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (936, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (937, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (938, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (939, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (940, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (941, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (942, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (943, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (943, 36);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (944, 11);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (945, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (946, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (947, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (948, 6);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (949, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (950, 26);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (951, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (952, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (953, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (953, 38);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (954, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (954, 8);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (955, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (956, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (957, 40);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (958, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (959, 40);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (960, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (961, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (962, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (963, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (964, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (965, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (966, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (967, 40);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (968, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (969, 40);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (970, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (971, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (971, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (972, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (972, 1);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (973, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (974, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (975, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (976, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (977, 40);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (978, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (979, 40);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (980, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (981, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (982, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (983, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (984, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (985, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (986, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (987, 40);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (988, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (988, 31);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (989, 40);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (990, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (991, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (992, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (993, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (994, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (995, 18);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (996, 22);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (997, 40);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (997, 14);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (998, 3);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (999, 40);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (999, 5);
INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (1000, 22);
COMMIT TRANSACTION;
GO

-- 4. VERIFY FINAL DATABASE STATS
SELECT COUNT(*) AS [FinalTotalBooks] FROM [dbo].[Books];
SELECT COUNT(*) AS [FinalTotalAuthors] FROM [dbo].[Authors];
SELECT c.Id, c.Name, COUNT(b.Id) AS BookCount FROM [dbo].[Categories] c LEFT JOIN [dbo].[Books] b ON b.CategoryId = c.Id GROUP BY c.Id, c.Name ORDER BY c.Id;
GO
