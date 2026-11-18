import { TrendingUp, Award, Download } from 'lucide-react'
import { formatPrice } from '@/lib/utils'
import apiClient from '@/api/client'
import { toast } from 'sonner'

interface WeeklySale {
  date: string
  dayLabel: string
  revenue: number
  orderCount: number
}

interface TopSeller {
  bookId: number
  title: string
  totalSold: number
  totalRevenue: number
}

interface AdminAnalyticsProps {
  weeklySales?: WeeklySale[]
  topSellers?: TopSeller[]
}

export default function AdminAnalyticsSection({ weeklySales = [], topSellers = [] }: AdminAnalyticsProps) {
  
  const maxRevenue = Math.max(...weeklySales.map(d => d.revenue), 500000)

  // Export Books to Excel (CSV with UTF-8 BOM)
  const handleExportBooks = async () => {
    try {
      toast.info('Đang chuẩn bị file dữ liệu sách...')
      const res = await apiClient.get('/admin/books', { params: { pageSize: 1000 } })
      const books = res.data.items || []

      let csv = '\uFEFF' // UTF-8 BOM for Excel
      csv += 'ID,Mã ISBN,Tên Sách,Tác Giả,Thể Loại,Giá Bìa,Giá Bán,Tồn Kho,Năm XB,Trạng Thái\n'
      
      books.forEach((b: any) => {
        const title = `"${(b.title || '').replace(/"/g, '""')}"`
        const authors = `"${(b.authorNames || '').replace(/"/g, '""')}"`
        const category = `"${(b.categoryName || '').replace(/"/g, '""')}"`
        csv += `${b.id},${b.isbn || ''},${title},${authors},${category},${b.originalPrice},${b.salePrice || b.originalPrice},${b.stockQuantity},${b.publishYear || ''},${b.isAvailable ? 'Sẵn sàng' : 'Tạm khóa'}\n`
      })

      const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' })
      const url = URL.createObjectURL(blob)
      const link = document.createElement('a')
      link.href = url
      link.setAttribute('download', `Bookstore_KhoSach_${new Date().toISOString().slice(0, 10)}.csv`)
      document.body.appendChild(link)
      link.click()
      document.body.removeChild(link)
      toast.success('Đã tải xuống file danh sách sách thành công!')
    } catch (err) {
      toast.error('Có lỗi xảy ra khi xuất file dữ liệu sách.')
    }
  }

  // Export Orders to Excel (CSV with UTF-8 BOM)
  const handleExportOrders = async () => {
    try {
      toast.info('Đang chuẩn bị file dữ liệu đơn hàng...')
      const res = await apiClient.get('/admin/orders')
      const orders = res.data || []

      let csv = '\uFEFF' // UTF-8 BOM
      csv += 'Mã Đơn,Ngày Đặt,Khách Hàng,Số Điện Thoại,Địa Chỉ,Tổng Tiền,Giảm Giá,Phí Vận Chuyển,Thanh Toán,Phương Thức,Trạng Thái\n'

      orders.forEach((o: any) => {
        const customer = `"${(o.customerName || '').replace(/"/g, '""')}"`
        const address = `"${(o.shippingAddress || '').replace(/"/g, '""')}"`
        csv += `${o.orderCode},${new Date(o.orderDate).toLocaleDateString('vi-VN')},${customer},${o.customerPhone || ''},${address},${o.totalAmount},${o.discountAmount || 0},${o.shippingFee || 0},${o.finalAmount},${o.paymentMethod || 'COD'},${o.status}\n`
      })

      const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' })
      const url = URL.createObjectURL(blob)
      const link = document.createElement('a')
      link.href = url
      link.setAttribute('download', `Bookstore_DonHang_${new Date().toISOString().slice(0, 10)}.csv`)
      document.body.appendChild(link)
      link.click()
      document.body.removeChild(link)
      toast.success('Đã tải xuống file báo cáo đơn hàng thành công!')
    } catch (err) {
      toast.error('Có lỗi xảy ra khi xuất file báo cáo đơn hàng.')
    }
  }

  return (
    <div className="space-y-6">
      
      {/* Quick Excel Export Bar */}
      <div className="bg-[#FAF9F5] p-4 rounded-2xl border border-[#EBE7DC] flex flex-col sm:flex-row sm:items-center justify-between gap-3">
        <div className="flex items-center gap-2">
          <Download className="w-4 h-4 text-[#B84A39]" />
          <span className="text-xs font-bold text-[#191614]">Xuất Dữ Liệu Báo Cáo Chuyên Nghiệp (Excel/CSV):</span>
        </div>
        <div className="flex items-center gap-2">
          <button
            onClick={handleExportBooks}
            className="px-3 py-1.5 rounded-xl border border-[#DDD6C4] bg-white hover:bg-[#F5F3ED] text-xs font-semibold text-[#191614] flex items-center gap-1.5 transition-colors shadow-2xs"
          >
            <Download className="w-3.5 h-3.5 text-emerald-700" />
            <span>Xuất 1.000 Sách (CSV)</span>
          </button>
          <button
            onClick={handleExportOrders}
            className="px-3 py-1.5 rounded-xl border border-[#DDD6C4] bg-white hover:bg-[#F5F3ED] text-xs font-semibold text-[#191614] flex items-center gap-1.5 transition-colors shadow-2xs"
          >
            <Download className="w-3.5 h-3.5 text-blue-700" />
            <span>Xuất Đơn Hàng (CSV)</span>
          </button>
        </div>
      </div>

      {/* Analytics Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        
        {/* 7-Day Revenue Trend Bar Chart */}
        <div className="lg:col-span-7 bg-white p-6 rounded-2xl border border-[#EBE7DC] shadow-xs space-y-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <TrendingUp className="w-5 h-5 text-emerald-600" />
              <h3 className="font-serif font-bold text-base text-[#191614]">Biểu Đồ Doanh Thu 7 Ngày Gần Nhất</h3>
            </div>
            <span className="text-xs text-[#8C857B] font-medium">Theo chu kỳ tuần</span>
          </div>

          <div className="h-56 flex items-end justify-between gap-2 pt-8 pb-2 px-2 border-b border-[#F5F3ED]">
            {weeklySales.map((item, idx) => {
              const heightPercent = maxRevenue > 0 ? Math.max(10, Math.round((item.revenue / maxRevenue) * 100)) : 10
              return (
                <div key={idx} className="flex-1 flex flex-col items-center gap-2 group h-full justify-end">
                  
                  {/* Tooltip value */}
                  <div className="opacity-0 group-hover:opacity-100 transition-opacity text-[10px] font-bold font-sans tabular-nums bg-[#191614] text-white px-2 py-0.5 rounded shadow-sm whitespace-nowrap mb-1">
                    {formatPrice(item.revenue)} ({item.orderCount} đơn)
                  </div>

                  {/* Bar */}
                  <div className="w-full max-w-[36px] bg-[#FAF9F5] rounded-t-xl overflow-hidden flex flex-col justify-end h-full">
                    <div
                      style={{ height: `${heightPercent}%` }}
                      className={`w-full rounded-t-xl transition-all duration-500 ${
                        item.revenue > 0 ? 'bg-gradient-to-t from-[#B84A39] to-[#E06D53] group-hover:brightness-110' : 'bg-zinc-200'
                      }`}
                    ></div>
                  </div>

                  {/* X Axis Label */}
                  <div className="text-center">
                    <span className="text-xs font-bold text-[#191614] block font-sans tabular-nums">{item.date}</span>
                    <span className="text-[10px] text-[#8C857B] block">{item.dayLabel}</span>
                  </div>

                </div>
              )
            })}
          </div>

          <div className="flex items-center justify-between text-xs text-[#706B65] pt-1">
            <span>💡 Di chuột vào từng cột để xem chi tiết doanh thu và số đơn</span>
            <span className="font-bold text-[#191614]">Đơn vị: VNĐ</span>
          </div>
        </div>

        {/* Top 5 Best Sellers Leaderboard */}
        <div className="lg:col-span-5 bg-white p-6 rounded-2xl border border-[#EBE7DC] shadow-xs space-y-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <Award className="w-5 h-5 text-amber-500" />
              <h3 className="font-serif font-bold text-base text-[#191614]">Top Sách Bán Chạy Nhất</h3>
            </div>
            <span className="text-xs font-bold text-[#B84A39]">Best Sellers</span>
          </div>

          <div className="space-y-3 pt-2">
            {topSellers.map((item, idx) => (
              <div
                key={item.bookId}
                className="flex items-center justify-between p-2.5 rounded-xl bg-[#FAF9F5] border border-[#F5F3ED] hover:border-[#DDD6C4] transition-all"
              >
                <div className="flex items-center gap-3 min-w-0">
                  <span className={`w-6 h-6 rounded-full flex items-center justify-center font-bold text-xs font-mono shrink-0 ${
                    idx === 0 ? 'bg-amber-400 text-amber-950 shadow-xs' :
                    idx === 1 ? 'bg-zinc-300 text-zinc-900' :
                    idx === 2 ? 'bg-amber-700 text-amber-100' : 'bg-zinc-100 text-zinc-600'
                  }`}>
                    {idx + 1}
                  </span>
                  <div className="min-w-0">
                    <p className="font-bold text-xs text-[#191614] truncate">{item.title}</p>
                    <p className="text-[10px] text-[#706B65]">Đã bán: <strong className="font-sans tabular-nums text-emerald-700 font-bold">{item.totalSold} cuốn</strong></p>
                  </div>
                </div>

                <span className="font-sans font-bold tabular-nums text-xs text-[#191614] shrink-0 ml-2">
                  {formatPrice(item.totalRevenue)}
                </span>
              </div>
            ))}
          </div>
        </div>

      </div>

    </div>
  )
}
