import { useState, useEffect } from 'react'
import { Plus, PackagePlus, Calendar, User, ChevronDown, ChevronUp, FileText, CheckCircle2 } from 'lucide-react'
import { formatPrice } from '@/lib/utils'
import apiClient from '@/api/client'
import { toast } from 'sonner'

interface ReceiptItem {
  id: number
  bookId: number
  bookTitle: string
  bookCover?: string
  quantity: number
  costPrice: number
  lineTotal: number
}

interface GoodsReceipt {
  id: number
  receiptCode: string
  supplierName: string
  createdDate: string
  createdBy: string
  totalAmount: number
  note?: string
  itemCount: number
  totalQuantity: number
  items: ReceiptItem[]
}

interface BookOption {
  id: number
  title: string
  isbn?: string
  originalPrice: number
  stockQuantity: number
}

export default function AdminReceiptsTab() {
  const [receipts, setReceipts] = useState<GoodsReceipt[]>([])
  const [loading, setLoading] = useState(false)
  const [expandedId, setExpandedId] = useState<number | null>(null)

  // Modal create state
  const [isModalOpen, setIsModalOpen] = useState(false)
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [supplierName, setSupplierName] = useState('')
  const [createdBy, setCreatedBy] = useState('Quản trị viên')
  const [note, setNote] = useState('')
  
  // Available books for selection
  const [availableBooks, setAvailableBooks] = useState<BookOption[]>([])
  const [bookSearch, setBookSearch] = useState('')
  const [selectedItems, setSelectedItems] = useState<Array<{ bookId: number; title: string; quantity: number; costPrice: number }>>([])

  const fetchReceipts = async () => {
    try {
      setLoading(true)
      const res = await apiClient.get('/admin/receipts')
      setReceipts(res.data || [])
    } catch (err: any) {
      toast.error('Không thể tải danh sách phiếu nhập kho.')
    } finally {
      setLoading(false)
    }
  }

  const fetchBooksForReceipt = async (query: string) => {
    try {
      const res = await apiClient.get('/admin/books', { params: { search: query, pageSize: 20 } })
      setAvailableBooks(res.data.items || [])
    } catch (err) {
      console.error(err)
    }
  }

  useEffect(() => {
    fetchReceipts()
  }, [])

  useEffect(() => {
    if (isModalOpen) {
      fetchBooksForReceipt('')
    }
  }, [isModalOpen])

  const handleAddBookToReceipt = (book: BookOption) => {
    if (selectedItems.some(i => i.bookId === book.id)) {
      toast.info('Sách này đã có trong danh sách nhập.')
      return
    }
    const defaultCost = Math.round(book.originalPrice * 0.6) // 60% of original price
    setSelectedItems(prev => [
      ...prev,
      { bookId: book.id, title: book.title, quantity: 20, costPrice: defaultCost }
    ])
  }

  const handleUpdateItem = (index: number, field: 'quantity' | 'costPrice', value: number) => {
    setSelectedItems(prev => prev.map((item, idx) => idx === index ? { ...item, [field]: value } : item))
  }

  const handleRemoveItem = (index: number) => {
    setSelectedItems(prev => prev.filter((_, idx) => idx !== index))
  }

  const totalReceiptAmount = selectedItems.reduce((sum, i) => sum + (i.quantity * i.costPrice), 0)

  const handleSubmitReceipt = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!supplierName.trim()) {
      toast.error('Vui lòng nhập tên nhà xuất bản hoặc nhà cung cấp.')
      return
    }
    if (selectedItems.length === 0) {
      toast.error('Vui lòng chọn ít nhất 1 đầu sách để nhập kho.')
      return
    }

    try {
      setIsSubmitting(true)
      const payload = {
        supplierName: supplierName.trim(),
        createdBy: createdBy.trim(),
        note: note.trim(),
        items: selectedItems.map(i => ({
          bookId: i.bookId,
          quantity: Number(i.quantity),
          costPrice: Number(i.costPrice)
        }))
      }

      const res = await apiClient.post('/admin/receipts', payload)
      toast.success(res.data.message || 'Đã lập phiếu nhập kho thành công!')
      setIsModalOpen(false)
      setSelectedItems([])
      setSupplierName('')
      setNote('')
      fetchReceipts()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Có lỗi xảy ra khi tạo phiếu nhập kho.')
    } finally {
      setIsSubmitting(false)
    }
  }

  const supplierSuggestions = [
    'Nhà Xuất Bản Trẻ',
    'Công ty Cổ phần Văn hóa Nhã Nam',
    'Nhà Xuất Bản Kim Đồng',
    'First News - Trí Việt',
    'Công ty Cổ phần Sách Đông A',
    'Nhà Xuất Bản Phụ Nữ Việt Nam'
  ]

  return (
    <div className="space-y-6">
      {/* Top action bar */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 bg-white p-5 rounded-2xl border border-[#EBE7DC] shadow-xs">
        <div>
          <h2 className="font-serif text-xl font-bold text-[#191614] flex items-center gap-2">
            <PackagePlus className="w-5 h-5 text-[#B84A39]" />
            Quản lý Nhập Kho & Nhà Cung Cấp
          </h2>
          <p className="text-xs text-[#706B65] mt-1">
            Ghi nhận phiếu nhập sách, cập nhật số lượng tồn kho tự động và theo dõi giá vốn nhập hàng.
          </p>
        </div>

        <button
          onClick={() => setIsModalOpen(true)}
          className="px-4 py-2.5 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-bold flex items-center justify-center gap-2 transition-colors shadow-xs shrink-0"
        >
          <Plus className="w-4 h-4" />
          <span>Lập Phiếu Nhập Kho Mới</span>
        </button>
      </div>

      {/* Receipts List */}
      {loading ? (
        <div className="py-12 text-center text-xs text-[#706B65]">Đang tải danh sách phiếu nhập kho...</div>
      ) : receipts.length === 0 ? (
        <div className="bg-white rounded-2xl border border-[#EBE7DC] p-12 text-center text-xs text-[#706B65]">
          Chưa có phiếu nhập kho nào. Hãy tạo phiếu nhập hàng đầu tiên!
        </div>
      ) : (
        <div className="space-y-3.5">
          {receipts.map(receipt => {
            const isExpanded = expandedId === receipt.id
            return (
              <div
                key={receipt.id}
                className="bg-white rounded-2xl border border-[#EBE7DC] p-5 shadow-xs hover:border-[#DDD6C4] transition-all space-y-4"
              >
                <div className="flex flex-col md:flex-row md:items-center justify-between gap-3">
                  <div className="flex items-start sm:items-center gap-3">
                    <span className="px-3 py-1 rounded-full text-xs font-mono font-bold bg-[#FAF9F5] border border-[#DDD6C4] text-[#B84A39]">
                      {receipt.receiptCode}
                    </span>
                    <div>
                      <h3 className="font-serif font-bold text-base text-[#191614]">
                        {receipt.supplierName}
                      </h3>
                      <div className="flex flex-wrap items-center gap-3 text-xs text-[#706B65] mt-0.5">
                        <span className="flex items-center gap-1">
                          <Calendar className="w-3.5 h-3.5" />
                          {new Date(receipt.createdDate).toLocaleDateString('vi-VN')}
                        </span>
                        <span className="flex items-center gap-1">
                          <User className="w-3.5 h-3.5" />
                          Người lập: {receipt.createdBy}
                        </span>
                        {receipt.note && (
                          <span className="text-[#8C857B] italic">
                            • Ghi chú: {receipt.note}
                          </span>
                        )}
                      </div>
                    </div>
                  </div>

                  <div className="flex items-center justify-between md:justify-end gap-4 border-t md:border-t-0 pt-3 md:pt-0 border-[#F5F3ED]">
                    <div className="text-left md:text-right">
                      <span className="text-[11px] text-[#8C857B] block">
                        {receipt.itemCount} đầu sách • {receipt.totalQuantity} cuốn
                      </span>
                      <span className="font-sans font-bold text-base text-[#191614] tabular-nums">
                        {formatPrice(receipt.totalAmount)}
                      </span>
                    </div>

                    <button
                      onClick={() => setExpandedId(isExpanded ? null : receipt.id)}
                      className="p-2 rounded-xl text-[#706B65] hover:text-[#191614] hover:bg-[#F5F3ED] transition-colors"
                      title={isExpanded ? "Thu gọn chi tiết" : "Xem chi tiết sách nhập"}
                    >
                      {isExpanded ? <ChevronUp className="w-5 h-5" /> : <ChevronDown className="w-5 h-5" />}
                    </button>
                  </div>
                </div>

                {/* Collapsible Items Breakdown */}
                {isExpanded && (
                  <div className="pt-3 border-t border-[#F5F3ED] animate-in fade-in duration-200">
                    <p className="text-xs font-bold text-[#8C857B] uppercase tracking-wider mb-2">
                      Chi tiết các đầu sách trong phiếu nhập ({receipt.items?.length || 0}):
                    </p>
                    <div className="overflow-x-auto">
                      <table className="w-full text-left text-xs">
                        <thead>
                          <tr className="border-b border-[#EBE7DC] text-[#706B65]">
                            <th className="py-2 px-2 font-semibold">Tên sách</th>
                            <th className="py-2 px-2 font-semibold text-center">Số lượng nhập</th>
                            <th className="py-2 px-2 font-semibold text-right">Đơn giá vốn</th>
                            <th className="py-2 px-2 font-semibold text-right">Thành tiền</th>
                          </tr>
                        </thead>
                        <tbody className="divide-y divide-[#F5F3ED]">
                          {receipt.items?.map(item => (
                            <tr key={item.id} className="hover:bg-[#FAF9F5]">
                              <td className="py-2.5 px-2 font-medium text-[#191614] flex items-center gap-2">
                                <span className="w-2 h-2 rounded-full bg-emerald-500 shrink-0"></span>
                                {item.bookTitle}
                              </td>
                              <td className="py-2.5 px-2 text-center font-sans font-bold tabular-nums">
                                +{item.quantity} cuốn
                              </td>
                              <td className="py-2.5 px-2 text-right font-sans tabular-nums text-[#615C56]">
                                {formatPrice(item.costPrice)}
                              </td>
                              <td className="py-2.5 px-2 text-right font-sans font-bold tabular-nums text-[#191614]">
                                {formatPrice(item.lineTotal)}
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  </div>
                )}
              </div>
            )
          })}
        </div>
      )}

      {/* Modal Lập Phiếu Nhập Kho */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-xs overflow-y-auto">
          <div className="w-full max-w-3xl bg-white rounded-3xl border border-[#EBE7DC] shadow-2xl overflow-hidden my-6 flex flex-col max-h-[90vh]">
            
            <div className="px-6 py-4 bg-[#FAF9F5] border-b border-[#EBE7DC] flex items-center justify-between">
              <div className="flex items-center gap-2">
                <FileText className="w-5 h-5 text-[#B84A39]" />
                <h3 className="font-serif font-bold text-lg text-[#191614]">Tạo Phiếu Nhập Kho Mới</h3>
              </div>
              <button
                onClick={() => setIsModalOpen(false)}
                className="text-[#8C857B] hover:text-[#191614] p-1.5 rounded-lg hover:bg-[#F5F3ED]"
              >
                ✕
              </button>
            </div>

            <form onSubmit={handleSubmitReceipt} className="p-6 overflow-y-auto space-y-5">
              
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                  <label className="text-xs font-bold text-[#191614] block mb-1">
                    Nhà xuất bản / Nhà cung cấp *
                  </label>
                  <input
                    type="text"
                    required
                    value={supplierName}
                    onChange={(e) => setSupplierName(e.target.value)}
                    placeholder="VD: Công ty Cổ phần Sách Nhã Nam"
                    className="w-full text-xs rounded-xl border border-[#DDD6C4] p-2.5 outline-none focus:border-[#191614]"
                  />
                  <div className="flex flex-wrap gap-1.5 mt-2">
                    {supplierSuggestions.map(s => (
                      <button
                        type="button"
                        key={s}
                        onClick={() => setSupplierName(s)}
                        className="text-[10px] px-2 py-0.5 rounded-md bg-[#FAF9F5] hover:bg-[#EBE7DC] border border-[#DDD6C4] text-[#615C56]"
                      >
                        {s}
                      </button>
                    ))}
                  </div>
                </div>

                <div className="space-y-3">
                  <div>
                    <label className="text-xs font-bold text-[#191614] block mb-1">
                      Người lập phiếu
                    </label>
                    <input
                      type="text"
                      value={createdBy}
                      onChange={(e) => setCreatedBy(e.target.value)}
                      className="w-full text-xs rounded-xl border border-[#DDD6C4] p-2.5 outline-none focus:border-[#191614]"
                    />
                  </div>
                  <div>
                    <label className="text-xs font-bold text-[#191614] block mb-1">
                      Ghi chú đợt nhập
                    </label>
                    <input
                      type="text"
                      value={note}
                      onChange={(e) => setNote(e.target.value)}
                      placeholder="VD: Nhập tái bản quý 4..."
                      className="w-full text-xs rounded-xl border border-[#DDD6C4] p-2.5 outline-none focus:border-[#191614]"
                    />
                  </div>
                </div>
              </div>

              {/* Book Search & Picker */}
              <div className="pt-4 border-t border-[#F5F3ED] space-y-3">
                <label className="text-xs font-bold text-[#191614] block">
                  Tìm và chọn sách để nhập vào kho:
                </label>
                <div className="flex gap-2">
                  <input
                    type="text"
                    value={bookSearch}
                    onChange={(e) => {
                      setBookSearch(e.target.value)
                      fetchBooksForReceipt(e.target.value)
                    }}
                    placeholder="Gõ tên cuốn sách hoặc mã ISBN..."
                    className="flex-1 text-xs rounded-xl border border-[#DDD6C4] p-2.5 outline-none focus:border-[#191614]"
                  />
                </div>

                {availableBooks.length > 0 && bookSearch.trim() && (
                  <div className="max-h-40 overflow-y-auto border border-[#EBE7DC] rounded-xl divide-y divide-[#F5F3ED] bg-[#FAF9F5] p-1">
                    {availableBooks.slice(0, 8).map(b => (
                      <div key={b.id} className="p-2 flex items-center justify-between text-xs hover:bg-white rounded-lg transition-colors">
                        <div>
                          <p className="font-semibold text-[#191614] line-clamp-1">{b.title}</p>
                          <p className="text-[10px] text-[#706B65]">Tồn hiện tại: {b.stockQuantity} • Giá bìa: {formatPrice(b.originalPrice)}</p>
                        </div>
                        <button
                          type="button"
                          onClick={() => handleAddBookToReceipt(b)}
                          className="px-2.5 py-1 rounded-lg bg-[#191614] hover:bg-[#B84A39] text-white text-[11px] font-semibold transition-colors"
                        >
                          + Chọn
                        </button>
                      </div>
                    ))}
                  </div>
                )}
              </div>

              {/* Selected items table */}
              <div className="space-y-2">
                <div className="flex justify-between items-center text-xs font-bold text-[#191614]">
                  <span>Danh sách sách nhập ({selectedItems.length}):</span>
                  <span>Tổng tiền nhập: <strong className="text-[#B84A39] font-sans tabular-nums text-sm">{formatPrice(totalReceiptAmount)}</strong></span>
                </div>

                {selectedItems.length === 0 ? (
                  <p className="text-xs text-[#8C857B] italic py-4 text-center border border-dashed border-[#DDD6C4] rounded-xl">
                    Chưa chọn đầu sách nào. Tìm kiếm sách ở trên để thêm vào phiếu.
                  </p>
                ) : (
                  <div className="border border-[#EBE7DC] rounded-xl overflow-hidden divide-y divide-[#F5F3ED]">
                    {selectedItems.map((item, idx) => (
                      <div key={item.bookId} className="p-3 bg-white flex flex-col sm:flex-row sm:items-center justify-between gap-3 text-xs">
                        <div className="flex-1 min-w-0">
                          <p className="font-bold text-[#191614] truncate">{item.title}</p>
                        </div>
                        
                        <div className="flex items-center gap-3">
                          <div className="flex items-center gap-1.5">
                            <span className="text-[#706B65]">SL:</span>
                            <input
                              type="number"
                              min={1}
                              value={item.quantity}
                              onChange={(e) => handleUpdateItem(idx, 'quantity', Math.max(1, parseInt(e.target.value) || 1))}
                              className="w-16 rounded-lg border border-[#DDD6C4] p-1 text-center font-bold font-sans tabular-nums"
                            />
                          </div>

                          <div className="flex items-center gap-1.5">
                            <span className="text-[#706B65]">Giá vốn:</span>
                            <input
                              type="number"
                              min={0}
                              step={1000}
                              value={item.costPrice}
                              onChange={(e) => handleUpdateItem(idx, 'costPrice', Math.max(0, parseInt(e.target.value) || 0))}
                              className="w-24 rounded-lg border border-[#DDD6C4] p-1 text-right font-sans tabular-nums"
                            />
                          </div>

                          <span className="font-sans font-bold tabular-nums text-[#191614] w-24 text-right">
                            {formatPrice(item.quantity * item.costPrice)}
                          </span>

                          <button
                            type="button"
                            onClick={() => handleRemoveItem(idx)}
                            className="text-red-500 hover:text-red-700 p-1"
                          >
                            ✕
                          </button>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>

              {/* Submit Buttons */}
              <div className="pt-4 border-t border-[#EBE7DC] flex justify-end gap-3">
                <button
                  type="button"
                  onClick={() => setIsModalOpen(false)}
                  className="px-4 py-2.5 rounded-xl border border-[#DDD6C4] text-xs font-semibold text-[#615C56] hover:bg-[#F5F3ED]"
                >
                  Hủy bỏ
                </button>
                <button
                  type="submit"
                  disabled={isSubmitting || selectedItems.length === 0}
                  className="px-5 py-2.5 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-bold flex items-center gap-2 transition-colors disabled:opacity-50"
                >
                  <CheckCircle2 className="w-4 h-4" />
                  <span>{isSubmitting ? 'Đang cập nhật kho...' : 'Xác nhận Nhập Kho'}</span>
                </button>
              </div>

            </form>

          </div>
        </div>
      )}

    </div>
  )
}
