# -*- coding: utf-8 -*-
"""
Script to generate 800 books to bring BookstoreDb to exactly 1000 books.
"""
import random
import re
import datetime

# 1. Read authentic cover images from assign_authentic_covers.sql
covers = []
try:
    with open('scripts/assign_authentic_covers.sql', 'r', encoding='utf-8') as f:
        content = f.read()
        covers = re.findall(r"CoverImageUrl = N'([^']+)'", content)
except Exception as e:
    print("Could not read assign_authentic_covers.sql:", e)

# Fallback covers if list is small
fallback_covers = [
    'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg',
    'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg',
    'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg',
    'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg',
    'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/df/fe/df/08a4a624353b4289b877cf3bced910e4.jpg',
    'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/a0/a3/2b/006dac88a54de6057ebc9e922069d2bd.jpg',
    'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg',
    'https://salt.tikicdn.com/cache/750x750/ts/product/a5/65/4c/2da4aa944b6f280afbd694ac1a129682.jpeg',
    'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg',
    'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235241848.jpg',
]

if not covers:
    covers = fallback_covers

print(f"Loaded {len(covers)} cover URLs from assign_authentic_covers.sql.")

# 2. Define new Authors to insert if not present
new_authors = [
    (26, "Victor Hugo", "Pháp", "Đại văn hào chủ nghĩa lãng mạn, tác giả Những Người Khốn Khổ và Nhà Thờ Đức Bà Paris."),
    (27, "Arthur Conan Doyle", "Anh", "Bác sĩ kiêm nhà văn, cha đẻ của thám tử lừng danh Sherlock Holmes."),
    (28, "Lev Tolstoy", "Nga", "Đại văn hào hiện thực vĩ đại, tác giả Chiến Tranh Và Hòa Bình, Anna Karenina."),
    (29, "J.K. Rowling", "Anh", "Nữ văn sĩ người Anh, tác giả bộ truyện phù thủy huyền thoại Harry Potter."),
    (30, "Dan Brown", "Mỹ", "Bậc thầy tiểu thuyết trinh thám trí tuệ và giải mã biểu tượng học."),
    (31, "Walter Isaacson", "Mỹ", "Nhà viết tiểu sử kiệt xuất của Steve Jobs, Elon Musk, Leonardo da Vinci."),
    (32, "Malcolm Gladwell", "Canada", "Nhà báo, tác giả các ấn phẩm tư duy kinh điển Điểm Bùng Phát, Những Kẻ Xuất Chúng."),
    (33, "Thích Nhất Hạnh", "Việt Nam", "Thiền sư lỗi lạc quốc tế, tác giả Giận, An Lạc Từng Bước Chân, Hiểu Về Trái Tim."),
    (34, "Marcus Aurelius", "La Mã", "Hoàng đế kiêm triết gia Khắc Kỷ lừng danh của đế chế La Mã cổ đại."),
    (35, "Sun Tzu (Tôn Tử)", "Trung Quốc", "Danh tướng thời Xuân Thu, tác giả Binh Pháp Tôn Tử kinh điển."),
    (36, "Robin Sharma", "Canada", "Chuyên gia phát triển bản thân và kỹ năng lãnh đạo hàng đầu thế giới."),
    (37, "Brian Tracy", "Mỹ", "Bậc thầy đào tạo thành công, quản lý thời gian và đàm phán thương lượng."),
    (38, "Cal Newport", "Mỹ", "Giáo sư khoa học máy tính tại ĐH Georgetown, tác giả Deep Work và Digital Minimalism."),
    (39, "Donald Knuth", "Mỹ", "Huyền thoại khoa học máy tính, tác giả bộ sách The Art of Computer Programming."),
    (40, "Richard Feynman", "Mỹ", "Nhà vật lý lượng tử đoạt giải Nobel, tác giả Chắc Bạn Đùa Feynman!.")
]

