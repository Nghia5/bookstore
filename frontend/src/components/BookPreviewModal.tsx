import { useState } from 'react'
import { X, ChevronLeft, ChevronRight, BookOpen, Sparkles } from 'lucide-react'
import type { Book } from '@/types'

interface BookPreviewModalProps {
  isOpen: boolean
  onClose: () => void
  book: Book | null
}

export default function BookPreviewModal({ isOpen, onClose, book }: BookPreviewModalProps) {
  const [currentPage, setCurrentPage] = useState(1)

  if (!isOpen || !book) return null

  const totalPages = 4

  const renderPageContent = () => {
    switch (currentPage) {
      case 1:
        return (
          <div className="flex flex-col items-center text-center space-y-6 py-6 animate-in fade-in duration-200">
            <div className="w-40 h-56 rounded-xl shadow-xl overflow-hidden border border-[#DDD6C4]">
              <img
                src={book.coverImageUrl || 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg'}
                alt={book.title}
                referrerPolicy="no-referrer"
                className="w-full h-full object-cover"
              />
            </div>
            <div>
              <span className="text-[11px] font-bold text-[#B84A39] uppercase tracking-wider block mb-1">
                Bản quyền tiếng Việt độc quyền
              </span>
              <h2 className="font-serif text-2xl font-bold text-[#191614] max-w-md mx-auto">
                {book.title}
              </h2>
              <p className="text-sm font-medium text-[#706B65] mt-1">
                Tác giả: {book.authors?.map(a => a.name).join(', ') || 'Nhiều tác giả'}
              </p>
              {book.isbn && (
                <p className="text-xs text-[#8C857B] font-mono mt-2">
                  ISBN: {book.isbn} • Năm xuất bản: {book.publishYear || 2024}
                </p>
              )}
            </div>
            <div className="p-4 rounded-2xl bg-[#F5F3ED] border border-[#DDD6C4] text-xs text-[#615C56] max-w-lg leading-relaxed italic">
              "Cuốn sách bạn đang cầm trên tay là kết tinh của trí tuệ, lòng nhiệt thành và tình yêu sâu sắc đối với tri thức."
            </div>
          </div>
        )

      case 2:
        return (
          <div className="space-y-6 py-4 animate-in fade-in duration-200">
            <div className="border-b border-[#DDD6C4] pb-3 text-center">
              <span className="text-xs font-bold text-[#B84A39] uppercase tracking-widest block">Nội dung tuyển chọn</span>
              <h3 className="font-serif text-xl font-bold text-[#191614]">Mục Lục Tác Phẩm</h3>
            </div>
            <div className="space-y-3 font-serif text-sm text-[#423E3A]">
              <div className="flex justify-between border-b border-dotted border-[#DDD6C4] pb-1">
                <span>Lời giới thiệu & Lời người dịch</span>
                <span className="font-mono text-xs text-[#8C857B]">Trang 7</span>
              </div>
              <div className="flex justify-between border-b border-dotted border-[#DDD6C4] pb-1">
                <span>Phần I: Khởi nguyên của những chuyến đi và giấc mơ</span>
                <span className="font-mono text-xs text-[#8C857B]">Trang 21</span>
              </div>
              <div className="flex justify-between border-b border-dotted border-[#DDD6C4] pb-1">
                <span>Phần II: Đối diện thử thách & Bài học từ sa mạc</span>
                <span className="font-mono text-xs text-[#8C857B]">Trang 89</span>
              </div>
              <div className="flex justify-between border-b border-dotted border-[#DDD6C4] pb-1">
                <span>Phần III: Ngôn ngữ của vũ trụ và dấu hiệu định mệnh</span>
                <span className="font-mono text-xs text-[#8C857B]">Trang 165</span>
              </div>
              <div className="flex justify-between border-b border-dotted border-[#DDD6C4] pb-1">
                <span>Phần IV: Về đích & Kho báu thực sự ở chân trời</span>
                <span className="font-mono text-xs text-[#8C857B]">Trang 240</span>
              </div>
              <div className="flex justify-between border-b border-dotted border-[#DDD6C4] pb-1">
                <span>Lời bạt & Phụ lục tư liệu</span>
                <span className="font-mono text-xs text-[#8C857B]">Trang 312</span>
              </div>
            </div>
          </div>
        )

      case 3:
        return (
          <div className="space-y-4 py-4 animate-in fade-in duration-200">
            <div className="border-b border-[#DDD6C4] pb-3">
              <span className="text-xs font-bold text-[#B84A39] uppercase tracking-widest block">Lời Tựa Tác Giả</span>
              <h3 className="font-serif text-xl font-bold text-[#191614]">Âm vang của những trang viết</h3>
            </div>
            <div className="font-serif text-sm leading-relaxed text-[#2B2724] space-y-3 text-justify">
              <p>
                Khi bắt đầu đặt bút viết những dòng đầu tiên, tôi chỉ có một niềm tin duy nhất: Mỗi cuốn sách đều có một số phận riêng, và nó sẽ tìm đến đúng người cần nó vào đúng thời điểm thích hợp nhất trong cuộc đời.
              </p>
              <p>
                Thế giới này luôn chuyển động không ngừng với biết bao ồn ã và vội vã. Nhưng kỳ diệu thay, mỗi khi mở một trang sách ra, thời gian như lắng đọng lại. Ta được trò chuyện với những tâm hồn vĩ đại vượt qua mọi rào cản thế kỷ và địa lý.
              </p>
              <p className="italic text-[#706B65]">
                {book.description || 'Tác phẩm truyền tải thông điệp sâu sắc về cuộc sống, đánh thức đam mê và khát vọng vươn lên trong tâm thức mỗi người đọc.'}
              </p>
            </div>
          </div>
        )

      case 4:
        return (
          <div className="space-y-4 py-4 animate-in fade-in duration-200">
            <div className="border-b border-[#DDD6C4] pb-3 text-center">
              <span className="text-xs font-bold text-[#B84A39] uppercase tracking-widest block">Chương Mở Đầu</span>
              <h3 className="font-serif text-xl font-bold text-[#191614]">Bước Chân Đầu Tiên</h3>
            </div>
            <div className="font-serif text-sm leading-relaxed text-[#2B2724] space-y-3 text-justify">
              <p className="first-letter:text-4xl first-letter:font-bold first-letter:text-[#B84A39] first-letter:mr-2 first-letter:float-left">
                Ánh bình minh bắt đầu rọi xuống những mái nhà cổ kính, sương sớm còn đọng trên từng tán lá. Trong khoảnh khắc tĩnh lặng ấy, một quyết định đã được đưa ra — một quyết định sẽ làm thay đổi hoàn toàn quỹ đạo của những ngày tháng phía trước.
              </p>
              <p>
                "Không có con đường nào là dễ dàng," người lữ khách già mỉm cười nói khẽ, mắt hướng về phía đường chân trời xa xôi. "Nhưng chính những ngã rẽ gập ghềnh mới tôi luyện nên một tâm hồn kiên cường và biết trân trọng cái đẹp."
              </p>
              <div className="mt-6 p-4 rounded-xl bg-amber-50 border border-amber-200 text-center space-y-2">
                <Sparkles className="w-5 h-5 text-amber-700 mx-auto" />
                <p className="text-xs font-semibold text-amber-900">
                  Bạn đang đọc thử 4 trang trích đoạn mẫu.
                </p>
                <p className="text-xs text-amber-800">
                  Hãy thêm sách vào giỏ hàng để thưởng thức trọn vẹn kiệt tác này nhé!
                </p>
              </div>
            </div>
          </div>
        )

      default:
        return null
    }
  }

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs">
      <div className="w-full max-w-xl bg-[#FAF8F3] rounded-3xl border border-[#DDD6C4] shadow-2xl overflow-hidden flex flex-col max-h-[92vh]">
        
        {/* Modal Top Bar */}
        <div className="px-6 py-4 bg-[#F2EFE9] border-b border-[#DDD6C4] flex items-center justify-between">
          <div className="flex items-center gap-2">
            <BookOpen className="w-4 h-4 text-[#B84A39]" />
            <span className="font-serif text-sm font-bold text-[#191614]">
              Đọc thử: {book.title}
            </span>
          </div>
          <button
            onClick={onClose}
            className="p-1.5 rounded-lg text-[#8C857B] hover:text-[#191614] hover:bg-[#EBE7DC] transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Book Page Frame */}
        <div className="flex-1 overflow-y-auto p-6 sm:p-8">
          <div className="min-h-[380px] flex flex-col justify-between">
            {renderPageContent()}
          </div>
        </div>

        {/* Modal Bottom Controls */}
        <div className="px-6 py-3.5 bg-[#F2EFE9] border-t border-[#DDD6C4] flex items-center justify-between">
          <button
            onClick={() => setCurrentPage(p => Math.max(1, p - 1))}
            disabled={currentPage === 1}
            className="px-3 py-1.5 rounded-xl border border-[#DDD6C4] bg-white text-xs font-semibold text-[#191614] flex items-center gap-1 hover:bg-[#FAF9F5] disabled:opacity-40 disabled:cursor-not-allowed transition-all"
          >
            <ChevronLeft className="w-4 h-4" />
            <span>Trang trước</span>
          </button>

          <span className="font-mono text-xs font-bold text-[#706B65]">
            Trang {currentPage} / {totalPages}
          </span>

          <button
            onClick={() => setCurrentPage(p => Math.min(totalPages, p + 1))}
            disabled={currentPage === totalPages}
            className="px-3 py-1.5 rounded-xl border border-[#DDD6C4] bg-white text-xs font-semibold text-[#191614] flex items-center gap-1 hover:bg-[#FAF9F5] disabled:opacity-40 disabled:cursor-not-allowed transition-all"
          >
            <span>Trang sau</span>
            <ChevronRight className="w-4 h-4" />
          </button>
        </div>

      </div>
    </div>
  )
}
