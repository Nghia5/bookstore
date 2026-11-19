import { useState, useEffect } from 'react'
import { Plus, Tag, Trash2, Calendar, Ticket } from 'lucide-react'
import { formatPrice } from '@/lib/utils'
import apiClient from '@/api/client'
import { toast } from 'sonner'

interface DiscountItem {
  id: number
  code: string
  discountPercent: number
  maxDiscountAmount?: number
  minOrderAmount?: number
  startDate: string
  endDate: string
  usageLimit?: number
  timesUsed: number
  isActive: boolean
}

export default function AdminDiscountsTab() {
  const [discounts, setDiscounts] = useState<DiscountItem[]>([])
  const [loading, setLoading] = useState(false)

  // Modal create state
  const [isModalOpen, setIsModalOpen] = useState(false)
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [code, setCode] = useState('')
  const [percent, setPercent] = useState(10)
  const [maxAmount, setMaxAmount] = useState(50000)
  const [minAmount, setMinAmount] = useState(150000)
  const [usageLimit, setUsageLimit] = useState(200)
  const [endDate, setEndDate] = useState(() => new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString().slice(0, 10))

  const fetchDiscounts = async () => {
    try {
      setLoading(true)
      const res = await apiClient.get('/admin/discounts')
      setDiscounts(res.data || [])
    } catch (err: any) {
      toast.error('Không thể tải danh sách mã giảm giá.')
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchDiscounts()
  }, [])

  const handleToggleStatus = async (id: number) => {
    try {
      const res = await apiClient.put(`/admin/discounts/${id}/toggle-status`)
      toast.success(res.data.message)
      fetchDiscounts()
    } catch (err: any) {
      toast.error('Không thể cập nhật trạng thái mã.')
    }
  }

  const handleDelete = async (discount: DiscountItem) => {
    if (!confirm(`Bạn có chắc muốn xóa mã ưu đãi "${discount.code}"?`)) return
    try {
      const res = await apiClient.delete(`/admin/discounts/${discount.id}`)
      toast.success(res.data.message || 'Đã xóa mã ưu đãi.')
      fetchDiscounts()
    } catch (err: any) {
      toast.error('Không thể xóa mã ưu đãi.')
    }
  }

  const handleCreateDiscount = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!code.trim()) {
      toast.error('Vui lòng nhập mã giảm giá.')
      return
    }

    try {
      setIsSubmitting(true)
      const payload = {
        code: code.trim().toUpperCase(),
        discountPercent: Number(percent),
        maxDiscountAmount: maxAmount > 0 ? Number(maxAmount) : null,
        minOrderAmount: minAmount > 0 ? Number(minAmount) : null,
        usageLimit: usageLimit > 0 ? Number(usageLimit) : null,
        startDate: new Date().toISOString(),
        endDate: new Date(endDate + 'T23:59:59').toISOString()
      }

      const res = await apiClient.post('/admin/discounts', payload)
      toast.success(res.data.message || 'Tạo mã ưu đãi thành công!')
      setIsModalOpen(false)
      setCode('')
      fetchDiscounts()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Có lỗi xảy ra khi tạo mã.')
    } finally {
      setIsSubmitting(false)
    }
  }

  return (
    <div className="space-y-6">
      {/* Top action bar */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 bg-white p-5 rounded-2xl border border-[#EBE7DC] shadow-xs">
        <div>
          <h2 className="font-serif text-xl font-bold text-[#191614] flex items-center gap-2">
            <Ticket className="w-5 h-5 text-[#B84A39]" />
            Quản lý Mã Giảm Giá & Voucher
          </h2>
          <p className="text-xs text-[#706B65] mt-1">
            Thiết lập chiến dịch khuyến mãi, mã voucher giảm theo phần trăm hoặc số tiền, giới hạn điều kiện đơn hàng tối thiểu.
          </p>
        </div>

        <button
          onClick={() => setIsModalOpen(true)}
          className="px-4 py-2.5 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-bold flex items-center justify-center gap-2 transition-colors shadow-xs shrink-0"
        >
          <Plus className="w-4 h-4" />
          <span>Tạo Mã Ưu Đãi Mới</span>
        </button>
      </div>

      {/* Discounts Grid */}
      {loading ? (
        <div className="py-12 text-center text-xs text-[#706B65]">Đang tải danh sách voucher...</div>
      ) : discounts.length === 0 ? (
        <div className="bg-white rounded-2xl border border-[#EBE7DC] p-12 text-center text-xs text-[#706B65]">
          Chưa có mã giảm giá nào trong hệ thống.
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {discounts.map(d => (
            <div
              key={d.id}
              className={`bg-white rounded-2xl border p-5 shadow-xs transition-all flex flex-col justify-between space-y-4 ${
                d.isActive ? 'border-[#EBE7DC] hover:border-[#DDD6C4]' : 'border-red-200 bg-red-50/20 opacity-75'
              }`}
            >
              <div className="space-y-3">
                <div className="flex items-start justify-between gap-2">
                  <div className="flex items-center gap-2">
                    <div className="w-9 h-9 rounded-xl bg-amber-50 text-amber-700 flex items-center justify-center shrink-0">
                      <Tag className="w-4 h-4" />
                    </div>
                    <div>
                      <span className="font-mono text-base font-bold text-[#191614] tracking-wider block">
                        {d.code}
                      </span>
                      <span className="text-[10px] font-bold text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-full border border-emerald-200">
                        Giảm {d.discountPercent}%
                      </span>
                    </div>
                  </div>

                  <button
                    onClick={() => handleToggleStatus(d.id)}
                    className={`text-[10px] font-bold px-2.5 py-1 rounded-full border transition-colors ${
                      d.isActive 
                        ? 'bg-emerald-50 text-emerald-800 border-emerald-200 hover:bg-emerald-100'
                        : 'bg-zinc-100 text-zinc-600 border-zinc-200 hover:bg-zinc-200'
                    }`}
                  >
                    {d.isActive ? 'Đang kích hoạt' : 'Tạm dừng'}
                  </button>
                </div>

                <div className="p-3 bg-[#FAF9F5] rounded-xl border border-[#EBE7DC] space-y-1.5 text-xs">
                  <div className="flex justify-between text-[#615C56]">
                    <span>Giảm tối đa:</span>
                    <span className="font-sans font-bold tabular-nums text-[#191614]">
                      {d.maxDiscountAmount ? formatPrice(d.maxDiscountAmount) : 'Không giới hạn'}
                    </span>
                  </div>
                  <div className="flex justify-between text-[#615C56]">
                    <span>Đơn tối thiểu:</span>
                    <span className="font-sans font-semibold tabular-nums text-[#191614]">
                      {d.minOrderAmount ? formatPrice(d.minOrderAmount) : '0 đ'}
                    </span>
                  </div>
                  <div className="flex justify-between text-[#615C56]">
                    <span>Lượt sử dụng:</span>
                    <span className="font-sans font-bold tabular-nums text-amber-700">
                      {d.timesUsed} {d.usageLimit ? `/ ${d.usageLimit}` : 'lượt'}
                    </span>
                  </div>
                </div>
              </div>

              <div className="pt-3 border-t border-[#F5F3ED] flex items-center justify-between text-xs">
                <span className="text-[11px] text-[#8C857B] flex items-center gap-1">
                  <Calendar className="w-3.5 h-3.5" />
                  Hết hạn: {new Date(d.endDate).toLocaleDateString('vi-VN')}
                </span>

                <button
                  onClick={() => handleDelete(d)}
                  className="p-1.5 text-[#8C857B] hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                  title="Xóa mã voucher"
                >
                  <Trash2 className="w-4 h-4" />
                </button>
              </div>

            </div>
          ))}
        </div>
      )}

      {/* Modal Tạo Voucher Mới */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-xs">
          <div className="w-full max-w-md bg-white rounded-3xl border border-[#EBE7DC] shadow-2xl overflow-hidden animate-in fade-in zoom-in-95 duration-200">
            
            <div className="px-6 py-4 bg-[#FAF9F5] border-b border-[#EBE7DC] flex items-center justify-between">
              <div className="flex items-center gap-2">
                <Ticket className="w-5 h-5 text-[#B84A39]" />
                <h3 className="font-serif font-bold text-lg text-[#191614]">Tạo Mã Giảm Giá Mới</h3>
              </div>
              <button
                onClick={() => setIsModalOpen(false)}
                className="text-[#8C857B] hover:text-[#191614] p-1.5 rounded-lg hover:bg-[#F5F3ED]"
              >
                ✕
              </button>
            </div>

            <form onSubmit={handleCreateDiscount} className="p-6 space-y-4 text-xs">
              <div>
                <label className="font-bold text-[#191614] block mb-1">Mã Voucher (Code) *</label>
                <input
                  type="text"
                  required
                  value={code}
                  onChange={(e) => setCode(e.target.value.toUpperCase())}
                  placeholder="VD: BOOKFEST20, TRIEUDOCGIA"
                  className="w-full font-mono font-bold text-sm uppercase rounded-xl border border-[#DDD6C4] p-2.5 outline-none focus:border-[#191614]"
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="font-bold text-[#191614] block mb-1">Tỉ lệ giảm (%) *</label>
                  <input
                    type="number"
                    min={1}
                    max={100}
                    required
                    value={percent}
                    onChange={(e) => setPercent(Number(e.target.value))}
                    className="w-full font-sans font-bold tabular-nums rounded-xl border border-[#DDD6C4] p-2.5 outline-none focus:border-[#191614]"
                  />
                </div>
                <div>
                  <label className="font-bold text-[#191614] block mb-1">Giảm tối đa (đ)</label>
                  <input
                    type="number"
                    step={1000}
                    value={maxAmount}
                    onChange={(e) => setMaxAmount(Number(e.target.value))}
                    className="w-full font-sans tabular-nums rounded-xl border border-[#DDD6C4] p-2.5 outline-none focus:border-[#191614]"
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="font-bold text-[#191614] block mb-1">Đơn tối thiểu (đ)</label>
                  <input
                    type="number"
                    step={10000}
                    value={minAmount}
                    onChange={(e) => setMinAmount(Number(e.target.value))}
                    className="w-full font-sans tabular-nums rounded-xl border border-[#DDD6C4] p-2.5 outline-none focus:border-[#191614]"
                  />
                </div>
                <div>
                  <label className="font-bold text-[#191614] block mb-1">Giới hạn lượt dùng</label>
                  <input
                    type="number"
                    min={1}
                    value={usageLimit}
                    onChange={(e) => setUsageLimit(Number(e.target.value))}
                    className="w-full font-sans tabular-nums rounded-xl border border-[#DDD6C4] p-2.5 outline-none focus:border-[#191614]"
                  />
                </div>
              </div>

              <div>
                <label className="font-bold text-[#191614] block mb-1">Ngày hết hạn (mã tự xóa khi hết hạn hoặc hết lượt)</label>
                <input
                  type="date"
                  required
                  min={new Date().toISOString().slice(0, 10)}
                  value={endDate}
                  onChange={(e) => setEndDate(e.target.value)}
                  className="w-full font-sans tabular-nums rounded-xl border border-[#DDD6C4] p-2.5 outline-none focus:border-[#191614]"
                />
              </div>

              <div className="pt-4 border-t border-[#EBE7DC] flex justify-end gap-3">
                <button
                  type="button"
                  onClick={() => setIsModalOpen(false)}
                  className="px-4 py-2 rounded-xl border border-[#DDD6C4] font-semibold text-[#615C56] hover:bg-[#F5F3ED]"
                >
                  Hủy bỏ
                </button>
                <button
                  type="submit"
                  disabled={isSubmitting}
                  className="px-5 py-2 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white font-bold transition-colors disabled:opacity-50"
                >
                  {isSubmitting ? 'Đang tạo...' : 'Kích hoạt Mã'}
                </button>
              </div>
            </form>

          </div>
        </div>
      )}

    </div>
  )
}