# 3. Curated Book Titles and Descriptions per Category
# Category 1: Văn học (cat_id: 1)
vanhoc_data = [
    ("Những Người Khốn Khổ - Trọn Bộ 2 Tập", "Bản hùng ca vĩ đại về tình người, lòng bao dung và sự cứu rỗi giữa xã hội nước Pháp thế kỷ 19.", 26),
    ("Nhà Thờ Đức Bà Paris", "Chuyện tình bi thương và cao thượng của chàng gù Quasimodo dành cho nàng Esmeralda.", 26),
    ("Chiến Tranh Và Hòa Bình - Trọn Bộ", "Kiệt tác sử thi đồ sộ mô tả chân thực xã hội Nga thời kỳ chiến tranh Vệ quốc chống Napoleon.", 28),
    ("Anna Karenina", "Bi kịch tình yêu và hôn nhân của giới quý tộc Nga, một trong những tiểu thuyết hiện thực hay nhất mọi thời đại.", 28),
    ("Sherlock Holmes - Chiếc Nhẫn Tình Cờ", "Vụ án đầu tiên mở màn tình bạn huyền thoại giữa Sherlock Holmes và bác sĩ Watson.", 27),
    ("Sherlock Holmes - Con Chó Của Dòng Họ Baskerville", "Bí ẩn kinh hoàng về bóng ma chó săn khổng lồ rình rập trên đầm lầy hoang vắng xứ Dartmoor.", 27),
    ("Sherlock Holmes - Thung Lũng Khủng Khiếp", "Vụ án mạng ly kỳ dẫn lối Holmes vén màn tổ chức tội phạm bí mật xuyên lục địa.", 27),
    ("Harry Potter Và Hòn Đá Phù Thủy", "Chuyến tàu tốc hành đưa cậu bé Harry Potter bước vào thế giới phép thuật kỳ ảo Hogwarts.", 29),
    ("Harry Potter Và Phòng Chứa Bí Mật", "Bí mật ngàn năm dưới lòng Hogwarts thức giấc đe dọa tính mạng các phù thủy sinh gốc Muggle.", 29),
    ("Harry Potter Và Tên Tù Nhân Ngục Azkaban", "Bí ẩn về Sirius Black và cuộc đối đầu với những giám ngục Azkaban lạnh giá.", 29),
    ("Harry Potter Và Chiếc Cốc Lửa", "Giải đấu Tam Pháp Thuật đầy kịch tính đánh dấu sự trở lại đen tối của Chúa tể Voldemort.", 29),
    ("Mật Mã Da Vinci", "Cuộc truy lùng Chén Thánh nghẹt thở qua các biểu tượng ẩn giấu trong tranh của Leonardo da Vinci.", 30),
    ("Thiên Thần Và Ác Quỷ", "Âm mưu phá hủy Vatican bằng phản vật chất của giáo phái bí ẩn Illuminati.", 30),
    ("Biểu Tượng Thất Truyền", "Bí mật cổ xưa của hội Tam Điểm ẩn giấu tại thủ đô Washington D.C.", 30),
    ("Hỏa Ngục (Inferno)", "Cuộc chạy đua ngăn chặn đại dịch toàn cầu dựa trên thi phẩm Địa Ngục của Dante.", 30),
    ("Rừng Na Uy", "Khúc ca hoài niệm đầy day dứt về tuổi trẻ, tình yêu và nỗi cô đơn của những người trẻ tuổi Tokyo.", 14),
    ("Biên Niên Ký Chim Vặn Dây Cót", "Hành trình siêu thực tìm kiếm người vợ mất tích đưa Toru Okada lặn sâu vào ký ức chiến tranh.", 14),
    ("Kafka Bên Bờ Biển", "Chuyến trốn chạy định mệnh của cậu bé 15 tuổi Kafka Tamura hòa cùng thế giới huyền ảo của ông lão Nakata.", 14),
    ("1Q84 - Trọn Bộ 3 Tập", "Thế giới song song với hai vầng trăng nơi Aomame và Tengo tìm lại mối liên kết định mệnh.", 14),
    ("Người Đua Diều", "Câu chuyện cảm động về tình bạn, tội lỗi và sự chuộc tội trên đất nước Afghanistan nhiều biến động.", 1),
    ("Trăm Năm Cô Đơn", "Bản anh hùng ca của dòng họ Buendia tại ngôi làng Macondo huyền thoại của chủ nghĩa hiện thực huyền ảo.", 1),
    ("Đồi Gió Hú", "Mối tình nồng cháy nhưng đầy thù hận giữa Heathcliff và Catherine trên cánh đồng hoang Yorkshire.", 1),
    ("Kiêu Hãnh Và Định Kiến", "Nghệ thuật ứng xử, sự kiêu hãnh và những định kiến trong tình yêu của Elizabeth Bennet và Ngài Darcy.", 1),
    ("Bá Tước Monte Cristo", "Hành trình trả thù vĩ đại và tìm lại công lý của chàng thủy thủ Edmond Dantès.", 26),
    ("Ba Chàng Lính Ngự Lâm", "Khẩu hiệu 'Một người vì mọi người, mọi người vì một người' bất hủ của d'Artagnan và ba chàng ngự lâm quân.", 26),
    ("Chuông Nguyện Hồn Ai", "Tác phẩm khắc họa lòng dũng cảm, tình đồng đội và sự khốc liệt trong cuộc nội chiến Tây Ban Nha.", 1),
    ("Ông Già Và Biển Cả", "Ý chí phi thường của con người trước thiên nhiên dữ dội: 'Con người có thể bị hủy diệt nhưng không thể bị đánh bại.'", 1),
    ("Bắt Trẻ Đồng Xanh", "Tiếng nói nổi loạn, chân thật và nhạy cảm của cậu thiếu niên Holden Caulfield giữa xã hội giả tạo.", 1),
    ("Đại Gia Gatsby", "Ảo mộng phù hoa của giấc mơ Mỹ và tình si vô vọng của chàng triệu phú Jay Gatsby.", 1),
    ("Cuốn Theo Chiều Gió", "Bản tình ca bất hủ giữa nàng Scarlett O'Hara kiêu kỳ và Rhett Butler phong trần trong khói lửa nội chiến Mỹ.", 1),
    ("Giết Con Chim Nhại", "Bài học sâu sắc về lòng nhân ái, công lý và sự bình đẳng chủng tộc qua góc nhìn của cô bé Scout.", 1),
    ("Dịch Hạch", "Sự đoàn kết và phẩm giá con người kiên cường đối mặt với bệnh dịch và sự phi lý của cuộc đời.", 11),
    ("Người Xa Lạ", "Tác phẩm mở đường cho chủ nghĩa hiện sinh về sự thờ ơ và phi lý của xã hội hiện đại.", 11),
    ("Số Đỏ", "Kiệt tác trào phúng đỉnh cao của văn học Việt Nam về xã hội tư sản thực dân nửa mùa Âu hóa.", 17),
    ("Giông Tố", "Bức tranh xã hội ngột ngạt, tàn bạo với bi kịch gia đình và sự tha hóa của đồng tiền.", 17),
    ("Tắt Đèn", "Bi kịch cùng cực và tinh thần phản kháng quật khởi của chị Dậu dưới ách sưu cao thuế nặng.", 16),
    ("Chí Phèo & Những Truyện Ngắn Chọn Lọc", "Tiếng kêu xé ruột đòi quyền làm người lương thiện của số phận người nông dân bị bần cùng hóa.", 16),
    ("Vợ Nhặt & Tác Phẩm Kinh Điển", "Tình người ấm áp, khát vọng sống và niềm tin vào tương lai giữa nạn đói kinh hoàng 1945.", 16),
    ("Lão Hạc", "Tình phụ tử cảm động và nhân cách trong sạch của một lão nông nghèo thà chết chứ không bán rẻ lương tâm.", 16),
    ("Nỗi Buồn Chiến Tranh", "Góc nhìn nhân văn sâu sắc về nỗi đau âm ỉ của những người bước ra từ khói lửa chiến trường.", 5),
    ("Cánh Đồng Bất Tận", "Những mảnh đời trôi dạt trên sông nước miền Tây qua ngòi bút đượm buồn và chan chứa trắc ẩn.", 5),
    ("Bến Không Chồng", "Số phận những người phụ nữ làng Đông mòn mỏi chờ đợi người thân sau chiến tranh.", 5),
    ("Mùa Lá Rụng Trong Vườn", "Sự va đập giữa các giá trị đạo đức truyền thống và lối sống hiện đại trong gia đình ông Ánh.", 5),
    ("Truyện Kiều - Ấn Bản Đặc Biệt", "Kiệt tác văn học trung đại Việt Nam của Đại thi hào Nguyễn Du với tranh minh họa mỹ thuật.", 15),
    ("Hoa Tiên & Thơ Văn Nguyễn Du", "Tuyển tập những áng thơ tuyệt tác bất hủ của đại thi hào văn học dân tộc.", 15),
    ("Gió Đầu Mùa", "Những truyện ngắn tinh tế, nhẹ nhàng và giàu chất thơ về tình yêu thương con người của Thạch Lam.", 5),
    ("Nắng Trong Vườn", "Nét đẹp giản dị, trong ngần của con người và cảnh sắc Hà Nội xưa.", 5),
    ("Hà Nội Băm Sáu Phố Phường", "Tùy bút ẩm thực và phong vị văn hóa tao nhã của mảnh đất nghìn năm văn hiến.", 5)
]

