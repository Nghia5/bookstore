import { X, Printer, BookOpen, CheckCircle } from 'lucide-react'
import { formatPrice } from '@/lib/utils'

export interface InvoiceData {
  orderCode: string
  orderDate?: string
  customerName: string
  phoneNumber?: string
  address: string
  paymentMethod?: string
  status?: string
  items: Array<{
    title: string
    quantity: number
    price: number
  }>
  totalAmount?: number
  subtotal?: number
  discountAmount?: number
  shippingFee?: number
  finalAmount: number
  note?: string
}

interface InvoiceModalProps {
  isOpen: boolean
  onClose: () => void
  data: InvoiceData | null
}

export default function InvoiceModal({ isOpen, onClose, data }: InvoiceModalProps) {
  if (!isOpen || !data) return null

  const handlePrint = () => {
    window.print()
  }

  const items = data.items || []
  const subtotal = data.subtotal ?? items.reduce((sum, i) => sum + i.price * i.quantity, 0)
  const discount = data.discountAmount ?? 0
  const shipping = data.shippingFee ?? 0
  const total = data.finalAmount || (subtotal - discount + shipping)

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-xs overflow-y-auto">
      <div className="w-full max-w-2xl bg-white rounded-3xl shadow-2xl border border-[#EBE7DC] overflow-hidden my-8 flex flex-col print:m-0 print:p-0 print:border-none print:shadow-none print:max-w-none">
        
        {/* Header Controls (Hidden when printing) */}
        <div className="px-6 py-4 bg-[#FAF9F5] border-b border-[#EBE7DC] flex items-center justify-between print:hidden">
          <div className="flex items-center gap-2">
            <Printer className="w-5 h-5 text-[#B84A39]" />
            <h3 className="font-serif font-bold text-base text-[#191614]">Hóa đơn thanh toán bán lẻ</h3>
          </div>
          <div className="flex items-center gap-2">
            <button
              onClick={handlePrint}
              className="px-4 py-2 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-bold flex items-center gap-1.5 transition-colors shadow-xs"
            >
              <Printer className="w-4 h-4" />
              <span>In Hóa Đơn / Lưu PDF</span>
            </button>
            <button
              onClick={onClose}
              className="p-2 text-[#8C857B] hover:text-[#191614] rounded-xl hover:bg-[#F5F3ED] transition-colors"
            >
              <X className="w-5 h-5" />
            </button>
          </div>
        </div>

        {/* Printable Invoice Body */}
        <div id="printable-invoice" className="p-8 sm:p-10 space-y-6 text-[#191614] bg-white">
          
          {/* Top Brand & Order Details */}
          <div className="flex flex-col sm:flex-row justify-between items-start gap-4 pb-6 border-b border-[#EBE7DC]">
            <div className="space-y-1">
              <div className="flex items-center gap-2 text-[#B84A39]">
                <BookOpen className="w-6 h-6" />
                <span className="font-serif text-xl font-bold tracking-tight text-[#191614]">Bookstore Nhã Nam & Tri Thức</span>
              </div>
              <p className="text-xs text-[#706B65]">59 Đỗ Quang, P. Trung Hòa, Cầu Giấy, Hà Nội</p>
              <p className="text-xs text-[#706B65]">Hotline: 1900 6401 • Email: cskh@bookstore.vn</p>
              <p className="text-xs text-[#706B65]">Mã số thuế: 0102394857</p>
            </div>

            <div className="text-left sm:text-right space-y-1 sm:self-start">
              <span className="inline-block px-3 py-1 rounded-full text-xs font-mono font-bold bg-[#FAF9F5] border border-[#DDD6C4] text-[#B84A39]">
                {data.orderCode}
              </span>
              <p className="text-xs text-[#706B65]">
                Ngày lập: {data.orderDate ? new Date(data.orderDate).toLocaleDateString('vi-VN', { hour: '2-digit', minute: '2-digit', day: '2-digit', month: '2-digit', year: 'numeric' }) : new Date().toLocaleDateString('vi-VN')}
              </p>
              <p className="text-xs font-semibold text-emerald-700 flex items-center sm:justify-end gap-1">
                <CheckCircle className="w-3.5 h-3.5" />
                <span>{data.status || 'Đã ghi nhận hệ thống'}</span>
              </p>
            </div>
          </div>

          {/* Customer & Delivery Information */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 p-4 rounded-2xl bg-[#FAF9F5] border border-[#EBE7DC] text-xs">
            <div>
              <p className="text-[#8C857B] font-medium uppercase tracking-wider text-[10px]">Khách hàng / Người nhận</p>
              <p className="font-bold text-sm text-[#191614] mt-0.5">{data.customerName}</p>
              {data.phoneNumber && <p className="text-[#615C56] mt-0.5">SĐT: {data.phoneNumber}</p>}
            </div>
            <div>
              <p className="text-[#8C857B] font-medium uppercase tracking-wider text-[10px]">Địa chỉ nhận sách & Phương thức</p>
              <p className="font-medium text-[#191614] mt-0.5">{data.address || 'Nhận tại cửa hàng'}</p>
              <p className="text-[#615C56] mt-0.5">Hình thức: {data.paymentMethod || 'COD - Thanh toán tiền mặt'}</p>
            </div>
          </div>

          {/* Itemized Table */}
          <div className="overflow-x-auto">
            <table className="w-full text-left text-xs">
              <thead>
                <tr className="border-b-2 border-[#191614] text-[#191614]">
                  <th className="py-2.5 px-1 font-bold">#</th>
                  <th className="py-2.5 px-2 font-bold">Tên tác phẩm</th>
                  <th className="py-2.5 px-2 font-bold text-center">Số lượng</th>
                  <th className="py-2.5 px-2 font-bold text-right">Đơn giá</th>
                  <th className="py-2.5 px-2 font-bold text-right">Thành tiền</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[#EBE7DC]">
                {items.map((item, idx) => (
                  <tr key={idx} className="hover:bg-[#FAF9F5]">
                    <td className="py-3 px-1 text-[#8C857B] font-mono">{idx + 1}</td>
                    <td className="py-3 px-2 font-medium text-[#191614] max-w-xs">{item.title}</td>
                    <td className="py-3 px-2 text-center font-sans font-bold tabular-nums">{item.quantity}</td>
                    <td className="py-3 px-2 text-right font-sans tabular-nums text-[#615C56]">{formatPrice(item.price)}</td>
                    <td className="py-3 px-2 text-right font-sans font-bold tabular-nums text-[#191614]">{formatPrice(item.price * item.quantity)}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* Pricing Breakdown & QR Code */}
          <div className="flex flex-col sm:flex-row justify-between items-end gap-6 pt-4 border-t border-[#EBE7DC]">
            <div className="flex items-center gap-4 text-xs text-[#706B65]">
              <div className="w-20 h-20 bg-white p-1 rounded-xl border border-[#DDD6C4] shrink-0">
                <img
                  src={`https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${encodeURIComponent(data.orderCode)}`}
                  alt="QR Code"
                  className="w-full h-full object-contain"
                />
              </div>
              <div className="space-y-0.5">
                <p className="font-semibold text-[#191614]">Mã xác thực tra cứu</p>
                <p className="text-[11px]">Quét mã QR để kiểm tra lộ trình vận chuyển tại bookstore.vn</p>
                <p className="text-[10px] text-[#8C857B] italic">Hóa đơn điện tử khởi tạo từ hệ thống POS</p>
              </div>
            </div>

            <div className="w-full sm:w-64 space-y-2 text-xs">
              <div className="flex justify-between text-[#615C56]">
                <span>Tạm tính hàng:</span>
                <span className="font-sans tabular-nums font-semibold text-[#191614]">{formatPrice(subtotal)}</span>
              </div>

              {discount > 0 && (
                <div className="flex justify-between text-emerald-700 font-semibold">
                  <span>Khuyến mãi / Voucher:</span>
                  <span className="font-sans tabular-nums">-{formatPrice(discount)}</span>
                </div>
              )}

              <div className="flex justify-between text-[#615C56]">
                <span>Phí vận chuyển:</span>
                <span className="font-sans tabular-nums font-semibold text-[#191614]">
                  {shipping === 0 ? 'Miễn phí' : formatPrice(shipping)}
                </span>
              </div>

              <div className="pt-2 border-t border-[#EBE7DC] flex justify-between items-baseline font-bold text-sm">
                <span className="text-[#191614]">TỔNG CỘNG:</span>
                <span className="font-sans font-extrabold text-xl text-[#B84A39] tabular-nums">
                  {formatPrice(total)}
                </span>
              </div>
            </div>
          </div>

          {/* Footer Thank You Note */}
          <div className="pt-6 border-t border-dashed border-[#DDD6C4] text-center text-xs text-[#8C857B] space-y-1">
            <p className="font-serif italic font-semibold text-[#423E3A]">
              "Sách là ngọn đèn sáng bất diệt của trí tuệ nhân loại."
            </p>
            <p className="text-[11px]">Cảm ơn quý khách đã tin chọn Bookstore. Hỗ trợ đổi trả trong vòng 7 ngày nếu lỗi in ấn.</p>
          </div>

        </div>

      </div>
    </div>
  )
}
