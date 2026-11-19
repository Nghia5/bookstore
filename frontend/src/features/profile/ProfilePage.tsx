import { useState, useEffect } from 'react'
import { Link, useLocation } from 'react-router-dom'
import { 
  User, Mail, Phone, Lock, MapPin, Package, Shield, 
  Award, Edit, Calendar, ArrowRight, Eye, EyeOff, Heart, 
  Ticket, Copy, Plus, Trash2, ShoppingBag, X, Printer
} from 'lucide-react'
import { useAuthStore } from '@/stores/authStore'
import { useWishlistStore } from '@/stores/wishlistStore'
import { useCartStore } from '@/stores/cartStore'
import apiClient from '@/api/client'
import { toast } from 'sonner'
import { cn, formatPrice } from '@/lib/utils'
import InvoiceModal from '@/components/InvoiceModal'
import type { InvoiceData } from '@/components/InvoiceModal'

interface UserProfileData {
  id: number
  email: string
  fullName: string
  phoneNumber?: string
  role: string
  createdAt?: string
  totalOrders: number
  totalSpent: number
  addresses: Array<{
    id: number
    receiverName: string
    receiverPhone: string
    streetAddress: string
    ward: string
    district: string
    city: string
    isDefault: boolean
  }>
}

interface OrderItem {
  bookTitle: string
  quantity: number
  unitPrice: number
  lineTotal: number
}

interface UserOrder {
  id: number
  orderCode: string
  orderDate: string
  customerName?: string
  customerPhone?: string
  shippingAddress?: string
  totalAmount?: number
  discountAmount?: number
  shippingFee?: number
  finalAmount: number
  status: string
  paymentMethod: string
  items: OrderItem[]
}



