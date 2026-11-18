# -*- coding: utf-8 -*-
import hashlib
import random

def get_pw_hash(password):
    # Match C# DbInitializer: SHA256(password + "BookstoreSalt2026") in base64
    import base64
    data = (password + "BookstoreSalt2026").encode('utf-8')
    h = hashlib.sha256(data).digest()
    return base64.b64encode(h).decode('ascii')

categories = [
    (1, "Văn học", "van-hoc", "Tiểu thuyết, truyện ngắn, thơ ca kinh điển và đương đại"),
    (2, "Kinh tế & Kinh doanh", "kinh-te", "Kinh tế học, khởi nghiệp, tài chính, đầu tư và quản trị doanh nghiệp"),
    (3, "Tâm lý & Kỹ năng sống", "tam-ly-ky-nang", "Phát triển bản thân, tư duy tích cực, quản trị cảm xúc và nghệ thuật giao tiếp"),
    (4, "Công nghệ & Lập trình", "cong-nghe-lap-trinh", "Khoa học máy tính, trí tuệ nhân tạo, an toàn thông tin, DevOps và lập trình"),
    (5, "Lịch sử & Triết học", "lich-su-triet-hoc", "Lịch sử thế giới, lịch sử Việt Nam, văn minh nhân loại và triết học"),
    (6, "Văn học Thiếu nhi", "thieu-nhi", "Truyện tranh, cổ tích, đồng thoại nuôi dưỡng tâm hồn trẻ thơ"),
    (7, "Khoa học & Vũ trụ", "khoa-hoc", "Vật lý thiên văn, sinh học, khám phá tự nhiên và khoa học đại chúng")
]

publishers = [
    (1, "NXB Trẻ", "161B Lý Chính Thắng, Q.3, TP.HCM", "hopthu@nxbtre.com.vn"),
    (2, "Công ty Cổ phần Văn hóa Nhã Nam", "59 Đỗ Quang, Cầu Giấy, Hà Nội", "contact@nhanam.vn"),
    (3, "NXB Kim Đồng", "55 Quang Trung, Hai Bà Trưng, Hà Nội", "cskh@nxbkimdong.com.vn"),
    (4, "First News - Trí Việt", "11H Nguyễn Thị Minh Khai, Q.1, TP.HCM", "triviet@firstnews.com.vn"),
    (5, "NXB Thế Giới", "46 Trần Hưng Đạo, Hoàn Kiếm, Hà Nội", "thegioi@hn.vnn.vn"),
    (6, "NXB Tổng Hợp TP.HCM", "62 Nguyễn Thị Minh Khai, Q.1, TP.HCM", "tonghop@nxbhcm.com.vn"),
    (7, "Alpha Books", "Tầng 3, Dream Center Home, 11A Tô Ngọc Vân, Hà Nội", "info@alphabooks.vn"),
    (8, "NXB Hội Nhà Văn", "65 Nguyễn Du, Hai Bà Trưng, Hà Nội", "nxbhnv@vnn.vn")
]

authors = [
    (1, "Paulo Coelho", "Brazil", "Tác giả kiệt tác Nhà Giả Kim bán chạy toàn cầu."),
    (2, "Dale Carnegie", "Mỹ", "Bậc thầy nghệ thuật giao tiếp và thuyết phục nhân tâm."),
    (3, "Yuval Noah Harari", "Israel", "Sử gia lỗi lạc, tác giả bộ ba Sapiens, Homo Deus và 21 Bài Học."),
    (4, "James Clear", "Mỹ", "Chuyên gia hàng đầu thế giới về thói quen nguyên tử Atomic Habits."),
    (5, "Nguyễn Nhật Ánh", "Việt Nam", "Nhà văn của tuổi mới lớn với những tác phẩm trong trẻo đầy hoài niệm."),
    (6, "Tô Hoài", "Việt Nam", "Cây đại thụ văn học thiếu nhi với Dế Mèn Phiêu Lưu Ký."),
    (7, "Nguyên Phong", "Việt Nam", "GS. John Vu - nhà khoa học và dịch giả tâm linh huyền học nổi tiếng."),
    (8, "Robert Kiyosaki", "Mỹ", "Tác giả bộ sách tài chính cá nhân Cha Giàu Cha Nghèo."),
    (9, "Morgan Housel", "Mỹ", "Chuyên gia tài chính, tác giả Tâm Lý Học Về Tiền."),
    (10, "Daniel Kahneman", "Mỹ", "Nhà tâm lý học đoạt giải Nobel Kinh tế, tác giả Tư Duy Nhanh Và Chậm."),
    (11, "Antoine de Saint-Exupéry", "Pháp", "Nhà văn kiêm phi công, tác giả Hoàng Tử Bé bất hủ."),
    (12, "George Orwell", "Anh", "Tiểu thuyết gia vĩ đại của Trại Súc Vật và 1984."),
    (13, "Franz Kafka", "Áo-Hung", "Cây bút hiện sinh xuất chúng với Hóa Thân, Vụ Án."),
    (14, "Haruki Murakami", "Nhật Bản", "Tiểu thuyết gia siêu thực đương đại nổi tiếng toàn cầu."),
    (15, "Nguyễn Du", "Việt Nam", "Đại thi hào dân tộc, tác giả Truyện Kiều."),
    (16, "Nam Cao", "Việt Nam", "Cây bút hiện thực phê phán xuất sắc của văn học Việt Nam."),
    (17, "Vũ Trọng Phụng", "Việt Nam", "Ông vua phóng sự đất Bắc, tác giả Số Đỏ."),
    (18, "Stephen Hawking", "Anh", "Nhà vật lý lý thuyết vĩ đại, tác giả Lược Sử Thời Gian."),
    (19, "Robert C. Martin (Uncle Bob)", "Mỹ", "Chuyên gia phần mềm hàng đầu, tác giả Clean Code và Clean Architecture."),
    (20, "Martin Fowler", "Anh", "Kiến trúc sư phần mềm, tác giả Refactoring."),
    (21, "Andrew Ng", "Mỹ", "Tiên phong trong lĩnh vực Trí Tuệ Nhân Tạo và Deep Learning."),
    (22, "Carl Sagan", "Mỹ", "Nhà thiên văn học huyền thoại, tác giả Vũ Trụ (Cosmos)."),
    (23, "Rosie Nguyễn", "Việt Nam", "Tác giả cuốn sách gối đầu giường Tuổi Trẻ Đáng Giá Bao Nhiêu."),
    (24, "Tony Buổi Sáng", "Việt Nam", "Tác giả bộ đôi sách truyền cảm hứng sống đẹp cho giới trẻ."),
    (25, "Nguyễn Du", "Việt Nam", "Đại thi hào văn học cổ điển Việt Nam.")
]

cover_images = [
    "https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80",
    "https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80",
    "https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=600&q=80",
    "https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?auto=format&fit=crop&w=600&q=80",
    "https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=600&q=80",
    "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80",
    "https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80",
    "https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=600&q=80",
    "https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=600&q=80",
    "https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=600&q=80",
    "https://images.unsplash.com/photo-1553729459-efe14ef6055d?auto=format&fit=crop&w=600&q=80",
    "https://images.unsplash.com/photo-1491841573634-28140fc7ced7?auto=format&fit=crop&w=600&q=80",
    "https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=600&q=80",
    "https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=600&q=80",
    "https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80"
]

