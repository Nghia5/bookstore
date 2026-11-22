using Bookstore.Domain.Entities;
using Bookstore.Infrastructure.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Text.RegularExpressions;

namespace Bookstore.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ChatController : ControllerBase
{
    private readonly BookstoreDbContext _context;

    public ChatController(BookstoreDbContext context)
    {
        _context = context;
    }

    [HttpPost]
    public async Task<IActionResult> ProcessMessage([FromBody] ChatRequest request)
    {
        if (string.IsNullOrWhiteSpace(request.Message))
        {
            return BadRequest(new { message = "Tin nhắn không được để trống." });
        }

        var userMsg = request.Message.Trim();
        var lowerMsg = userMsg.ToLowerInvariant();
        var normMsg = RemoveDiacritics(lowerMsg);

        // 1. Fetch relevant books from DB based on keyword
        var suggestedBooks = await SearchBooksForChat(normMsg);

        // 2. Generate intelligent human-like response
        var response = GenerateBotResponse(userMsg, lowerMsg, normMsg, suggestedBooks);

        return Ok(response);
    }

    private async Task<List<BookSuggestionDto>> SearchBooksForChat(string normMsg)
    {
        try
        {
            // Extract meaningful book or author search keywords
            var keywords = ExtractSearchTerms(normMsg);
            if (keywords.Count == 0) return new List<BookSuggestionDto>();

            var query = _context.Books
                .Include(b => b.Category)
                .Include(b => b.BookAuthors).ThenInclude(ba => ba.Author)
                .Include(b => b.Reviews)
                .Where(b => b.IsAvailable)
                .AsNoTracking();

            // Match against any keyword
            var candidates = await query
                .OrderByDescending(b => b.StockQuantity)
                .Take(50)
                .ToListAsync();

            var matched = candidates.Where(b =>
            {
                var normTitle = RemoveDiacritics(b.Title.ToLowerInvariant());
                var normAuthor = RemoveDiacritics(string.Join(" ", b.BookAuthors.Select(ba => ba.Author.Name)).ToLowerInvariant());
                var normCat = RemoveDiacritics((b.Category?.Name ?? "").ToLowerInvariant());

                return keywords.Any(k => normTitle.Contains(k) || normAuthor.Contains(k) || normCat.Contains(k));
            })
            .Take(4)
            .Select(b => new BookSuggestionDto
            {
                Id = b.Id,
                Title = b.Title,
                AuthorNames = string.Join(", ", b.BookAuthors.Select(ba => ba.Author.Name)),
                CategoryName = b.Category?.Name ?? "Sách chọn lọc",
                OriginalPrice = b.OriginalPrice,
                SalePrice = b.SalePrice,
                CoverImageUrl = b.CoverImageUrl,
                AverageRating = b.Reviews.Any() ? Math.Round(b.Reviews.Average(r => r.Rating), 1) : 5.0
            })
            .ToList();

            return matched;
        }
        catch
        {
            return new List<BookSuggestionDto>();
        }
    }