# Category 2: Kinh tế & Kinh doanh (cat_id: 2)
kinhte_data = [
    ("Khởi Nghiệp Tinh Gọn (The Lean Startup)", "Phương pháp xây dựng doanh nghiệp đổi mới sáng tạo, thử nghiệm nhanh và tối ưu hóa chi phí.", 31),
    ("Từ Không Đến Một (Zero to One)", "Bí quyết kiến tạo những sản phẩm độc bản và xây dựng doanh nghiệp thống lĩnh tương lai.", 31),
    ("Gã Nghiện Giày (Shoe Dog)", "Hồi ký truyền cảm hứng về hành trình xây dựng đế chế thể thao Nike từ hai bàn tay trắng.", 31),
    ("Từ Tốt Đến Vĩ Đại (Good to Great)", "Nghiên cứu kinh điển giải mã bí quyết giúp các công ty bình thường vươn lên thành vĩ đại trường tồn.", 32),
    ("Xây Dựng Để Trường Tồn (Built to Last)", "Những thói quen thành công của các tập đoàn có tầm nhìn vĩ đại qua hàng thập kỷ.", 32),
    ("Nhà Đầu Tư Thông Minh (The Intelligent Investor)", "Cẩm nang đầu tư giá trị kinh điển của Benjamin Graham được Warren Buffett khuyên đọc.", 9),
    ("Cổ Phiếu Thường Lợi Nhuận Phi Thường", "Chiến lược lựa chọn doanh nghiệp tăng trưởng xuất sắc của huyền thoại Philip Fisher.", 9),
    ("Bước Đi Ngẫu Nhiên Trên Phố Wall", "Hướng dẫn đầu tư tài chính thông minh, cân bằng rủi ro và xây dựng danh mục bền vững.", 9),
    ("Tâm Lý Học Về Tiền - Những Bài Học Bất Biến", "Cách con người đưa ra quyết định tài chính và bản chất thực sự của sự thịnh vượng.", 9),
    ("Chiến Lược Đại Dương Xanh", "Cách thức tạo lập khoảng trống thị trường vô tranh và vô hiệu hóa đối thủ cạnh tranh.", 32),
    ("Marketing 5.0 - Công Nghệ Vị Nhân Sinh", "Chiến lược tiếp thị ứng dụng trí tuệ nhân tạo, tự động hóa và phân tích dữ liệu lớn.", 32),
    ("22 Quy Luật Bất Biến Trong Marketing", "Những nguyên lý cốt lõi bất di bất dịch định hình thành bại của mọi chiến dịch tiếp thị.", 32),
    ("Nghệ Thuật Lan Truyền (Contagious)", "Tại sao sản phẩm, ý tưởng và hành vi lại có sức lan tỏa mạnh mẽ trong cộng đồng.", 32),
    ("Bán Niềm Tin Mua Sự Trung Thành", "Bí quyết xây dựng trải nghiệm khách hàng vượt trội để biến người mua thành đại sứ thương hiệu.", 32),
    ("Quảng Cáo Theo Phong Cách Ogilvy", "Bậc thầy David Ogilvy chia sẻ bí quyết viết thông điệp quảng cáo thuyết phục hàng triệu người.", 32),
    ("Dốc Hết Trái Tim - Xây Dựng Đế Chế Starbucks", "Hành trình Howard Schultz biến quán cà phê nhỏ Seattle thành thương hiệu toàn cầu.", 31),
    ("Steve Jobs - Tiểu Sử Độc Quyền", "Chân dung chân thực về thiên tài công nghệ đã định hình lại 6 ngành công nghiệp thế giới.", 31),
    ("Elon Musk - Kẻ Kiến Tạo Tương Lai", "Hành trình liều lĩnh của người sáng lập Tesla, SpaceX và giấc mơ đưa nhân loại lên sao Hỏa.", 31),
    ("Tái Tạo Tổ Chức (Reinventing Organizations)", "Mô hình quản trị doanh nghiệp tự chủ, minh bạch và phát triển toàn diện con người.", 32),
    ("OKRs - Đo Lường Điều Quan Trọng", "Phương pháp quản trị mục tiêu then chốt được Google, Intel và các tập đoàn hàng đầu tin dùng.", 32),
    ("Bán Hàng Cho Người Khổng Lồ", "Chiến thuật chốt các hợp đồng B2B giá trị triệu đô với các tập đoàn đa quốc gia.", 37),
    ("Nghệ Thuật Bán Hàng Bậc Cao", "Phương pháp tiếp cận, thuyết phục và xây dựng mối quan hệ tin cậy với khách hàng khó tính.", 2),
    ("Kỹ Năng Đàm Phán Thương Lượng Đỉnh Cao", "Bí quyết đàm phán win-win đem lại lợi thế tối đa trong mọi cuộc thương thảo thương mại.", 2),
    ("Người Giàu Có Nhất Thành Babylon", "Những bài học tiết kiệm, đầu tư và giữ tiền thông minh từ nền văn minh cổ đại.", 8),
    ("Cha Giàu Cha Nghèo - Tập 1: Để Không Có Tiền Vẫn Tạo Ra Tiền", "Tư duy tài chính đột phá về tài sản, tiêu sản và tự do tài chính cá nhân.", 8),
    ("Cha Giàu Cha Nghèo - Tập 2: Sử Dụng Đồng Vốn", "Bí quyết chuyển dịch từ nhóm người làm thuê sang nhóm chủ doanh nghiệp và nhà đầu tư.", 8),
    ("Cha Giàu Cha Nghèo - Tập 3: Hướng Dẫn Đầu Tư", "Cẩm nang hướng dẫn cách tư duy và hành động như một nhà đầu tư chuyên nghiệp.", 8),
    ("Cha Giàu Cha Nghèo - Tập 4: Nghỉ Hưu Sớm Nghỉ Hưu Giàu", "Lộ trình đạt độc lập tài chính và tự do cuộc sống ở độ tuổi thanh xuân.", 8),
    ("Cha Giàu Cha Nghèo - Tập 5: Doanh Nghiệp Của Thế Kỷ 21", "Mô hình kinh doanh mạng lưới và kinh tế kết nối hiện đại.", 8),
    ("Thuật Quản Trị Vốn Dành Cho Nhà Đầu Tư", "Cách phân bổ dòng tiền, quản trị rủi ro thanh khoản và bảo toàn lợi nhuận bền vững.", 9),
    ("Báo Cáo Tài Chính Dưới Góc Nhìn Của Warren Buffett", "Hướng dẫn phân tích bảng cân đối kế toán và báo cáo lưu chuyển tiền tệ chuẩn xác.", 9),
    ("Tư Duy Đặt Cược - Nghệ Thuật Quyết Định", "Cách các cao thủ poker và nhà đầu tư ra quyết định chính xác trong môi trường bất định.", 10),
    ("Bản Đồ Chiến Lược Doanh Nghiệp", "Công cụ biến tầm nhìn trừu tượng thành các bước hành động cụ thể cho toàn bộ nhân sự.", 32),
    ("Văn Hóa Doanh Nghiệp Thời Kỳ Bất Định", "Cách giữ chân nhân tài và duy trì sức bật tổ chức vượt qua các cuộc khủng hoảng kinh tế.", 31)
]