# 200 real titles catalog
book_templates = [
    # 1. Văn học (45)
    ("Nhà Giả Kim (The Alchemist)", 1, 1, 1, 89000, 69000, "Cuộc phiêu lưu tìm kiếm kho báu và sứ mệnh cuộc đời của chàng chăn cừu Santiago."),
    ("Hoàng Tử Bé (Le Petit Prince)", 1, 2, 11, 75000, 59000, "Câu chuyện ngụ ngôn giàu chất thơ về tình bạn, tình yêu và ý nghĩa của cuộc sống."),
    ("Mắt Biếc", 1, 1, 5, 110000, 88000, "Mối tình si của Ngạn dành cho cô bạn thời thơ ấu Hà Lan với đôi mắt biếc."),
    ("Tôi Thấy Hoa Vàng Trên Cỏ Xanh", 1, 1, 5, 125000, 99000, "Bức tranh hoài niệm tuổi thơ làng quê miền Trung với tình anh em và những rung động đầu đời."),
    ("Cho Tôi Xin Một Vé Đi Tuổi Thơ", 1, 1, 5, 90000, 72000, "Tấm vé nhiệm màu đưa người lớn quay về với sự hồn nhiên, tinh nghịch của tuổi thơ."),
    ("Cây Cam Ngọt Của Tôi", 1, 2, 8, 108000, 85000, "Câu chuyện cảm động rơi nước mắt về cậu bé Zezé 5 tuổi và cây cam ngọt trong sân."),
    ("Rừng Na Uy", 1, 2, 14, 145000, 115000, "Kiệt tác của Haruki Murakami về tuổi trẻ, tình yêu, sự cô đơn và mất mát."),
    ("Chiến Binh Cầu Vồng", 1, 2, 8, 119000, 95000, "Hành trình theo đuổi con chữ đầy xúc động của 10 đứa trẻ nghèo trên đảo Belitong."),
    ("Không Gia Đình (Sans Famille)", 1, 3, 8, 160000, 128000, "Cuộc đời lưu lạc đầy thử thách nhưng ngời sáng nhân cách của cậu bé Rémi."),
    ("Hai Số Phận (Kane and Abel)", 1, 2, 8, 195000, 155000, "Thiên tiểu thuyết kinh điển về cuộc đời đối đầu kịch tính của hai con người xuất chúng."),
    ("Trăm Năm Cô Đơn", 1, 2, 8, 185000, 148000, "Kiệt tác chủ nghĩa hiện thực huyền ảo về dòng họ Buendía qua bảy thế hệ."),
    ("1984", 1, 2, 12, 115000, 92000, "Bản cảnh báo mang tính tiên tri sâu sắc của George Orwell về một xã hội toàn trị."),
    ("Trại Súc Vật (Animal Farm)", 1, 2, 12, 79000, 65000, "Truyện ngụ ngôn chính trị kinh điển châm biếm sâu cay những ảo tưởng quyền lực."),
    ("Số Đỏ", 1, 5, 17, 85000, 68000, "Kiệt tác châm biếm hiện thực xuất sắc nhất của văn học hiện đại Việt Nam."),
    ("Chí Phèo & Tuyển Tập Truyện Ngắn Nam Cao", 1, 5, 16, 95000, 76000, "Tiếng kêu xé lòng đòi quyền làm người lương thiện của số phận người nông dân."),
    ("Dế Mèn Phiêu Lưu Ký", 1, 3, 6, 55000, 45000, "Bài học nhân sinh đầu đời sâu sắc về tình bạn và tinh thần hiệp nghĩa."),
    ("Hóa Thân (The Metamorphosis)", 1, 2, 13, 65000, 52000, "Kiệt tác hiện sinh của Franz Kafka về sự tha hóa và cô đơn tột cùng của con người."),
    ("Tiếng Chim Hót Trong Bụi Mận Gai", 1, 2, 8, 175000, 140000, "Bi tình sử lay động hàng triệu trái tim về tình yêu bị ngăn cách bởi định kiến."),
    ("Cuốn Theo Chiều Gió (Gone with the Wind)", 1, 5, 8, 260000, 208000, "Bản anh hùng ca bất hủ về sức sống mãnh liệt của nàng Scarlett O'Hara."),
    ("Đồi Gió Hú (Wuthering Heights)", 1, 2, 8, 120000, 96000, "Mối tình nồng nàn, dữ dội và đầy ám ảnh giữa Heathcliff và Catherine."),
    ("Kiêu Hãnh Và Định Kiến (Pride and Prejudice)", 1, 2, 8, 135000, 108000, "Kiệt tác tình cảm lãng mạn kinh điển của nữ văn sĩ Jane Austen."),
    ("Những Người Khốn Khổ (Les Misérables)", 1, 5, 8, 290000, 230000, "Bức tranh hoành tráng về tình thương, công lý và sự cứu rỗi của Victor Hugo."),
    ("Bắt Trẻ Đồng Xanh (The Catcher in the Rye)", 1, 2, 8, 95000, 78000, "Tâm sự nổi loạn và nỗi bơ vơ lạc lõng của chàng thiếu niên Holden Caulfield."),
    ("Tội Ác Và Trừng Phạt (Crime and Punishment)", 1, 5, 8, 210000, 168000, "Phân tích tâm lý bậc thầy của Dostoevsky về tội lỗi, lương tri và sự phục thiện."),
    ("Bác Sĩ Zhivago", 1, 2, 8, 220000, 176000, "Bản tình ca da diết giữa bão táp chiến tranh và cách mạng nước Nga."),
    ("Ông Già Và Biển Cả (The Old Man and the Sea)", 1, 2, 8, 75000, 60000, "Bài ca ngợi ca ý chí bất khuất của con người trước thử thách nghiệt ngã."),
    ("Đường Xưa Mây Trắng", 1, 5, 7, 215000, 172000, "Cuộc đời Đức Phật Thích Ca qua ngòi bút thiền vị, an nhiên của Thích Nhất Hạnh."),
    ("Vợ Nhặt & Những Truyện Ngắn Hay", 1, 3, 6, 70000, 56000, "Bức tranh hiện thực xót xa nhưng ngời sáng tình thương trong nạn đói 1945."),
    ("Hương Đồng Gió Nội", 1, 1, 5, 85000, 68000, "Tản văn dịu dàng về những nét đẹp văn hóa và ẩm thực Hà Nội xưa."),
    ("Thương Nhớ Mười Hai", 1, 2, 8, 99000, 79000, "Những trang văn đẫm chất thơ về nỗi nhớ quê hương và nét sinh hoạt đất Bắc."),
    ("Gió Đầu Mùa", 1, 2, 8, 65000, 52000, "Tập truyện ngắn tinh tế, nhẹ nhàng và đượm tình người của Thạch Lam."),
    ("Lão Hạc & Đời Thừa", 1, 5, 16, 75000, 60000, "Nỗi đau quằn quại của người trí thức nghèo trước hiện thực xã hội ngột ngạt."),
    ("Truyện Kiều (Bản Hiệu Khảo Trọn Vẹn)", 1, 8, 15, 150000, 120000, "Kiệt tác thi ca đỉnh cao muôn đời của nền văn học dân tộc Việt Nam."),
    ("Cánh Đồng Bất Tận", 1, 1, 8, 88000, 70000, "Những mảnh đời trôi dạt trên sông nước miền Tây qua ngòi bút Nguyễn Ngọc Tư."),
    ("Hạ Đỏ", 1, 1, 5, 82000, 65000, "Mùa hè đầy ắp kỷ niệm thôn quê và mối tình đầu bâng khuâng tuổi mới lớn."),
    ("Ngồi Khóc Trên Cây", 1, 1, 5, 105000, 84000, "Chuyện tình cảm động, trong sáng giữa núi rừng thơ mộng làng Đo Đo."),
    ("Cô Gái Đến Từ Hôm Qua", 1, 1, 5, 92000, 74000, "Sợi dây duyên số kỳ lạ nối liền quá khứ tuổi thơ và tình yêu hiện tại."),
    ("Bàn Có Năm Chỗ Ngồi", 1, 1, 5, 72000, 58000, "Tình bạn học trò ấm áp và những bài học sẻ chia đầu đời."),
    ("Phía Sau Nghi Can X", 1, 2, 14, 118000, 95000, "Cuộc đấu trí nghẹt thở và câu chuyện tình si lay động của Keigo Higashino."),
    ("Điều Kỳ Diệu Của Tiệm Tạp Hóa Namiya", 1, 2, 14, 125000, 100000, "Hộp thư tư vấn kỳ lạ kết nối quá khứ và hiện tại để xoa dịu những vết thương lòng."),
    ("Chuông Nguyện Hồn Ai", 1, 2, 8, 198000, 158000, "Bản hùng ca về sự hy sinh và lý tưởng tự do của Ernest Hemingway."),
    ("Tiếng Gọi Nơi Hoang Dã", 1, 3, 8, 78000, 62000, "Bản năng sinh tồn mãnh liệt của chú chó Buck giữa vùng đất băng giá phương Bắc."),
    ("Hành Trình Về Phương Đông", 1, 4, 7, 128000, 102000, "Chuyến đi thám hiểm khám phá những giá trị minh triết tâm linh Ấn Độ cổ xưa."),
    ("Muôn Kiếp Nhân Sinh - Tập 2", 1, 4, 7, 188000, 150000, "Hồi kết về quy luật thức tỉnh tâm linh và tương lai của nhân loại."),
    ("Dấu Chân Trên Cát", 1, 4, 7, 138000, 110000, "Hành trình tìm kiếm chân lý và sự giác ngộ qua nền văn minh Ai Cập cổ đại."),

    # 2. Kinh tế & Kinh doanh (40)
    ("Cha Giàu Cha Nghèo (Tập 1)", 2, 1, 8, 125000, 99000, "Cuốn sách dạy con làm giàu và tư duy tự do tài chính bán chạy nhất thế giới."),
    ("Tâm Lý Học Về Tiền (The Psychology of Money)", 2, 7, 9, 189000, 149000, "Những bài học vĩnh cửu về sự giàu có, lòng tham và hạnh phúc tài chính."),
    ("Tư Duy Nhanh Và Chậm (Thinking, Fast and Slow)", 2, 7, 10, 249000, 199000, "Hai hệ thống tư duy chi phối mọi quyết định và phán đoán của con người."),
    ("Khởi Nghiệp Tinh Gọn (The Lean Startup)", 2, 7, 8, 175000, 140000, "Phương pháp xây dựng doanh nghiệp thành công bằng chu trình học hỏi nhanh."),
    ("Từ Tốt Đến Vĩ Đại (Good to Great)", 2, 1, 8, 190000, 152000, "Nghiên cứu kinh điển giải mã bí quyết đưa công ty bình thường vươn lên xuất chúng."),
    ("Chiến Lược Đại Dương Xanh (Blue Ocean Strategy)", 2, 7, 8, 168000, 135000, "Cách tạo ra khoảng thị trường không có cạnh tranh và khiến đối thủ trở nên vô nghĩa."),
    ("Nhà Đầu Tư Thông Minh (The Intelligent Investor)", 2, 7, 8, 290000, 230000, "Kinh thánh về trường phái đầu tư giá trị của bậc thầy Benjamin Graham."),
    ("Dốc Hết Trái Tim (Pour Your Heart Into It)", 2, 7, 8, 155000, 124000, "Hành trình xây dựng đế chế cà phê Starbucks từ tình yêu và sự tận tụy."),
    ("Cổ Phiếu Thường, Lợi Nhuận Phi Thường", 2, 7, 8, 145000, 116000, "Triết lý chọn cổ phiếu tăng trưởng đột phá của huyền thoại Philip Fisher."),
    ("Phi Lý Trí (Predictably Irrational)", 2, 7, 10, 165000, 132000, "Khám phá những động lực ẩn giấu đằng sau những quyết định mua sắm của chúng ta."),
    ("Dẫn Dắt Sự Thay Đổi (Leading Change)", 2, 7, 8, 140000, 112000, "Mô hình 8 bước chuyển đổi tổ chức của giáo sư Harvard John Kotter."),
    ("Nguyên Tắc (Principles) - Ray Dalio", 2, 7, 8, 380000, 304000, "Các nguyên tắc sống và làm việc đã giúp tạo nên quỹ đầu tư Bridgewater huyền thoại."),
    ("Không Đến Một (Zero to One) - Peter Thiel", 2, 7, 8, 148000, 118000, "Bí quyết khởi nghiệp sáng tạo bằng cách tạo ra cái mới chưa từng có."),
    ("Nghệ Thuật Bán Hàng Bậc Cao", 2, 4, 2, 138000, 110000, "Bí quyết thuyết phục và chốt đơn đỉnh cao từ huyền thoại Zig Ziglar."),
    ("Tuần Làm Việc 4 Giờ (The 4-Hour Workweek)", 2, 7, 8, 169000, 135000, "Tự động hóa thu nhập và tận hưởng cuộc sống tự do bất cứ nơi đâu."),
    ("Người Giàu Có Nhất Thành Babylon", 2, 4, 8, 85000, 68000, "Những nguyên tắc quản lý tài chính trường tồn từ nền văn minh cổ đại."),
    ("Bí Mật Tư Duy Triệu Phú", 2, 4, 8, 120000, 96000, "Cài đặt lại nhiệt kế tài chính trong tâm thức để đón nhận sự giàu có."),
    ("Dạy Con Làm Giàu - Tập 2 (Sử Dụng Đồng Vốn)", 2, 1, 8, 135000, 108000, "Kim tứ đồ giải phóng bạn khỏi cạm bẫy làm thuê sang làm chủ đầu tư."),
    ("Dạy Con Làm Giàu - Tập 3 (Hướng Dẫn Đầu Tư)", 2, 1, 8, 145000, 116000, "Cách các nhà đầu tư lão luyện biến đồng vốn thành cỗ máy sinh lời."),
    ("Quản Trị Theo Phong Cách Intel (High Output Management)", 2, 7, 8, 160000, 128000, "Bí quyết tối ưu hóa hiệu suất làm việc đội nhóm của huyền thoại Andrew Grove."),
    ("Tỷ Phú Bán Giày (Delivering Happiness)", 2, 1, 8, 139000, 111000, "Văn hóa doanh nghiệp hướng tới niềm vui khách hàng của CEO Zappos Tony Hsieh."),
    ("Để Xây Dựng Doanh Nghiệp Hiệu Quả (The E-Myth Revisited)", 2, 7, 8, 130000, 104000, "Vì sao hầu hết các doanh nghiệp nhỏ thất bại và cách khắc phục bền vững."),
    ("Chiến Lược Giá (Priceless)", 2, 7, 8, 165000, 132000, "Nghệ thuật tâm lý học đằng sau việc định giá sản phẩm và dịch vụ."),
    ("Marketing Du Kích (Guerrilla Marketing)", 2, 7, 8, 142000, 114000, "Chiến lược quảng bá đạt hiệu quả tối đa với ngân sách tối thiểu."),
    ("Định Vị (Positioning: The Battle for Your Mind)", 2, 7, 8, 150000, 120000, "Chiếm lĩnh tâm trí khách hàng trước khi đối thủ kịp xuất hiện."),
    ("Tung Sản Phẩm (Launch) - Jeff Walker", 2, 7, 8, 158000, 126000, "Công thức tạo nên những đợt bùng nổ doanh số kỷ lục trong ngày ra mắt."),
    ("Kinh Tế Học Hài Hước (Freakonomics)", 2, 7, 8, 168000, 134000, "Góc nhìn kinh tế học dí dỏm giải thích những hiện tượng kỳ lạ trong đời sống."),
    ("Kinh Tế Học Kỳ Quặc (SuperFreakonomics)", 2, 7, 8, 175000, 140000, "Tiếp tục giải mã bản chất hành vi con người bằng những con số bất ngờ."),
    ("Chiến Lược Kinh Doanh Tinh Gọn", 2, 7, 8, 145000, 116000, "Xây dựng mô hình kinh doanh nhanh nhạy thích ứng với kỷ nguyên số."),
    ("Blockchain - Bản Chất Của Cách Mạng Tài Chính", 2, 7, 8, 185000, 148000, "Toàn cảnh công nghệ chuỗi khối và tác động định hình lại hệ thống ngân hàng."),
    ("Kinh Doanh Thời 4.0", 2, 7, 8, 160000, 128000, "Chiến lược chuyển đổi số và khai phá dữ liệu lớn để tăng trưởng bứt phá."),
    ("Thấu Hiểu Khách Hàng (Customer Understanding)", 2, 7, 8, 155000, 124000, "Phương pháp nghiên cứu insight khách hàng để tạo ra sản phẩm không thể từ chối."),
    ("Tối Ưu Hóa Chi Phí Vận Hành", 2, 7, 8, 140000, 112000, "Cắt giảm lãng phí và gia tăng biên lợi nhuận cho doanh nghiệp vừa và nhỏ."),
    ("Kỹ Năng Đàm Phán Thương Lượng Đỉnh Cao", 2, 4, 2, 130000, 104000, "Nghệ thuật đạt thỏa thuận đôi bên cùng có lợi trong mọi hợp đồng lớn."),
    ("Lãnh Đạo Giỏi Không Cần Chức Quyền", 2, 1, 8, 148000, 118000, "Tạo sức ảnh hưởng tích cực từ chính năng lực và sự chân thành của bạn."),
    ("Văn Hóa Tinh Gọn Trong Doanh Nghiệp", 2, 7, 8, 165000, 132000, "Xây dựng môi trường làm việc cởi mở, minh bạch và trao quyền tối đa."),
    ("Báo Cáo Tài Chính Dành Cho Người Không Chuyên", 2, 7, 8, 138000, 110000, "Đọc hiểu bảng cân đối kế toán và dòng tiền một cách dễ hiểu nhất."),
    ("Quản Lý Dự Án Agile & Scrum Thực Chiến", 2, 7, 19, 175000, 140000, "Phương pháp triển khai dự án linh hoạt, giao hàng nhanh và đáp ứng tốt thay đổi."),
    ("Quản Trị Rủi Ro Trong Kinh Doanh", 2, 7, 8, 160000, 128000, "Xây dựng kịch bản ứng phó trước khủng hoảng kinh tế và biến động thị trường."),
    ("Nghệ Thuật Xây Dựng Thương Hiệu Cá Nhân", 2, 4, 8, 125000, 100000, "Khẳng định uy tín và giá trị bản thân trong thị trường lao động cạnh tranh."),

    # 3. Tâm lý & Kỹ năng sống (40)
    ("Đắc Nhân Tâm", 3, 4, 2, 96000, 75000, "Nghệ thuật xử thế nhân văn thu phục lòng người trường tồn cùng năm tháng."),
    ("Quẳng Gánh Lo Đi Và Vui Sống", 3, 4, 2, 88000, 70000, "Bí quyết hóa giải âu lo, làm chủ căng thẳng và tìm lại sự an nhiên nội tại."),
    ("Atomic Habits - Thay Đổi Tí Hon, Hiệu Quả Bất Ngờ", 3, 4, 4, 169000, 135000, "Phương pháp khoa học xây dựng thói quen tốt và triệt tiêu thói quen xấu."),
    ("Tuổi Trẻ Đáng Giá Bao Nhiêu?", 3, 2, 23, 95000, 76000, "Cuốn sách truyền cảm hứng hành động, học tập và trải nghiệm cho người trẻ."),
    ("Cà Phê Cùng Tony", 3, 1, 24, 75000, 60000, "Những câu chuyện ngắn hóm hỉnh rèn luyện tính tự lập, tác phong chuyên nghiệp."),
    ("Trên Đường Băng", 3, 1, 24, 82000, 65000, "Tiếp thêm động lực cho tuổi trẻ cất cánh vươn mình ra biển lớn thế giới."),
    ("Khi Hơi Thở Hóa Thinh Không (When Breath Becomes Air)", 3, 2, 8, 125000, 100000, "Hồi ký xúc động về ranh giới sinh tử của một bác sĩ phẫu thuật thần kinh tài hoa."),
    ("Tìm Lại Lạc Quan (Man's Search for Meaning)", 3, 7, 8, 115000, 92000, "Tìm ra ý nghĩa cuộc đời ngay giữa ngục tù thử thách khắc nghiệt nhất."),
    ("Sức Mạnh Của Hiện Tại (The Power of Now)", 3, 4, 8, 140000, 112000, "Buông bỏ quá khứ và lo âu tương lai để sống trọn vẹn trong từng khoảnh khắc."),
    ("Một Cuộc Đời Đáng Sống (The Subtle Art of Not Giving a F*ck)", 3, 7, 8, 135000, 108000, "Học cách buông bỏ những điều phù phiếm để tập trung vào giá trị cốt lõi."),
    ("Dám Bị Ghét", 3, 2, 8, 110000, 88000, "Tâm lý học Adler khai mở can đảm để sống tự do và hạnh phúc đích thực."),
    ("Dám Hạnh Phúc", 3, 2, 8, 115000, 92000, "Tiếp nối Dám Bị Ghét với những chỉ dẫn cụ thể để xây dựng các mối quan hệ hòa hợp."),
    ("Tư Duy Ngược (Lateral Thinking)", 3, 7, 8, 128000, 102000, "Khai phóng tư duy sáng tạo bằng cách tiếp cận vấn đề từ góc nhìn bất ngờ."),
    ("Hiểu Về Trái Tim", 3, 1, 7, 145000, 116000, "Soi sáng những ngóc ngách tâm lý để chuyển hóa khổ đau thành an lạc."),
    ("Hạnh Phúc Đích Thực", 3, 5, 7, 120000, 96000, "Nghệ thuật nuôi dưỡng bình an nội tâm và lòng từ bi trong cuộc sống."),
    ("Sức Mạnh Của Tĩnh Lặng", 3, 4, 8, 125000, 100000, "Tìm về điểm tĩnh lặng bên trong để đưa ra những quyết định sáng suốt nhất."),
    ("Tâm Lý Học Tội Phạm", 3, 7, 8, 168000, 134000, "Giải mã những động cơ hành vi và diễn biến tâm lý phức tạp của tội phạm."),
    ("Nghệ Thuật Lắng Nghe", 3, 4, 2, 95000, 76000, "Lắng nghe chân thành là chiếc chìa khóa vạn năng mở cửa mọi trái tim."),
    ("Trí Tuệ Cảm Xúc 2.0 (Emotional Intelligence 2.0)", 3, 7, 8, 142000, 114000, "Rèn luyện EQ để thành công trong sự nghiệp và thấu hiểu chính mình."),
    ("Đọc Vị Bất Kỳ Ai", 3, 4, 8, 98000, 78000, "Kỹ năng nhận biết tâm lý đối phương chỉ qua ngôn ngữ cơ thể và ánh mắt."),
    ("Nghệ Thuật Giao Tiếp Để Thành Công", 3, 4, 2, 110000, 88000, "96 thủ thuật tinh tế giúp bạn tự tin tỏa sáng trong mọi cuộc trò chuyện."),
    ("Thôi Miên Bằng Ngôn Từ", 3, 7, 8, 155000, 124000, "Sức mạnh của câu chữ trong việc thuyết phục và chạm đến cảm xúc người nghe."),
    ("Quản Lý Thời Gian Thông Minh", 3, 7, 8, 118000, 94000, "Sắp xếp thứ tự ưu tiên và đánh bại thói quen trì hoãn mỗi ngày."),
    ("Kỷ Luật Tự Giác (Self-Discipline)", 3, 7, 8, 130000, 104000, "Cầu nối duy nhất biến ước mơ trừu tượng thành kết quả hữu hình."),
    ("Chữa Lành Đứa Trẻ Bên Trong Bạn", 3, 7, 8, 145000, 116000, "Nhận diện những tổn thương thời thơ ấu để sống trọn vẹn và an yên."),
    ("Không Diệt Không Sinh Đừng Sợ Hãi", 3, 5, 7, 110000, 88000, "Cái nhìn sâu sắc xua tan nỗi sợ hãi cái chết và chia ly của Thiền sư Thích Nhất Hạnh."),
    ("Bước Chậm Lại Giữa Thế Gian Vội Vã", 3, 2, 8, 98000, 78000, "Những lời khuyên an ủi tâm hồn giữa cuộc sống hiện đại đầy hối hả."),
    ("Yêu Những Điều Không Hoàn Hảo", 3, 2, 8, 105000, 84000, "Bao dung với những khiếm khuyết của bản thân và những người xung quanh."),
    ("Sống Thực Tế Giữa Đời Thực Dụng", 3, 7, 8, 112000, 89000, "Giữ cho mình một tâm hồn trong sáng mà không ngây thơ trước cám dỗ."),
    ("Tâm Lý Học Đám Đông (The Crowd)", 3, 5, 8, 135000, 108000, "Phân tích kinh điển của Gustave Le Bon về hành vi bầy đàn của số đông."),
    ("Tư Duy Sâu (Deep Thinking)", 3, 7, 8, 148000, 118000, "Vượt qua sự hời hợt của kỷ nguyên số để rèn luyện năng lực tư duy bản chất."),
    ("Làm Chủ Cảm Xúc (Master Your Emotions)", 3, 7, 8, 125000, 100000, "Chiến lược quản trị giận dữ, thất vọng và xây dựng tinh thần lạc quan."),
    ("Nghệ Thuật Tư Duy Rành Mạch", 3, 2, 8, 140000, 112000, "Nhận diện 52 lỗi tư duy phổ biến khiến chúng ta đưa ra quyết định sai lầm."),
    ("Khí Chất Bao Nhiêu, Hạnh Phúc Bấy Nhiêu", 3, 7, 8, 108000, 86000, "Nuôi dưỡng sự độc lập, tự tin và kiêu hãnh của phụ nữ hiện đại."),
    ("Bạn Đắt Giá Bao Nhiêu?", 3, 7, 8, 115000, 92000, "Lời nhắc nhở giá trị bản thân không phụ thuộc vào ánh nhìn của người khác."),
    ("Tìm Mình Trong Thế Giới Hậu Tuổi Thơ", 3, 1, 8, 128000, 102000, "Hành trình định vị bản thân và chữa lành cho những người trẻ chông chênh."),
    ("Đừng Lựa Chọn An Nhàn Khi Còn Trẻ", 3, 7, 8, 95000, 76000, "Đánh thức khát vọng cống hiến và nỗ lực hết mình cho tương lai."),
    ("Học Cách Nói Không", 3, 4, 8, 90000, 72000, "Thiết lập ranh giới lành mạnh để bảo vệ thời gian và năng lượng của bạn."),
    ("Nghệ Thuật Tối Giản Trong Cuộc Sống (Danshari)", 3, 7, 8, 102000, 81000, "Dọn dẹp không gian sống để mở rộng không gian tâm trí."),
    ("Tự Tin Trong 60 Giây", 3, 4, 2, 85000, 68000, "Các bài tập thực hành kích hoạt sự tự tin ngay trước mỗi cuộc phỏng vấn quan trọng."),

    # 4. Công nghệ & Lập trình (35)
    ("Clean Code - Mã Sạch", 4, 7, 19, 295000, 236000, "Cẩm nang hướng dẫn viết code tinh gọn, dễ bảo trì cho kỹ sư phần mềm."),
    ("Clean Architecture - Kiến Trúc Phần Mềm Sạch", 4, 7, 19, 320000, 256000, "Quy tắc thiết kế cấu trúc hệ thống độc lập framework, database và UI."),
    ("Refactoring - Tối Ưu Hóa Mã Nguồn Hiện Có", 4, 7, 20, 310000, 248000, "Nghệ thuật cải thiện thiết kế mã nguồn mà không làm thay đổi hành vi bên ngoài."),
    ("Design Patterns - 23 Mẫu Thiết Kế Hướng Đối Tượng", 4, 7, 19, 350000, 280000, "Kinh thánh về giải pháp kiến trúc giải quyết các bài toán thiết kế kinh điển."),
    ("Lập Trình .NET 10 & C# 14 Toàn Tập", 4, 7, 19, 280000, 224000, "Hướng dẫn toàn diện xây dựng Web API, Microservices với ASP.NET Core 10."),
    ("React 19 & Next.js Thực Chiến", 4, 7, 21, 260000, 208000, "Xây dựng ứng dụng web hiện đại với React Server Components và Tailwind CSS."),
    ("Học Sâu & Trí Tuệ Nhân Tạo (Deep Learning)", 4, 7, 21, 380000, 304000, "Giáo trình nền tảng về mạng nơ-ron, thị giác máy tính và xử lý ngôn ngữ tự nhiên."),
    ("Nhập Môn Học Máy Với Python (Machine Learning with Python)", 4, 7, 21, 275000, 220000, "Thực hành xây dựng mô hình dự đoán với Scikit-Learn và TensorFlow."),
    ("Docker & Kubernetes Toàn Diện", 4, 7, 19, 290000, 232000, "Đóng gói container và điều phối cụm microservices trong môi trường Production."),
    ("DevOps Thực Chiến: CI/CD Với Jenkins & GitHub Actions", 4, 7, 19, 265000, 212000, "Xây dựng pipeline tự động hóa kiểm thử, đóng gói và triển khai đám mây."),
    ("Cơ Sở Dữ Liệu SQL Server & T-SQL Nâng Cao", 4, 7, 19, 250000, 200000, "Tối ưu hóa truy vấn, lập chỉ mục Indexing và quản trị hiệu năng CSDL."),
    ("Thiết Kế Hệ Thống Quy Mô Lớn (System Design Interview)", 4, 7, 19, 330000, 264000, "Bí quyết kiến trúc hệ thống phục vụ hàng triệu người dùng đồng thời."),
    ("Lập Trình Microservices Với .NET & RabbitMQ", 4, 7, 19, 295000, 236000, "Xây dựng kiến trúc hướng sự kiện (Event-Driven) chịu tải cao."),
    ("An Toàn Thông Tin & Hacker Mũ Trắng", 4, 7, 19, 240000, 192000, "Các kỹ thuật kiểm thử xâm nhập (Penetration Testing) và phòng thủ mạng."),
    ("Cấu Trúc Dữ Liệu & Giải Thuật Thực Hành", 4, 7, 19, 210000, 168000, "Nền tảng vững chắc để vượt qua các kỳ phỏng vấn thuật toán tại các tập đoàn công nghệ."),
    ("Lập Trình Hướng Đối Tượng C++ Hiện Đại", 4, 7, 19, 225000, 180000, "Làm chủ con trỏ thông minh, bộ nhớ và các tính năng từ C++11 đến C++20."),
    ("Lập Trình Python Từ Cơ Bản Đến Nâng Cao", 4, 7, 21, 195000, 156000, "Ngôn ngữ đa năng cho phân tích dữ liệu, tự động hóa và phát triển web."),
    ("Kỹ Nghệ Dữ Liệu (Data Engineering Essentials)", 4, 7, 21, 310000, 248000, "Xây dựng data pipeline ETL với Spark, Kafka và Airflow."),
    ("Phân Tích Dữ Liệu Với Pandas & SQL", 4, 7, 21, 235000, 188000, "Biến dữ liệu thô thành những báo cáo phân tích kinh doanh giá trị."),
    ("Cloud Computing Với AWS & Azure", 4, 7, 19, 315000, 252000, "Thiết kế hạ tầng đám mây không máy chủ (Serverless) chuẩn Well-Architected."),
    ("Lập Trình Di Động Flutter & Dart", 4, 7, 19, 245000, 196000, "Xây dựng ứng dụng native đa nền tảng iOS & Android chỉ với một mã nguồn."),
    ("Node.js & Express - Xây Dựng RESTful API", 4, 7, 19, 215000, 172000, "Tận dụng cơ chế non-blocking I/O để xây dựng backend tốc độ cao."),
    ("TypeScript Cho Người Mới Bắt Đầu", 4, 7, 19, 185000, 148000, "Thêm sức mạnh type-safety cho dự án JavaScript của bạn."),
    ("Tối Ưu Hóa SEO Cho Lập Trình Viên Web", 4, 7, 19, 170000, 136000, "Kỹ thuật tối ưu hóa Core Web Vitals và cấu trúc dữ liệu cho công cụ tìm kiếm."),
    ("Kiểm Thử Phần Mềm Tự Động Với Selenium & Playwright", 4, 7, 19, 220000, 176000, "Viết kịch bản test E2E bảo đảm chất lượng phần mềm liên tục."),
    ("Git & GitHub Thực Chiến Trong Doanh Nghiệp", 4, 7, 19, 150000, 120000, "Quy trình làm việc nhóm với Gitflow, Trunk-based và Pull Request."),
    ("GraphQL - Ngôn Ngữ Truy Vấn Dữ Liệu Thế Hệ Mới", 4, 7, 19, 210000, 168000, "Giải pháp thay thế linh hoạt cho kiến trúc REST API truyền thống."),
    ("Lập Trình Java Spring Boot 3", 4, 7, 19, 285000, 228000, "Phát triển ứng dụng doanh nghiệp ổn định và mở rộng mạnh mẽ."),
    ("Thuật Toán Xử Lý Ảnh Với OpenCV", 4, 7, 21, 260000, 208000, "Nhận diện khuôn mặt, phát hiện đối tượng trong video thời gian thực."),
    ("Xử Lý Ngôn Ngữ Tự Nhiên Với Transformers", 4, 7, 21, 340000, 272000, "Fine-tuning mô hình ngôn ngữ lớn (LLM) và ứng dụng hỏi đáp tự động."),
    ("Phát Triển Web UI Với Tailwind CSS", 4, 7, 19, 175000, 140000, "Xây dựng giao diện web phản hồi nhanh (Responsive) thần tốc."),
    ("Redis Trong Thực Tế: Caching & Message Queue", 4, 7, 19, 225000, 180000, "Tăng tốc độ hệ thống lên gấp 10 lần nhờ bộ nhớ đệm In-Memory."),
    ("Quản Lý Cấu Hình Máy Chủ Với Ansible", 4, 7, 19, 210000, 168000, "Tự động hóa triển khai hạ tầng máy chủ hàng loạt bằng mã (IaC)."),
    ("Lập Trình Linux & Shell Scripting", 4, 7, 19, 190000, 152000, "Khai phá sức mạnh dòng lệnh Bash để quản trị hệ thống chuyên nghiệp."),
    ("Kỹ Năng Giải Quyết Vấn Đề Cho Kỹ Sư Công Nghệ", 4, 7, 19, 165000, 132000, "Tư duy phản biện và phương pháp luận gỡ lỗi (Debugging) trong hệ thống phức tạp."),

    # 5. Lịch sử & Triết học (25)
    ("Sapiens: Lược Sử Loài Người", 5, 2, 3, 219000, 175000, "Hành trình tiến hóa và thống trị hành tinh ngoạn mục của loài người."),
    ("Homo Deus: Lược Sử Tương Lai", 5, 2, 3, 229000, 183000, "Những kịch bản tương lai khi nhân loại làm chủ công nghệ sinh học và AI."),
    ("21 Bài Học Cho Thế Kỷ 21", 5, 2, 3, 199000, 159000, "Những thách thức cấp bách về chính trị, công nghệ và bản sắc nhân loại."),
    ("Súng, Vi Trùng Và Thép (Guns, Germs, and Steel)", 5, 2, 8, 235000, 188000, "Nghiên cứu về số phận các xã hội loài người dưới tác động của địa lý."),
    ("Việt Nam Sử Lược", 5, 6, 8, 165000, 132000, "Bộ thông sử Việt Nam đầu tiên viết bằng chữ quốc ngữ của Trần Trọng Kim."),
    ("Đại Việt Sử Ký Toàn Thư (Bản Rút Gọn)", 5, 6, 8, 290000, 232000, "Di sản sử học quý báu ghi chép lịch sử dân tộc từ thời Hồng Bàng."),
    ("Lịch Sử Văn Minh Thế Giới", 5, 5, 8, 320000, 256000, "Hành trình phát triển rực rỡ của các nền văn minh phương Đông và phương Tây."),
    ("Cộng Hòa (The Republic) - Plato", 5, 5, 8, 210000, 168000, "Tác phẩm triết học kinh điển bàn về công lý, nhà nước lý tưởng và giáo dục."),
    ("Bàn Về Tự Do (On Liberty) - John Stuart Mill", 5, 5, 8, 135000, 108000, "Luận thuyết nền tảng bảo vệ tự do tư tưởng và quyền cá nhân."),
    ("Khế Ước Xã Hội (The Social Contract) - Rousseau", 5, 5, 8, 140000, 112000, "Tư tưởng triết học chính trị truyền cảm hứng cho cuộc Cách mạng Pháp."),
    ("Lịch Sử Triết Học Phương Tây", 5, 5, 8, 350000, 280000, "Toàn cảnh tư tưởng triết học từ Hy Lạp cổ đại đến thế kỷ 20 của Bertrand Russell."),
    ("Đạo Đức Kinh - Lão Tử", 5, 5, 8, 115000, 92000, "Minh triết phương Đông về lẽ vô vi và quy luật vận hành của trời đất."),
    ("Luận Ngữ - Khổng Tử", 5, 5, 8, 125000, 100000, "Những lời dạy cốt lõi về nhân, nghĩa, lễ, trí của Nho gia."),
    ("Tư Mã Thiên - Sử Ký", 5, 5, 8, 280000, 224000, "Kiệt tác sử học và văn học vĩ đại ghi chép lịch sử Trung Hoa cổ đại."),
    ("Binh Pháp Tôn Tử", 5, 5, 8, 98000, 78000, "Nghệ thuật quân sự và triết lý chiến lược mưu lược đỉnh cao muôn đời."),
    ("Con Đường Tơ Lụa (The Silk Roads)", 5, 2, 8, 265000, 212000, "Một lịch sử mới của thế giới nhìn từ ngã tư các tuyến đường giao thương."),
    ("Sử Lược Nước Mỹ", 5, 5, 8, 195000, 156000, "Hành trình từ thuộc địa trở thành siêu cường kinh tế của Hợp chủng quốc Hoa Kỳ."),
    ("Đông Dương Cổ Đại", 5, 5, 8, 180000, 144000, "Khảo cứu công phu về khảo cổ học và các nền văn hóa cổ xưa trên bán đảo."),
    ("Lịch Sử Hà Nội Qua Những Con Đường", 5, 5, 8, 145000, 116000, "Ký ức ngàn năm Thăng Long soi chiếu qua từng con phố rêu phong."),
    ("Sài Gòn - Gia Định Xưa", 5, 6, 8, 155000, 124000, "Những trang sử và phong tục tập quán hào sảng của đất phương Nam."),
    ("Những Nhân Vật Làm Thay Đổi Lịch Sử Thế Giới", 5, 5, 8, 190000, 152000, "Tiểu sử và tầm ảnh hưởng của 100 vĩ nhân định hình nhân loại."),
    ("Chiến Tranh Thế Giới Thứ Hai", 5, 5, 8, 340000, 272000, "Toàn cảnh cuộc chiến đẫm máu nhất trong lịch sử nhân loại."),
    ("Văn Minh Maya - Bí Ẩn Về Sự Suy Tàn", 5, 5, 8, 160000, 128000, "Khám phá khoa học thiên văn và sự biến mất kỳ lạ của đế chế Trung Mỹ."),
    ("Hy Lạp Cổ Đại - Cái Nôi Dân Chủ", 5, 5, 8, 175000, 140000, "Khám phá thần thoại, triết học và kiến trúc đỉnh cao của người Hy Lạp."),
    ("La Mã Cổ Đại - Từ Nền Cộng Hòa Tới Đế Chế", 5, 5, 8, 215000, 172000, "Sức mạnh quân sự và luật pháp kiến tạo nên đế chế vĩ đại bậc nhất thế giới."),

    # 6. Văn học Thiếu nhi (15)
    ("Dế Mèn Phiêu Lưu Ký (Ấn Bản Kỷ Niệm Bìa Cứng)", 6, 3, 6, 95000, 76000, "Phiên bản minh họa màu tuyệt đẹp của tác phẩm văn học thiếu nhi kinh điển."),
    ("Chuyện Con Mèo Dạy Hải Âu Bay", 6, 2, 8, 65000, 52000, "Bài học sâu sắc về tình mẫu tử, lời hứa và lòng dũng cảm vượt qua định kiến."),
    ("Góc Sân Và Khoảng Trời", 6, 3, 8, 85000, 68000, "Những vần thơ tuổi thơ trong trẻo, hồn nhiên của thần đồng thơ Trần Đăng Khoa."),
    ("Bác Sĩ Dolittle & Những Động Vật Kỳ Lạ", 6, 3, 8, 75000, 60000, "Hành trình chữa bệnh đầy tiếng cười của vị bác sĩ hiểu được tiếng muông thú."),
    ("Alice Ở Xứ Sở Thần Tiên (Alice in Wonderland)", 6, 3, 8, 90000, 72000, "Chuyến phiêu lưu vào hang thỏ kỳ diệu đầy màu sắc tưởng tượng."),
    ("Peter Pan - Cậu Bé Không Bao Giờ Lớn", 6, 3, 8, 80000, 64000, "Vùng đất Neverland kỳ ảo nơi tuổi thơ được lưu giữ mãi mãi."),
    ("Khu Vườn Bí Mật (The Secret Garden)", 6, 3, 8, 110000, 88000, "Sức mạnh diệu kỳ của thiên nhiên và tình bạn làm hồi sinh những trái tim cô độc."),
    ("Gió Qua Rặng Liễu (The Wind in the Willows)", 6, 3, 8, 105000, 84000, "Tình bạn ấm áp giữa bác Chuột Chũi, Chuột Nước và chàng Cóc ngổ ngáo."),
    ("Pippi Tất Dài (Pippi Longstocking)", 6, 3, 8, 95000, 76000, "Cô bé tóc đỏ nghịch ngợm, khỏe nhất thế giới với trái tim hào hiệp."),
    ("Charlie Và Nhà Máy Sôcôla", 6, 3, 8, 85000, 68000, "Tấm vé vàng mở ra thế giới ngọt ngào đầy bất ngờ của ngài Willy Wonka."),
    ("Cô Bé Quàng Khăn Đỏ & Cổ Tích Grimm", 6, 3, 8, 115000, 92000, "Tuyển tập những câu chuyện cổ tích nuôi dưỡng ước mơ của mọi thế hệ."),
    ("Cổ Tích Andersen Chọn Lọc", 6, 3, 8, 120000, 96000, "Nàng tiên cá, Chú vịt con xấu xí và những câu chuyện nhân ái bất hủ."),
    ("Nghìn Lẻ Một Đêm (Ấn Bản Thiếu Nhi)", 6, 3, 8, 135000, 108000, "Kho tàng thần thoại Ả Rập với Aladdin, Ali Baba và Sinbad dũng cảm."),
    ("Đất Rừng Phương Nam", 6, 3, 8, 100000, 80000, "Hành trình tìm cha đầy gian truân nhưng ấm áp nghĩa tình của cậu bé An."),
    ("Totto-chan Bên Cửa Sổ", 6, 2, 8, 108000, 86000, "Ngôi trường Tomoe mơ ước với phương pháp giáo dục tôn trọng cá tính trẻ thơ."),

    # 7. Khoa học & Vũ trụ (5)
    ("Lược Sử Thời Gian (A Brief History of Time)", 7, 5, 18, 155000, 124000, "Kiệt tác của Stephen Hawking mở ra bí ẩn của hố đen, vụ nổ Big Bang và thời gian."),
    ("Vũ Trụ (Cosmos) - Carl Sagan", 7, 2, 22, 280000, 224000, "Bản giao hưởng kỳ vĩ đưa người đọc khám phá 15 tỷ năm tiến hóa của vũ trụ."),
    ("Nguồn Gốc Các Loài (On the Origin of Species)", 7, 5, 8, 250000, 200000, "Học thuyết tiến hóa chấn động của Charles Darwin làm thay đổi nhận thức nhân loại."),
    ("Gen Vị Kỷ (The Selfish Gene) - Richard Dawkins", 7, 5, 8, 220000, 176000, "Góc nhìn đột phá về tiến hóa sinh học và động lực sinh tồn của sự sống."),
    ("Thế Giới Bị Quỷ Ám - Khoa Học Như Ngọn Nến Trong Đêm", 7, 2, 22, 185000, 148000, "Bảo vệ tư duy khoa học và lòng hoài nghi trước những mê tín dị đoan.")
]

