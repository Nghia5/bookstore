# -*- coding: utf-8 -*-
import urllib.request
import urllib.parse
import json
import time

titles = [
    (1, "Nhà Giả Kim", 1), # Paulo Coelho
    (2, "Hoàng Tử Bé", 11), # Saint-Exupery
    (3, "Mắt Biếc", 5), # Nguyen Nhat Anh
    (4, "Tôi Thấy Hoa Vàng Trên Cỏ Xanh", 5),
    (5, "Cho Tôi Xin Một Vé Đi Tuổi Thơ", 5),
    (6, "Cây Cam Ngọt Của Tôi", 26),
    (7, "Rừng Na Uy", 14), # Murakami
    (8, "Chiến Binh Cầu Vồng", 26),
    (9, "Không Gia Đình", 26),
    (10, "Hai Số Phận", 32),
    (11, "Trăm Năm Cô Đơn", 1),
    (12, "1984", 12), # George Orwell
    (13, "Trại Súc Vật", 12), # George Orwell
    (14, "Số Đỏ", 17), # Vu Trong Phung
    (15, "Chí Phèo", 16), # Nam Cao
    (16, "Dế Mèn Phiêu Lưu Ký", 6), # To Hoai
    (17, "Hóa Thân", 13), # Franz Kafka
    (18, "Tiếng Chim Hót Trong Bụi Mận Gai", 26),
    (19, "Cuốn Theo Chiều Gió", 26),
    (46, "Cha Giàu Cha Nghèo", 8), # Robert Kiyosaki
    (47, "Tâm Lý Học Về Tiền", 9), # Morgan Housel
    (48, "Tư Duy Nhanh Và Chậm", 10), # Daniel Kahneman
    (49, "Khởi Nghiệp Tinh Gọn", 8),
    (50, "Từ Tốt Đến Vĩ Đại", 8),
    (51, "Chiến Lược Đại Dương Xanh", 8),
    (52, "Nhà Đầu Tư Thông Minh", 8),
    (53, "Dốc Hết Trái Tim", 8),
    (54, "Cổ Phiếu Thường, Lợi Nhuận Phi Thường", 8),
    (55, "Phi Lý Trí", 10),
    (56, "Dẫn Dắt Sự Thay Đổi", 8),
    (57, "Nguyên Tắc", 8),
    (58, "Không Đến Một", 8),
    (59, "Nghệ Thuật Bán Hàng Bậc Cao", 2),
    (60, "Tuần Làm Việc 4 Giờ", 8),
    (61, "Người Giàu Có Nhất Thành Babylon", 8),
    (62, "Bí Mật Tư Duy Triệu Phú", 8),
    (63, "Dạy Con Làm Giàu - Tập 2", 8),
    (64, "Dạy Con Làm Giàu - Tập 3", 8),
    (86, "Đắc Nhân Tâm", 2), # Dale Carnegie
    (87, "Quẳng Gánh Lo Đi Và Vui Sống", 2), # Dale Carnegie
    (88, "Atomic Habits", 4), # James Clear
    (89, "Tuổi Trẻ Đáng Giá Bao Nhiêu", 23), # Rosie Nguyen
    (90, "Cà Phê Cùng Tony", 24), # Tony Buoi Sang
    (91, "Trên Đường Băng", 24), # Tony Buoi Sang
    (92, "Khi Hơi Thở Hóa Thinh Không", 10),
    (93, "Tìm Lại Lạc Quan", 10),
    (94, "Sức Mạnh Của Hiện Tại", 33),
    (95, "Một Cuộc Đời Đáng Sống", 10),
    (96, "Dám Bị Ghét", 10),
    (97, "Dám Hạnh Phúc", 10),
    (98, "Tư Duy Ngược", 10),
    (99, "Hiểu Về Trái Tim", 33), # Thich Nhat Hanh
    (100, "Hạnh Phúc Đích Thực", 33),
    (101, "Sức Mạnh Của Tĩnh Lặng", 33),
    (102, "Tâm Lý Học Tội Phạm", 10),
    (103, "Nghệ Thuật Lắng Nghe", 2),
    (104, "Trí Tuệ Cảm Xúc 2.0", 10),
    (105, "Đọc Vị Bất Kỳ Ai", 10),
    (106, "Nghệ Thuật Giao Tiếp Để Thành Công", 2),
    (107, "Thôi Miên Bằng Ngôn Từ", 2),
    (108, "Quản Lý Thời Gian Thông Minh", 37), # Brian Tracy
    (109, "Kỷ Luật Tự Giác", 37),
    (110, "Chữa Lành Đứa Trẻ Bên Trong Bạn", 25),
    (111, "Không Diệt Không Sinh Đừng Sợ Hãi", 33), # Thich Nhat Hanh
    (112, "Bước Chậm Lại Giữa Thế Gian Vội Vã", 25), # Haemin
    (113, "Yêu Những Điều Không Hoàn Hảo", 25), # Haemin
    (114, "Sống Thực Tế Giữa Đời Thực Dụng", 25),
    (115, "Tâm Lý Học Đám Đông", 10),
    (116, "Tư Duy Sâu", 38), # Cal Newport
    (117, "Làm Chủ Cảm Xúc", 10),
    (118, "Nghệ Thuật Tư Duy Rành Mạch", 10),
    (126, "Clean Code - Mã Sạch", 19), # Uncle Bob
    (127, "Clean Architecture - Kiến Trúc Phần Mềm Sạch", 19), # Uncle Bob
    (128, "Refactoring - Tối Ưu Hóa Mã Nguồn Hiện Có", 20), # Martin Fowler
    (129, "Design Patterns - 23 Mẫu Thiết Kế Hướng Đối Tượng", 19),
    (132, "Học Sâu & Trí Tuệ Nhân Tạo (Deep Learning)", 21), # Andrew Ng
    (133, "Nhập Môn Học Máy Với Python", 21), # Andrew Ng
    (161, "Sapiens: Lược Sử Loài Người", 3), # Yuval Harari
    (162, "Homo Deus: Lược Sử Tương Lai", 3), # Yuval Harari
    (163, "21 Bài Học Cho Thế Kỷ 21", 3), # Yuval Harari
    (164, "Súng, Vi Trùng Và Thép", 3),
    (165, "Việt Nam Sử Lược", 15),
    (166, "Đại Việt Sử Ký Toàn Thư", 15),
    (170, "Lịch Sử Triết Học Phương Tây", 34),
    (171, "Đạo Đức Kinh - Lão Tử", 35),
    (172, "Luận Ngữ - Khổng Tử", 35),
    (175, "Binh Pháp Tôn Tử", 35), # Sun Tzu
    (186, "Dế Mèn Phiêu Lưu Ký (Ấn Bản Kỷ Niệm Bìa Cứng)", 6), # To Hoai
    (187, "Chuyện Con Mèo Dạy Hải Âu Bay", 26),
    (188, "Góc Sân Và Khoảng Trời", 6),
    (199, "Đất Rừng Phương Nam", 6),
    (200, "Totto-chan Bên Cửa Sổ", 26),
    (201, "Những Người Khốn Khổ - Trọn Bộ 2 Tập", 26), # Victor Hugo
    (202, "Nhà Thờ Đức Bà Paris", 26), # Victor Hugo
    (203, "Chiến Tranh Và Hòa Bình - Trọn Bộ", 28), # Lev Tolstoy
    (204, "Anna Karenina", 28), # Lev Tolstoy
    (205, "Sherlock Holmes - Chiếc Nhẫn Tình Cờ", 27), # Conan Doyle
    (206, "Sherlock Holmes - Thung Lũng Khủng Hoảng", 27),
    (207, "Sherlock Holmes - Dấu Bộ Tứ", 27),
    (208, "Harry Potter và Hòn Đá Phù Thủy", 29), # J.K. Rowling
    (209, "Harry Potter và Phòng Chứa Bí Mật", 29),
    (210, "Harry Potter và Tên Tù Nhân Ngục Azkaban", 29),
    (211, "Mật Mã Da Vinci (The Da Vinci Code)", 30), # Dan Brown
    (212, "Thiên Thần Và Ác Quỷ (Angels & Demons)", 30),
    (213, "Hỏa Ngục (Inferno)", 30),
    (214, "Biểu Tượng Thất Truyền (The Lost Symbol)", 30),
    (215, "Steve Jobs (Tiểu Sử Bìa Cứng)", 31), # Walter Isaacson
    (216, "Elon Musk (Tiểu Sử Toàn Diện)", 31), # Walter Isaacson
    (217, "Leonardo da Vinci (Tiểu Sử)", 31), # Walter Isaacson
    (218, "Những Kẻ Xuất Chúng (Outliers)", 32), # Malcolm Gladwell
    (219, "Điểm Bùng Phát (The Tipping Point)", 32), # Malcolm Gladwell
    (220, "Trong Chớp Mắt (Blink)", 32), # Malcolm Gladwell
    (221, "Giận - Bồ Đề Tâm Chữa Lành Oán Hận", 33), # Thich Nhat Hanh
    (222, "An Lạc Từng Bước Chân", 33), # Thich Nhat Hanh
    (223, "Phép Lạ Của Sự Tỉnh Thức", 33), # Thich Nhat Hanh
    (224, "Suy Tưởng (Meditations)", 34), # Marcus Aurelius
    (225, "Chủ Nghĩa Khắc Kỷ Trong Đời Sống Hiện Đại", 34),
    (226, "Nhà Sư Bán Chiếc Ferrari", 36), # Robin Sharma
    (227, "Câu Lạc Bộ 5 Giờ Sáng (The 5 AM Club)", 36), # Robin Sharma
    (228, "Thuật Quản Lý Thời Gian Đỉnh Cao", 37), # Brian Tracy
    (229, "Để Hiệu Quả Trong Công Việc (Eat That Frog)", 37), # Brian Tracy
    (230, "Làm Ra Làm Chơi Ra Chơi (Deep Work)", 38), # Cal Newport
    (231, "Tối Giản Trong Thời Đại Số (Digital Minimalism)", 38), # Cal Newport
    (232, "Nghệ Thuật Lập Trình (The Art of Computer Programming)", 39), # Donald Knuth
    (233, "Chắc Bạn Đùa Feynman!", 40), # Richard Feynman
    (234, "Ý Niệm Về Vạn Vật (Six Easy Pieces)", 40), # Richard Feynman
]