# Category 3: Tâm lý & Kỹ năng sống (cat_id: 3)
kynang_data = [
    ("Atomic Habits - Thay Đổi Tí Hon Hiệu Quả Bất Ngờ", "Hệ thống xây dựng thói quen tốt và loại bỏ thói quen xấu dựa trên khoa học hành vi.", 4),
    ("Sức Mạnh Của Thói Quen (The Power of Habit)", "Vòng lặp thói quen: Gợi ý, Hành động, Phần thưởng và bí quyết tái lập trình não bộ.", 4),
    ("Deep Work - Làm Ra Làm Chơi Ra Chơi", "Nghệ thuật tập trung cao độ trong một thế giới đầy xao nhãng để tạo ra giá trị đột phá.", 38),
    ("Digital Minimalism - Sống Tối Giản Thời Công Nghệ", "Cách giải phóng bản thân khỏi nghiện mạng xã hội và lấy lại sự tập trung thanh thản.", 38),
    ("Tư Duy Nhanh Và Chậm (Thinking, Fast and Slow)", "Hai hệ thống tư duy chi phối mọi quyết định và những cạm bẫy định kiến nhận thức.", 10),
    ("7 Thói Quen Để Thành Đạt (The 7 Habits)", "Nguyên lý phát triển nhân cách toàn diện và năng lực lãnh đạo từ bên trong.", 2),
    ("Đắc Nhân Tâm (Khổ Lớn Đặc Biệt)", "Nghệ thuật thu phục lòng người, tạo dựng thiện cảm và xây dựng quan hệ bền vững.", 2),
    ("Quẳng Gánh Lo Đi Và Vui Sống", "Bí quyết xua tan âu lo, làm chủ căng thẳng và tận hưởng cuộc sống trọn vẹn mỗi ngày.", 2),
    ("Khéo Ăn Nói Sẽ Có Được Thiên Hạ", "Kỹ năng giao tiếp ứng biến linh hoạt trong công sở, gia đình và các mối quan hệ xã hội.", 2),
    ("Nghệ Thuật Lắng Nghe Trong Giao Tiếp", "Sức mạnh của sự tĩnh lặng và thấu hiểu chiều sâu cảm xúc đối phương.", 2),
    ("Đọc Vị Bất Kỳ Ai - Để Không Bị Thao Túng", "Nhận biết ngôn ngữ cơ thể, vi biểu cảm và nắm bắt tâm lý người đối diện chuẩn xác.", 2),
    ("Thôi Miên Bằng Ngôn Từ", "Nghệ thuật sử dụng từ ngữ ma lực để lay động cảm xúc và thuyết phục người nghe.", 2),
    ("Câu Lạc Bộ 5 Giờ Sáng", "Thói quen làm chủ buổi sáng để nâng tầm cuộc sống, kích hoạt năng lượng và sự sáng tạo.", 36),
    ("Nhà Sư Bán Chiếc Ferrari", "Hành trình tìm về chân giá trị cuộc sống, bình an tâm hồn và ý nghĩa đích thực của sự tồn tại.", 36),
    ("Thuật Thao Túng Tâm Lý & Nhận Diện Thao Túng", "Cách nhận biết các chiêu trò gaslighting và bảo vệ ranh giới cá nhân lành mạnh.", 10),
    ("Sức Bền (Grit) - Sức Mạnh Của Niềm Đam Mê", "Tại sao sự kiên trì bền bỉ lại quyết định thành công hơn tài năng bẩm sinh.", 4),
    ("Kỷ Luật Tự Giác - Vũ Khí Của Kẻ Mạnh", "Cách chiến thắng sự trì hoãn và duy trì thói quen tự giác sắt đá.", 37),
    ("Hoàn Thành Mọi Việc Không Hề Khó (GTD)", "Phương pháp tổ chức công việc và dọn dẹp tâm trí để đạt hiệu suất tối đa.", 37),
    ("Làm Chủ Tư Duy Thay Đổi Vận Mệnh", "Phương pháp lập trình ngôn ngữ tư duy NLP để khai phóng tiềm năng ẩn giấu.", 4),
    ("An Lạc Từng Bước Chân", "Thực hành chánh niệm trong từng hơi thở, bước đi để tìm thấy an lạc giữa cuộc sống bộn bề.", 33),
    ("Giận - Chuyển Hóa Cơn Giận Bằng Yêu Thương", "Phương thuốc diệu kỳ làm dịu tâm can và chuyển hóa năng lượng tiêu cực.", 33),
    ("Hiểu Về Trái Tim", "Tác phẩm soi rọi từng ngõ ngách cảm xúc: Yêu, Ghét, Đau Khổ, Bao Dung và Hạnh Phúc.", 33),
    ("Không Diệt Không Sinh Đừng Sợ Hãi", "Lời khai thị nhẹ nhàng về sự vô thường của kiếp nhân sinh và giải phóng nỗi sợ cái chết.", 33),
    ("Nghệ Thuật Sống Khắc Kỷ", "Triết lý sống kiên cường, thản nhiên trước nghịch cảnh và làm chủ những gì trong tầm kiểm soát.", 34),
    ("Suy Tưởng (Meditations - Marcus Aurelius)", "Nhật ký nội tâm của vị hoàng đế La Mã về nghĩa vụ, sự khiêm nhường và kỷ luật tự thân.", 34),
    ("Chủ Nghĩa Tối Giản Trong Lối Sống", "Bỏ bớt đồ đạc để giải phóng không gian, dọn dẹp tâm trí để chào đón niềm vui bình dị.", 4),
    ("Tìm Lại Chính Mình", "Hành trình chữa lành những tổn thương thơ ấu và thiết lập mối liên kết sâu sắc với bản ngã.", 33),
    ("Cân Bằng Cảm Xúc Lúc Bão Giông", "Cách thức xoa dịu những cơn hoảng loạn, âu lo và lấy lại sự tự tin nội tại.", 2)
]

