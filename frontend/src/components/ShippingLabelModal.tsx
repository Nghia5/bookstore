import { X, Printer, Truck, Package } from 'lucide-react'
import { formatPrice } from '@/lib/utils'

export interface ShippingOrderData {
  orderCode: string
  orderDate?: string
  customerName: string
  customerPhone?: string
  shippingAddress: string
  paymentMethod?: string | number
  status?: string
  items: Array<{
    bookTitle?: string
    title?: string
    quantity: number
    price?: number
    unitPrice?: number
  }>
  totalAmount?: number
  discountAmount?: number
  shippingFee?: number
  finalAmount: number
  note?: string
}

interface ShippingLabelModalProps {
  isOpen: boolean
  onClose: () => void
  data: ShippingOrderData | null
}

export default function ShippingLabelModal({ isOpen, onClose, data }: ShippingLabelModalProps) {
  if (!isOpen || !data) return null

  const handlePrint = () => {
    window.print()
  }

  const items = data.items || []
  const isCod = data.paymentMethod === 'COD' || data.paymentMethod === 0 || data.paymentMethod === '0'
  const estimatedWeight = Math.max(350, items.reduce((sum, i) => sum + i.quantity * 380, 0))

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-xs overflow-y-auto">
      <div className="w-full max-w-xl bg-white rounded-3xl shadow-2xl border border-[#DDD6C4] overflow-hidden my-8 flex flex-col print:m-0 print:p-0 print:border-none print:shadow-none print:max-w-none">
        
        {/* Header Controls (Hidden when printing) */}
        <div className="px-6 py-4 bg-[#FAF9F5] border-b border-[#EBE7DC] flex items-center justify-between print:hidden">
          <div className="flex items-center gap-2">
            <Truck className="w-5 h-5 text-sky-700" />
            <h3 className="font-serif font-bold text-base text-[#191614]">Phiếu gửi hàng & Vận đơn bưu tá</h3>
          </div>
          <div className="flex items-center gap-2">
            <button
              onClick={handlePrint}
              className="px-4 py-2 rounded-xl bg-sky-700 hover:bg-sky-800 text-white text-xs font-bold flex items-center gap-1.5 transition-colors shadow-xs"
            >
              <Printer className="w-4 h-4" />
              <span>In Vận Đơn / Lưu PDF</span>
            </button>
            <button
              onClick={onClose}
              className="p-2 text-[#8C857B] hover:text-[#191614] rounded-xl hover:bg-[#F5F3ED] transition-colors"
            >
              <X className="w-5 h-5" />
            </button>
          </div>
        </div>

        {/* Printable Shipping Label Body */}
        <div id="printable-shipping-label" className="p-6 sm:p-8 space-y-4 text-[#191614] bg-white print:p-6 print:space-y-3 font-sans text-xs">
          
          {/* Header Bar */}
          <div className="border-2 border-black p-3 rounded-lg flex items-center justify-between">
            <div>
              <div className="flex items-center gap-1.5 font-bold text-sm tracking-tight uppercase">
                <Package className="w-4 h-4 text-black" />
                <span>GIAO HÀNG TIẾT KIỆM / VIETTEL POST</span>
              </div>
              <p className="text-[10px] text-gray-600 mt-0.5">Tiêu chuẩn chuyển phát nhanh đường bộ & hàng không</p>
            </div>
            <div className="text-right">
              <span className="font-mono font-bold text-base bg-black text-white px-2 py-0.5 rounded">
                VN-POST
              </span>
            </div>
          </div>

          {/* Barcode & Tracking Code */}
          <div className="border border-black p-3 rounded-lg text-center space-y-1 bg-[#FAFAF9]">
            {/* SVG Simulated Barcode */}
            <div className="flex justify-center items-center h-12 gap-[3px] overflow-hidden px-4">
              {[3,1,2,1,4,2,1,3,2,4,1,2,3,1,1,2,4,1,3,2,1,4,2,3,1,2,1,3,4,2,1,3,2,1,4,1,2,3].map((w, idx) => (
                <div key={idx} className="bg-black h-full" style={{ width: `${w * 1.5}px` }} />
              ))}
            </div>
            <p className="font-mono font-bold text-sm tracking-widest uppercase mt-1">
              {data.orderCode}
            </p>
            <p className="text-[10px] text-gray-500 font-mono">
              Ngày tạo: {data.orderDate ? new Date(data.orderDate).toLocaleDateString('vi-VN') : new Date().toLocaleDateString('vi-VN')}
            </p>
          </div>

          {/* From & To Grid */}
          <div className="grid grid-cols-2 gap-3 border border-black rounded-lg divide-x divide-black overflow-hidden">
            {/* Sender */}
            <div className="p-3 space-y-1 bg-white">
              <span className="font-bold uppercase tracking-wider text-[10px] text-gray-500 block">
                NGƯỜI GỬI (FROM):
              </span>
              <p className="font-bold text-[#191614]">Bookstore Nhã Nam & Tri Thức</p>
              <p className="text-gray-700">59 Đỗ Quang, P. Trung Hòa, Cầu Giấy, Hà Nội</p>
              <p className="font-mono font-semibold text-gray-900 mt-1">Hotline: 1900 6401 - 0988 123 456</p>
            </div>

            {/* Receiver */}
            <div className="p-3 space-y-1 bg-white">
              <span className="font-bold uppercase tracking-wider text-[10px] text-sky-800 block">
                NGƯỜI NHẬN (TO):
              </span>
              <p className="font-bold text-sm text-[#191614] uppercase">{data.customerName}</p>
              <p className="font-mono font-bold text-sm text-[#B84A39]">{data.customerPhone || 'Chưa cung cấp SĐT'}</p>
              <p className="text-gray-800 leading-tight mt-1">{data.shippingAddress}</p>
            </div>
          </div>

          {/* Package Content & COD Box */}
          <div className="grid grid-cols-3 gap-3 border border-black rounded-lg overflow-hidden">
            {/* Content summary (2 cols) */}
            <div className="col-span-2 p-3 space-y-2 border-r border-black">
              <span className="font-bold uppercase tracking-wider text-[10px] text-gray-500 block">
                NỘI DUNG HÀNG HÓA ({items.length} đầu sách, KL: ~{estimatedWeight}g):
              </span>
              <div className="space-y-1">
                {items.map((i, idx) => (
                  <div key={idx} className="flex justify-between items-center text-[11px] border-b border-dashed border-gray-200 pb-0.5">
                    <span className="truncate pr-2 font-medium">{idx + 1}. {i.bookTitle || i.title || 'Sách tuyển chọn'}</span>
                    <span className="font-mono font-bold shrink-0">SL: {i.quantity}</span>
                  </div>
                ))}
              </div>
              {data.note && (
                <p className="text-[10px] text-amber-900 bg-amber-50 p-1.5 rounded border border-amber-200">
                  <strong>Ghi chú đơn:</strong> {data.note}
                </p>
              )}
            </div>

            {/* COD Amount Box (1 col) */}
            <div className="col-span-1 p-3 flex flex-col justify-between text-center bg-gray-50">
              <div>
                <span className="font-bold uppercase tracking-wider text-[10px] text-gray-600 block">
                  TIỀN THU NGƯỜI NHẬN (COD)
                </span>
                <div className="my-2 p-2 bg-white rounded border-2 border-dashed border-black">
                  <span className="font-sans font-black text-base text-[#B84A39] tabular-nums block">
                    {isCod ? formatPrice(data.finalAmount) : '0 VNĐ'}
                  </span>
                  <span className="text-[9px] uppercase font-bold text-gray-500 block mt-0.5">
                    {isCod ? '(Thu tiền khi giao)' : '(Đã thanh toán online)'}
                  </span>
                </div>
              </div>

              <div className="text-[9px] text-gray-500 border-t border-gray-200 pt-1">
                Khối lượng: <strong>{estimatedWeight}g</strong>
              </div>
            </div>
          </div>

          {/* Delivery Instructions & Signatures */}
          <div className="border border-black p-3 rounded-lg grid grid-cols-2 gap-4">
            <div className="space-y-1">
              <span className="font-bold uppercase tracking-wider text-[10px] text-gray-600 block">
                CHỈ DẪN CỦA NGƯỜI GỬI:
              </span>
              <ul className="list-disc list-inside text-[10px] text-gray-700 space-y-0.5">
                <li>Cho khách kiểm tra hàng trước khi nhận, không cho thử.</li>
                <li>Hàng sách giấy cao cấp, cẩn thận tránh ẩm ướt & móp méo.</li>
                <li>Chuyển hoàn sau 3 lần giao không thành công.</li>
              </ul>
            </div>

            <div className="grid grid-cols-2 gap-2 text-center text-[10px]">
              <div>
                <span className="font-semibold block text-gray-600">Chữ ký người gửi</span>
                <div className="h-10 flex items-center justify-center italic text-gray-400">
                  (Đã ký đóng gói)
                </div>
              </div>
              <div>
                <span className="font-semibold block text-gray-600">Chữ ký người nhận</span>
                <div className="h-10 flex items-center justify-center italic text-gray-400">
                  (Ký và ghi rõ họ tên)
                </div>
              </div>
            </div>
          </div>

        </div>

      </div>
    </div>
  )
}
