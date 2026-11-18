import { useState, useEffect } from 'react'
import { Star, MessageSquare, Trash2 } from 'lucide-react'
import apiClient from '@/api/client'
import { toast } from 'sonner'

interface AdminReview {
  id: number
  bookId: number
  bookTitle: string
  bookCover?: string
  userId: number
  userName: string
  userEmail?: string
  rating: number
  comment?: string
  createdAt: string
}

export default function AdminReviewsTab() {
  const [reviews, setReviews] = useState<AdminReview[]>([])
  const [loading, setLoading] = useState(false)

  const fetchReviews = async () => {
    try {
      setLoading(true)
      const res = await apiClient.get('/admin/reviews')
      setReviews(res.data || [])
    } catch (err: any) {
      toast.error('Không thể tải danh sách nhận xét.')
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchReviews()
  }, [])

  const handleDelete = async (review: AdminReview) => {
    if (!confirm(`Bạn có chắc muốn xóa nhận xét của "${review.userName}" cho cuốn "${review.bookTitle}"?`)) return
    try {
      const res = await apiClient.delete(`/admin/reviews/${review.id}`)
      toast.success(res.data?.message || 'Đã xóa nhận xét.')
      fetchReviews()
    } catch (err: any) {
      toast.error('Không thể xóa nhận xét.')
    }
  }

  return (
    <div className="space-y-6">
      {/* Top action bar */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 bg-white p-5 rounded-2xl border border-[#EBE7DC] shadow-xs">
        <div>
          <h2 className="font-serif text-xl font-bold text-[#191614] flex items-center gap-2">
            <MessageSquare className="w-5 h-5 text-[#B84A39]" />
            Kiểm Duyệt Nhận Xét & Đánh Giá Bạn Đọc ({reviews.length})
          </h2>
          <p className="text-xs text-[#706B65] mt-1">
            Theo dõi ý kiến phản hồi, mức độ hài lòng về tác phẩm và kiểm duyệt bình luận của độc giả.
          </p>
        </div>
      </div>

      {/* Reviews list */}
      {loading ? (
        <div className="py-12 text-center text-xs text-[#706B65]">Đang tải danh sách nhận xét...</div>
      ) : reviews.length === 0 ? (
        <div className="bg-white rounded-2xl border border-[#EBE7DC] p-12 text-center text-xs text-[#706B65]">
          Chưa có nhận xét nào từ bạn đọc.
        </div>
      ) : (
        <div className="space-y-3.5">
          {reviews.map(r => (
            <div
              key={r.id}
              className="bg-white rounded-2xl border border-[#EBE7DC] p-5 shadow-xs hover:border-[#DDD6C4] transition-all space-y-3"
            >
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-14 rounded-lg overflow-hidden border border-[#DDD6C4] bg-[#F5F3ED] shrink-0">
                    <img
                      src={r.bookCover || 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg'}
                      alt={r.bookTitle}
                      referrerPolicy="no-referrer"
                      className="w-full h-full object-cover"
                    />
                  </div>
                  <div>
                    <h3 className="font-serif font-bold text-sm text-[#191614] line-clamp-1">
                      {r.bookTitle}
                    </h3>
                    <div className="flex items-center gap-2 mt-1">
                      <div className="flex items-center gap-0.5 text-amber-500">
                        {[1, 2, 3, 4, 5].map(star => (
                          <Star
                            key={star}
                            className={`w-3.5 h-3.5 ${star <= r.rating ? 'fill-amber-400 text-amber-400' : 'text-zinc-200'}`}
                          />
                        ))}
                      </div>
                      <span className="text-xs font-bold text-[#191614] font-sans tabular-nums">
                        {r.rating}.0 / 5
                      </span>
                    </div>
                  </div>
                </div>

                <div className="flex items-center gap-4 text-xs text-[#706B65]">
                  <div className="text-left sm:text-right">
                    <p className="font-semibold text-[#191614]">{r.userName}</p>
                    <p className="text-[10px] text-[#8C857B]">
                      {new Date(r.createdAt).toLocaleDateString('vi-VN')}
                    </p>
                  </div>

                  <button
                    onClick={() => handleDelete(r)}
                    className="p-2 text-[#8C857B] hover:text-red-600 hover:bg-red-50 rounded-xl transition-colors"
                    title="Xóa nhận xét này"
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
                </div>
              </div>

              {r.comment && (
                <div className="p-3 bg-[#FAF9F5] rounded-xl border border-[#F5F3ED] text-xs text-[#423E3A] leading-relaxed">
                  "{r.comment}"
                </div>
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