# Category 4: Công nghệ & Lập trình (cat_id: 4)
tech_data = [
    ("Clean Code - Mã Sạch Trong Lập Trình", "Quy chuẩn viết code dễ đọc, dễ bảo trì và loại bỏ code smell của huyền thoại Uncle Bob.", 19),
    ("Clean Architecture - Kiến Trúc Phần Mềm Sạch", "Cấu trúc hệ thống phần mềm độc lập với framework, UI, cơ sở dữ liệu và ngoại vi.", 19),
    ("Refactoring - Cải Thiện Thiết Kế Mã Nguồn Hiện Có", "Kỹ thuật tái cấu trúc code an toàn với các mẫu chuyển đổi kinh điển của Martin Fowler.", 20),
    ("The Pragmatic Programmer - Lập Trình Viên Thực Dụng", "Lời khuyên thực chiến quý giá từ tư duy nghề nghiệp đến kỹ thuật coding đỉnh cao.", 19),
    ("Head First Design Patterns - Các Mẫu Thiết Kế", "Học các mẫu thiết kế hướng đối tượng qua hình ảnh trực quan, dí dỏm và dễ tiếp thu.", 19),
    ("Designing Data-Intensive Applications", "Cuốn sách gối đầu giường về thiết kế hệ thống dữ liệu phân tán quy mô lớn.", 19),
    ("Building Microservices - Thiết Kế Hệ Thống Độc Lập", "Kiến trúc microservice toàn diện: Phân tách domain, giao tiếp API, bảo mật và deploy.", 20),
    ("Microservices Patterns - Mẫu Kiến Trúc Thực Chiến", "Giải quyết các thách thức phân tán: Saga pattern, CQRS, Event Sourcing và Transactional Outbox.", 20),
    ("Machine Learning Yearning - Cẩm Nang Thực Chiến", "Andrew Ng chia sẻ kinh nghiệm định hướng và tối ưu hóa dự án học máy thực tế.", 21),
    ("Deep Learning - Học Sâu Với Python & PyTorch", "Toàn thư về mạng nơ-ron nhân tạo, CNN, RNN, Transformer và Generative AI.", 21),
    ("Prompt Engineering Thực Chiến Cho Lập Trình Viên", "Khai thác tối đa sức mạnh của LLM, ChatGPT và Gemini trong quy trình phát triển phần mềm.", 21),
    ("Data Science Từ Con Số 0", "Nền tảng toán học, thống kê, giải thuật và phân tích dữ liệu ứng dụng bằng Python.", 21),
    ("Lập Trình Python Nâng Cao & Tối Ưu Hiệu Năng", "Làm chủ Generators, Concurrency, Asyncio, Metaprogramming và tối ưu bộ nhớ.", 21),
    ("C# 12 & .NET 8/9/10 Thực Chiến", "Xây dựng Web API, Microservices và ứng dụng Cloud-native hiện đại với nền tảng .NET.", 19),
    ("Lập Trình Rust - Từ Cơ Bản Đến Hệ Thống An Toàn", "Khái niệm Ownership, Borrowing, Lifetimes và lập trình hệ thống không lo rò rỉ bộ nhớ.", 19),
    ("Golang Cho Hệ Thống Hiệu Năng Cao", "Xây dựng các backend chịu tải lớn, đồng thời cao với Goroutines và Channels.", 19),
    ("Docker & Kubernetes Toàn Thư", "Đóng gói ứng dụng container và quản trị điều phối cụm server sản xuất quy mô lớn.", 19),
    ("DevOps & CI/CD Hiện Đại Với GitHub Actions", "Tự động hóa kiểm thử, build và triển khai phần mềm liên tục lên hạ tầng Cloud.", 19),
    ("An Toàn Thông Tin & Phòng Ngự Mã Độc", "Nguyên lý an ninh mạng, kiểm thử xâm nhập (Penetration Testing) và bảo mật ứng dụng Web.", 19),
    ("Kiến Trúc Cloud-Native Với AWS & Azure", "Thiết kế các giải pháp điện toán đám mây co giãn linh hoạt, chịu lỗi cao và tối ưu chi phí.", 19),
    ("The Art of Computer Programming - Tập 1: Giải Thuật Căn Bản", "Bộ sách kinh điển vĩ đại của Donald Knuth về cấu trúc dữ liệu và giải thuật toán học.", 39),
    ("The Art of Computer Programming - Tập 2: Giải Thuật Bán Số Học", "Nghiên cứu chuyên sâu về số học ngẫu nhiên và phép toán số học máy tính.", 39),
    ("The Art of Computer Programming - Tập 3: Sắp Xếp & Tìm Kiếm", "Toàn thư về các thuật toán sắp xếp và tra cứu dữ liệu tối ưu nhất.", 39),
    ("CODE - Ngôn Ngữ Ẩn Giấu Đằng Sau Máy Tính", "Hành trình giải thích sinh động cách phần cứng và phần mềm máy tính thực sự hoạt động.", 19)
]