export default function ProfilePage() {
  const { user, isAuthenticated, updateUser, logout } = useAuthStore()
  const { items: wishlistBooks, removeFromWishlist } = useWishlistStore()
  const addToCart = useCartStore((s) => s.addItem)
  const location = useLocation()
  const [availableVouchers, setAvailableVouchers] = useState<{ code: string; title: string; desc: string; expiry: string; tag: string }[]>([])
  const [loyalty, setLoyalty] = useState<{ earned: number; used: number; balance: number; pointValue: number }>({ earned: 0, used: 0, balance: 0, pointValue: 100 })

  // Tab state: info | orders | addresses | wishlist | vouchers | password
  const [activeTab, setActiveTab] = useState<'info' | 'orders' | 'addresses' | 'wishlist' | 'vouchers' | 'password'>(
    location.pathname.includes('/orders') ? 'orders' : 'info'
  )

  const [, setLoading] = useState(false)
  const [profileData, setProfileData] = useState<UserProfileData | null>(null)
  const [orders, setOrders] = useState<UserOrder[]>([])

  // Invoice modal state
  const [isInvoiceOpen, setIsInvoiceOpen] = useState(false)
  const [selectedInvoiceData, setSelectedInvoiceData] = useState<InvoiceData | null>(null)

  // Edit profile form state
  const [fullName, setFullName] = useState(user?.fullName || '')
  const [phoneNumber, setPhoneNumber] = useState(user?.phoneNumber || '')
  const [isEditingInfo, setIsEditingInfo] = useState(false)

  // Change password form state
  const [currentPassword, setCurrentPassword] = useState('')
  const [newPassword, setNewPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [showCurrentPass, setShowCurrentPass] = useState(false)
  const [showNewPass, setShowNewPass] = useState(false)

  // Add Address Modal
  const [isAddressModalOpen, setIsAddressModalOpen] = useState(false)
  const [newAddress, setNewAddress] = useState({
    receiverName: user?.fullName || '',
    receiverPhone: user?.phoneNumber || '',
    streetAddress: '',
    ward: 'Phường Bến Nghé',
    district: 'Quận 1',
    city: 'TP. Hồ Chí Minh',
    isDefault: false
  })

  // 1. Fetch user profile data from /auth/me
  const fetchProfile = async () => {
    try {
      setLoading(true)
      const res = await apiClient.get('/auth/me')
      setProfileData(res.data)
      setFullName(res.data.fullName)
      setPhoneNumber(res.data.phoneNumber || '')
    } catch {
      // Keep local state
    } finally {
      setLoading(false)
    }
  }

  // 2. Fetch my orders
  const fetchMyOrders = async () => {
    try {
      const res = await apiClient.get('/orders/my-orders')
      setOrders(res.data || [])
    } catch {
      // Fallback empty orders
    }
  }

  useEffect(() => {
    apiClient.get('/discounts').then(res => {
      const fmt = (n?: number | null) => (n ?? 0).toLocaleString('vi-VN') + 'đ'
      setAvailableVouchers((res.data || []).map((d: any) => ({
        code: d.code,
        title: `Giảm ${d.discountPercent}%${d.maxDiscountAmount ? ' tối đa ' + fmt(d.maxDiscountAmount) : ''}`,
        desc: d.minOrderAmount ? `Áp dụng cho đơn từ ${fmt(d.minOrderAmount)}` : 'Áp dụng cho mọi đơn hàng',
        expiry: new Date(d.endDate).toLocaleDateString('vi-VN'),
        tag: d.usageLimit ? `Còn ${Math.max(0, d.usageLimit - d.timesUsed)} lượt` : 'Không giới hạn lượt',
      })))
    }).catch(() => setAvailableVouchers([]))
  }, [])
  useEffect(() => {
    if (isAuthenticated) {
      fetchProfile()
      fetchMyOrders()
      apiClient.get('/orders/loyalty').then(r => setLoyalty(r.data)).catch(() => {})
    }
  }, [isAuthenticated])

  useEffect(() => {
    if (location.pathname.includes('/orders')) {
      setActiveTab('orders')
    }
  }, [location.pathname])

  // Handle update profile info
  const handleUpdateProfile = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!fullName.trim()) {
      toast.error('Vui lòng nhập họ và tên.')
      return
    }

    try {
      const res = await apiClient.put('/auth/profile', {
        fullName: fullName.trim(),
        phoneNumber: phoneNumber.trim()
      })
      updateUser({ fullName: fullName.trim(), phoneNumber: phoneNumber.trim() })
      toast.success(res.data?.message || 'Cập nhật thông tin thành công!')
      setIsEditingInfo(false)
      fetchProfile()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Không thể cập nhật thông tin.')
    }
  }

  // Handle Cancel Order
  const handleCancelOrder = async (orderId: number) => {
    if (!confirm('Bạn có chắc chắn muốn hủy đơn hàng này không?')) return

    try {
      await apiClient.put(`/orders/${orderId}/cancel`)
      toast.success('Đã hủy đơn hàng thành công!')
      fetchMyOrders()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Không thể hủy đơn hàng.')
    }
  }

  // Handle Add New Address
  const handleSaveAddress = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!newAddress.receiverName.trim() || !newAddress.streetAddress.trim()) {
      toast.error('Vui lòng điền họ tên người nhận và địa chỉ.')
      return
    }

    try {
      await apiClient.post('/auth/addresses', {
        receiverName: newAddress.receiverName.trim(),
        receiverPhone: newAddress.receiverPhone.trim(),
        streetAddress: newAddress.streetAddress.trim(),
        ward: newAddress.ward.trim(),
        district: newAddress.district.trim(),
        city: newAddress.city.trim(),
        isDefault: newAddress.isDefault
      })
      toast.success('Đã thêm địa chỉ nhận hàng mới!')
      setIsAddressModalOpen(false)
      setNewAddress({
        receiverName: user?.fullName || '',
        receiverPhone: user?.phoneNumber || '',
        streetAddress: '',
        ward: 'Phường Bến Nghé',
        district: 'Quận 1',
        city: 'TP. Hồ Chí Minh',
        isDefault: false
      })
      fetchProfile()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Không thể lưu địa chỉ.')
    }
  }

  // Handle Delete Address
  const handleDeleteAddress = async (id: number) => {
    if (!confirm('Bạn có chắc chắn muốn xóa địa chỉ này?')) return

    try {
      await apiClient.delete(`/auth/addresses/${id}`)
      toast.success('Đã xóa địa chỉ thành công!')
      fetchProfile()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Không thể xóa địa chỉ.')
    }
  }

  // Handle change password
  const handleChangePassword = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!currentPassword) {
      toast.error('Vui lòng nhập mật khẩu hiện tại.')
      return
    }
    if (newPassword.length < 6) {
      toast.error('Mật khẩu mới phải có ít nhất 6 ký tự.')
      return
    }
    if (newPassword !== confirmPassword) {
      toast.error('Mật khẩu xác nhận không khớp.')
      return
    }

    try {
      const res = await apiClient.put('/auth/change-password', {
        currentPassword,
        newPassword
      })
      toast.success(res.data?.message || 'Đổi mật khẩu thành công!')
      setCurrentPassword('')
      setNewPassword('')
      setConfirmPassword('')
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Đổi mật khẩu không thành công.')
    }
  }

  // Copy voucher
  const handleCopyVoucher = (code: string) => {
    navigator.clipboard.writeText(code)
    toast.success(`Đã sao chép mã ưu đãi: ${code}`)
  }

  // If not logged in
  if (!isAuthenticated || !user) {
    return (
      <div className="min-h-[70vh] flex items-center justify-center px-4 py-16">
        <div className="w-full max-w-md bg-white border border-[#EBE7DC] rounded-3xl p-8 text-center shadow-lg">
          <div className="mx-auto w-16 h-16 rounded-2xl bg-[#F5F3ED] flex items-center justify-center text-[#B84A39] mb-4">
            <User className="w-8 h-8" />
          </div>
          <h2 className="text-2xl font-serif font-bold text-[#191614] mb-2">
            Tài Khoản Độc Giả
          </h2>
          <p className="text-xs text-[#706B65] mb-6">
            Vui lòng đăng nhập để xem thông tin cá nhân, lịch sử đơn hàng, sổ địa chỉ và ưu đãi của bạn.
          </p>
          <div className="flex flex-col gap-2.5">
            <Link
              to="/login"
              className="w-full py-3 rounded-xl bg-[#191614] text-white text-xs font-semibold hover:bg-[#B84A39] transition-all shadow-sm"
            >
              Đăng nhập ngay
            </Link>
            <Link
              to="/register"
              className="w-full py-3 rounded-xl border border-[#DDD6C4] text-[#423E3A] text-xs font-medium hover:bg-[#F5F3ED] transition-all"
            >
              Tạo tài khoản mới
            </Link>
          </div>
        </div>
      </div>
    )
  }

  const initialLetter = (user.fullName || 'U').charAt(0).toUpperCase()

  return (
    <div className="min-h-screen bg-[#FDFCF9] pb-20 pt-8">
      <div className="mx-auto max-w-6xl px-4 sm:px-6 lg:px-8">
        
        {/* ================= USER HERO HEADER ================= */}
        <div className="relative overflow-hidden rounded-3xl border border-[#EBE7DC] bg-white p-6 sm:p-8 shadow-xs mb-8">
          <div className="flex flex-col sm:flex-row items-center sm:items-start gap-6">
            
            {/* Avatar Circle */}
            <div className="relative flex-shrink-0">
              <div className="w-20 h-20 sm:w-24 sm:h-24 rounded-2xl bg-gradient-to-br from-[#191614] to-[#423E3A] text-[#F5F3ED] font-serif text-3xl sm:text-4xl font-bold flex items-center justify-center shadow-md">
                {initialLetter}
              </div>
              <div className="absolute -bottom-1.5 -right-1.5 p-1 rounded-lg bg-amber-100 border border-amber-300 text-amber-800">
                <Award className="w-4 h-4" />
              </div>
            </div>

            {/* User Info Details */}
            <div className="flex-1 text-center sm:text-left space-y-1.5">
              <div className="flex flex-wrap items-center justify-center sm:justify-start gap-2.5">
                <h1 className="text-2xl sm:text-3xl font-serif font-bold text-[#191614]">
                  {user.fullName}
                </h1>
                <span className={cn(
                  "px-2.5 py-0.5 rounded-full text-xs font-bold uppercase tracking-wider border",
                  user.role === 'Admin' ? "bg-amber-100 text-amber-900 border-amber-300" :
                  (user.role === 'SalesStaff' || user.role === 'WarehouseStaff') ? "bg-blue-100 text-blue-900 border-blue-300" :
                  "bg-emerald-100 text-emerald-900 border-emerald-300"
                )}>
                  {user.role === 'Admin' ? 'Quản trị viên' : 
                   (user.role === 'SalesStaff' || user.role === 'WarehouseStaff') ? 'Nhân viên hệ thống' : 
                   'Độc giả Vàng (Hội viên)'}
                </span>
              </div>

              <div className="flex flex-wrap items-center justify-center sm:justify-start gap-4 text-xs sm:text-sm text-[#706B65] pt-1">
                <div className="flex items-center gap-1.5">
                  <Mail className="w-4 h-4 text-[#8C857B]" />
                  <span>{user.email}</span>
                </div>
                {user.phoneNumber && (
                  <div className="flex items-center gap-1.5">
                    <Phone className="w-4 h-4 text-[#8C857B]" />
                    <span>{user.phoneNumber}</span>
                  </div>
                )}
                <div className="flex items-center gap-1.5">
                  <Calendar className="w-4 h-4 text-[#8C857B]" />
                  <span>Tham gia từ 2026</span>
                </div>
              </div>
            </div>

            {/* Quick Action Buttons */}
            <div className="flex items-center gap-2">
              {user.role === 'Admin' && (
                <Link
                  to="/admin"
                  className="flex items-center gap-1.5 px-3.5 py-2 rounded-xl bg-amber-500 hover:bg-amber-600 text-white text-xs font-bold transition-all shadow-xs"
                >
                  <Shield className="w-4 h-4" />
                  <span>Bảng điều khiển Admin</span>
                </Link>
              )}
              <button
                onClick={logout}
                className="px-3.5 py-2 rounded-xl border border-red-200 text-red-600 hover:bg-red-50 text-xs font-semibold transition-all"
              >
                Đăng xuất
              </button>
            </div>

          </div>

          {/* Quick Metrics Bar */}
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 mt-8 pt-6 border-t border-[#F5F3ED]">
            <div className="text-center sm:text-left">
              <span className="text-[11px] font-bold uppercase tracking-wider text-[#8C857B]">Đơn hàng đã đặt</span>
              <div className="font-serif text-xl font-bold text-[#191614] mt-0.5">
                {profileData?.totalOrders ?? orders.length} đơn
              </div>
            </div>
            <div className="text-center sm:text-left">
              <span className="text-[11px] font-bold uppercase tracking-wider text-[#8C857B]">Tổng chi tiêu</span>
              <div className="font-serif text-xl font-bold text-[#B84A39] mt-0.5">
                {(profileData?.totalSpent ?? 0).toLocaleString('vi-VN')} đ
              </div>
            </div>
            <div className="text-center sm:text-left">
              <span className="text-[11px] font-bold uppercase tracking-wider text-[#8C857B]">Điểm tích lũy</span>
              <div className="font-serif text-xl font-bold text-amber-700 mt-0.5">
                {loyalty.balance.toLocaleString('vi-VN')} điểm
              </div>
              <span className="text-[10px] text-[#8C857B] block mt-0.5">1 điểm = {loyalty.pointValue.toLocaleString('vi-VN')}đ · dùng khi thanh toán</span>
            </div>
            <div className="text-center sm:text-left">
              <span className="text-[11px] font-bold uppercase tracking-wider text-[#8C857B]">Sách yêu thích</span>
              <div className="font-serif text-xl font-bold text-emerald-700 mt-0.5">
                {wishlistBooks.length} cuốn
              </div>
            </div>
          </div>
        </div>

        {/* ================= MAIN CONTENT TABS ================= */}
        <div className="grid grid-cols-1 lg:grid-cols-4 gap-8">
          
          {/* Left Sidebar Navigation */}
          <div className="lg:col-span-1 space-y-2">
            {[
              { id: 'info', label: 'Hồ sơ cá nhân', icon: User },
              { id: 'orders', label: 'Lịch sử đơn hàng', icon: Package, badge: orders.length },
              { id: 'addresses', label: 'Sổ địa chỉ', icon: MapPin },
              { id: 'wishlist', label: 'Sách yêu thích', icon: Heart, badge: wishlistBooks.length },
              { id: 'vouchers', label: 'Ví ưu đãi & Voucher', icon: Ticket, badge: availableVouchers.length },
              { id: 'password', label: 'Bảo mật & Mật khẩu', icon: Lock },
            ].map(item => {
              const Icon = item.icon
              const isSelected = activeTab === item.id
              return (
                <button
                  key={item.id}
                  onClick={() => setActiveTab(item.id as any)}
                  className={cn(
                    "w-full flex items-center justify-between px-4 py-3 rounded-2xl text-xs sm:text-sm font-semibold transition-all text-left",
                    isSelected 
                      ? "bg-[#191614] text-white shadow-xs" 
                      : "bg-white border border-[#EBE7DC] text-[#423E3A] hover:bg-[#F5F3ED]"
                  )}
                >
                  <div className="flex items-center gap-3">
                    <Icon className="w-4 h-4" />
                    <span>{item.label}</span>
                  </div>
                  {item.badge !== undefined && (
                    <span className={cn(
                      "px-2 py-0.5 rounded-full text-xs font-bold",
                      isSelected ? "bg-white/20 text-white" : "bg-[#F5F3ED] text-[#706B65]"
                    )}>
                      {item.badge}
                    </span>
                  )}
                </button>
              )
            })}
          </div>

          {/* Right Main Content Area */}
          <div className="lg:col-span-3">

            {/* TAB 1: PERSONAL INFO */}
            {activeTab === 'info' && (
              <div className="bg-white rounded-3xl border border-[#EBE7DC] p-6 sm:p-8 shadow-xs">
                <div className="flex items-center justify-between pb-6 border-b border-[#F5F3ED] mb-6">
                  <div>
                    <h2 className="text-lg font-serif font-bold text-[#191614]">
                      Thông tin tài khoản
                    </h2>
                    <p className="text-xs text-[#706B65] mt-0.5">
                      Cập nhật thông tin định danh và liên hệ của bạn tại Bookstore
                    </p>
                  </div>
                  {!isEditingInfo && (
                    <button
                      onClick={() => setIsEditingInfo(true)}
                      className="flex items-center gap-1.5 px-3 py-1.5 rounded-xl border border-[#DDD6C4] hover:bg-[#F5F3ED] text-xs font-semibold text-[#191614] transition-colors"
                    >
                      <Edit className="w-3.5 h-3.5" />
                      <span>Chỉnh sửa</span>
                    </button>
                  )}
                </div>

                <form onSubmit={handleUpdateProfile} className="space-y-5 max-w-lg">
                  <div>
                    <label className="block text-xs font-bold uppercase tracking-wider text-[#423E3A] mb-1.5">
                      Họ và tên
                    </label>
                    <input
                      type="text"
                      disabled={!isEditingInfo}
                      value={fullName}
                      onChange={(e) => setFullName(e.target.value)}
                      className={cn(
                        "w-full px-4 py-2.5 rounded-xl border text-sm transition-all outline-none",
                        isEditingInfo 
                          ? "border-[#191614] bg-white ring-1 ring-[#191614]/10" 
                          : "border-[#EBE7DC] bg-[#FDFCF9] text-[#706B65]"
                      )}
                    />
                  </div>

                  <div>
                    <label className="block text-xs font-bold uppercase tracking-wider text-[#423E3A] mb-1.5">
                      Địa chỉ Email (Tài khoản)
                    </label>
                    <input
                      type="email"
                      disabled
                      value={user.email}
                      className="w-full px-4 py-2.5 rounded-xl border border-[#EBE7DC] bg-[#F5F3ED] text-sm text-[#706B65] cursor-not-allowed"
                    />
                    <p className="text-[11px] text-[#8C857B] mt-1">Email được cố định để bảo mật tài khoản.</p>
                  </div>

                  <div>
                    <label className="block text-xs font-bold uppercase tracking-wider text-[#423E3A] mb-1.5">
                      Số điện thoại nhận hàng
                    </label>
                    <input
                      type="tel"
                      disabled={!isEditingInfo}
                      value={phoneNumber}
                      onChange={(e) => setPhoneNumber(e.target.value)}
                      placeholder="Chưa cập nhật số điện thoại"
                      className={cn(
                        "w-full px-4 py-2.5 rounded-xl border text-sm transition-all outline-none",
                        isEditingInfo 
                          ? "border-[#191614] bg-white ring-1 ring-[#191614]/10" 
                          : "border-[#EBE7DC] bg-[#FDFCF9] text-[#706B65]"
                      )}
                    />
                  </div>

                  {isEditingInfo && (
                    <div className="flex items-center gap-3 pt-3">
                      <button
                        type="submit"
                        className="px-5 py-2.5 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs sm:text-sm font-semibold transition-colors shadow-xs"
                      >
                        Lưu thay đổi
                      </button>
                      <button
                        type="button"
                        onClick={() => {
                          setFullName(user.fullName)
                          setPhoneNumber(user.phoneNumber || '')
                          setIsEditingInfo(false)
                        }}
                        className="px-4 py-2.5 rounded-xl border border-[#DDD6C4] hover:bg-[#F5F3ED] text-xs sm:text-sm font-semibold text-[#423E3A] transition-colors"
                      >
                        Hủy
                      </button>
                    </div>
                  )}
                </form>
              </div>
            )}

            {/* TAB 2: ORDER HISTORY (WITH CANCEL BUTTON) */}
            {activeTab === 'orders' && (
              <div className="bg-white rounded-3xl border border-[#EBE7DC] p-6 sm:p-8 shadow-xs">
                <div className="pb-6 border-b border-[#F5F3ED] mb-6">
                  <h2 className="text-lg font-serif font-bold text-[#191614]">
                    Lịch sử đơn hàng
                  </h2>
                  <p className="text-xs text-[#706B65] mt-0.5">
                    Theo dõi lộ trình giao nhận và các đơn hàng bạn đã đặt
                  </p>
                </div>

                {orders.length === 0 ? (
                  <div className="py-16 text-center text-[#8C857B]">
                    <Package className="w-12 h-12 mx-auto text-[#DDD6C4] mb-3" />
                    <p className="font-serif text-lg text-[#191614] font-bold">Bạn chưa có đơn hàng nào</p>
                    <p className="text-xs text-[#706B65] mt-1 max-w-sm mx-auto">
                      Hãy dạo quanh tiệm sách và chọn cho mình những cuốn sách yêu thích nhé!
                    </p>
                    <Link
                      to="/books"
                      className="inline-flex items-center gap-2 mt-5 px-5 py-2.5 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-semibold transition-all shadow-xs"
                    >
                      <span>Khám phá Tủ Sách</span>
                      <ArrowRight className="w-3.5 h-3.5" />
                    </Link>
                  </div>
                ) : (
                  <div className="space-y-4">
                    {orders.map((ord) => (
                      <div
                        key={ord.id}
                        className="border border-[#EBE7DC] rounded-2xl p-5 hover:border-[#DDD6C4] transition-all bg-[#FDFCF9]"
                      >
                        <div className="flex flex-wrap items-center justify-between gap-2 pb-3 border-b border-[#EBE7DC]">
                          <div>
                            <span className="font-mono text-xs font-bold text-[#191614] mr-2">
                              {ord.orderCode}
                            </span>
                            <span className="text-[11px] text-[#8C857B]">
                              Ngày đặt: {new Date(ord.orderDate).toLocaleDateString('vi-VN')}
                            </span>
                          </div>
                          
                          <div className="flex items-center gap-2">
                            <span className={cn(
                              "px-2.5 py-0.5 rounded-full text-xs font-semibold border",
                              ord.status === 'Completed' || ord.status === 'Delivered' ? "bg-emerald-50 text-emerald-800 border-emerald-200" :
                              ord.status === 'Shipping' || ord.status === 'Shipped' ? "bg-blue-50 text-blue-800 border-blue-200" :
                              ord.status === 'Cancelled' ? "bg-red-50 text-red-800 border-red-200" :
                              "bg-amber-50 text-amber-800 border-amber-200"
                            )}>
                              {ord.status === 'Completed' || ord.status === 'Delivered' ? 'Đã hoàn thành' :
                               ord.status === 'Shipping' || ord.status === 'Shipped' ? 'Đang giao hàng' :
                               ord.status === 'Cancelled' ? 'Đã hủy đơn' : 'Chờ xác nhận'}
                            </span>

                            {/* CANCEL ORDER ACTION FOR PENDING ORDERS */}
                            {ord.status === 'Pending' && (
                              <button
                                onClick={() => handleCancelOrder(ord.id)}
                                className="px-2.5 py-1 text-xs font-semibold text-red-600 hover:bg-red-50 rounded-lg border border-red-200 transition-colors"
                              >
                                Hủy đơn
                              </button>
                            )}
                          </div>
                        </div>

                        {/* Items preview */}
                        <div className="py-3 space-y-1.5 text-xs text-[#423E3A]">
                          {ord.items.map((it, idx) => (
                            <div key={idx} className="flex justify-between">
                              <span>• {it.bookTitle} (x{it.quantity})</span>
                              <span className="font-medium text-[#706B65]">{it.lineTotal.toLocaleString('vi-VN')} đ</span>
                            </div>
                          ))}
                        </div>

                        <div className="pt-3 border-t border-[#EBE7DC] flex flex-wrap items-center justify-between gap-3">
                          <div className="flex items-center gap-3">
                            <span className="text-xs text-[#706B65]">
                              Hình thức: <strong>{ord.paymentMethod}</strong>
                            </span>
                            <button
                              onClick={() => {
                                setSelectedInvoiceData({
                                  orderCode: ord.orderCode,
                                  orderDate: ord.orderDate,
                                  customerName: user?.fullName || 'Độc giả',
                                  phoneNumber: user?.phoneNumber || '',
                                  address: ord.shippingAddress || 'Nhận tại cửa hàng',
                                  paymentMethod: ord.paymentMethod,
                                  status: ord.status,
                                  items: ord.items?.map((i: any) => ({
                                    title: i.bookTitle,
                                    quantity: i.quantity,
                                    price: i.unitPrice
                                  })) || [],
                                  subtotal: ord.totalAmount,
                                  discountAmount: ord.discountAmount,
                                  shippingFee: ord.shippingFee,
                                  finalAmount: ord.finalAmount
                                })
                                setIsInvoiceOpen(true)
                              }}
                              className="px-2.5 py-1 text-xs font-semibold rounded-lg border border-[#DDD6C4] bg-white hover:bg-[#F5F3ED] text-[#191614] flex items-center gap-1 transition-colors"
                            >
                              <Printer className="w-3.5 h-3.5 text-[#B84A39]" />
                              <span>In Hóa Đơn</span>
                            </button>
                          </div>
                          <div className="text-right">
                            <span className="text-xs text-[#8C857B] mr-1.5">Tổng thanh toán:</span>
                            <span className="font-serif text-base font-bold text-[#B84A39]">
                              {ord.finalAmount.toLocaleString('vi-VN')} đ
                            </span>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            )}

            {/* TAB 3: ADDRESS BOOK (WITH ADD ADDRESS MODAL) */}
            {activeTab === 'addresses' && (
              <div className="bg-white rounded-3xl border border-[#EBE7DC] p-6 sm:p-8 shadow-xs">
                <div className="pb-6 border-b border-[#F5F3ED] mb-6 flex items-center justify-between">
                  <div>
                    <h2 className="text-lg font-serif font-bold text-[#191614]">
                      Sổ địa chỉ nhận hàng
                    </h2>
                    <p className="text-xs text-[#706B65] mt-0.5">
                      Lưu trữ các địa chỉ nhận hàng quen thuộc giúp bạn đặt sách nhanh chóng
                    </p>
                  </div>

                  <button
                    onClick={() => setIsAddressModalOpen(true)}
                    className="flex items-center gap-1.5 px-4 py-2 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-semibold transition-colors shadow-xs"
                  >
                    <Plus className="w-3.5 h-3.5" />
                    <span>Thêm địa chỉ mới</span>
                  </button>
                </div>

                {(!profileData?.addresses || profileData.addresses.length === 0) ? (
                  <div className="border border-[#EBE7DC] rounded-2xl p-5 bg-[#FDFCF9]">
                    <div className="flex items-center justify-between mb-2">
                      <div className="flex items-center gap-2">
                        <span className="font-bold text-sm text-[#191614]">{user.fullName}</span>
                        <span className="px-2 py-0.5 rounded-md text-[10px] font-bold bg-amber-100 text-amber-900 border border-amber-300">
                          Mặc định
                        </span>
                      </div>
                    </div>
                    <p className="text-xs text-[#706B65]">SĐT: {user.phoneNumber || '0912 345 678'}</p>
                    <p className="text-xs text-[#423E3A] mt-1">123 Đường Sách Nguyễn Huệ, Phường Bến Nghé, Quận 1, TP. Hồ Chí Minh</p>
                  </div>
                ) : (
                  <div className="space-y-3">
                    {profileData.addresses.map((addr) => (
                      <div key={addr.id} className="border border-[#EBE7DC] rounded-2xl p-5 bg-[#FDFCF9] flex items-start justify-between">
                        <div>
                          <div className="flex items-center gap-2 mb-1.5">
                            <span className="font-bold text-sm text-[#191614]">{addr.receiverName}</span>
                            {addr.isDefault && (
                              <span className="px-2 py-0.5 rounded-md text-[10px] font-bold bg-amber-100 text-amber-900 border border-amber-300">
                                Mặc định
                              </span>
                            )}
                          </div>
                          <p className="text-xs text-[#706B65]">SĐT: {addr.receiverPhone}</p>
                          <p className="text-xs text-[#423E3A] mt-1">{addr.streetAddress}, {addr.ward}, {addr.district}, {addr.city}</p>
                        </div>

                        <button
                          onClick={() => handleDeleteAddress(addr.id)}
                          className="p-1.5 rounded-lg border border-red-200 text-red-600 hover:bg-red-50 transition-colors"
                          title="Xóa địa chỉ"
                        >
                          <Trash2 className="w-3.5 h-3.5" />
                        </button>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            )}

            {/* TAB 4: WISHLIST / SÁCH YÊU THÍCH */}
            {activeTab === 'wishlist' && (
              <div className="bg-white rounded-3xl border border-[#EBE7DC] p-6 sm:p-8 shadow-xs">
                <div className="pb-6 border-b border-[#F5F3ED] mb-6 flex items-center justify-between">
                  <div>
                    <h2 className="text-lg font-serif font-bold text-[#191614]">
                      Sách yêu thích &amp; Muốn đọc
                    </h2>
                    <p className="text-xs text-[#706B65] mt-0.5">
                      Danh sách những tựa sách bạn đã lưu để dành thưởng thức sau
                    </p>
                  </div>
                  <span className="text-xs font-semibold text-[#8C857B]">
                    {wishlistBooks.length} cuốn
                  </span>
                </div>

                {wishlistBooks.length === 0 ? (
                  <div className="py-16 text-center text-[#8C857B]">
                    <Heart className="w-12 h-12 mx-auto text-[#DDD6C4] mb-3" />
                    <p className="font-serif text-lg text-[#191614] font-bold">Chưa có cuốn sách nào trong danh sách yêu thích</p>
                    <p className="text-xs text-[#706B65] mt-1 max-w-sm mx-auto">
                      Khi duyệt sách, bấm vào biểu tượng trái tim để lưu lại những tựa sách bạn tâm đắc nhé!
                    </p>
                    <Link
                      to="/books"
                      className="inline-flex items-center gap-2 mt-5 px-5 py-2.5 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-semibold transition-all shadow-xs"
                    >
                      Khám phá Tủ Sách
                    </Link>
                  </div>
                ) : (
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    {wishlistBooks.map((b) => (
                      <div key={b.id} className="flex gap-3.5 p-3.5 rounded-2xl border border-[#EBE7DC] bg-[#FDFCF9] hover:border-[#DDD6C4] transition-all">
                        <img
                          src={b.coverImageUrl || 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg'}
                          alt={b.title}
                          referrerPolicy="no-referrer"
                          onError={(e) => {
                            (e.target as HTMLImageElement).src = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg'
                          }}
                          className="w-16 h-22 object-cover rounded-xl border border-[#DDD6C4] shrink-0"
                        />
                        <div className="flex-1 flex flex-col justify-between min-w-0">
                          <div>
                            <h4 className="font-serif font-bold text-sm text-[#191614] line-clamp-1">
                              {b.title}
                            </h4>
                            <p className="text-xs text-[#706B65] mt-0.5 truncate">
                              {b.authors?.map(a => a.name).join(', ') || 'Tác giả'}
                            </p>
                            <span className="font-sans font-bold tabular-nums text-sm text-[#B84A39] block mt-1">
                              {formatPrice(b.salePrice ?? b.originalPrice)}
                            </span>
                          </div>

                          <div className="flex items-center gap-2 pt-2">
                            <button
                              onClick={() => {
                                addToCart(b, 1)
                                toast.success(`Đã thêm "${b.title}" vào giỏ hàng!`)
                              }}
                              className="flex items-center gap-1 px-3 py-1.5 rounded-lg bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-semibold transition-colors shadow-xs"
                            >
                              <ShoppingBag className="w-3.5 h-3.5" />
                              <span>Thêm giỏ</span>
                            </button>
                            <button
                              onClick={() => {
                                removeFromWishlist(b.id)
                                toast.success('Đã bỏ sách khỏi danh sách yêu thích.')
                              }}
                              className="p-1.5 rounded-lg border border-red-200 text-red-600 hover:bg-red-50 transition-colors"
                              title="Bỏ yêu thích"
                            >
                              <Trash2 className="w-3.5 h-3.5" />
                            </button>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            )}

            {/* TAB 5: VOUCHERS / VÍ ƯU ĐÃI */}
            {activeTab === 'vouchers' && (
              <div className="bg-white rounded-3xl border border-[#EBE7DC] p-6 sm:p-8 shadow-xs">
                <div className="pb-6 border-b border-[#F5F3ED] mb-6">
                  <h2 className="text-lg font-serif font-bold text-[#191614]">
                    Ví Voucher &amp; Mã Ưu Đãi Độc Quyền
                  </h2>
                  <p className="text-xs text-[#706B65] mt-0.5">
                    Sao chép mã giảm giá và dán vào bước thanh toán để nhận ưu đãi
                  </p>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {availableVouchers.map((v) => (
                    <div
                      key={v.code}
                      className="border border-[#EBE7DC] rounded-2xl p-4 bg-[#FDFCF9] flex flex-col justify-between space-y-3 relative overflow-hidden"
                    >
                      <div className="flex items-start justify-between gap-2">
                        <div>
                          <span className="text-[10px] font-bold uppercase tracking-wider px-2 py-0.5 rounded-md bg-amber-100 text-amber-900 border border-amber-300">
                            {v.tag}
                          </span>
                          <h4 className="font-serif font-bold text-sm text-[#191614] mt-2">
                            {v.title}
                          </h4>
                          <p className="text-xs text-[#706B65] mt-1">{v.desc}</p>
                        </div>
                      </div>

                      <div className="pt-2 border-t border-[#F5F3ED] flex items-center justify-between">
                        <div>
                          <span className="font-mono text-xs font-bold text-[#B84A39] bg-[#F5F3ED] px-2 py-1 rounded-md border border-[#DDD6C4]">
                            {v.code}
                          </span>
                          <span className="text-[10px] text-[#8C857B] ml-2">HSD: {v.expiry}</span>
                        </div>

                        <button
                          onClick={() => handleCopyVoucher(v.code)}
                          className="flex items-center gap-1 px-3 py-1.5 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-semibold transition-colors shadow-xs"
                        >
                          <Copy className="w-3.5 h-3.5" />
                          <span>Sao chép</span>
                        </button>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}

            {/* TAB 6: CHANGE PASSWORD */}
            {activeTab === 'password' && (
              <div className="bg-white rounded-3xl border border-[#EBE7DC] p-6 sm:p-8 shadow-xs">
                <div className="pb-6 border-b border-[#F5F3ED] mb-6">
                  <h2 className="text-lg font-serif font-bold text-[#191614]">
                    Đổi mật khẩu tài khoản
                  </h2>
                  <p className="text-xs text-[#706B65] mt-0.5">
                    Để bảo mật, vui lòng chọn mật khẩu mạnh có ít nhất 6 ký tự
                  </p>
                </div>

                <form onSubmit={handleChangePassword} className="space-y-5 max-w-md">
                  <div>
                    <label className="block text-xs font-bold uppercase tracking-wider text-[#423E3A] mb-1.5">
                      Mật khẩu hiện tại
                    </label>
                    <div className="relative">
                      <input
                        type={showCurrentPass ? 'text' : 'password'}
                        required
                        value={currentPassword}
                        onChange={(e) => setCurrentPassword(e.target.value)}
                        placeholder="Nhập mật khẩu đang dùng"
                        className="w-full px-4 py-2.5 pr-10 rounded-xl border border-[#DDD6C4] text-sm focus:outline-none focus:border-[#191614]"
                      />
                      <button
                        type="button"
                        onClick={() => setShowCurrentPass(!showCurrentPass)}
                        className="absolute right-3 top-1/2 -translate-y-1/2 text-[#8C857B] hover:text-[#191614]"
                      >
                        {showCurrentPass ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                      </button>
                    </div>
                  </div>

                  <div>
                    <label className="block text-xs font-bold uppercase tracking-wider text-[#423E3A] mb-1.5">
                      Mật khẩu mới
                    </label>
                    <div className="relative">
                      <input
                        type={showNewPass ? 'text' : 'password'}
                        required
                        value={newPassword}
                        onChange={(e) => setNewPassword(e.target.value)}
                        placeholder="Tối thiểu 6 ký tự"
                        className="w-full px-4 py-2.5 pr-10 rounded-xl border border-[#DDD6C4] text-sm focus:outline-none focus:border-[#191614]"
                      />
                      <button
                        type="button"
                        onClick={() => setShowNewPass(!showNewPass)}
                        className="absolute right-3 top-1/2 -translate-y-1/2 text-[#8C857B] hover:text-[#191614]"
                      >
                        {showNewPass ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                      </button>
                    </div>
                  </div>

                  <div>
                    <label className="block text-xs font-bold uppercase tracking-wider text-[#423E3A] mb-1.5">
                      Xác nhận mật khẩu mới
                    </label>
                    <input
                      type="password"
                      required
                      value={confirmPassword}
                      onChange={(e) => setConfirmPassword(e.target.value)}
                      placeholder="Nhập lại mật khẩu mới"
                      className="w-full px-4 py-2.5 rounded-xl border border-[#DDD6C4] text-sm focus:outline-none focus:border-[#191614]"
                    />
                  </div>

                  <div className="pt-2">
                    <button
                      type="submit"
                      className="px-6 py-2.5 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs sm:text-sm font-semibold transition-colors shadow-xs"
                    >
                      Cập nhật mật khẩu
                    </button>
                  </div>
                </form>
              </div>
            )}

          </div>

        </div>

      </div>

      {/* ===================== MODAL: THÊM ĐỊA CHỈ MỚI ===================== */}
      {isAddressModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-xs">
          <div className="w-full max-w-lg bg-white rounded-3xl border border-[#EBE7DC] shadow-2xl p-6">
            <div className="flex items-center justify-between pb-4 border-b border-[#F5F3ED] mb-4">
              <div className="flex items-center gap-2">
                <MapPin className="w-5 h-5 text-[#B84A39]" />
                <h3 className="font-serif text-lg font-bold text-[#191614]">Thêm địa chỉ nhận hàng</h3>
              </div>
              <button onClick={() => setIsAddressModalOpen(false)} className="p-1 rounded-lg text-[#8C857B] hover:text-[#191614]">
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleSaveAddress} className="space-y-3.5">
              <div>
                <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                  Họ và tên người nhận <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  required
                  value={newAddress.receiverName}
                  onChange={(e) => setNewAddress({ ...newAddress, receiverName: e.target.value })}
                  placeholder="Ví dụ: Nguyễn Văn A"
                  className="w-full px-3.5 py-2 text-xs rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                />
              </div>

              <div>
                <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                  Số điện thoại <span className="text-red-500">*</span>
                </label>
                <input
                  type="tel"
                  required
                  value={newAddress.receiverPhone}
                  onChange={(e) => setNewAddress({ ...newAddress, receiverPhone: e.target.value })}
                  placeholder="Ví dụ: 0912 345 678"
                  className="w-full px-3.5 py-2 text-xs rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                />
              </div>

              <div>
                <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                  Địa chỉ chi tiết (Số nhà, tên đường...) <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  required
                  value={newAddress.streetAddress}
                  onChange={(e) => setNewAddress({ ...newAddress, streetAddress: e.target.value })}
                  placeholder="Số 45 Lê Duẩn..."
                  className="w-full px-3.5 py-2 text-xs rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                    Quận / Huyện
                  </label>
                  <input
                    type="text"
                    value={newAddress.district}
                    onChange={(e) => setNewAddress({ ...newAddress, district: e.target.value })}
                    placeholder="Quận 1"
                    className="w-full px-3.5 py-2 text-xs rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                  />
                </div>
                <div>
                  <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                    Tỉnh / Thành phố
                  </label>
                  <input
                    type="text"
                    value={newAddress.city}
                    onChange={(e) => setNewAddress({ ...newAddress, city: e.target.value })}
                    placeholder="TP. Hồ Chí Minh"
                    className="w-full px-3.5 py-2 text-xs rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                  />
                </div>
              </div>

              <div className="flex items-center gap-2 pt-1">
                <input
                  type="checkbox"
                  id="isDefault"
                  checked={newAddress.isDefault}
                  onChange={(e) => setNewAddress({ ...newAddress, isDefault: e.target.checked })}
                  className="rounded text-[#191614] focus:ring-0"
                />
                <label htmlFor="isDefault" className="text-xs text-[#423E3A] font-medium cursor-pointer">
                  Đặt làm địa chỉ nhận hàng mặc định
                </label>
              </div>

              <div className="pt-3 flex justify-end gap-2">
                <button
                  type="button"
                  onClick={() => setIsAddressModalOpen(false)}
                  className="px-4 py-2 text-xs rounded-xl border border-[#DDD6C4] text-[#423E3A] font-semibold hover:bg-[#F5F3ED]"
                >
                  Hủy
                </button>
                <button
                  type="submit"
                  className="px-5 py-2 text-xs rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white font-semibold transition-colors shadow-xs"
                >
                  Lưu địa chỉ
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Invoice Modal for Customer Order History */}
      <InvoiceModal
        isOpen={isInvoiceOpen}
        onClose={() => setIsInvoiceOpen(false)}
        data={selectedInvoiceData}
      />

    </div>
  )
}