sql_updates = []
sql_updates.append("USE [BookstoreDb];")
sql_updates.append("SET NOCOUNT ON;")
sql_updates.append("GO\n")

# 1. Update Author 25 to Hae Min
sql_updates.append("-- 1. Update Author 25 to Dai duc Hae Min")
sql_updates.append("UPDATE [dbo].[Authors] SET [Name] = N'Đại đức Hae Min', [Nationality] = N'Hàn Quốc', [Biography] = N'Thiền sư, giảng viên đại học và tác giả của những tác phẩm chữa lành tâm hồn bán chạy hàng đầu châu Á: Bước Chậm Lại Giữa Thế Gian Vội Vã, Yêu Những Điều Không Hoàn Hảo.', [AvatarUrl] = N'https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=400&q=80' WHERE [Id] = 25;")
sql_updates.append("GO\n")

print(f"Querying Tiki for authentic covers of {len(titles)} prominent books...")

for book_id, title, author_id in titles:
    # Query Tiki API
    cleaned_title = title.split('(')[0].split('-')[0].strip()
    q = urllib.parse.quote(cleaned_title)
    url = f"https://tiki.vn/api/v2/products?limit=1&q={q}"
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'})
    cover_url = None
    try:
        with urllib.request.urlopen(req, timeout=4) as res:
            data = json.loads(res.read().decode('utf-8'))
            items = data.get('data', [])
            if items:
                raw_thumb = items[0].get('thumbnail_url', '')
                if raw_thumb and 'tikicdn.com' in raw_thumb:
                    cover_url = raw_thumb.replace('/cache/280x280/', '/cache/750x750/')
    except Exception as e:
        print(f"Error fetching {cleaned_title}: {e}")

    # Fallback for book 112 if needed
    if book_id == 112 and not cover_url:
        cover_url = "https://salt.tikicdn.com/cache/750x750/ts/product/7a/18/8e/2f70de3ea7eec9c34f55e402254e27ed.jpg"
    elif book_id == 113 and not cover_url:
        cover_url = "https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/20/79/b3/8b1139ce30144b41473b199c19001942.jpg"

    if cover_url:
        print(f"[OK] #{book_id} {title} -> Author {author_id} -> {cover_url[:60]}...")
        sql_updates.append(f"UPDATE [dbo].[Books] SET [CoverImageUrl] = N'{cover_url}' WHERE [Id] = {book_id};")
        sql_updates.append(f"DELETE FROM [dbo].[BookAuthors] WHERE [BookId] = {book_id};")
        sql_updates.append(f"INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES ({book_id}, {author_id});")
    else:
        # Just update author
        print(f"[NO COVER] #{book_id} {title} -> Author {author_id}")
        sql_updates.append(f"DELETE FROM [dbo].[BookAuthors] WHERE [BookId] = {book_id};")
        sql_updates.append(f"INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES ({book_id}, {author_id});")

    time.sleep(0.08)

sql_updates.append("GO\n")
sql_updates.append("PRINT 'Updated authentic covers and authors successfully.';")

with open('scripts/fix_covers_and_authors.sql', 'w', encoding='utf-8') as f:
    f.write('\n'.join(sql_updates))

print("Wrote scripts/fix_covers_and_authors.sql successfully.")