# Category 5: Lịch sử & Triết học (cat_id: 5)
lichsu_data = [
    ("Sapiens - Lược Sử Loài Người (Bản Đặc Biệt)", "Hành trình loài vượn người tầm thường thảo nguyên châu Phi trở thành bá chủ Trái Đất.", 3),
    ("Homo Deus - Lược Sử Tương Lai", "Dự báo tương lai khi con người làm chủ công nghệ sinh học và trí tuệ nhân tạo.", 3),
    ("21 Bài Học Cho Thế Kỷ 21", "Những câu hỏi cấp thiết về công nghệ, chính trị, tôn giáo và sự sống còn thời đại số.", 3),
    ("Súng, Vi Trùng Và Thép - Định Mệnh Các Xã Hội", "Giải mã tại sao các nền văn minh Á-Âu lại phát triển vượt bậc so với các châu lục khác.", 3),
    ("Việt Nam Sử Lược - Trần Trọng Kim", "Bộ thông sử Việt Nam đầu tiên viết bằng chữ quốc ngữ, mạch lạc và súc tích.", 15),
    ("Đại Việt Sử Ký Toàn Thư - Trọn Bộ", "Bộ quốc sử vĩ đại ghi chép lịch sử nước Việt từ thời Hồng Bàng đến thời Hậu Lê.", 15),
    ("Lịch Sử Văn Minh Thế Giới", "Toàn cảnh các nền văn minh Lưỡng Hà, Ai Cập, Hy Lạp, La Mã, Ấn Độ và Trung Hoa.", 3),
    ("Con Đường Tơ Lụa - Lịch Sử Mới Của Thế Giới", "Mạng lưới giao thương Á-Âu đã định hình sự chuyển dịch quyền lực và văn hóa nhân loại.", 3),
    ("Binh Pháp Tôn Tử & Tam Thập Lục Kế", "Bậc thầy mưu lược quân sự Tôn Vũ với nghệ thuật bất chiến tự nhiên thành.", 35),
    ("Đạo Đức Kinh - Lão Tử", "Triết lý Vô vi, hòa hợp với tự nhiên và sự uyển chuyển như nước của Đạo gia phương Đông.", 7),
    ("Nam Hoa Kinh - Trang Tử", "Những câu chuyện ngụ ngôn thâm thúy về tự do tuyệt đối của tâm hồn giữa cõi nhân gian.", 7),
    ("Cộng Hòa (Plato)", "Tác phẩm nền tảng của triết học chính trị phương Tây về công lý và nhà nước lý tưởng.", 3),
    ("Bàn Về Khế Ước Xã Hội (Rousseau)", "Tư tưởng tự do dân chủ và chủ quyền nhân dân mở đường cho Cách mạng Pháp.", 3),
    ("Nhập Môn Triết Học Phương Tây", "Hành trình tư tưởng từ Socrates, Plato, Descartes, Kant đến Nietzsche và Sartre.", 3),
    ("Lý Quang Diệu - Hồi Ký Xây Dựng Đất Nước", "Hành trình biến hòn đảo nhỏ nghèo nàn Singapore thành kỳ quan phát triển của thế giới.", 31)
]