    private List<string> ExtractSearchTerms(string normMsg)
    {
        var terms = new List<string>();

        // Check author names
        if (normMsg.Contains("nguyen nhat anh")) terms.Add("nguyen nhat anh");
        if (normMsg.Contains("to hoai")) terms.Add("to hoai");
        if (normMsg.Contains("paulo coelho")) terms.Add("paulo coelho");
        if (normMsg.Contains("dale carnegie")) terms.Add("dale carnegie");
        if (normMsg.Contains("harari") || normMsg.Contains("yuval")) terms.Add("harari");
        if (normMsg.Contains("james clear")) terms.Add("james clear");
        if (normMsg.Contains("nguyen phong") || normMsg.Contains("john vu")) terms.Add("nguyen phong");

        // Check book titles
        if (normMsg.Contains("nha gia kim")) terms.Add("nha gia kim");
        if (normMsg.Contains("dac nhan tam")) terms.Add("dac nhan tam");
        if (normMsg.Contains("sapiens")) terms.Add("sapiens");
        if (normMsg.Contains("atomic habits")) terms.Add("atomic");
        if (normMsg.Contains("de men")) terms.Add("de men");
        if (normMsg.Contains("mat biec")) terms.Add("mat biec");
        if (normMsg.Contains("cho toi xin mot ve")) terms.Add("ve di tuoi tho");
        if (normMsg.Contains("clean code")) terms.Add("clean code");
        if (normMsg.Contains("muon kiep nhan sinh")) terms.Add("muon kiep");
        if (normMsg.Contains("khong gia dinh")) terms.Add("khong gia dinh");
        if (normMsg.Contains("hoang tu be")) terms.Add("hoang tu be");
        if (normMsg.Contains("rung na uy")) terms.Add("na uy");

        // Check categories
        if (normMsg.Contains("lap trinh") || normMsg.Contains("cong nghe") || normMsg.Contains("cntt") || normMsg.Contains("code")) terms.Add("cong nghe");
        if (normMsg.Contains("kinh te") || normMsg.Contains("kinh doanh") || normMsg.Contains("tai chinh") || normMsg.Contains("dau tu")) terms.Add("kinh te");
        if (normMsg.Contains("ky nang") || normMsg.Contains("tam ly") || normMsg.Contains("giao tiep")) terms.Add("ky nang");
        if (normMsg.Contains("van hoc") || normMsg.Contains("tieu thuyet") || normMsg.Contains("truyen")) terms.Add("van hoc");
        if (normMsg.Contains("lich su") || normMsg.Contains("triet hoc")) terms.Add("lich su");
        if (normMsg.Contains("thieu nhi") || normMsg.Contains("tre em") || normMsg.Contains("truyen tranh")) terms.Add("thieu nhi");
        if (normMsg.Contains("khoa hoc") || normMsg.Contains("vu tru") || normMsg.Contains("thien van")) terms.Add("khoa hoc");

        return terms;
    }