# Ensure we have exactly 200 books by generating variations if needed
all_books = []
for i in range(200):
    tmpl = book_templates[i % len(book_templates)]
    # Create unique ISBN and variations for repeats
    book_id = i + 1
    cycle = i // len(book_templates)
    title = tmpl[0] if cycle == 0 else f"{tmpl[0]} (Ấn bản {cycle + 1})"
    cat_id = tmpl[1]
    pub_id = tmpl[2]
    author_id = tmpl[3]
    orig_price = tmpl[4] + (cycle * 5000)
    sale_price = tmpl[5] + (cycle * 4000) if tmpl[5] else None
    desc = tmpl[6]
    isbn = f"978-604-{100 + (i % 800):03d}-{1000 + i:04d}"
    cover = cover_images[i % len(cover_images)]
    pages = 180 + (i * 7) % 450
    year = 2019 + (i % 6)
    stock = 30 + (i * 13) % 180

    all_books.append({
        "id": book_id,
        "title": title,
        "isbn": isbn,
        "categoryId": cat_id,
        "publisherId": pub_id,
        "authorId": author_id,
        "originalPrice": orig_price,
        "salePrice": sale_price,
        "description": desc,
        "coverImageUrl": cover,
        "pageCount": pages,
        "publishYear": year,
        "stockQuantity": stock
    })