# Category 6: Văn học Thiếu nhi (cat_id: 6)
thieunhi_data = [
    ("Dế Mèn Phiêu Lưu Ký (Ấn Bản Kỷ Niệm)", "Chuyến du hành khám phá thế giới rộng lớn và bài học kết nghĩa anh em của Dế Mèn.", 6),
    ("Chuyện Hoa Chuyện Quả", "Những câu chuyện cổ tích giải thích nguồn gốc các loài hoa quả thơm ngọt nước Nam.", 6),
    ("Góc Sân Và Khoảng Trời - Trần Đăng Khoa", "Những vần thơ hồn nhiên, trong trẻo như giọt sương mai của thần đồng thơ ca đất Việt.", 6),
    ("Hoàng Tử Bé (Le Petit Prince)", "Câu chuyện ngụ ngôn triết lý cảm động về tình bạn, hoa hồng và con mắt của trái tim.", 11),
    ("Alice Ở Xứ Sở Thần Tiên", "Cuộc phiêu lưu kỳ thú của cô bé Alice rơi vào hang thỏ tới thế giới phép thuật ngộ nghĩnh.", 6),
    ("Những Cuộc Phiêu Lưu Của Tom Sawyer", "Trò nghịch ngợm đáng yêu và lòng dũng cảm của chú bé Tom bên dòng sông Mississippi.", 6),
    ("Đảo Giấu Vàng - Robert Louis Stevenson", "Hành trình vượt đại dương tìm kho báu chôn giấu của thuyền trưởng Flint và cậu bé Jim Hawkins.", 6),
    ("Totto-chan Bên Cửa Sổ", "Trường tiểu học Tomoe kỳ diệu nơi các em học sinh được tự do phát triển nhân cách và năng khiếu.", 6),
    ("Không Gia Đình - Hector Malot", "Cuộc đời phiêu bạt đầy nghị lực và lòng hiếu thảo của chú bé mồ côi Remi.", 26),
    ("Trong Gia Đình - Hector Malot", "Nghị lực phi thường của cô bé Perrine vượt qua nghèo khó để tìm lại cội nguồn gia đình.", 26)
]

# Category 7: Khoa học & Vũ trụ (cat_id: 7)
khoahoc_data = [
    ("Lược Sử Thời Gian - Stephen Hawking", "Kiệt tác vật lý vũ trụ giải thích Big Bang, Lỗ đen và bản chất của không - thời gian.", 18),
    ("Vũ Trụ (Cosmos) - Carl Sagan", "Bản giao hưởng kỳ vĩ về 15 tỷ năm tiến hóa vũ trụ và vị thế của loài người giữa các vì sao.", 22),
    ("Vũ Trụ Trong Vỏ Hạt Dẻ", "Học thuyết M, siêu dây và cuộc truy tìm Lý thuyết Vạn vật thống nhất vũ trụ.", 18),
    ("Giai Điệu Bí Ẩn - Con Người Đã Tạo Ra Vũ Trụ Ra Sao", "Sự tương quan kỳ diệu giữa hằng số vũ trụ và sự tồn tại của sự sống thông minh.", 18),
    ("Bản Thiết Kế Vĩ Đại (The Grand Design)", "Vũ trụ tự hình thành từ hư vô theo các quy luật vật lý lượng tử mà không cần phép màu.", 18),
    ("Vật Lý Thiên Văn Cho Người Vội Vã (Neil deGrasse Tyson)", "Những hiểu biết cốt lõi về vũ trụ được giải thích súc tích, hóm hỉnh và dễ hiểu.", 22),
    ("Chắc Bạn Đùa, Feynman!", "Hồi ức hài hước, lập dị và đam mê khám phá của nhà vật lý lượng tử thiên tài Richard Feynman.", 40),
    ("Nguồn Gốc Các Loài - Charles Darwin", "Cuốn sách làm rung chuyển thế giới với học thuyết tiến hóa qua chọn lọc tự nhiên.", 3),
    ("Thế Giới Lượng Tử Kỳ Thú", "Khám phá nguyên lý bất định, hiện tượng chồng chập và máy tính lượng tử tương lai.", 40),
    ("Tương Lai Của Nhân Loại - Michio Kaku", "Hành trình di cư lên sao Hỏa, du hành liên sao và viễn cảnh bất tử công nghệ.", 22)
]

categories_pool = [
    (1, vanhoc_data, 180),
    (2, kinhte_data, 160),
    (3, kynang_data, 150),
    (4, tech_data, 120),
    (5, lichsu_data, 90),
    (6, thieunhi_data, 50),
    (7, khoahoc_data, 50)
]

total_target = sum(target for _, _, target in categories_pool)
print(f"Total target new books to generate: {total_target}")

# 4. Generate the 800 book records
generated_books = []
book_authors_records = []
current_book_id = 201