    private ChatResponse GenerateBotResponse(string originalMsg, string lowerMsg, string normMsg, List<BookSuggestionDto> books)
    {
        var quickReplies = new List<string>
        {
            "🌟 Gợi ý sách bán chạy",
            "📚 Có những thể loại nào?",
            "🚚 Phí ship & thời gian nhận",
            "🎁 Xem các mã giảm giá",
            "💎 Cách dùng điểm tích lũy"
        };

        // 1. Chào hỏi
        if (IsMatch(normMsg, "chao", "hello", "hi ", "hi!", "alo", "co ai khong", "ban la ai", "ten gi", "tro ly"))
        {
            return new ChatResponse
            {
                Reply = "Dạ em chào anh/chị ạ! Em là **Mai - Trợ lý tư vấn độc giả** của Bookstore Tiệm Sách Tri Thức. 📖✨\n\nEm có thể hỗ trợ anh/chị:\n- 🔍 **Tìm kiếm và gợi ý sách** trong kho hơn 1.000 đầu sách chọn lọc.\n- 🏷️ **Kiểm tra 7 thể loại sách** và thông tin các tác giả nổi tiếng.\n- 🎁 **Cung cấp mã giảm giá & voucher** ưu đãi hôm nay.\n- 🚚 **Giải đáp chính sách giao hàng, đổi trả** và hướng dẫn đặt hàng.\n\nAnh/chị đang muốn tìm đọc cuốn sách nào hay cần em gợi ý chủ đề gì ạ?",
                QuickReplies = quickReplies
            };
        }

        // 2. Hỏi về số lượng sách / quy mô
        if (IsMatch(normMsg, "bao nhieu sach", "so luong sach", "kho sach", "quy mo", "co nhieu sach khong"))
        {
            return new ChatResponse
            {
                Reply = "Dạ hiện tại Bookstore Tiệm Sách Tri Thức đang phục vụ bạn đọc hơn **1.000 đầu sách** chính hãng chọn lọc, được chia đều thành **7 thể loại** lớn:\n\n" +
                        "1. 📖 **Văn học** (~225 đầu sách): Nguyễn Nhật Ánh, Paulo Coelho, Tô Hoài, Victor Hugo...\n" +
                        "2. 📈 **Kinh tế** (~200 đầu sách): Tài chính, khởi nghiệp, quản trị doanh nghiệp, đầu tư.\n" +
                        "3. 🧠 **Kỹ năng sống** (~190 đầu sách): Atomic Habits, Đắc Nhân Tâm, tâm lý giao tiếp.\n" +
                        "4. 💻 **Công nghệ** (~155 đầu sách): Lập trình, AI, Clean Code, bảo mật, DevOps.\n" +
                        "5. 🏛️ **Lịch sử** (~115 đầu sách): Sapiens, lịch sử Việt Nam và văn minh thế giới.\n" +
                        "6. 🎈 **Thiếu nhi** (~65 đầu sách): Dế Mèn Phiêu Lưu Ký, cổ tích, đồng thoại.\n" +
                        "7. 🔭 **Khoa học** (~50 đầu sách): Vũ trụ, thiên văn, sinh học, khám phá tự nhiên.\n\n" +
                        "Anh/chị muốn khám phá sâu hơn về thể loại nào ạ?",
                QuickReplies = new List<string> { "📖 Sách Văn học hay", "💻 Sách Lập trình CNTT", "📈 Sách Kinh tế", "🧠 Sách Kỹ năng sống" }
            };
        }

        // 3. Hỏi về thể loại / danh mục
        if (IsMatch(normMsg, "the loai", "danh muc", "chu de", "cac loai sach"))
        {
            return new ChatResponse
            {
                Reply = "Dạ, Tiệm Sách Tri Thức hiện có **7 thể loại sách** tiêu chuẩn để anh/chị lựa chọn:\n\n" +
                        "• **Văn học:** Tiểu thuyết kinh điển, văn học Việt Nam và thế giới.\n" +
                        "• **Kinh tế:** Khởi nghiệp, thị trường chứng khoán, quản trị và tư duy tài chính.\n" +
                        "• **Kỹ năng sống:** Phát triển bản thân, xây dựng thói quen và nghệ thuật sống.\n" +
                        "• **Công nghệ:** Khoa học máy tính, trí tuệ nhân tạo, an toàn thông tin và lập trình.\n" +
                        "• **Lịch sử:** Dấu ấn lịch sử Việt Nam, biên niên sử thế giới và khảo cứu.\n" +
                        "• **Thiếu nhi:** Nuôi dưỡng trí tưởng tượng và bài học làm người cho thiếu nhi.\n" +
                        "• **Khoa học:** Tri thức thường thức, vật lý đại chúng và bí ẩn vũ trụ.\n\n" +
                        "Anh/chị có thể bấm chọn một chủ đề bên dưới để em gợi ý những cuốn nổi bật nhất nhé!",
                QuickReplies = new List<string> { "📖 Xem sách Văn học", "📈 Xem sách Kinh tế", "💻 Xem sách Công nghệ", "🧠 Xem sách Kỹ năng" }
            };
        }

        // 4. Hỏi về Phí ship / Thời gian giao hàng
        if (IsMatch(normMsg, "phi ship", "phi van chuyen", "ship", "giao hang", "freeship", "bao lau", "nhan hang"))
        {
            return new ChatResponse
            {
                Reply = "Dạ, chính sách giao hàng của Bookstore rất rõ ràng và ưu đãi ạ: 🚚\n\n" +
                        "• 📦 **Phí vận chuyển chuẩn:** Đồng giá **30.000 đ** trên toàn quốc.\n" +
                        "• 🎁 **Miễn phí vận chuyển (Freeship):** Đơn hàng từ **300.000 đ** trở lên sẽ được **tự động miễn phí giao hàng 100%**!\n" +
                        "• ⏱️ **Thời gian nhận hàng:** Từ **2 - 3 ngày làm việc** (giao qua bưu tá GHTK / Viettel Post Express).\n" +
                        "• 🛡️ **Quy cách đóng gói:** Mỗi cuốn sách đều được bọc chống sốc 2 lớp và đóng hộp carton cứng cáp để bảo vệ bìa sách nguyên vẹn khi đến tay anh/chị ạ.",
                QuickReplies = new List<string> { "🎁 Xem mã Freeship", "💳 Phương thức thanh toán", "🔄 Chính sách đổi trả" }
            };
        }

        // 5. Hỏi về Phương thức thanh toán
        if (IsMatch(normMsg, "thanh toan", "cod", "chuyen khoan", "vnpay", "tien mat", "tra tien"))
        {
            return new ChatResponse
            {
                Reply = "Dạ, Bookstore hỗ trợ 2 phương thức thanh toán an toàn và tiện lợi: 💳💵\n\n" +
                        "1. 💵 **Thanh toán khi nhận hàng (COD):** Anh/chị được nhận sách tận tay, kiểm tra gói hàng rồi mới thanh toán tiền mặt cho shipper.\n" +
                        "2. 💳 **Thanh toán trực tuyến / Chuyển khoản (VnPay/QR):** Thao tác nhanh gọn qua ngân hàng hoặc ví điện tử, đơn hàng sẽ được kích hoạt xử lý đóng gói ngay lập tức.\n\n" +
                        "Cả 2 hình thức đều hoàn toàn không phát sinh thêm bất kỳ chi phí phụ thu nào ạ!",
                QuickReplies = new List<string> { "🛒 Hướng dẫn đặt hàng", "🎁 Xem các voucher giảm giá", "🚚 Phí ship thế nào?" }
            };
        }

        // 6. Hỏi về Mã giảm giá / Voucher
        if (IsMatch(normMsg, "ma giam gia", "voucher", "khuyen mai", "coupon", "code", "giam gia", "uu dai"))
        {
            return new ChatResponse
            {
                Reply = "Dạ hiện tại Bookstore đang có các **mã giảm giá cực tốt** dành tặng độc giả: 🎁🎟️\n\n" +
                        "• `WELCOME10`: Giảm **10%** (tối đa 50k, đơn từ 100k - dành cho độc giả mới).\n" +
                        "• `FREESHIP`: Miễn phí vận chuyển **100%** (tối đa 30k, đơn từ 250k).\n" +
                        "• `TRIEUDOCGIA`: Giảm **15%** (tối đa 60k, đơn từ 200k).\n" +
                        "• `BOOKFEST50K`: Giảm **20%** (tối đa 50k, đơn từ 250k).\n" +
                        "• `TRIENTHO20`: Giảm **20%** (tối đa 80k, đơn từ 300k).\n" +
                        "• `BOOKSTORE10`: Giảm **10%** (tối đa 40k, đơn từ 150k).\n\n" +
                        "💡 **Mẹo:** Khi vào trang **Giỏ hàng**, anh/chị chỉ cần bấm vào các nút mã giảm giá có sẵn là hệ thống sẽ tự động áp dụng ngay ạ!",
                QuickReplies = new List<string> { "🛒 Vào xem giỏ hàng", "💎 Điểm tích lũy dùng sao?", "🌟 Gợi ý sách bán chạy" }
            };
        }

        // 7. Hỏi về Điểm tích lũy độc giả
        if (IsMatch(normMsg, "tich diem", "diem tich luy", "loyalty", "diem thuong", "diem de lam gi"))
        {
            return new ChatResponse
            {
                Reply = "Dạ, chương trình **Tích điểm Độc Giả Thân Thiết** tại Bookstore giúp anh/chị tiết kiệm tối đa khi mua sách: 💎✨\n\n" +
                        "• ⭐ **Tích lũy:** Cứ mỗi **1.000 đ** của đơn hàng đã giao thành công, tài khoản của anh/chị sẽ được cộng ngay **1 điểm**.\n" +
                        "• 💰 **Quy đổi:** **1 điểm = 100 đ** tiền mặt giảm trực tiếp vào đơn hàng kế tiếp.\n" +
                        "• 🎯 **Cách sử dụng:** Tại trang **Giỏ hàng**, anh/chị chỉ cần tick vào ô *'Dùng điểm tích lũy'*, hệ thống sẽ tự động trừ thẳng vào số tiền cần thanh toán ạ!\n\n" +
                        "Ví dụ: Anh/chị có 300 điểm sẽ được giảm ngay 30.000 đ!",
                QuickReplies = new List<string> { "🛒 Hướng dẫn đặt hàng", "🎁 Các mã giảm giá hiện có" }
            };
        }

        // 8. Hỏi về Đổi trả / Sách lỗi
        if (IsMatch(normMsg, "doi tra", "loi in", "rach sach", "mop meo", "bao hanh", "tra hang", "hong sach"))
        {
            return new ChatResponse
            {
                Reply = "Dạ anh/chị hoàn toàn yên tâm khi mua sách tại Bookstore nhé ạ! Bên em có chính sách **Bảo hành sách 100%**: 🛡️\n\n" +
                        "• 🔄 **Đổi mới trong 7 ngày:** Nếu sách có lỗi từ nhà sản xuất (thiếu trang, nhòe mực, ngược trang) hoặc bị móp méo, rách bìa do vận chuyển.\n" +
                        "• 🚚 **Chi phí đổi trả: Hoàn toàn MIỄN PHÍ 100%**, shipper sẽ đến tận nhà thu hồi sách lỗi và giao cuốn mới cho anh/chị.\n" +
                        "• ☎️ **Cách thức yêu cầu:** Anh/chị chỉ cần gọi Hotline **1900 6401** hoặc nhắn trực tiếp qua đây, nhân viên CSKH bên em sẽ hỗ trợ xử lý ngay trong 24h ạ!",
                QuickReplies = new List<string> { "📞 Thông tin liên hệ", "🚚 Chính sách giao hàng" }
            };
        }

        // 9. Hỏi Hướng dẫn đặt hàng
        if (IsMatch(normMsg, "cach dat hang", "huong dan mua", "mua the nao", "dat sach"))
        {
            return new ChatResponse
            {
                Reply = "Dạ, quy trình đặt sách tại Bookstore cực kỳ đơn giản gồm 5 bước sau ạ: 🛒\n\n" +
                        "1. **Bước 1:** Bấm **'Đăng nhập'** hoặc tạo tài khoản để được tích điểm độc giả.\n" +
                        "2. **Bước 2:** Chọn cuốn sách yêu thích và bấm **'Thêm vào giỏ'** (hoặc 'Mua ngay').\n" +
                        "3. **Bước 3:** Vào biểu tượng **Giỏ hàng**, tick chọn những cuốn sách muốn mua.\n" +
                        "4. **Bước 4:** Bấm chọn **Mã giảm giá** hoặc tick dùng **Điểm tích lũy**.\n" +
                        "5. **Bước 5:** Bấm **'Điền thông tin giao hàng'** -> Điền Tên, Số điện thoại, Địa chỉ nhận và bấm **'Xác nhận đặt hàng'**.\n\n" +
                        "Đơn hàng sẽ được chuyển tới bộ phận kho đóng gói ngay lập tức ạ!",
                QuickReplies = new List<string> { "🌟 Xem sách bán chạy", "🎁 Mã giảm giá hôm nay" }
            };
        }

        // 10. Hỏi Thông tin liên hệ / Cửa hàng
        if (IsMatch(normMsg, "dia chi", "tiem o dau", "hotline", "so dien thoai", "lien he", "email", "cua hang"))
        {
            return new ChatResponse
            {
                Reply = "Dạ, đây là thông tin chính thức của Tiệm Sách Bookstore Tri Thức: 📍📚\n\n" +
                        "• 🏛️ **Địa chỉ:** Số 59 Đỗ Quang, P. Trung Hòa, Q. Cầu Giấy, Hà Nội\n" +
                        "• ☎️ **Hotline tư vấn & CSKH:** **1900 6401** (Hoạt động 8:00 - 21:00 hàng ngày)\n" +
                        "• 📧 **Email:** `cskh@bookstore.vn`\n" +
                        "• 🌐 **Hệ thống:** Phục vụ giao sách tận nơi trên toàn bộ 63 tỉnh thành Việt Nam.\n\n" +
                        "Em luôn sẵn sàng hỗ trợ anh/chị bất cứ lúc nào ạ!",
                QuickReplies = quickReplies
            };
        }

        // 11. Nếu tìm thấy sách phù hợp từ DB
        if (books.Count > 0)
        {
            var bookNames = string.Join("\n", books.Select((b, idx) => $"{idx + 1}. **{b.Title}** - {b.AuthorNames} ({(b.SalePrice ?? b.OriginalPrice):N0} đ)"));
            return new ChatResponse
            {
                Reply = $"Dạ, theo yêu cầu của anh/chị, em tìm thấy **{books.Count} tựa sách** rất phù hợp và được đánh giá cao tại Tiệm Sách:\n\n{bookNames}\n\nAnh/chị có thể bấm trực tiếp vào thẻ sách bên dưới để xem chi tiết tóm tắt nội dung và đặt mua nhé ạ! 👇",
                SuggestedBooks = books,
                QuickReplies = new List<string> { "🛒 Xem giỏ hàng", "🎁 Mã giảm giá", "🚚 Phí ship bao nhiêu?" }
            };
        }

        // 12. Trường hợp mặc định / Trả lời linh hoạt
        return new ChatResponse
        {
            Reply = $"Dạ em ghi nhận câu hỏi của anh/chị về: *\"{originalMsg}\"*. 😊\n\n" +
                    "Tại Bookstore Tiệm Sách Tri Thức, tụi em luôn sẵn sàng hỗ trợ anh/chị tìm đúng tựa sách ưng ý nhất trong hơn 1.000 đầu sách thuộc các lĩnh vực Văn học, Kinh tế, Kỹ năng sống, Công nghệ, Lịch sử, Thiếu nhi và Khoa học.\n\n" +
                    "Anh/chị có thể nhắn cho em tên tác giả, tựa sách cụ thể, hoặc chọn nhanh các chủ đề bên dưới để em phục vụ chu đáo nhất nhé ạ!",
            QuickReplies = quickReplies
        };
    }

