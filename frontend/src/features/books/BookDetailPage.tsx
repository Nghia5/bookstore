import { useState, useEffect } from 'react'
import { useParams, Link, useNavigate } from 'react-router-dom'
import { 
  Star, ShoppingBag, ArrowLeft, Truck, ShieldCheck, RefreshCw, 
  BookOpen, Heart, MessageSquare, Send, Sparkles, Ticket, Zap, Tag
} from 'lucide-react'
import { formatPrice } from '@/lib/utils'
import { useCartStore } from '@/stores/cartStore'
import { useAuthStore } from '@/stores/authStore'
import { toast } from 'sonner'
import { useWishlistStore } from '@/stores/wishlistStore'
import { useRequireAuth } from '@/lib/useRequireAuth'
import apiClient from '@/api/client'
import type { Book } from '@/types'
import BookPreviewModal from '@/components/BookPreviewModal'
import { cn } from '@/lib/utils'

const fallbackBooks: Record<number, Book> = {
  1: {
    id: 1,
    isbn: "978-604-1-16503-4",
    title: "Nhà Giả Kim (The Alchemist)",
    description: "Tất cả những trải nghiệm trong chuyến phiêu lưu theo đuổi vận mệnh của chàng chăn cừu Santiago đã giúp cậu thấu hiểu được ý nghĩa sâu xa nhất của hạnh phúc, hòa hợp với vũ trụ và con người. Cuốn sách như một câu chuyện cổ tích giản dị, trong trẻo, giàu chất thơ, thấm đẫm những minh triết huyền bí của phương Đông.",
    originalPrice: 89000,
    salePrice: 69000,
    stockQuantity: 120,
    pageCount: 228,
    publishYear: 2020,
    language: "Tiếng Việt",
    coverImageUrl: "https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg",
    isAvailable: true,
    authors: [{ id: 1, name: "Paulo Coelho", biography: "Nhà văn tiểu thuyết gia lừng danh người Brazil" }],
    category: { id: 1, name: "Văn học", slug: "van-hoc", bookCount: 245 },
    averageRating: 4.9
  },
  2: {
    id: 2,
    isbn: "978-604-58-9988-7",
    title: "Đắc Nhân Tâm (How to Win Friends and Influence People)",
    description: "Tác phẩm kinh điển vượt thời gian về nghệ thuật giao tiếp, thấu hiểu và kết nối con người. Từng trang sách chỉ ra những nguyên tắc xử thế chân thành và đầy lòng trắc ẩn.",
    originalPrice: 98000,
    salePrice: 78000,
    stockQuantity: 150,
    pageCount: 320,
    publishYear: 2021,
    language: "Tiếng Việt",
    coverImageUrl: "https://salt.tikicdn.com/cache/750x750/ts/product/a5/d9/38/c205391c530b4278adcb02c3ae945fa6.jpg",
    isAvailable: true,
    authors: [{ id: 2, name: "Dale Carnegie", biography: "Bậc thầy nghệ thuật thuyết phục nhân tâm" }],
    category: { id: 3, name: "Tâm lý & Kỹ năng sống", slug: "tam-ly-ky-nang-song", bookCount: 190 },
    averageRating: 5.0
  }
}