for cat_id, data_list, target_count in categories_pool:
    n_base = len(data_list)
    for i in range(target_count):
        base_title, base_desc, primary_author_id = data_list[i % n_base]
        
        # If looped, create realistic subtitle or edition
        loop_idx = i // n_base
        if loop_idx == 0:
            title = base_title
        elif loop_idx == 1:
            title = f"{base_title} (Tái bản có bổ sung)"
        elif loop_idx == 2:
            title = f"{base_title} - Ấn bản kỷ niệm"
        elif loop_idx == 3:
            title = f"{base_title} (Bìa cứng mỹ thuật)"
        else:
            title = f"{base_title} - Tập {loop_idx + 1}"

        # Clean title escaping
        title = title.replace("'", "''")
        desc = base_desc.replace("'", "''")

        # Generate unique ISBN
        # Format: 978-604-XXX-YYYY
        isbn = f"978-604-{cat_id:02d}{current_book_id:04d}"

        # Price calculation
        # Range 65,000 - 280,000 VND
        orig_price = random.choice([69000, 75000, 85000, 92000, 98000, 110000, 125000, 138000, 145000, 160000, 175000, 195000, 220000, 250000, 280000])
        has_discount = random.random() < 0.85
        if has_discount:
            discount_rate = random.choice([0.80, 0.82, 0.85, 0.88, 0.90])
            sale_price = int(round(orig_price * discount_rate, -3))
        else:
            sale_price = "NULL"

        stock = random.randint(15, 250)
        pages = random.randint(160, 680)
        year = random.choice([2019, 2020, 2021, 2022, 2023, 2024])
        lang = 'vi' if random.random() > 0.05 else 'en'
        cover = covers[current_book_id % len(covers)]
        pub_id = random.randint(1, 8)

        created_day = random.randint(1, 28)
        created_month = random.randint(1, 10)
        created_date = f"2026-{created_month:02d}-{created_day:02d} 10:00:00"

        generated_books.append({
            'id': current_book_id,
            'isbn': isbn,
            'title': title,
            'desc': desc,
            'orig_price': orig_price,
            'sale_price': sale_price,
            'stock': stock,
            'pages': pages,
            'year': year,
            'lang': lang,
            'cover': cover,
            'cat_id': cat_id,
            'pub_id': pub_id,
            'created_date': created_date
        })

        # BookAuthors
        book_authors_records.append((current_book_id, primary_author_id))
        # Random co-author for ~10% of books
        if random.random() < 0.12:
            co_author_id = random.randint(1, 40)
            if co_author_id != primary_author_id:
                book_authors_records.append((current_book_id, co_author_id))

        current_book_id += 1

print(f"Generated {len(generated_books)} books. Last ID: {current_book_id - 1}")

# 5. Build SQL script
sql_lines = []
sql_lines.append("-- =====================================================================")
sql_lines.append("-- SEED SCRIPT: EXPAND BOOKSTORE DATABASE TO 1000 BOOKS")
sql_lines.append("-- =====================================================================")
sql_lines.append("USE [BookstoreDb];")
sql_lines.append("SET NOCOUNT ON;")
sql_lines.append("GO\n")

# A. Insert new Authors if not existing
sql_lines.append("-- 1. INSERT PROMINENT AUTHORS (IDs 26 to 40)")
sql_lines.append("SET IDENTITY_INSERT [dbo].[Authors] ON;")
for aid, aname, anation, abio in new_authors:
    aname_esc = aname.replace("'", "''")
    abio_esc = abio.replace("'", "''")
    sql_lines.append(f"""IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Id] = {aid})
BEGIN
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Nationality], [Biography])
    VALUES ({aid}, N'{aname_esc}', N'{anation}', N'{abio_esc}');
END;""")
sql_lines.append("SET IDENTITY_INSERT [dbo].[Authors] OFF;")
sql_lines.append("GO\n")

# B. Insert Books
sql_lines.append("-- 2. INSERT 800 NEW BOOKS (IDs 201 to 1000)")
sql_lines.append("SET IDENTITY_INSERT [dbo].[Books] ON;")
sql_lines.append("BEGIN TRANSACTION;")

batch_size = 50
for idx, b in enumerate(generated_books):
    sale_str = f"{b['sale_price']:.2f}" if b['sale_price'] != "NULL" else "NULL"
    sql_lines.append(f"""INSERT INTO [dbo].[Books] ([Id], [ISBN], [Title], [Description], [OriginalPrice], [SalePrice], [StockQuantity], [PageCount], [PublishYear], [Language], [CoverImageUrl], [IsAvailable], [CreatedAt], [CategoryId], [PublisherId])
VALUES ({b['id']}, N'{b['isbn']}', N'{b['title']}', N'{b['desc']}', {b['orig_price']:.2f}, {sale_str}, {b['stock']}, {b['pages']}, {b['year']}, N'{b['lang']}', N'{b['cover']}', 1, '{b['created_date']}', {b['cat_id']}, {b['pub_id']});""")
    
    if (idx + 1) % batch_size == 0 and (idx + 1) < len(generated_books):
        sql_lines.append("COMMIT TRANSACTION;")
        sql_lines.append("BEGIN TRANSACTION;")

sql_lines.append("COMMIT TRANSACTION;")
sql_lines.append("SET IDENTITY_INSERT [dbo].[Books] OFF;")
sql_lines.append("GO\n")

# C. Insert BookAuthors
sql_lines.append("-- 3. INSERT BOOK-AUTHOR RELATIONSHIPS")
sql_lines.append("BEGIN TRANSACTION;")
for idx, (bid, aid) in enumerate(book_authors_records):
    sql_lines.append(f"INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES ({bid}, {aid});")
    if (idx + 1) % 100 == 0 and (idx + 1) < len(book_authors_records):
        sql_lines.append("COMMIT TRANSACTION;")
        sql_lines.append("BEGIN TRANSACTION;")

sql_lines.append("COMMIT TRANSACTION;")
sql_lines.append("GO\n")

# D. Verify Final Count
sql_lines.append("-- 4. VERIFY FINAL DATABASE STATS")
sql_lines.append("SELECT COUNT(*) AS [FinalTotalBooks] FROM [dbo].[Books];")
sql_lines.append("SELECT COUNT(*) AS [FinalTotalAuthors] FROM [dbo].[Authors];")
sql_lines.append("SELECT c.Id, c.Name, COUNT(b.Id) AS BookCount FROM [dbo].[Categories] c LEFT JOIN [dbo].[Books] b ON b.CategoryId = c.Id GROUP BY c.Id, c.Name ORDER BY c.Id;")
sql_lines.append("GO\n")

output_file = 'scripts/seed_to_1000_books.sql'
with open(output_file, 'w', encoding='utf-8') as f:
    f.write('\n'.join(sql_lines))

print(f"Successfully generated {output_file} ({len(sql_lines)} lines).")