    private static bool IsMatch(string normMsg, params string[] patterns)
    {
        return patterns.Any(p => normMsg.Contains(p));
    }

    private static string RemoveDiacritics(string text)
    {
        if (string.IsNullOrWhiteSpace(text)) return "";
        var normalizedString = text.Normalize(System.Text.NormalizationForm.FormD);
        var stringBuilder = new System.Text.StringBuilder();

        foreach (var c in normalizedString)
        {
            var unicodeCategory = System.Globalization.CharUnicodeInfo.GetUnicodeCategory(c);
            if (unicodeCategory != System.Globalization.UnicodeCategory.NonSpacingMark)
            {
                stringBuilder.Append(c);
            }
        }

        var result = stringBuilder.ToString().Normalize(System.Text.NormalizationForm.FormC);
        result = result.Replace('đ', 'd').Replace('Đ', 'D');
        return result.ToLowerInvariant();
    }
}

public class ChatRequest
{
    public string Message { get; set; } = string.Empty;
    public List<ChatMessageDto>? History { get; set; }
}

public class ChatMessageDto
{
    public string Role { get; set; } = "user";
    public string Content { get; set; } = string.Empty;
}

public class ChatResponse
{
    public string Reply { get; set; } = string.Empty;
    public List<BookSuggestionDto> SuggestedBooks { get; set; } = new();
    public List<string> QuickReplies { get; set; } = new();
}

public class BookSuggestionDto
{
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string? AuthorNames { get; set; }
    public string? CategoryName { get; set; }
    public decimal OriginalPrice { get; set; }
    public decimal? SalePrice { get; set; }
    public string? CoverImageUrl { get; set; }
    public double AverageRating { get; set; }
}