print(f"Total books ready to seed: {len(all_books)}")

# Write the full SQL script
with open(r"D:\Code\DevOps\bookstore\init_bookstore.sql", "w", encoding="utf-8") as f:
    f.write("""-- =====================================================================
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
(1, N'admin@bookstore.vn', N'""" + get_pw_hash("Admin@123") + """', N'Quản trị viên', N'0901234567', 3, 1),
(2, N'docgia@gmail.com', N'""" + get_pw_hash("User@123") + """', N'Nguyễn Văn Độc Giả', N'0987654321', 0, 1),
(3, N'nhanvien@bookstore.vn', N'""" + get_pw_hash("Staff@123") + """', N'Lê Thị Thu Ngân', N'0912345678', 1, 1);
SET IDENTITY_INSERT [dbo].[Users] OFF;
GO

-- 4. INSERT CATEGORIES
SET IDENTITY_INSERT [dbo].[Categories] ON;
""")
    for cat in categories:
        f.write(f"INSERT INTO [dbo].[Categories] ([Id], [Name], [Slug], [Description]) VALUES ({cat[0]}, N'{cat[1]}', N'{cat[2]}', N'{cat[3]}');\n")
    f.write("SET IDENTITY_INSERT [dbo].[Categories] OFF;\nGO\n\n")

    # Publishers
    f.write("-- 5. INSERT PUBLISHERS\nSET IDENTITY_INSERT [dbo].[Publishers] ON;\n")
    for pub in publishers:
        f.write(f"INSERT INTO [dbo].[Publishers] ([Id], [Name], [Address], [ContactEmail]) VALUES ({pub[0]}, N'{pub[1]}', N'{pub[2]}', N'{pub[3]}');\n")
    f.write("SET IDENTITY_INSERT [dbo].[Publishers] OFF;\nGO\n\n")

    # Authors
    f.write("-- 6. INSERT AUTHORS\nSET IDENTITY_INSERT [dbo].[Authors] ON;\n")
    for a in authors:
        f.write(f"INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography]) VALUES ({a[0]}, N'{a[1]}', N'{a[2]}', N'{a[3]}');\n")
    f.write("SET IDENTITY_INSERT [dbo].[Authors] OFF;\nGO\n\n")

    # Discounts
    f.write("""-- 7. INSERT DISCOUNTS
INSERT INTO [dbo].[Discounts] ([Code], [DiscountPercent], [MaxDiscountAmount], [MinOrderAmount], [StartDate], [EndDate], [UsageLimit], [TimesUsed], [IsActive])
VALUES 
(N'BOOKSTORE10', 10.00, 50000.00, 150000.00, '2026-01-01', '2026-12-31', 500, 12, 1),
(N'TRIENTHO20', 20.00, 100000.00, 300000.00, '2026-01-01', '2026-12-31', 200, 45, 1),
(N'FREESHIP', 100.00, 30000.00, 250000.00, '2026-01-01', '2026-12-31', 1000, 89, 1);
GO

-- 8. INSERT 200 BOOKS
SET IDENTITY_INSERT [dbo].[Books] ON;
""")
    for b in all_books:
        sale_val = f"{b['salePrice']:.2f}" if b['salePrice'] else "NULL"
        desc_escaped = b['description'].replace("'", "''")
        title_escaped = b['title'].replace("'", "''")
        f.write(f"INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CategoryId], [PublisherId]) "
                f"VALUES ({b['id']}, N'{b['isbn']}', N'{title_escaped}', N'{desc_escaped}', {b['originalPrice']:.2f}, {sale_val}, {b['stockQuantity']}, {b['pageCount']}, {b['publishYear']}, N'vi', N'{b['coverImageUrl']}', 1, {b['categoryId']}, {b['publisherId']});\n")
    f.write("SET IDENTITY_INSERT [dbo].[Books] OFF;\nGO\n\n")

    # BookAuthors
    f.write("-- 9. LINK BOOK AUTHORS\n")
    for b in all_books:
        f.write(f"INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES ({b['id']}, {b['authorId']});\n")
    f.write("GO\n\n")

    # Sample reviews
    f.write("""-- 10. INSERT REVIEWS
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
""")

print("Successfully generated D:\Code\DevOps\bookstore\init_bookstore.sql")
