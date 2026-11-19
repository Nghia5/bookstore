import { useState, useEffect } from 'react'
import { Star, MessageSquare, Trash2, Reply, ExternalLink } from 'lucide-react'
import { Link } from 'react-router-dom'
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
  adminReply?: string | null
  adminReplyAt?: string | null
}

export default function AdminReviewsTab() {
  const [reviews, setReviews] = useState<AdminReview[]>([])
  const [loading, setLoading] = useState(false)
  const [drafts, setDrafts] = useState<Record<number, string>>({})
  const [openReply, setOpenReply] = useState<number | null>(null)
  const [filter, setFilter] = useState<'all' | 'pending'>('all')

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

  const sendReply = async (review: AdminReview) => {
    const text = (drafts[review.id] ?? review.adminReply ?? '').trim()
    if (!text) { toast.error('Vui lòng nhập nội dung phản hồi.'); return }
    try {
      const res = await apiClient.post(`/admin/reviews/${review.id}/reply`, { reply: text })
      toast.success(res.data?.message || 'Đã gửi phản hồi.')
      setOpenReply(null)
      fetchReviews()
    } catch {
      toast.error('Không thể gửi phản hồi.')
    }
  }

  const removeReply = async (review: AdminReview) => {
    try {
      await apiClient.post(`/admin/reviews/${review.id}/reply`, { reply: '' })
      toast.success('Đã gỡ phản hồi.')
      fetchReviews()
    } catch {
      toast.error('Không thể gỡ phản hồi.')
    }
  }

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

      <div className="flex gap-2 text-xs">
        <button onClick={() => setFilter('all')} className={`px-3 py-1.5 rounded-full border font-semibold ${filter === 'all' ? 'bg-[#191614] text-white border-[#191614]' : 'bg-white text-[#615C56] border-[#DDD6C4]'}`}>Tất cả ({reviews.length})</button>
        <button onClick={() => setFilter('pending')} className={`px-3 py-1.5 rounded-full border font-semibold ${filter === 'pending' ? 'bg-[#191614] text-white border-[#191614]' : 'bg-white text-[#615C56] border-[#DDD6C4]'}`}>Chưa phản hồi ({reviews.filter(r => !r.adminReply).length})</button>
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
          {reviews.filter(r => filter === 'all' || !r.adminReply).map(r => (
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
                    <Link to={`/books/${r.bookId}`} target="_blank" className="font-serif font-bold text-sm text-[#191614] line-clamp-1 hover:text-[#B84A39] inline-flex items-center gap-1" title="Mở trang sản phẩm">
                      {r.bookTitle}
                      <ExternalLink className="w-3 h-3 shrink-0" />
                    </Link>
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

              {r.adminReply && openReply !== r.id && (
                <div className="ml-4 p-3 bg-[#FFF7ED] rounded-xl border border-amber-200 text-xs text-[#423E3A] leading-relaxed">
                  <p className="font-bold text-[#B84A39] mb-1">Phản hồi từ Bookstore · {r.adminReplyAt ? new Date(r.adminReplyAt).toLocaleDateString('vi-VN') : ''}</p>
                  {r.adminReply}
                  <div className="mt-2 flex gap-3 font-semibold">
                    <button onClick={() => { setDrafts(d => ({ ...d, [r.id]: r.adminReply || '' })); setOpenReply(r.id) }} className="text-[#191614] hover:underline">Sửa</button>
                    <button onClick={() => removeReply(r)} className="text-red-600 hover:underline">Gỡ</button>
                  </div>
                </div>
              )}

              {openReply === r.id ? (
                <div className="ml-4 space-y-2">
                  <textarea
                    rows={3}
                    autoFocus
                    value={drafts[r.id] ?? ''}
                    onChange={(e) => setDrafts(d => ({ ...d, [r.id]: e.target.value }))}
                    placeholder={`Trả lời ${r.userName}...`}
                    className="w-full text-xs rounded-xl border border-[#DDD6C4] p-3 outline-none focus:border-[#191614] resize-none"
                  />
                  <div className="flex gap-2 justify-end text-xs">
                    <button onClick={() => setOpenReply(null)} className="px-3 py-1.5 rounded-lg border border-[#DDD6C4] font-semibold text-[#615C56]">Hủy</button>
                    <button onClick={() => sendReply(r)} className="px-3 py-1.5 rounded-lg bg-[#191614] hover:bg-[#B84A39] text-white font-bold">Gửi phản hồi</button>
                  </div>
                </div>
              ) : !r.adminReply && (
                <button onClick={() => { setDrafts(d => ({ ...d, [r.id]: '' })); setOpenReply(r.id) }} className="ml-4 inline-flex items-center gap-1.5 text-xs font-bold text-[#B84A39] hover:underline">
                  <Reply className="w-3.5 h-3.5" /> Trả lời khách hàng
                </button>
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