export default function BookDetailPage() {
  const { id } = useParams<{ id: string }>()
  const navigate = useNavigate()
  const bookId = Number(id) || 1
  const [book, setBook] = useState<Book>(fallbackBooks[bookId] || fallbackBooks[1])
  const [quantity, setQuantity] = useState(1)
  const addItem = useCartStore((s) => s.addItem)
  const { appliedVoucherCode, setAppliedVoucher } = useCartStore()
  const { isAuthenticated, user } = useAuthStore()
  const requireAuth = useRequireAuth()
  const { isInWishlist, toggleWishlist } = useWishlistStore()

  // Book preview modal state
  const [isPreviewOpen, setIsPreviewOpen] = useState(false)

  // Vouchers state
  const [availableVouchers, setAvailableVouchers] = useState<any[]>([])

  // Reviews state
  const [reviewsData, setReviewsData] = useState<{
    averageRating: number
    totalReviews: number
    starCounts: { star1: number; star2: number; star3: number; star4: number; star5: number }
    items: Array<{
      id: number
      userId: number
      userName: string
      rating: number
      comment?: string
      createdAt: string
    }>
  } | null>(null)

  const [newRating, setNewRating] = useState(5)
  const [newComment, setNewComment] = useState('')
  const [isSubmittingReview, setIsSubmittingReview] = useState(false)

  // Related books
  const [relatedBooks, setRelatedBooks] = useState<Book[]>([])

  const fetchReviews = async () => {
    try {
      const res = await apiClient.get(`/books/${bookId}/reviews`)
      setReviewsData(res.data)
    } catch (err) {
      console.error('Failed to load reviews:', err)
    }
  }

  useEffect(() => {
    // 1. Fetch book detail
    apiClient.get(`/books/${bookId}`)
      .then(res => {
        if (res.data) {
          setBook({
            ...res.data,
            coverImageUrl: res.data.coverImageUrl || fallbackBooks[bookId]?.coverImageUrl || fallbackBooks[1].coverImageUrl
          })
          
          // Fetch related books by category
          if (res.data.category?.id) {
            apiClient.get('/books', { params: { categoryId: res.data.category.id, pageSize: 4 } })
              .then(relRes => {
                if (relRes.data?.items) {
                  setRelatedBooks(relRes.data.items.filter((b: Book) => b.id !== bookId).slice(0, 4))
                }
              })
              .catch(() => {})
          }
        }
      })
      .catch(() => {})

    // 2. Fetch reviews
    fetchReviews()

    // 3. Fetch active vouchers
    apiClient.get('/discounts')
      .then(res => {
        if (res.data && res.data.length > 0) {
          setAvailableVouchers(res.data)
        }
      })
      .catch(() => {})
  }, [bookId])

  const handleAddToCart = () => {
    if (!isAuthenticated) { requireAuth(() => {}, 'Vui lòng đăng nhập để thêm sách vào giỏ hàng.'); return }
    addItem(book, quantity)
    toast.success(`Đã thêm ${quantity} cuốn "${book.title}" vào giỏ hàng`)
  }

  const handleBuyNow = () => {
    if (!isAuthenticated) { requireAuth(() => {}, 'Vui lòng đăng nhập để mua hàng.'); return }
    addItem(book, quantity)
    toast.success(`Đã chọn "${book.title}"! Đang chuyển đến thanh toán...`)
    navigate('/cart')
  }

  const handleSubmitReview = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!isAuthenticated) {
      toast.error('Vui lòng đăng nhập để gửi đánh giá tác phẩm.')
      return
    }

    try {
      setIsSubmittingReview(true)
      const res = await apiClient.post(`/books/${bookId}/reviews`, {
        rating: newRating,
        comment: newComment.trim()
      })
      toast.success(res.data?.message || 'Đã gửi đánh giá thành công!')
      setNewComment('')
      fetchReviews()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Không thể gửi nhận xét.')
    } finally {
      setIsSubmittingReview(false)
    }
  }

  const discountPercent = book.salePrice 
    ? Math.round(((book.originalPrice - book.salePrice) / book.originalPrice) * 100) 
    : 0

  const avgRating = reviewsData?.averageRating ?? book.averageRating ?? 4.9
  const totalReviewsCount = reviewsData?.totalReviews ?? (reviewsData?.items?.length || 0)

  return (
    <div className="mx-auto max-w-7xl px-4 py-10 sm:px-6 lg:px-8">
      <Link to="/books" className="inline-flex items-center gap-1.5 text-xs sm:text-sm text-[#B84A39] hover:underline transition-colors mb-6 font-semibold">
        <ArrowLeft className="h-4 w-4" />
        Quay lại tủ sách
      </Link>

      <div className="grid grid-cols-1 lg:grid-cols-12 gap-10 bg-white rounded-3xl p-6 sm:p-10 border border-[#EBE7DC] shadow-sm">
        
        {/* Book Cover Image & Look Inside */}
        <div className="lg:col-span-5 flex flex-col items-center">
          <div className="relative aspect-[3/4.2] w-full max-w-sm rounded-2xl overflow-hidden shadow-2xl border border-[#DDD6C4]">
            <img 
              src={book.coverImageUrl || 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg'} 
              alt={book.title} 
              referrerPolicy="no-referrer"
              onError={(e) => {
                (e.target as HTMLImageElement).src = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg'
              }}
              className="h-full w-full object-cover"
            />
            {discountPercent > 0 && (
              <span className="absolute top-3.5 right-3.5 bg-[#B84A39] text-white text-xs font-bold px-3 py-1 rounded-full shadow-md font-sans tabular-nums">
                TIẾT KIỆM {discountPercent}%
              </span>
            )}
          </div>

          {/* Look Inside Button */}
          <button
            onClick={() => setIsPreviewOpen(true)}
            className="mt-4 w-full max-w-sm py-2.5 px-4 rounded-xl border-2 border-[#191614] bg-[#FAF9F5] hover:bg-[#191614] text-[#191614] hover:text-white transition-all font-bold text-xs flex items-center justify-center gap-2 shadow-xs group"
          >
            <BookOpen className="w-4 h-4 text-[#B84A39] group-hover:text-white transition-colors" />
            <span>Đọc thử vài trang (Look Inside)</span>
            <Sparkles className="w-3.5 h-3.5 text-amber-500" />
          </button>

          <div className="mt-6 grid grid-cols-3 gap-3 w-full max-w-sm text-center">
            <div className="p-3 bg-[#F5F3ED] rounded-xl">
              <Truck className="h-4 w-4 text-[#B84A39] mx-auto mb-1" />
              <span className="text-[11px] font-semibold text-[#191614] block">Giao hỏa tốc</span>
            </div>
            <div className="p-3 bg-[#EBF2EB] rounded-xl">
              <ShieldCheck className="h-4 w-4 text-[#2D5A43] mx-auto mb-1" />
              <span className="text-[11px] font-semibold text-[#191614] block">100% Sách thật</span>
            </div>
            <div className="p-3 bg-[#F5F3ED] rounded-xl">
              <RefreshCw className="h-4 w-4 text-[#B84A39] mx-auto mb-1" />
              <span className="text-[11px] font-semibold text-[#191614] block">Đổi trả 7 ngày</span>
            </div>
          </div>
        </div>

        {/* Book Details */}
        <div className="lg:col-span-7 flex flex-col justify-between">
          <div>
            <div className="text-xs uppercase tracking-wider text-[#D97706] font-bold mb-2">
              {book.category?.name || 'Tác phẩm tuyển chọn'}
            </div>

            <h1 className="font-serif text-3xl sm:text-4xl font-bold text-[#191614] leading-tight mb-3">
              {book.title}
            </h1>

            <div className="flex flex-wrap items-center gap-4 text-xs sm:text-sm mb-5">
              <span className="text-[#615C56]">
                Tác giả:{' '}
                {book.authors && book.authors.length > 0 ? (
                  book.authors.map((a, idx) => (
                    <span key={a.id || idx}>
                      <Link
                        to={`/books?authorId=${a.id}&author=${encodeURIComponent(a.name)}`}
                        className="text-[#191614] font-bold hover:text-[#B84A39] hover:underline transition-colors"
                        title={`Xem tất cả tác phẩm của ${a.name}`}
                      >
                        {a.name}
                      </Link>
                      {idx < (book.authors?.length || 0) - 1 ? ', ' : ''}
                    </span>
                  ))
                ) : (
                  <strong className="text-[#191614]">Nhiều tác giả</strong>
                )}
              </span>

              <span className="text-[#DDD6C4]">•</span>

              <div className="flex items-center gap-1.5">
                <div className="flex items-center text-[#F59E0B]">
                  {[1, 2, 3, 4, 5].map((s) => (
                    <Star key={s} className="h-3.5 w-3.5 fill-[#F59E0B]" />
                  ))}
                </div>
                <span className="font-bold text-[#191614] font-sans tabular-nums text-xs">
                  {avgRating} ({totalReviewsCount} đánh giá)
                </span>
              </div>
            </div>

            {/* Pricing */}
            <div className="flex items-baseline gap-3 p-4 bg-[#FAF9F5] rounded-2xl border border-[#EBE7DC] mb-6">
              <span className="font-sans font-bold tabular-nums text-3xl sm:text-4xl text-[#B84A39]">
                {formatPrice(book.salePrice || book.originalPrice)}
              </span>
              {book.salePrice && (
                <span className="font-sans tabular-nums text-base text-[#8C857B] line-through">
                  {formatPrice(book.originalPrice)}
                </span>
              )}
              <span className="ml-auto text-xs font-semibold text-emerald-800 bg-emerald-50 border border-emerald-200 px-2.5 py-1 rounded-full font-sans tabular-nums">
                Còn {book.stockQuantity || 50} cuốn
              </span>
            </div>

            {/* VOUCHER & KHUYẾN MÃI CHO SÁCH NÀY */}
            <div className="p-4 rounded-2xl bg-amber-50/70 border border-amber-200/90 mb-6 space-y-3">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2">
                  <Ticket className="w-4 h-4 text-[#B84A39]" />
                  <span className="text-xs font-bold uppercase tracking-wider text-[#191614]">
                    Mã Giảm Giá &amp; Ưu Đãi Áp Dụng
                  </span>
                </div>
                <span className="text-[11px] font-semibold text-emerald-800 bg-emerald-100 px-2 py-0.5 rounded-full">
                  {availableVouchers.length || 4} mã khả dụng
                </span>
              </div>

              {/* Vouchers list */}
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                {(availableVouchers.length > 0 ? availableVouchers : [
                  { id: 1, code: 'WELCOME10', discountPercent: 10, minOrderAmount: 100000, maxDiscountAmount: 50000 },
                  { id: 2, code: 'BOOKFEST50K', discountPercent: 20, minOrderAmount: 250000, maxDiscountAmount: 50000 },
                  { id: 3, code: 'FREESHIP', discountPercent: 100, minOrderAmount: 250000, maxDiscountAmount: 30000 },
                  { id: 4, code: 'TRIEUDOCGIA', discountPercent: 15, minOrderAmount: 200000, maxDiscountAmount: 60000 }
                ]).map(v => {
                  const isApplied = appliedVoucherCode === v.code
                  return (
                    <div
                      key={v.id}
                      className={cn(
                        "flex items-center justify-between p-2.5 rounded-xl border transition-all text-xs",
                        isApplied 
                          ? "bg-white border-[#B84A39] shadow-xs ring-1 ring-[#B84A39]" 
                          : "bg-white/80 border-[#EBE7DC] hover:border-amber-300"
                      )}
                    >
                      <div className="min-w-0 pr-2">
                        <div className="flex items-center gap-1.5">
                          <span className="font-mono font-bold text-xs text-[#191614] tracking-wide">
                            {v.code}
                          </span>
                          <span className="text-[10px] font-bold text-emerald-700 bg-emerald-50 px-1.5 py-0.2 rounded border border-emerald-200">
                            -{v.discountPercent}%
                          </span>
                        </div>
                        <p className="text-[10px] text-[#706B65] mt-0.5 truncate">
                          {v.minOrderAmount ? `Đơn từ ${formatPrice(v.minOrderAmount)}` : 'Mọi đơn hàng'}
                        </p>
                      </div>

                      <button
                        type="button"
                        onClick={() => {
                          setAppliedVoucher(v.code)
                          toast.success(`Đã chọn mã ưu đãi ${v.code}!`)
                        }}
                        className={cn(
                          "px-2.5 py-1 rounded-lg text-[11px] font-bold transition-all shrink-0",
                          isApplied
                            ? "bg-emerald-600 text-white"
                            : "bg-[#191614] hover:bg-[#B84A39] text-white"
                        )}
                      >
                        {isApplied ? '✓ Đang chọn' : 'Áp dụng'}
                      </button>
                    </div>
                  )
                })}
              </div>

              {/* Active voucher notification */}
              <div className="pt-2 border-t border-amber-200/60 flex items-center justify-between text-xs text-amber-950">
                <span className="flex items-center gap-1 font-medium">
                  <Tag className="w-3.5 h-3.5 text-[#B84A39]" />
                  <span>Đang chọn mã: <strong className="font-mono font-bold text-[#B84A39]">{appliedVoucherCode || 'WELCOME10'}</strong></span>
                </span>
                <span className="text-[11px] text-[#706B65]">
                  Tự động giảm khi bấm Mua Ngay
                </span>
              </div>
            </div>

            {/* Description */}
            <div className="mb-6">
              <h3 className="text-xs font-bold uppercase tracking-wider text-[#8C857B] mb-2">
                Nội dung tác phẩm
              </h3>
              <p className="text-sm text-[#423E3A] leading-relaxed">
                {book.description}
              </p>
            </div>

            {/* Specifications */}
            <div className="grid grid-cols-3 gap-3 p-4 bg-[#FAFAF7] rounded-xl text-xs text-[#615C56] border border-[#EBE7DC] mb-6">
              <div>Mã ISBN: <strong className="text-[#191614] block mt-0.5 font-mono">{book.isbn}</strong></div>
              <div>Số trang: <strong className="text-[#191614] block mt-0.5 font-sans tabular-nums">{book.pageCount || 300} trang</strong></div>
              <div>Năm phát hành: <strong className="text-[#191614] block mt-0.5 font-sans tabular-nums">{book.publishYear || 2022}</strong></div>
            </div>
          </div>

          {/* Action buttons */}
          <div className="flex flex-col sm:flex-row gap-3 items-stretch pt-4 border-t border-[#F5F3ED]">
            <div className="flex items-center justify-between border border-[#DDD6C4] rounded-xl px-3 py-2 sm:w-28 bg-white shrink-0">
              <button 
                onClick={() => setQuantity(Math.max(1, quantity - 1))}
                className="text-lg font-bold text-[#615C56] hover:text-[#191614] px-1"
              >
                -
              </button>
              <span className="font-bold text-sm text-[#191614] font-sans tabular-nums">{quantity}</span>
              <button 
                onClick={() => setQuantity(quantity + 1)}
                className="text-lg font-bold text-[#615C56] hover:text-[#191614] px-1"
              >
                +
              </button>
            </div>

            <button
              onClick={handleAddToCart}
              className="flex-1 flex items-center justify-center gap-2 rounded-xl border-2 border-[#191614] bg-white hover:bg-[#FAF9F5] text-[#191614] py-3.5 px-4 font-bold text-xs sm:text-sm transition-all shadow-xs"
            >
              <ShoppingBag className="h-4 w-4 text-[#B84A39]" />
              <span>Thêm vào giỏ</span>
            </button>

            <button
              onClick={handleBuyNow}
              className="flex-1 flex items-center justify-center gap-2 rounded-xl bg-[#B84A39] hover:bg-[#9E3E2F] text-white py-3.5 px-4 font-bold text-xs sm:text-sm transition-all shadow-md hover:shadow-lg"
            >
              <Zap className="h-4 w-4 fill-white" />
              <span>Mua Ngay (Áp Mã)</span>
            </button>

            <button 
              onClick={() => requireAuth(() => {
                const fav = isInWishlist(book.id)
                toggleWishlist(book)
                toast.success(fav ? 'Đã bỏ khỏi danh sách yêu thích' : 'Đã lưu vào danh sách yêu thích!')
              }, 'Vui lòng đăng nhập để thêm vào danh sách yêu thích.')}
              className="p-3.5 rounded-xl border border-[#DDD6C4] hover:bg-[#F5F3ED] text-[#B84A39] transition-colors flex items-center justify-center shrink-0"
              title="Thêm vào danh sách yêu thích"
            >
              <Heart className={cn("h-5 w-5", isInWishlist(book.id) && "fill-current")} />
            </button>
          </div>

        </div>
      </div>

      {/* Reader Reviews & Rating Section */}
      <div className="mt-12 bg-white rounded-3xl p-6 sm:p-10 border border-[#EBE7DC] shadow-sm space-y-8">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-6 border-b border-[#F5F3ED]">
          <div>
            <h2 className="font-serif text-2xl font-bold text-[#191614] flex items-center gap-2.5">
              <BookOpen className="h-6 w-6 text-[#B84A39]" />
              Cảm nhận từ độc giả ({totalReviewsCount})
            </h2>
            <p className="text-xs text-[#706B65] mt-1">
              Đánh giá thực tế từ các độc giả đã mua và thưởng thức cuốn sách này.
            </p>
          </div>

          <div className="flex items-center gap-3 bg-[#FAF9F5] p-3 rounded-2xl border border-[#DDD6C4]">
            <span className="font-serif font-extrabold text-3xl text-[#191614] font-sans tabular-nums">{avgRating}</span>
            <div>
              <div className="flex items-center text-[#F59E0B]">
                {[1, 2, 3, 4, 5].map((s) => (
                  <Star key={s} className="h-3 w-3 fill-[#F59E0B]" />
                ))}
              </div>
              <span className="text-[10px] text-[#8C857B] font-medium font-sans tabular-nums">Dựa trên {totalReviewsCount} lượt chấm</span>
            </div>
          </div>
        </div>

        {/* Submit Review Form */}
        <form onSubmit={handleSubmitReview} className="bg-[#FAF9F5] p-5 rounded-2xl border border-[#EBE7DC] space-y-3">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2">
            <h4 className="text-xs font-bold text-[#191614] uppercase tracking-wider flex items-center gap-1.5">
              <MessageSquare className="w-4 h-4 text-[#B84A39]" />
              Viết cảm nhận của bạn về cuốn sách:
            </h4>
            
            {/* Interactive Star Picker */}
            <div className="flex items-center gap-1">
              <span className="text-xs text-[#706B65] mr-1">Chấm sao:</span>
              {[1, 2, 3, 4, 5].map((star) => (
                <button
                  type="button"
                  key={star}
                  onClick={() => setNewRating(star)}
                  className="p-1 hover:scale-110 transition-transform"
                >
                  <Star className={`w-4 h-4 ${star <= newRating ? 'fill-amber-400 text-amber-400' : 'text-zinc-300'}`} />
                </button>
              ))}
              <span className="font-bold text-xs text-[#191614] ml-1 font-sans tabular-nums">{newRating} sao</span>
            </div>
          </div>

          <textarea
            required
            rows={3}
            value={newComment}
            onChange={(e) => setNewComment(e.target.value)}
            placeholder={isAuthenticated ? "Chia sẻ cảm xúc hoặc bài học tâm đắc bạn đúc kết được từ cuốn sách này..." : "Vui lòng đăng nhập để viết nhận xét..."}
            disabled={!isAuthenticated}
            className="w-full text-xs rounded-xl border border-[#DDD6C4] p-3 outline-none focus:border-[#191614] bg-white resize-none"
          />

          <div className="flex items-center justify-between pt-1">
            {!isAuthenticated ? (
              <Link to="/login" className="text-xs text-[#B84A39] font-bold hover:underline">
                Đăng nhập ngay để bình luận →
              </Link>
            ) : (
              <span className="text-xs text-[#706B65]">Bình luận dưới tên: <strong>{user?.fullName}</strong></span>
            )}

            <button
              type="submit"
              disabled={isSubmittingReview || !isAuthenticated || !newComment.trim()}
              className="px-4 py-2 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-bold flex items-center gap-1.5 transition-colors disabled:opacity-50"
            >
              <Send className="w-3.5 h-3.5" />
              <span>{isSubmittingReview ? 'Đang gửi...' : 'Gửi Nhận Xét'}</span>
            </button>
          </div>
        </form>

        {/* Reviews List */}
        <div className="space-y-4 pt-2">
          {((reviewsData?.items) ?? []).map((r: any, idx: number) => (
            <div key={idx} className="border-b border-[#F5F3ED] pb-4 last:border-b-0 space-y-1.5">
              <div className="flex items-center justify-between">
                <span className="font-bold text-sm text-[#191614]">{r.userName || 'Bạn đọc ẩn danh'}</span>
                <span className="text-xs text-[#8C857B] font-sans tabular-nums">
                  {new Date(r.createdAt || Date.now()).toLocaleDateString('vi-VN')}
                </span>
              </div>
              <div className="flex items-center gap-1 text-[#F59E0B]">
                {[1, 2, 3, 4, 5].map((s) => (
                  <Star key={s} className={`h-3 w-3 ${s <= (r.rating || 5) ? 'fill-[#F59E0B] text-[#F59E0B]' : 'text-zinc-200'}`} />
                ))}
              </div>
              <p className="text-xs sm:text-sm text-[#423E3A] leading-relaxed">{r.comment}</p>
            </div>
          ))}
        </div>
      </div>

      {/* Frequently Bought Together & Related Books */}
      {relatedBooks.length > 0 && (
        <div className="mt-12 space-y-4">
          <div className="flex items-center justify-between">
            <h3 className="font-serif text-xl font-bold text-[#191614] flex items-center gap-2">
              <Sparkles className="w-5 h-5 text-amber-500" />
              Độc Giả Thường Mua Cùng (Gợi ý tuyển chọn)
            </h3>
            <Link to="/books" className="text-xs font-bold text-[#B84A39] hover:underline">
              Xem thêm sách khác →
            </Link>
          </div>

          <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
            {relatedBooks.map((b) => (
              <Link
                key={b.id}
                to={`/books/${b.id}`}
                className="group bg-white rounded-2xl border border-[#EBE7DC] p-3 shadow-xs hover:border-[#B84A39] transition-all flex flex-col justify-between"
              >
                <div className="aspect-[3/4.2] rounded-xl overflow-hidden bg-[#FAF9F5] border border-[#EBE7DC] mb-3">
                  <img
                    src={b.coverImageUrl || 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg'}
                    alt={b.title}
                    referrerPolicy="no-referrer"
                    className="w-full h-full object-cover group-hover:scale-105 transition-transform"
                  />
                </div>
                <div>
                  <h4 className="font-serif font-bold text-xs text-[#191614] line-clamp-2 leading-snug group-hover:text-[#B84A39]">
                    {b.title}
                  </h4>
                  <p className="text-[11px] text-[#706B65] mt-1 font-sans font-bold tabular-nums text-[#B84A39]">
                    {formatPrice(b.salePrice || b.originalPrice)}
                  </p>
                </div>
              </Link>
            ))}
          </div>
        </div>
      )}

      {/* Look Inside Modal */}
      <BookPreviewModal
        isOpen={isPreviewOpen}
        onClose={() => setIsPreviewOpen(false)}
        book={book}
      />

    </div>
  )
}
