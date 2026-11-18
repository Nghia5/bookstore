import { useState, useEffect } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { 
  Minus, Plus, Trash2, ShoppingBag, ArrowLeft, BookOpen, 
  CheckCircle, Truck, ShieldAlert, Tag, ArrowRight, User, Printer
} from 'lucide-react'
import { useCartStore } from '@/stores/cartStore'
import { useAuthStore } from '@/stores/authStore'
import { formatPrice } from '@/lib/utils'
import apiClient from '@/api/client'
import { toast } from 'sonner'
import InvoiceModal from '@/components/InvoiceModal'

export default function CartPage() {
  const { items, removeItem, updateQuantity, clearCart, getTotal, appliedVoucherCode, setAppliedVoucher } = useCartStore()
  const { isAuthenticated, user } = useAuthStore()
  const navigate = useNavigate()

  const subtotal = getTotal()
  const shippingFee = subtotal >= 300000 || subtotal === 0 ? 0 : 30000

  // Discount / Voucher state
  const [couponCode, setCouponCode] = useState(appliedVoucherCode || '')
  const [appliedDiscount, setAppliedDiscount] = useState<{ code: string; percent: number; maxAmount?: number; discountAmount?: number } | null>(null)
  const [availableDiscounts, setAvailableDiscounts] = useState<any[]>([])

  let discountAmount = 0
  if (appliedDiscount && subtotal > 0) {
    if (appliedDiscount.discountAmount !== undefined) {
      discountAmount = appliedDiscount.discountAmount
    } else {
      discountAmount = Math.round(subtotal * (appliedDiscount.percent / 100))
      if (appliedDiscount.maxAmount && discountAmount > appliedDiscount.maxAmount) {
        discountAmount = appliedDiscount.maxAmount
      }
    }
  }

  const finalTotal = Math.max(0, subtotal - discountAmount + shippingFee)

  const [isCheckingOut, setIsCheckingOut] = useState(false)
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [orderSuccess, setOrderSuccess] = useState<any>(null)
  const [isInvoiceOpen, setIsInvoiceOpen] = useState(false)

  const [formData, setFormData] = useState({
    receiverName: user?.fullName || '',
    receiverPhone: user?.phoneNumber || '',
    streetAddress: '',
    paymentMethod: 0, // 0 = COD, 1 = VnPay
    note: ''
  })

  // Synchronize user profile into checkout form when auth status changes
  useEffect(() => {
    if (user) {
      setFormData(prev => ({
        ...prev,
        receiverName: prev.receiverName || user.fullName || '',
        receiverPhone: prev.receiverPhone || user.phoneNumber || ''
      }))
    }

    // Load active discounts
    apiClient.get('/discounts')
      .then(res => setAvailableDiscounts(res.data || []))
      .catch(() => {})
  }, [user])

  // Handle voucher apply with API verification
  const handleApplyCouponWithCode = async (codeToApply: string) => {
    const code = codeToApply.trim().toUpperCase()
    if (!code) return

    try {
      const res = await apiClient.post('/discounts/validate', {
        code,
        orderAmount: subtotal
      })

      if (res.data.isValid) {
        setAppliedDiscount({
          code: res.data.code,
          percent: res.data.discountPercent,
          maxAmount: res.data.maxDiscountAmount,
          discountAmount: res.data.discountAmount
        })
        setAppliedVoucher(res.data.code)
        toast.success(res.data.message || `Đã áp dụng mã ${res.data.code}!`)
      }
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Mã giảm giá không hợp lệ hoặc chưa đủ điều kiện.')
    }
  }

  // Pre-apply voucher if set from BookDetailPage or store
  useEffect(() => {
    if (appliedVoucherCode && subtotal > 0 && !appliedDiscount) {
      handleApplyCouponWithCode(appliedVoucherCode)
    }
  }, [appliedVoucherCode, subtotal])

  const handleApplyCoupon = (e: React.FormEvent) => {
    e.preventDefault()
    handleApplyCouponWithCode(couponCode)
  }

  // Handle checkout submit
  const handleCheckoutSubmit = async (e: React.FormEvent) => {
    e.preventDefault()

    // 1. Enforce login strictly
    if (!isAuthenticated) {
      toast.error('Vui lòng đăng nhập tài khoản trước khi tiến hành thanh toán.')
      navigate('/login?redirect=/cart')
      return
    }

    // 2. Validate form
    if (!formData.receiverName.trim() || !formData.receiverPhone.trim() || !formData.streetAddress.trim()) {
      toast.error('Vui lòng điền đầy đủ họ tên, số điện thoại và địa chỉ nhận hàng.')
      return
    }

    try {
      setIsSubmitting(true)
      const payload = {
        items: items.map(item => ({
          bookId: item.bookId,
          quantity: item.quantity
        })),
        paymentMethod: Number(formData.paymentMethod),
        receiverName: formData.receiverName.trim(),
        receiverPhone: formData.receiverPhone.trim(),
        streetAddress: formData.streetAddress.trim(),
        note: formData.note.trim(),
        discountCode: appliedDiscount ? appliedDiscount.code : undefined
      }

      const res = await apiClient.post('/orders', payload)
      setOrderSuccess(res.data)
      clearCart()
      toast.success('Đặt hàng thành công!')
    } catch (err: any) {
      console.error('Checkout error:', err)
      if (err.response?.status === 401) {
        toast.error('Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.')
        navigate('/login?redirect=/cart')
        return
      }
      toast.error(err.response?.data?.message || 'Có lỗi xảy ra trong quá trình đặt hàng.')
    } finally {
      setIsSubmitting(false)
    }
  }

  // Order confirmation view
  if (orderSuccess) {
    return (
      <div className="mx-auto max-w-xl px-4 py-16 text-center sm:px-6">
        <div className="mx-auto mb-6 flex h-20 w-20 items-center justify-center rounded-full bg-emerald-100 text-emerald-700 shadow-sm">
          <CheckCircle className="h-12 w-12" />
        </div>
        <h2 className="font-serif text-3xl font-bold text-[#191614] mb-2">Cảm ơn bạn đã đặt sách!</h2>
        <p className="text-sm text-[#615C56] mb-6">
          Mã đơn hàng của bạn là: <strong className="text-[#B84A39] font-mono text-base">{orderSuccess.orderCode}</strong>
        </p>

        <div className="bg-white rounded-3xl p-6 border border-[#EBE7DC] text-left mb-8 shadow-xs space-y-3">
          <div className="flex justify-between py-2 border-b border-[#F5F3ED] text-sm">
            <span className="text-[#615C56]">Tổng thanh toán:</span>
            <strong className="text-[#B84A39] text-base">{formatPrice(orderSuccess.finalAmount || finalTotal)}</strong>
          </div>
          <div className="flex justify-between py-2 border-b border-[#F5F3ED] text-sm">
            <span className="text-[#615C56]">Phương thức thanh toán:</span>
            <span className="font-medium text-[#191614]">
              {orderSuccess.paymentMethod === 'COD' || orderSuccess.paymentMethod === '0' 
                ? 'Thanh toán khi nhận hàng (COD)' 
                : 'Thanh toán trực tuyến'}
            </span>
          </div>
          <div className="flex justify-between py-2 text-sm">
            <span className="text-[#615C56]">Trạng thái xử lý:</span>
            <span className="px-2.5 py-0.5 rounded-full text-xs font-semibold bg-amber-100 text-amber-900 border border-amber-300">
              Chờ xác nhận &amp; đóng gói
            </span>
          </div>
        </div>

        <div className="flex flex-col sm:flex-row justify-center gap-3">
          <button
            onClick={() => setIsInvoiceOpen(true)}
            className="rounded-xl bg-[#FAF9F5] border border-[#DDD6C4] px-6 py-3 text-sm font-semibold text-[#191614] hover:bg-[#EBE7DC] transition-colors flex items-center justify-center gap-2 shadow-2xs"
          >
            <Printer className="w-4 h-4 text-[#B84A39]" />
            <span>In Hóa Đơn / Lưu PDF</span>
          </button>
          <Link
            to="/orders"
            className="rounded-xl bg-[#191614] px-6 py-3 text-sm font-semibold text-[#FAFAF7] hover:bg-[#B84A39] transition-colors shadow-sm flex items-center justify-center"
          >
            Xem lịch sử đơn hàng
          </Link>
          <Link
            to="/books"
            className="rounded-xl border border-[#DDD6C4] bg-white px-6 py-3 text-sm font-semibold text-[#191614] hover:bg-[#F5F3ED] transition-colors flex items-center justify-center"
          >
            Tiếp tục mua sắm
          </Link>
        </div>

        {/* Invoice Modal for newly created order */}
        <InvoiceModal
          isOpen={isInvoiceOpen}
          onClose={() => setIsInvoiceOpen(false)}
          data={{
            orderCode: orderSuccess.orderCode,
            orderDate: new Date().toISOString(),
            customerName: formData.receiverName || user?.fullName || 'Khách hàng',
            phoneNumber: formData.receiverPhone || user?.phoneNumber || '',
            address: formData.streetAddress || 'Nhận tại cửa hàng',
            paymentMethod: formData.paymentMethod === 0 ? 'COD - Tiền mặt khi nhận' : 'Chuyển khoản trực tuyến',
            status: 'Chờ xác nhận & đóng gói',
            items: orderSuccess.items?.map((i: any) => ({
              title: i.bookTitle || 'Sách tuyển chọn',
              quantity: i.quantity,
              price: i.unitPrice
            })) || [],
            subtotal,
            discountAmount,
            shippingFee,
            finalAmount: orderSuccess.finalAmount || finalTotal,
            note: formData.note
          }}
        />
      </div>
    )
  }

  // Empty cart view
  if (items.length === 0) {
    return (
      <div className="mx-auto max-w-2xl px-4 py-20 text-center sm:px-6">
        <div className="mx-auto mb-6 flex h-24 w-24 items-center justify-center rounded-3xl bg-[#F5F3ED] text-[#DDD6C4]">
          <ShoppingBag className="h-12 w-12" strokeWidth={1.5} />
        </div>
        <h2 className="font-serif text-2xl font-bold text-[#191614]">Giỏ hàng của bạn đang trống</h2>
        <p className="mt-2 text-sm text-[#615C56]">
          Hãy khám phá những ấn phẩm kinh điển và hiện đại để bổ sung vào tủ sách gia đình nhé.
        </p>
        <Link
          to="/books"
          className="mt-6 inline-flex items-center gap-2 rounded-xl bg-[#191614] px-6 py-3.5 text-sm font-semibold text-white shadow-md transition-all hover:bg-[#B84A39]"
        >
          <BookOpen className="h-4 w-4 text-[#D97706]" />
          <span>Duyệt tủ sách tuyển chọn</span>
        </Link>
      </div>
    )
  }

  return (
    <div className="mx-auto max-w-6xl px-4 py-8 sm:px-6 lg:px-8">
      {/* Header */}
      <div className="mb-8 flex items-center justify-between">
        <div>
          <Link to="/books" className="mb-2 inline-flex items-center gap-1.5 text-xs text-[#B84A39] hover:underline font-semibold">
            <ArrowLeft className="h-3.5 w-3.5" />
            Tiếp tục chọn sách
          </Link>
          <h1 className="font-serif text-3xl font-bold text-[#191614]">Giỏ hàng của bạn</h1>
          <p className="mt-1 text-xs text-[#615C56]">Đang có {items.length} đầu sách được chọn</p>
        </div>
        <button
          onClick={clearCart}
          className="rounded-xl border border-red-200 px-3.5 py-2 text-xs font-semibold text-red-600 transition-colors hover:bg-red-50"
        >
          Làm trống giỏ
        </button>
      </div>

      <div className="flex flex-col lg:flex-row gap-8">
        
        {/* Cart Items List */}
        <div className="flex-1 space-y-3.5">
          {items.map((item) => {
            const price = item.book.salePrice ?? item.book.originalPrice
            return (
              <div
                key={item.id}
                className="flex gap-4 rounded-2xl border border-[#EBE7DC] bg-white p-4 shadow-xs hover:border-[#DDD6C4] transition-all"
              >
                {/* Book Cover */}
                <div className="h-28 w-20 shrink-0 overflow-hidden rounded-xl bg-[#F5F3ED] border border-[#DDD6C4]">
                  <img
                    src={
                      item.book.title?.toLowerCase().includes('đất rừng') || item.book.title?.toLowerCase().includes('dat rung')
                        ? 'https://salt.tikicdn.com/cache/750x750/ts/product/31/a2/1b/70b1e4fc2b497fec6193aa5ce79b8338.jpg'
                        : (item.book.coverImageUrl || 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg')
                    }
                    alt={item.book.title}
                    referrerPolicy="no-referrer"
                    onError={(e) => {
                      (e.target as HTMLImageElement).src = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg'
                    }}
                    className="h-full w-full object-cover"
                  />
                </div>

                {/* Info */}
                <div className="flex flex-1 flex-col min-w-0">
                  <h3 className="font-serif text-base font-bold text-[#191614] line-clamp-1">
                    {item.book.title}
                  </h3>
                  <p className="text-xs text-[#615C56] mt-0.5 truncate">
                    {item.book.authors?.map((a) => a.name).join(', ') || 'Tác giả'}
                  </p>

                  <div className="mt-auto flex items-end justify-between pt-3">
                    {/* Quantity Selector */}
                    <div className="flex items-center gap-1 rounded-xl border border-[#DDD6C4] bg-[#FAFAF7] p-0.5">
                      <button
                        onClick={() => updateQuantity(item.bookId, item.quantity - 1)}
                        className="p-1.5 text-[#615C56] hover:text-[#191614] transition-colors rounded-lg hover:bg-white"
                        title="Giảm số lượng"
                      >
                        <Minus className="h-3.5 w-3.5" />
                      </button>
                      <span className="w-8 text-center text-xs font-bold text-[#191614]">
                        {item.quantity}
                      </span>
                      <button
                        onClick={() => updateQuantity(item.bookId, item.quantity + 1)}
                        className="p-1.5 text-[#615C56] hover:text-[#191614] transition-colors rounded-lg hover:bg-white"
                        title="Tăng số lượng"
                      >
                        <Plus className="h-3.5 w-3.5" />
                      </button>
                    </div>

                    {/* Price and Delete */}
                    <div className="flex items-center gap-3">
                      <span className="font-serif font-bold text-[#B84A39] text-base">
                        {formatPrice(price * item.quantity)}
                      </span>
                      <button
                        onClick={() => removeItem(item.bookId)}
                        className="p-1.5 text-[#8C857B] hover:text-red-600 transition-colors"
                        title="Xóa sách khỏi giỏ"
                      >
                        <Trash2 className="h-4 w-4" />
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            )
          })}
        </div>

        {/* Order Summary & Checkout Form */}
        <div className="lg:w-96 shrink-0">
          <div className="sticky top-24 rounded-3xl border border-[#EBE7DC] bg-white p-6 shadow-xs space-y-4">
            <h3 className="font-serif text-lg font-bold text-[#191614]">Tóm tắt đơn hàng</h3>

            {/* Price Calculations */}
            <div className="space-y-2.5 text-xs">
              <div className="flex justify-between text-[#615C56]">
                <span>Tạm tính</span>
                <span className="font-semibold text-[#191614]">{formatPrice(subtotal)}</span>
              </div>
              
              {discountAmount > 0 && (
                <div className="flex justify-between text-emerald-700 font-medium">
                  <span>Mã giảm giá ({appliedDiscount?.code})</span>
                  <span>-{formatPrice(discountAmount)}</span>
                </div>
              )}

              <div className="flex justify-between text-[#615C56]">
                <span>Phí vận chuyển</span>
                <span>{shippingFee === 0 ? <span className="text-emerald-700 font-bold">Miễn phí</span> : formatPrice(shippingFee)}</span>
              </div>

              {shippingFee > 0 && (
                <p className="text-[11px] text-emerald-700 bg-emerald-50 px-2 py-1 rounded-lg">
                  💡 Miễn phí vận chuyển cho đơn hàng từ {formatPrice(300000)}
                </p>
              )}

              <hr className="border-[#F5F3ED]" />
              
              <div className="flex justify-between font-bold text-[#191614] text-sm pt-1">
                <span>Tổng thanh toán</span>
                <span className="font-sans font-bold text-2xl text-[#B84A39] tabular-nums">{formatPrice(finalTotal)}</span>
              </div>
            </div>

            {/* Voucher Coupon Box */}
            <div className="pt-3 border-t border-[#F5F3ED] space-y-2.5">
              <div className="flex items-center justify-between">
                <span className="text-xs font-bold text-[#191614] flex items-center gap-1.5">
                  <Tag className="w-3.5 h-3.5 text-[#B84A39]" />
                  <span>Mã Giảm Giá / Voucher</span>
                </span>
                {appliedDiscount && (
                  <span className="text-[10px] font-bold text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-full border border-emerald-200">
                    Đã áp dụng
                  </span>
                )}
              </div>

              {appliedDiscount ? (
                <div className="p-3 bg-emerald-50/80 border border-emerald-300 rounded-2xl flex items-center justify-between">
                  <div className="flex items-center gap-2.5">
                    <div className="w-8 h-8 rounded-xl bg-emerald-600 text-white flex items-center justify-center font-bold font-mono text-xs">
                      %
                    </div>
                    <div>
                      <span className="font-mono font-bold text-xs text-emerald-950 block">
                        {appliedDiscount.code} (-{appliedDiscount.percent}%)
                      </span>
                      <span className="text-[11px] text-emerald-700 font-bold font-sans tabular-nums">
                        Tiết kiệm: -{formatPrice(discountAmount)}
                      </span>
                    </div>
                  </div>
                  <button
                    type="button"
                    onClick={() => {
                      setAppliedDiscount(null)
                      setCouponCode('')
                      setAppliedVoucher(null)
                      toast.info('Đã gỡ mã giảm giá.')
                    }}
                    className="text-[11px] font-bold text-red-600 hover:text-red-800 hover:bg-red-50 px-2 py-1 rounded-lg transition-colors"
                  >
                    Gỡ mã
                  </button>
                </div>
              ) : (
                <form onSubmit={handleApplyCoupon} className="space-y-2">
                  <div className="flex gap-2">
                    <div className="relative flex-1">
                      <Tag className="absolute left-3 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-[#8C857B]" />
                      <input
                        type="text"
                        value={couponCode}
                        onChange={(e) => setCouponCode(e.target.value)}
                        placeholder="Nhập mã (WELCOME10...)"
                        className="w-full text-xs rounded-xl border border-[#DDD6C4] py-2 pl-8 pr-2 uppercase outline-none focus:border-[#191614]"
                      />
                    </div>
                    <button
                      type="submit"
                      className="px-3.5 py-2 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-semibold transition-colors shrink-0"
                    >
                      Áp dụng
                    </button>
                  </div>

                  {/* Available Voucher Chips */}
                  {availableDiscounts.length > 0 && (
                    <div className="pt-1">
                      <span className="text-[10px] text-[#8C857B] block mb-1">Mã có sẵn cho bạn (nhấn để áp dụng ngay):</span>
                      <div className="flex flex-wrap gap-1.5">
                        {availableDiscounts.map(d => (
                          <button
                            type="button"
                            key={d.id}
                            onClick={() => {
                              setCouponCode(d.code)
                              handleApplyCouponWithCode(d.code)
                            }}
                            className="text-[10px] font-mono font-bold px-2 py-1 rounded-lg bg-[#FAF9F5] hover:bg-[#EBE7DC] border border-[#DDD6C4] text-[#B84A39] transition-colors shadow-2xs"
                          >
                            {d.code} (-{d.discountPercent}%)
                          </button>
                        ))}
                      </div>
                    </div>
                  )}
                </form>
              )}
            </div>

            {/* LOGIN REQUIREMENT GATEWAY */}
            {!isAuthenticated ? (
              <div className="rounded-2xl bg-amber-50 border border-amber-200 p-4 text-left space-y-3">
                <div className="flex items-start gap-2.5">
                  <ShieldAlert className="w-5 h-5 text-amber-700 shrink-0 mt-0.5" />
                  <div>
                    <h4 className="text-xs font-bold text-amber-900 uppercase tracking-wider">
                      Yêu cầu đăng nhập tài khoản
                    </h4>
                    <p className="text-xs text-amber-800 mt-1 leading-relaxed">
                      Để đảm bảo quyền lợi tích điểm độc giả và theo dõi lộ trình giao hàng, quý khách vui lòng đăng nhập trước khi tiến hành thanh toán.
                    </p>
                  </div>
                </div>

                <div className="flex flex-col gap-2 pt-1">
                  <Link
                    to="/login?redirect=/cart"
                    className="w-full py-3 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-bold text-center transition-all shadow-xs flex items-center justify-center gap-1.5"
                  >
                    <User className="w-3.5 h-3.5" />
                    <span>Đăng nhập để đặt hàng</span>
                    <ArrowRight className="w-3.5 h-3.5" />
                  </Link>

                  <Link
                    to="/register"
                    className="w-full py-2.5 rounded-xl border border-amber-300 text-amber-900 hover:bg-amber-100 text-xs font-semibold text-center transition-all"
                  >
                    Tạo tài khoản mới
                  </Link>
                </div>
              </div>
            ) : !isCheckingOut ? (
              /* User is authenticated, ready to proceed */
              <button 
                onClick={() => setIsCheckingOut(true)}
                className="mt-4 w-full rounded-xl bg-[#191614] py-3.5 text-sm font-semibold text-white shadow-md transition-all hover:bg-[#B84A39] flex items-center justify-center gap-2"
              >
                <span>Điền thông tin giao hàng</span>
                <ArrowRight className="h-4 w-4" />
              </button>
            ) : (
              /* Checkout form for authenticated user */
              <form onSubmit={handleCheckoutSubmit} className="mt-4 space-y-3 border-t border-[#F5F3ED] pt-4">
                <div className="flex items-center justify-between">
                  <h4 className="font-bold text-xs uppercase tracking-wider text-[#B84A39]">
                    Thông tin giao nhận
                  </h4>
                  <span className="text-[11px] text-[#8C857B]">
                    Tài khoản: <strong>{user?.fullName}</strong>
                  </span>
                </div>
                
                <div>
                  <label className="block text-[11px] font-semibold text-[#423E3A] mb-1">
                    Họ và tên người nhận <span className="text-red-500">*</span>
                  </label>
                  <input
                    type="text"
                    required
                    value={formData.receiverName}
                    onChange={e => setFormData({ ...formData, receiverName: e.target.value })}
                    placeholder="Nguyễn Văn A"
                    className="w-full text-xs rounded-xl border border-[#DDD6C4] p-2.5 outline-none focus:border-[#191614]"
                  />
                </div>

                <div>
                  <label className="block text-[11px] font-semibold text-[#423E3A] mb-1">
                    Số điện thoại nhận hàng <span className="text-red-500">*</span>
                  </label>
                  <input
                    type="tel"
                    required
                    value={formData.receiverPhone}
                    onChange={e => setFormData({ ...formData, receiverPhone: e.target.value })}
                    placeholder="0912 345 678"
                    className="w-full text-xs rounded-xl border border-[#DDD6C4] p-2.5 outline-none focus:border-[#191614]"
                  />
                </div>

                <div>
                  <label className="block text-[11px] font-semibold text-[#423E3A] mb-1">
                    Địa chỉ nhận hàng chi tiết <span className="text-red-500">*</span>
                  </label>
                  <textarea
                    required
                    rows={2}
                    value={formData.streetAddress}
                    onChange={e => setFormData({ ...formData, streetAddress: e.target.value })}
                    placeholder="Số nhà, tên đường, phường/xã, quận/huyện..."
                    className="w-full text-xs rounded-xl border border-[#DDD6C4] p-2.5 outline-none focus:border-[#191614]"
                  />
                </div>

                <div className="space-y-1.5 pt-1">
                  <label className="text-xs font-semibold text-[#191614] block">Hình thức thanh toán:</label>
                  <label className="flex items-center gap-2 text-xs text-[#191614] cursor-pointer p-2 rounded-xl border border-[#EBE7DC] hover:bg-[#FAFAF7]">
                    <input
                      type="radio"
                      name="paymentMethod"
                      value={0}
                      checked={formData.paymentMethod === 0}
                      onChange={() => setFormData({ ...formData, paymentMethod: 0 })}
                      className="accent-[#191614]"
                    />
                    <span>Thanh toán khi nhận hàng (COD)</span>
                  </label>
                  <label className="flex items-center gap-2 text-xs text-[#191614] cursor-pointer p-2 rounded-xl border border-[#EBE7DC] hover:bg-[#FAFAF7]">
                    <input
                      type="radio"
                      name="paymentMethod"
                      value={1}
                      checked={formData.paymentMethod === 1}
                      onChange={() => setFormData({ ...formData, paymentMethod: 1 })}
                      className="accent-[#191614]"
                    />
                    <span>Thanh toán trực tuyến (VNPAY QR)</span>
                  </label>
                </div>

                <button
                  type="submit"
                  disabled={isSubmitting}
                  className="w-full rounded-xl bg-[#191614] hover:bg-[#B84A39] py-3.5 text-sm font-semibold text-white shadow-md transition-all disabled:opacity-50 mt-2"
                >
                  {isSubmitting ? 'Đang tạo đơn...' : `Xác nhận đặt hàng (${formatPrice(finalTotal)})`}
                </button>

                <button
                  type="button"
                  onClick={() => setIsCheckingOut(false)}
                  className="w-full text-xs text-[#8C857B] hover:text-[#191614] text-center block pt-1"
                >
                  Quay lại xem giỏ hàng
                </button>
              </form>
            )}

            <div className="mt-4 flex items-center justify-center gap-2 text-xs text-[#615C56] pt-2 border-t border-[#F5F3ED]">
              <Truck className="h-3.5 w-3.5 text-[#B84A39]" />
              <span>Giao hàng toàn quốc từ 2 - 3 ngày</span>
            </div>
          </div>
        </div>

      </div>
    </div>
  )
}
