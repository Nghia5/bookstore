import { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { 
  BookOpen, ShoppingCart, Users, DollarSign, Plus, 
  Search, Edit3, Trash2, 
  ArrowLeft, X, Shield, Key, LogOut,
  UserPlus, Feather, Eye, Printer, AlertTriangle,
  CheckCircle2, Truck, Clock, Ban, PackageCheck, RefreshCw
} from 'lucide-react'
import { useAuthStore } from '@/stores/authStore'
import apiClient from '@/api/client'
import { toast } from 'sonner'
import { cn } from '@/lib/utils'
import InvoiceModal from '@/components/InvoiceModal'
import type { InvoiceData } from '@/components/InvoiceModal'
import AdminReceiptsTab from './components/AdminReceiptsTab'
import AdminDiscountsTab from './components/AdminDiscountsTab'
import AdminReviewsTab from './components/AdminReviewsTab'
import AdminAnalyticsSection from './components/AdminAnalyticsSection'

export const ORDER_STATUS_CONFIG: Record<string, { label: string; badgeClass: string }> = {
  Pending: { 
    label: 'Chờ xử lý', 
    badgeClass: 'bg-amber-50 text-amber-800 border-amber-300'
  },
  Confirmed: { 
    label: 'Đã xác nhận', 
    badgeClass: 'bg-sky-50 text-sky-800 border-sky-300'
  },
  Processing: { 
    label: 'Đang đóng gói', 
    badgeClass: 'bg-blue-50 text-blue-800 border-blue-300'
  },
  Shipped: { 
    label: 'Đang giao hàng', 
    badgeClass: 'bg-indigo-50 text-indigo-800 border-indigo-300'
  },
  Shipping: { 
    label: 'Đang giao hàng', 
    badgeClass: 'bg-indigo-50 text-indigo-800 border-indigo-300'
  },
  Delivered: { 
    label: 'Đã giao thành công', 
    badgeClass: 'bg-emerald-50 text-emerald-800 border-emerald-300'
  },
  Completed: { 
    label: 'Đã hoàn tất', 
    badgeClass: 'bg-emerald-50 text-emerald-800 border-emerald-300'
  },
  Cancelled: { 
    label: 'Đã hủy', 
    badgeClass: 'bg-rose-50 text-rose-800 border-rose-300'
  },
  Returned: { 
    label: 'Hoàn trả hàng', 
    badgeClass: 'bg-purple-50 text-purple-800 border-purple-300'
  }
}

interface OverviewData {
  totalBooks: number
  totalOrders: number
  totalUsers: number
  totalStock: number
  lowStockBooks: number
  totalRevenue: number
  totalReceipts?: number
  totalReviews?: number
  totalDiscounts?: number
  weeklySales?: any[]
  topSellers?: any[]
  recentOrders: Array<{
    id: number
    orderCode: string
    orderDate: string
    customerName: string
    finalAmount: number
    status: string
    itemCount: number
  }>
  topCategories: Array<{
    id: number
    name: string
    bookCount: number
  }>
}

interface AdminBook {
  id: number
  isbn: string
  title: string
  originalPrice: number
  salePrice?: number
  stockQuantity: number
  publishYear?: number
  coverImageUrl?: string
  isAvailable: boolean
  categoryId?: number
  categoryName: string
  authorNames: string
}

interface AdminOrder {
  id: number
  orderCode: string
  orderDate: string
  customerName: string
  customerPhone: string
  shippingAddress: string
  totalAmount: number
  discountAmount: number
  shippingFee: number
  finalAmount: number
  status: string
  paymentMethod: string
  note?: string
  items: Array<{
    bookId: number
    bookTitle: string
    quantity: number
    unitPrice: number
    lineTotal: number
  }>
}

interface AdminUser {
  id: number
  email: string
  fullName: string
  phoneNumber?: string
  role: string
  roleValue: number
  isActive: boolean
  createdAt: string
  totalOrders: number
}

interface AdminAuthor {
  id: number
  name: string
  nationality?: string
  biography?: string
  avatarUrl?: string
  bookCount: number
}

export default function AdminDashboard() {
  const { user, logout } = useAuthStore()

  const [activeTab, setActiveTab] = useState<'overview' | 'books' | 'receipts' | 'discounts' | 'authors' | 'orders' | 'reviews' | 'users'>('overview')
  const [, setLoading] = useState(false)

  // Overview stats
  const [overview, setOverview] = useState<OverviewData | null>(null)

  // Invoice modal state
  const [isInvoiceOpen, setIsInvoiceOpen] = useState(false)
  const [selectedInvoiceData, setSelectedInvoiceData] = useState<InvoiceData | null>(null)

  // Books list state
  const [books, setBooks] = useState<AdminBook[]>([])
  const [searchQuery, setSearchQuery] = useState('')
  const [selectedCategory, setSelectedCategory] = useState<number | null>(null)
  const [lowStockFilter, setLowStockFilter] = useState(false)
  const [bookPage] = useState(1)

  // Authors state
  const [authors, setAuthors] = useState<AdminAuthor[]>([])
  const [authorSearch, setAuthorSearch] = useState('')
  const [isAuthorModalOpen, setIsAuthorModalOpen] = useState(false)
  const [editingAuthor, setEditingAuthor] = useState<Partial<AdminAuthor> | null>(null)
  const [selectedAuthorForBooks, setSelectedAuthorForBooks] = useState<AdminAuthor | null>(null)
  const [authorBooksList, setAuthorBooksList] = useState<AdminBook[]>([])
  const [isAuthorBooksModalOpen, setIsAuthorBooksModalOpen] = useState(false)
  const [loadingAuthorBooks, setLoadingAuthorBooks] = useState(false)

  // Orders list state
  const [orders, setOrders] = useState<AdminOrder[]>([])
  const [orderStatusFilter, setOrderStatusFilter] = useState<string>('all')
  const [updatingOrderId, setUpdatingOrderId] = useState<number | null>(null)

  // Users / Staff state
  const [adminUsers, setAdminUsers] = useState<AdminUser[]>([])
  const [userRoleFilter, setUserRoleFilter] = useState<'all' | 'staff' | 'admin' | 'customer'>('all')
  const [userSearch, setUserSearch] = useState('')
  const [isUserModalOpen, setIsUserModalOpen] = useState(false)
  const [editingUser, setEditingUser] = useState<Partial<AdminUser> | null>(null)
  const [newStaffPassword, setNewStaffPassword] = useState('')
  
  // Reset Password Modal
  const [isResetPassModalOpen, setIsResetPassModalOpen] = useState(false)
  const [resetTargetUser, setResetTargetUser] = useState<AdminUser | null>(null)
  const [resetNewPass, setResetNewPass] = useState('')

  // Edit / Add Book Modal
  const [isModalOpen, setIsModalOpen] = useState(false)
  const [editingBook, setEditingBook] = useState<Partial<AdminBook> | null>(null)
  const [newAuthorName, setNewAuthorName] = useState('')

  // 1. Fetch overview stats
  const fetchOverview = async () => {
    try {
      setLoading(true)
      const res = await apiClient.get('/admin/overview')
      setOverview(res.data)
    } catch (err: any) {
      console.error('Failed to load overview:', err)
    } finally {
      setLoading(false)
    }
  }

  // 2. Fetch books
  const fetchBooks = async () => {
    try {
      setLoading(true)
      const params: any = { page: bookPage, pageSize: 25 }
      if (searchQuery.trim()) params.search = searchQuery.trim()
      if (selectedCategory) params.categoryId = selectedCategory

      const res = await apiClient.get('/admin/books', { params })
      setBooks(res.data.items || [])
    } catch (err: any) {
      console.error('Failed to load books:', err)
    } finally {
      setLoading(false)
    }
  }

  // 3. Fetch Authors
  const fetchAuthors = async () => {
    try {
      setLoading(true)
      const params: any = {}
      if (authorSearch.trim()) params.search = authorSearch.trim()
      const res = await apiClient.get('/admin/authors', { params })
      setAuthors(res.data || [])
    } catch (err: any) {
      console.error('Failed to load authors:', err)
    } finally {
      setLoading(false)
    }
  }

  // 4. Fetch orders
  const fetchOrders = async () => {
    try {
      setLoading(true)
      const params: any = {}
      if (orderStatusFilter !== 'all') params.status = orderStatusFilter
      const res = await apiClient.get('/admin/orders', { params })
      setOrders(res.data || [])
    } catch (err: any) {
      console.error('Failed to load orders:', err)
    } finally {
      setLoading(false)
    }
  }

  // Update order status with immediate feedback
  const handleUpdateOrderStatus = async (orderId: number, newStatus: string) => {
    try {
      setUpdatingOrderId(orderId)
      await apiClient.put(`/admin/orders/${orderId}/status`, { status: newStatus })
      const config = ORDER_STATUS_CONFIG[newStatus]
      toast.success(`Đã cập nhật đơn hàng sang "${config?.label || newStatus}"!`)
      await fetchOrders()
      fetchOverview()
    } catch (err: any) {
      console.error('Failed to update order status:', err)
      toast.error(err.response?.data?.message || 'Không thể cập nhật trạng thái đơn hàng')
    } finally {
      setUpdatingOrderId(null)
    }
  }

  // 5. Fetch Users / Staff
  const fetchUsers = async () => {
    try {
      setLoading(true)
      const params: any = {}
      if (userSearch.trim()) params.search = userSearch.trim()
      const res = await apiClient.get('/admin/users', { params })
      setAdminUsers(res.data || [])
    } catch (err: any) {
      console.error('Failed to load users:', err)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchOverview()
  }, [])

  useEffect(() => {
    if (activeTab === 'books') {
      const timer = setTimeout(() => { fetchBooks() }, 250)
      return () => clearTimeout(timer)
    } else if (activeTab === 'authors') {
      const timer = setTimeout(() => { fetchAuthors() }, 250)
      return () => clearTimeout(timer)
    } else if (activeTab === 'orders') {
      fetchOrders()
    } else if (activeTab === 'users') {
      const timer = setTimeout(() => { fetchUsers() }, 250)
      return () => clearTimeout(timer)
    }
  }, [activeTab, bookPage, selectedCategory, searchQuery, authorSearch, userSearch, orderStatusFilter])

  // Book Handlers
  const handleSaveBook = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!editingBook?.title?.trim()) {
      toast.error('Vui lòng nhập tên tựa sách.')
      return
    }

    try {
      if (editingBook.id) {
        await apiClient.put(`/admin/books/${editingBook.id}`, {
          title: editingBook.title,
          originalPrice: Number(editingBook.originalPrice),
          salePrice: editingBook.salePrice ? Number(editingBook.salePrice) : null,
          stockQuantity: Number(editingBook.stockQuantity),
          coverImageUrl: editingBook.coverImageUrl,
          categoryId: editingBook.categoryId ? Number(editingBook.categoryId) : null,
          isAvailable: editingBook.isAvailable ?? true
        })
        toast.success(`Đã cập nhật sách: "${editingBook.title}"`)
      } else {
        await apiClient.post('/admin/books', {
          title: editingBook.title,
          authorName: newAuthorName.trim() || 'Nhiều tác giả',
          originalPrice: Number(editingBook.originalPrice || 100000),
          salePrice: editingBook.salePrice ? Number(editingBook.salePrice) : null,
          stockQuantity: Number(editingBook.stockQuantity || 20),
          coverImageUrl: editingBook.coverImageUrl,
          categoryId: editingBook.categoryId ? Number(editingBook.categoryId) : 1
        })
        toast.success(`Đã thêm sách mới thành công!`)
      }
      setIsModalOpen(false)
      fetchBooks()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Không thể lưu sách.')
    }
  }

  // Author Handlers
  const handleSaveAuthor = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!editingAuthor?.name?.trim()) {
      toast.error('Vui lòng nhập tên tác giả.')
      return
    }

    try {
      if (editingAuthor.id) {
        await apiClient.put(`/admin/authors/${editingAuthor.id}`, {
          name: editingAuthor.name.trim(),
          nationality: editingAuthor.nationality?.trim(),
          biography: editingAuthor.biography?.trim(),
          avatarUrl: editingAuthor.avatarUrl?.trim()
        })
        toast.success(`Đã cập nhật tác giả: "${editingAuthor.name}"`)
      } else {
        await apiClient.post('/admin/authors', {
          name: editingAuthor.name.trim(),
          nationality: editingAuthor.nationality?.trim(),
          biography: editingAuthor.biography?.trim(),
          avatarUrl: editingAuthor.avatarUrl?.trim()
        })
        toast.success(`Đã thêm tác giả "${editingAuthor.name}" thành công!`)
      }
      setIsAuthorModalOpen(false)
      fetchAuthors()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Không thể lưu tác giả.')
    }
  }

  const handleDeleteAuthor = async (author: AdminAuthor) => {
    if (author.bookCount > 0) {
      toast.error(`Không thể xóa tác giả "${author.name}" vì đang gắn với ${author.bookCount} đầu sách trong kho.`)
      return
    }

    if (!confirm(`Bạn có chắc chắn muốn xóa tác giả "${author.name}" khỏi hệ thống?`)) return

    try {
      await apiClient.delete(`/admin/authors/${author.id}`)
      toast.success(`Đã xóa tác giả "${author.name}"`)
      fetchAuthors()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Không thể xóa tác giả.')
    }
  }

  const handleViewAuthorBooks = async (author: AdminAuthor) => {
    setSelectedAuthorForBooks(author)
    setIsAuthorBooksModalOpen(true)
    setLoadingAuthorBooks(true)
    try {
      const res = await apiClient.get(`/admin/authors/${author.id}/books`)
      setAuthorBooksList(res.data.books || [])
    } catch (err: any) {
      console.error('Failed to load author books:', err)
      toast.error('Không thể tải danh sách sách của tác giả.')
    } finally {
      setLoadingAuthorBooks(false)
    }
  }

  // User / Staff Handlers
  const handleSaveUser = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!editingUser?.fullName?.trim() || !editingUser?.email?.trim()) {
      toast.error('Vui lòng điền họ tên và email.')
      return
    }

    try {
      if (editingUser.id) {
        // Update user
        await apiClient.put(`/admin/users/${editingUser.id}`, {
          fullName: editingUser.fullName.trim(),
          phoneNumber: editingUser.phoneNumber?.trim(),
          role: editingUser.roleValue,
          isActive: editingUser.isActive
        })
        toast.success(`Đã cập nhật tài khoản: "${editingUser.fullName}"`)
      } else {
        // Create new staff
        if (!newStaffPassword || newStaffPassword.length < 6) {
          toast.error('Mật khẩu nhân viên phải có ít nhất 6 ký tự.')
          return
        }
        await apiClient.post('/admin/users', {
          fullName: editingUser.fullName.trim(),
          email: editingUser.email.trim(),
          password: newStaffPassword,
          phoneNumber: editingUser.phoneNumber?.trim(),
          role: editingUser.roleValue ?? 1
        })
        toast.success(`Đã thêm nhân viên "${editingUser.fullName}" thành công!`)
      }
      setIsUserModalOpen(false)
      fetchUsers()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Thao tác không thành công.')
    }
  }

  const handleToggleUserStatus = async (targetUser: AdminUser) => {
    if (targetUser.id === user?.id) {
      toast.error('Không thể khóa chính tài khoản của bạn.')
      return
    }

    try {
      const res = await apiClient.put(`/admin/users/${targetUser.id}/toggle-status`)
      toast.success(res.data.message)
      fetchUsers()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Không thể cập nhật trạng thái.')
    }
  }

  const handleResetPassword = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!resetTargetUser || !resetNewPass || resetNewPass.length < 6) {
      toast.error('Mật khẩu mới phải có ít nhất 6 ký tự.')
      return
    }

    try {
      await apiClient.put(`/admin/users/${resetTargetUser.id}/reset-password`, {
        newPassword: resetNewPass
      })
      toast.success(`Đã đặt lại mật khẩu cho "${resetTargetUser.fullName}" thành công!`)
      setIsResetPassModalOpen(false)
      setResetNewPass('')
      setResetTargetUser(null)
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Không thể đặt lại mật khẩu.')
    }
  }

  const handleDeleteUser = async (targetUser: AdminUser) => {
    if (targetUser.id === user?.id) {
      toast.error('Không thể xóa tài khoản của chính bạn.')
      return
    }
    if (!confirm(`Bạn có chắc chắn muốn xóa tài khoản "${targetUser.fullName}" (${targetUser.email})?`)) return

    try {
      const res = await apiClient.delete(`/admin/users/${targetUser.id}`)
      toast.success(res.data?.message || 'Đã xóa tài khoản.')
      fetchUsers()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Không thể xóa tài khoản.')
    }
  }

  // Filtered Users List
  const filteredUsers = adminUsers.filter(u => {
    if (userRoleFilter === 'staff') return u.role === 'SalesStaff' || u.role === 'WarehouseStaff'
    if (userRoleFilter === 'admin') return u.role === 'Admin'
    if (userRoleFilter === 'customer') return u.role === 'Customer'
    return true
  })

  return (
    <div className="min-h-screen bg-[#FDFCF9] pb-24">
      {/* Top Navbar */}
      <div className="sticky top-0 z-40 bg-white/95 backdrop-blur-md border-b border-[#EBE7DC] shadow-xs">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          {/* Row 1: Brand + User info */}
          <div className="flex h-14 items-center justify-between gap-4">
            <div className="flex items-center gap-3">
              <Link to="/" className="p-2 rounded-xl text-[#706B65] hover:text-[#191614] hover:bg-[#F5F3ED] transition-colors" title="Về trang chủ">
                <ArrowLeft className="w-5 h-5" />
              </Link>
              <div className="flex items-center gap-2.5">
                <div className="w-9 h-9 rounded-xl bg-[#191614] flex items-center justify-center text-white shadow-sm">
                  <Shield className="w-4 h-4 text-amber-400" />
                </div>
                <div>
                  <span className="font-serif font-bold text-base text-[#191614] leading-tight block">Bookstore Admin</span>
                  <span className="text-[10px] font-bold uppercase tracking-wider text-amber-700 bg-amber-50 px-1.5 py-0.5 rounded border border-amber-200">
                    {user?.fullName || 'Administrator'}
                  </span>
                </div>
              </div>
            </div>

            <button
              onClick={logout}
              className="flex items-center gap-1.5 text-xs font-semibold text-red-600 hover:bg-red-50 px-3 py-1.5 rounded-xl transition-colors"
            >
              <LogOut className="w-3.5 h-3.5" />
              Đăng xuất
            </button>
          </div>

          {/* Row 2: Navigation Tabs - scrollable */}
          <nav className="flex items-center gap-1 overflow-x-auto pb-2 -mb-px scrollbar-hide">
            {[
              { id: 'overview', label: 'Tổng quan' },
              { id: 'books', label: `Kho Sách (${overview?.totalBooks ?? 1000})` },
              { id: 'receipts', label: `Nhập kho (${overview?.totalReceipts ?? 3})` },
              { id: 'discounts', label: `Khuyến mãi (${overview?.totalDiscounts ?? 6})` },
              { id: 'authors', label: `Tác giả (${authors.length || 40})` },
              { id: 'orders', label: `Đơn hàng (${orders.length || 5})` },
              { id: 'reviews', label: `Đánh giá (${overview?.totalReviews ?? 20})` },
              { id: 'users', label: `Tài khoản (${adminUsers.length || 5})` },
            ].map(tab => (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id as any)}
                className={cn(
                  "px-3.5 py-2 rounded-xl text-xs font-bold font-sans tabular-nums transition-all whitespace-nowrap",
                  activeTab === tab.id
                    ? "bg-[#191614] text-white shadow-xs"
                    : "text-[#615C56] hover:bg-[#F5F3ED] hover:text-[#191614]"
                )}
              >
                {tab.label}
              </button>
            ))}
          </nav>

        </div>
      </div>

      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-6">

        {/* ===================== TAB 1: OVERVIEW ===================== */}
        {activeTab === 'overview' && (
          <div className="space-y-6">
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
              
              <div className="bg-white p-5 rounded-2xl border border-[#EBE7DC] shadow-xs">
                <div className="flex items-center justify-between mb-3">
                  <span className="text-xs uppercase font-bold tracking-wider text-[#8C857B]">Tựa Sách Trong Kho</span>
                  <div className="w-9 h-9 rounded-xl bg-blue-50 text-blue-600 flex items-center justify-center">
                    <BookOpen className="w-4 h-4" />
                  </div>
                </div>
                <div className="text-3xl font-bold font-sans tabular-nums text-[#191614] tracking-tight">
                  {(overview?.totalBooks ?? 1000).toLocaleString('vi-VN')} <span className="text-sm font-medium text-[#706B65]">cuốn</span>
                </div>
                <p className="text-xs text-[#8C857B] mt-1 tabular-nums font-sans">
                  Tổng {(overview?.totalStock ?? 128724).toLocaleString('vi-VN')} bản in sẵn sàng bán
                </p>
              </div>

              <div className="bg-white p-5 rounded-2xl border border-[#EBE7DC] shadow-xs">
                <div className="flex items-center justify-between mb-3">
                  <span className="text-xs uppercase font-bold tracking-wider text-[#8C857B]">Doanh Thu</span>
                  <div className="w-9 h-9 rounded-xl bg-emerald-50 text-emerald-600 flex items-center justify-center">
                    <DollarSign className="w-4 h-4" />
                  </div>
                </div>
                <div className="text-3xl font-bold font-sans tabular-nums text-[#191614] tracking-tight">
                  {(overview?.totalRevenue ?? 0).toLocaleString('vi-VN')} <span className="text-sm font-medium text-[#706B65]">đ</span>
                </div>
                <p className="text-xs text-emerald-600 font-medium mt-1">
                  Đã ghi nhận vào sổ cái
                </p>
              </div>

              <div className="bg-white p-5 rounded-2xl border border-[#EBE7DC] shadow-xs">
                <div className="flex items-center justify-between mb-3">
                  <span className="text-xs uppercase font-bold tracking-wider text-[#8C857B]">Tổng Đơn Hàng</span>
                  <div className="w-9 h-9 rounded-xl bg-amber-50 text-amber-600 flex items-center justify-center">
                    <ShoppingCart className="w-4 h-4" />
                  </div>
                </div>
                <div className="text-3xl font-bold font-sans tabular-nums text-[#191614] tracking-tight">
                  {(overview?.totalOrders ?? 0).toLocaleString('vi-VN')} <span className="text-sm font-medium text-[#706B65]">đơn</span>
                </div>
                <p className="text-xs text-[#8C857B] mt-1">Cập nhật theo thời gian thực</p>
              </div>

              <div className="bg-white p-5 rounded-2xl border border-[#EBE7DC] shadow-xs">
                <div className="flex items-center justify-between mb-3">
                  <span className="text-xs uppercase font-bold tracking-wider text-[#8C857B]">Tài Khoản Phân Quyền</span>
                  <div className="w-9 h-9 rounded-xl bg-purple-50 text-purple-600 flex items-center justify-center">
                    <Users className="w-4 h-4" />
                  </div>
                </div>
                <div className="text-3xl font-bold font-sans tabular-nums text-[#191614] tracking-tight">
                  {adminUsers.length || 5} <span className="text-sm font-medium text-[#706B65]">tài khoản</span>
                </div>
                <p className="text-xs text-[#8C857B] mt-1">Quản trị viên, Nhân viên &amp; Độc giả</p>
              </div>

            </div>

            {/* Visual Analytics & Reports Section */}
            <AdminAnalyticsSection
              weeklySales={overview?.weeklySales}
              topSellers={overview?.topSellers}
            />

            {/* Quick Actions & Category Distribution */}
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
              <div className="bg-white p-6 rounded-2xl border border-[#EBE7DC] shadow-xs">
                <h3 className="font-serif text-lg font-bold text-[#191614] mb-4">
                  Phân bổ theo Thể loại
                </h3>
                <div className="space-y-3">
                  {(overview?.topCategories || [
                    { id: 1, name: 'Văn học', bookCount: 45 },
                    { id: 2, name: 'Kinh tế & Kinh doanh', bookCount: 40 },
                    { id: 3, name: 'Tâm lý & Kỹ năng sống', bookCount: 40 },
                    { id: 4, name: 'Công nghệ & Lập trình', bookCount: 35 },
                    { id: 5, name: 'Lịch sử & Triết học', bookCount: 25 },
                  ]).map((cat) => (
                    <div key={cat.id}>
                      <div className="flex justify-between text-xs font-semibold text-[#423E3A] mb-1">
                        <span>{cat.name}</span>
                        <span className="font-sans tabular-nums font-semibold text-[#191614]">{cat.bookCount} cuốn</span>
                      </div>
                      <div className="w-full bg-[#F5F3ED] rounded-full h-2">
                        <div
                          className="bg-[#191614] h-2 rounded-full"
                          style={{ width: `${Math.min(100, (cat.bookCount / 50) * 100)}%` }}
                        />
                      </div>
                    </div>
                  ))}
                </div>
              </div>

              {/* Recent Orders Overview */}
              <div className="lg:col-span-2 bg-white p-6 rounded-2xl border border-[#EBE7DC] shadow-xs">
                <div className="flex items-center justify-between mb-4">
                  <h3 className="font-serif text-lg font-bold text-[#191614]">
                    Đơn hàng mới tiếp nhận
                  </h3>
                  <button
                    onClick={() => setActiveTab('orders')}
                    className="text-xs font-semibold text-[#B84A39] hover:underline"
                  >
                    Xem tất cả đơn hàng →
                  </button>
                </div>

                <div className="divide-y divide-[#F5F3ED]">
                  {(overview?.recentOrders && overview.recentOrders.length > 0) ? (
                    overview.recentOrders.map(o => (
                      <div key={o.id} className="py-3 flex items-center justify-between text-xs">
                        <div className="flex items-center gap-2.5">
                          <strong className="text-[#191614] font-mono text-xs font-semibold tabular-nums tracking-wide bg-[#F5F3ED] px-2.5 py-1 rounded-lg border border-[#DDD6C4]">
                            {o.orderCode}
                          </strong>
                          <span className="text-[#706B65] font-sans font-medium">{o.customerName}</span>
                        </div>
                        <div className="flex items-center gap-3">
                          <span className="font-bold font-sans tabular-nums text-sm text-[#B84A39]">
                            {o.finalAmount.toLocaleString('vi-VN')} đ
                          </span>
                          {(() => {
                            const conf = ORDER_STATUS_CONFIG[o.status] || { label: o.status, badgeClass: 'bg-stone-50 text-stone-800 border-stone-200' }
                            return (
                              <span className={cn("px-2 py-0.5 rounded-full text-[10px] font-bold border", conf.badgeClass)}>
                                {conf.label}
                              </span>
                            )
                          })()}
                        </div>
                      </div>
                    ))
                  ) : (
                    <p className="text-xs text-[#8C857B] py-4 text-center">Chưa có đơn hàng mới.</p>
                  )}
                </div>
              </div>
            </div>
          </div>
        )}

        {/* ===================== TAB 2: BOOKS MANAGEMENT ===================== */}
        {activeTab === 'books' && (
          <div className="space-y-4">
            <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-3 bg-white p-4 rounded-2xl border border-[#EBE7DC]">
              <div className="relative flex-1">
                <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-[#8C857B]" />
                <input
                  type="text"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  placeholder="Tìm theo tên sách, tác giả hoặc ISBN..."
                  className="w-full text-xs pl-10 pr-4 py-2.5 rounded-xl border border-[#DDD6C4] outline-none focus:border-[#191614]"
                />
              </div>

              <div className="flex items-center gap-2">
                <select
                  value={selectedCategory || ''}
                  onChange={(e) => setSelectedCategory(e.target.value ? Number(e.target.value) : null)}
                  className="text-xs rounded-xl border border-[#DDD6C4] px-3 py-2.5 outline-none bg-white font-medium"
                >
                  <option value="">Tất cả danh mục</option>
                  <option value={1}>Văn học</option>
                  <option value={2}>Kinh tế & Kinh doanh</option>
                  <option value={3}>Tâm lý & Kỹ năng sống</option>
                  <option value={4}>Công nghệ & Lập trình</option>
                  <option value={5}>Lịch sử & Triết học</option>
                  <option value={6}>Văn học Thiếu nhi</option>
                  <option value={7}>Khoa học & Vũ trụ</option>
                </select>

                <button
                  onClick={() => setLowStockFilter(!lowStockFilter)}
                  className={cn(
                    "flex items-center gap-1.5 px-3 py-2.5 rounded-xl border text-xs font-semibold transition-all shrink-0",
                    lowStockFilter
                      ? "bg-red-50 text-red-700 border-red-300 font-bold"
                      : "bg-white text-[#706B65] border-[#DDD6C4] hover:bg-[#FAF9F5]"
                  )}
                >
                  <AlertTriangle className="w-3.5 h-3.5 text-red-600" />
                  <span>Sắp hết (≤ 20)</span>
                  <span className="px-1.5 py-0.5 rounded-full text-[10px] bg-red-600 text-white font-sans tabular-nums font-bold">
                    {overview?.lowStockBooks ?? 21}
                  </span>
                </button>

                <button
                  onClick={() => {
                    setEditingBook({
                      title: '',
                      originalPrice: 100000,
                      stockQuantity: 20,
                      categoryId: 1,
                      isAvailable: true
                    })
                    setNewAuthorName('')
                    setIsModalOpen(true)
                  }}
                  className="flex items-center gap-1.5 px-4 py-2.5 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-semibold shadow-xs transition-colors shrink-0"
                >
                  <Plus className="w-4 h-4" />
                  <span>Thêm sách mới</span>
                </button>
              </div>
            </div>

            {/* Books Table */}
            <div className="bg-white rounded-2xl border border-[#EBE7DC] overflow-hidden shadow-xs">
              <div className="overflow-x-auto">
                <table className="w-full text-left text-xs">
                  <thead className="bg-[#FAF9F5] border-b border-[#EBE7DC] text-[#706B65] uppercase tracking-wider font-semibold">
                    <tr>
                      <th className="p-3.5">Bìa sách</th>
                      <th className="p-3.5">Tựa sách</th>
                      <th className="p-3.5">Tác giả</th>
                      <th className="p-3.5">Thể loại</th>
                      <th className="p-3.5">Giá bán</th>
                      <th className="p-3.5">Tồn kho</th>
                      <th className="p-3.5 text-right">Thao tác</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-[#F5F3ED]">
                    {(lowStockFilter ? books.filter(b => b.stockQuantity <= 20) : books).map(b => (
                      <tr key={b.id} className="hover:bg-[#FAFAF7] transition-colors">
                        <td className="p-3.5">
                          <img
                            src={b.coverImageUrl || 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg'}
                            alt={b.title}
                            referrerPolicy="no-referrer"
                            onError={(e) => {
                              (e.target as HTMLImageElement).src = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg'
                            }}
                            className="w-10 h-14 object-cover rounded-lg border border-[#EBE7DC]"
                          />
                        </td>
                        <td className="p-3.5 max-w-xs">
                          <strong className="text-sm font-serif text-[#191614] block line-clamp-1">{b.title}</strong>
                          <span className="text-[11px] text-[#8C857B] font-mono">{b.isbn}</span>
                        </td>
                        <td className="p-3.5 text-[#615C56] font-medium">{b.authorNames || 'Chưa cập nhật'}</td>
                        <td className="p-3.5">
                          <span className="px-2 py-0.5 rounded-full text-[10px] font-semibold bg-[#F5F3ED] text-[#423E3A] border border-[#DDD6C4]">
                            {b.categoryName}
                          </span>
                        </td>
                        <td className="p-3.5 font-bold font-sans tabular-nums text-[#B84A39]">
                          {(b.salePrice || b.originalPrice).toLocaleString('vi-VN')} đ
                        </td>
                        <td className="p-3.5">
                          <span className={cn(
                            "px-2.5 py-0.5 rounded-full font-bold font-sans tabular-nums text-[10px] border",
                            b.stockQuantity <= 20 
                              ? "bg-red-50 text-red-700 border-red-200" 
                              : "bg-emerald-50 text-emerald-800 border-emerald-200"
                          )}>
                            {b.stockQuantity} cuốn
                          </span>
                        </td>
                        <td className="p-3.5 text-right">
                          <button
                            onClick={() => {
                              setEditingBook(b)
                              setNewAuthorName(b.authorNames)
                              setIsModalOpen(true)
                            }}
                            className="p-1.5 rounded-lg text-[#706B65] hover:text-[#191614] hover:bg-[#F5F3ED]"
                            title="Sửa sách"
                          >
                            <Edit3 className="w-4 h-4" />
                          </button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        )}

        {/* ===================== TAB 3: AUTHOR MANAGEMENT (NEW!) ===================== */}
        {activeTab === 'authors' && (
          <div className="space-y-4">
            <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-3 bg-white p-4 rounded-2xl border border-[#EBE7DC]">
              <div className="relative flex-1">
                <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-[#8C857B]" />
                <input
                  type="text"
                  value={authorSearch}
                  onChange={(e) => setAuthorSearch(e.target.value)}
                  placeholder="Tìm theo tên tác giả hoặc quốc tịch..."
                  className="w-full text-xs pl-10 pr-4 py-2.5 rounded-xl border border-[#DDD6C4] outline-none focus:border-[#191614]"
                />
              </div>

              <button
                onClick={() => {
                  setEditingAuthor({ name: '', nationality: 'Việt Nam', biography: '', avatarUrl: '' })
                  setIsAuthorModalOpen(true)
                }}
                className="flex items-center gap-1.5 px-4 py-2.5 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-semibold shadow-xs transition-colors shrink-0"
              >
                <Plus className="w-4 h-4" />
                <span>Thêm tác giả mới</span>
              </button>
            </div>

            {/* Authors Grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              {authors.map((author) => (
                <div 
                  key={author.id} 
                  className="bg-white rounded-2xl border border-[#EBE7DC] p-5 shadow-xs flex flex-col justify-between hover:border-[#B84A39] hover:shadow-md transition-all group"
                >
                  <div 
                    onClick={() => handleViewAuthorBooks(author)}
                    className="cursor-pointer"
                    title="Nhấn để xem các đầu sách của tác giả này"
                  >
                    <div className="flex items-start justify-between gap-3 mb-2">
                      <div className="flex items-center gap-3">
                        {author.avatarUrl ? (
                          <img
                            src={author.avatarUrl}
                            alt={author.name}
                            referrerPolicy="no-referrer"
                            onError={(e) => {
                              (e.target as HTMLImageElement).style.display = 'none';
                            }}
                            className="w-12 h-12 rounded-xl object-cover shadow-xs shrink-0 group-hover:scale-105 transition-transform border border-[#DDD6C4]"
                          />
                        ) : (
                          <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-[#191614] to-[#423E3A] text-white font-serif font-bold text-lg flex items-center justify-center shadow-xs shrink-0 group-hover:scale-105 transition-transform">
                            {author.name.charAt(0).toUpperCase()}
                          </div>
                        )}
                        <div>
                          <h4 className="font-serif font-bold text-base text-[#191614] leading-snug group-hover:text-[#B84A39] transition-colors">
                            {author.name}
                          </h4>
                          {author.nationality && (
                            <span className="text-[10px] font-semibold text-[#8C857B] uppercase tracking-wider block mt-0.5">
                              Quốc tịch: <strong className="text-[#423E3A]">{author.nationality}</strong>
                            </span>
                          )}
                        </div>
                      </div>

                      <span className="px-2.5 py-1 rounded-full text-xs font-bold font-sans tabular-nums bg-[#F5F3ED] text-[#191614] border border-[#DDD6C4] shrink-0 group-hover:bg-[#191614] group-hover:text-white transition-colors">
                        {author.bookCount} đầu sách
                      </span>
                    </div>

                    <p className="text-xs text-[#615C56] line-clamp-3 mt-3 leading-relaxed">
                      {author.biography || 'Chưa có thông tin tiểu sử chi tiết.'}
                    </p>
                  </div>

                  <div className="mt-4 pt-3 border-t border-[#F5F3ED] flex items-center justify-between gap-2">
                    <button
                      onClick={() => handleViewAuthorBooks(author)}
                      className="flex items-center gap-1.5 text-xs font-bold font-sans tabular-nums text-[#B84A39] hover:underline"
                    >
                      <BookOpen className="w-3.5 h-3.5" />
                      <span>Xem {author.bookCount} tác phẩm →</span>
                    </button>

                    <div className="flex items-center gap-1.5">
                      <button
                        onClick={() => {
                          setEditingAuthor(author)
                          setIsAuthorModalOpen(true)
                        }}
                        className="flex items-center gap-1 px-3 py-1.5 rounded-lg border border-[#DDD6C4] hover:bg-[#F5F3ED] text-xs font-semibold text-[#423E3A] transition-colors"
                      >
                        <Edit3 className="w-3.5 h-3.5" />
                        <span>Chỉnh sửa</span>
                      </button>
                      <button
                        onClick={() => handleDeleteAuthor(author)}
                        className="p-1.5 rounded-lg border border-red-200 hover:bg-red-50 text-red-600 transition-colors"
                        title="Xóa tác giả"
                      >
                        <Trash2 className="w-3.5 h-3.5" />
                      </button>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* ===================== TAB: NHẬP KHO (ERP MINI) ===================== */}
        {activeTab === 'receipts' && (
          <AdminReceiptsTab />
        )}

        {/* ===================== TAB: MÃ KHUYẾN MÃI & VOUCHER ===================== */}
        {activeTab === 'discounts' && (
          <AdminDiscountsTab />
        )}

        {/* ===================== TAB 4: ORDERS MANAGEMENT ===================== */}
        {activeTab === 'orders' && (
          <div className="space-y-4">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-white p-4 rounded-2xl border border-[#EBE7DC]">
              <div>
                <h3 className="font-serif text-base font-bold text-[#191614]">Quản lý đơn đặt hàng</h3>
                <p className="text-xs text-[#706B65] mt-0.5">Cập nhật trạng thái trực tiếp, in hóa đơn và theo dõi quy trình giao nhận</p>
              </div>
              <div className="flex flex-wrap items-center gap-1.5">
                {[
                  { id: 'all', label: 'Tất cả' },
                  { id: 'Pending', label: 'Chờ xử lý' },
                  { id: 'Processing', label: 'Đang đóng gói' },
                  { id: 'Shipped', label: 'Đang giao hàng' },
                  { id: 'Delivered', label: 'Đã hoàn tất' },
                  { id: 'Cancelled', label: 'Đã hủy' }
                ].map(st => (
                  <button
                    key={st.id}
                    onClick={() => setOrderStatusFilter(st.id)}
                    className={cn(
                      "px-3 py-1.5 rounded-xl text-xs font-semibold transition-all",
                      orderStatusFilter === st.id
                        ? "bg-[#191614] text-white shadow-xs"
                        : "bg-[#F5F3ED] text-[#615C56] hover:bg-[#EBE7DC]"
                    )}
                  >
                    {st.label}
                  </button>
                ))}
              </div>
            </div>

            <div className="space-y-3">
              {orders.length === 0 ? (
                <div className="bg-white rounded-2xl border border-[#EBE7DC] p-10 text-center text-[#8C857B]">
                  <ShoppingCart className="w-10 h-10 mx-auto text-[#DDD6C4] mb-2" />
                  <p className="font-serif text-base font-bold text-[#191614]">Không có đơn hàng nào</p>
                  <p className="text-xs text-[#706B65] mt-1">Không tìm thấy đơn hàng phù hợp với trạng thái đã chọn.</p>
                </div>
              ) : (
                orders.map(order => {
                  const statusConfig = ORDER_STATUS_CONFIG[order.status] || {
                    label: order.status,
                    badgeClass: 'bg-stone-100 text-stone-800 border-stone-300'
                  }
                  const normalizedStatus = order.status === 'Shipping' ? 'Shipped' : order.status === 'Completed' ? 'Delivered' : order.status
                  const isBusy = updatingOrderId === order.id

                  return (
                    <div key={order.id} className="bg-white rounded-2xl border border-[#EBE7DC] p-5 shadow-xs hover:border-[#DDD6C4] transition-all">
                      {/* Header */}
                      <div className="flex flex-wrap items-center justify-between gap-3 pb-3 border-b border-[#F5F3ED]">
                        <div className="flex items-center gap-2">
                          <span className="font-mono text-xs font-semibold text-[#191614] tabular-nums bg-[#F5F3ED] px-2.5 py-1 rounded-lg border border-[#DDD6C4]">
                            {order.orderCode}
                          </span>
                          <span className="text-xs text-[#8C857B] font-sans tabular-nums flex items-center gap-1">
                            <Clock className="w-3.5 h-3.5" />
                            {new Date(order.orderDate).toLocaleDateString('vi-VN')} {new Date(order.orderDate).toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' })}
                          </span>
                        </div>
                        <div className="flex items-center gap-3">
                          <span className="text-base font-sans font-bold tabular-nums text-[#B84A39]">
                            {order.finalAmount.toLocaleString('vi-VN')} đ
                          </span>
                          <span className={cn("px-2.5 py-1 rounded-full text-xs font-bold border inline-flex items-center gap-1.5", statusConfig.badgeClass)}>
                            <span className="w-1.5 h-1.5 rounded-full bg-current" />
                            {statusConfig.label} ({order.status})
                          </span>
                        </div>
                      </div>

                      {/* Customer info */}
                      <div className="py-3 text-xs text-[#615C56] grid grid-cols-1 sm:grid-cols-2 gap-2 bg-[#FAF9F5]/60 -mx-5 px-5 my-2">
                        <div>
                          <p>Khách hàng: <strong className="text-[#191614]">{order.customerName}</strong> ({order.customerPhone})</p>
                          <p className="mt-0.5">Địa chỉ nhận hàng: <span className="text-[#191614]">{order.shippingAddress}</span></p>
                        </div>
                        <div>
                          <p>Phương thức thanh toán: <strong className="text-[#191614]">{order.paymentMethod}</strong></p>
                          {order.note && <p className="mt-0.5">Ghi chú: <em className="text-[#B84A39]">"{order.note}"</em></p>}
                        </div>
                      </div>

                      {/* Items preview */}
                      <div className="py-1 text-xs text-[#706B65]">
                        <span className="font-semibold text-[#191614]">{order.items?.length || 0} sản phẩm: </span>
                        <span>{order.items?.map(i => `${i.bookTitle} (x${i.quantity})`).join(', ') || 'Chi tiết trong hóa đơn'}</span>
                      </div>

                      {/* Actions Footer */}
                      <div className="pt-3 mt-2 border-t border-[#F5F3ED] flex flex-wrap items-center justify-between gap-3">
                        {/* Status selector dropdown */}
                        <div className="flex items-center gap-2">
                          <span className="text-xs font-semibold text-[#706B65]">Cập nhật trạng thái:</span>
                          <select
                            value={normalizedStatus}
                            disabled={isBusy}
                            onChange={(e) => handleUpdateOrderStatus(order.id, e.target.value)}
                            className="text-xs font-semibold rounded-xl border border-[#DDD6C4] bg-white px-3 py-1.5 text-[#191614] shadow-2xs hover:border-[#191614] focus:outline-none focus:ring-2 focus:ring-[#191614]/20 transition-all cursor-pointer disabled:opacity-50"
                          >
                            <option value="Pending">⏳ Chờ xử lý (Pending)</option>
                            <option value="Processing">📦 Đang đóng gói (Processing)</option>
                            <option value="Shipped">🚚 Đang giao hàng (Shipped)</option>
                            <option value="Delivered">✅ Đã giao thành công (Delivered)</option>
                            <option value="Cancelled">❌ Hủy đơn hàng (Cancelled)</option>
                          </select>
                        </div>

                        {/* Quick action buttons & Print invoice */}
                        <div className="flex flex-wrap items-center gap-2">
                          <button
                            onClick={() => {
                              setSelectedInvoiceData({
                                orderCode: order.orderCode,
                                orderDate: order.orderDate,
                                customerName: order.customerName,
                                phoneNumber: order.customerPhone,
                                address: order.shippingAddress,
                                paymentMethod: order.paymentMethod,
                                status: order.status,
                                items: order.items?.map(i => ({
                                  title: i.bookTitle,
                                  quantity: i.quantity,
                                  price: i.unitPrice
                                })) || [],
                                totalAmount: order.totalAmount,
                                discountAmount: order.discountAmount,
                                shippingFee: order.shippingFee,
                                finalAmount: order.finalAmount,
                                note: order.note
                              })
                              setIsInvoiceOpen(true)
                            }}
                            className="px-3 py-1.5 rounded-xl border border-[#DDD6C4] bg-[#FAF9F5] hover:bg-[#EBE7DC] text-xs font-semibold text-[#191614] flex items-center gap-1.5 transition-colors shadow-2xs"
                          >
                            <Printer className="w-3.5 h-3.5 text-[#B84A39]" />
                            <span>In Hóa Đơn</span>
                          </button>

                          {/* Quick Transitions */}
                          {normalizedStatus === 'Pending' && (
                            <>
                              <button
                                disabled={isBusy}
                                onClick={() => handleUpdateOrderStatus(order.id, 'Processing')}
                                className="px-3 py-1.5 text-xs font-semibold rounded-xl bg-blue-50 text-blue-700 hover:bg-blue-100 border border-blue-200 transition-colors flex items-center gap-1"
                              >
                                <PackageCheck className="w-3.5 h-3.5" />
                                <span>Đóng gói (Processing)</span>
                              </button>
                              <button
                                disabled={isBusy}
                                onClick={() => handleUpdateOrderStatus(order.id, 'Shipped')}
                                className="px-3 py-1.5 text-xs font-semibold rounded-xl bg-indigo-50 text-indigo-700 hover:bg-indigo-100 border border-indigo-200 transition-colors flex items-center gap-1"
                              >
                                <Truck className="w-3.5 h-3.5" />
                                <span>Giao hàng ngay</span>
                              </button>
                              <button
                                disabled={isBusy}
                                onClick={() => handleUpdateOrderStatus(order.id, 'Cancelled')}
                                className="px-2.5 py-1.5 text-xs font-semibold rounded-xl bg-rose-50 text-rose-700 hover:bg-rose-100 border border-rose-200 transition-colors flex items-center gap-1"
                              >
                                <Ban className="w-3.5 h-3.5" />
                                <span>Hủy đơn</span>
                              </button>
                            </>
                          )}

                          {normalizedStatus === 'Processing' && (
                            <>
                              <button
                                disabled={isBusy}
                                onClick={() => handleUpdateOrderStatus(order.id, 'Shipped')}
                                className="px-3 py-1.5 text-xs font-semibold rounded-xl bg-indigo-50 text-indigo-700 hover:bg-indigo-100 border border-indigo-200 transition-colors flex items-center gap-1"
                              >
                                <Truck className="w-3.5 h-3.5" />
                                <span>Bắt đầu giao hàng</span>
                              </button>
                              <button
                                disabled={isBusy}
                                onClick={() => handleUpdateOrderStatus(order.id, 'Cancelled')}
                                className="px-2.5 py-1.5 text-xs font-semibold rounded-xl bg-rose-50 text-rose-700 hover:bg-rose-100 border border-rose-200 transition-colors flex items-center gap-1"
                              >
                                <Ban className="w-3.5 h-3.5" />
                                <span>Hủy đơn</span>
                              </button>
                            </>
                          )}

                          {normalizedStatus === 'Shipped' && (
                            <>
                              <button
                                disabled={isBusy}
                                onClick={() => handleUpdateOrderStatus(order.id, 'Delivered')}
                                className="px-3 py-1.5 text-xs font-semibold rounded-xl bg-emerald-50 text-emerald-700 hover:bg-emerald-100 border border-emerald-200 transition-colors flex items-center gap-1 shadow-2xs"
                              >
                                <CheckCircle2 className="w-3.5 h-3.5" />
                                <span>Xác nhận đã giao thành công</span>
                              </button>
                              <button
                                disabled={isBusy}
                                onClick={() => handleUpdateOrderStatus(order.id, 'Cancelled')}
                                className="px-2.5 py-1.5 text-xs font-semibold rounded-xl bg-rose-50 text-rose-700 hover:bg-rose-100 border border-rose-200 transition-colors flex items-center gap-1"
                              >
                                <Ban className="w-3.5 h-3.5" />
                                <span>Hủy / Trả hàng</span>
                              </button>
                            </>
                          )}

                          {normalizedStatus === 'Delivered' && (
                            <span className="px-3 py-1.5 text-xs font-semibold rounded-xl bg-emerald-50 text-emerald-700 border border-emerald-200 flex items-center gap-1">
                              <CheckCircle2 className="w-3.5 h-3.5" />
                              <span>Đơn hàng đã hoàn tất</span>
                            </span>
                          )}

                          {normalizedStatus === 'Cancelled' && (
                            <button
                              disabled={isBusy}
                              onClick={() => handleUpdateOrderStatus(order.id, 'Pending')}
                              className="px-3 py-1.5 text-xs font-semibold rounded-xl bg-amber-50 text-amber-800 hover:bg-amber-100 border border-amber-200 transition-colors flex items-center gap-1"
                            >
                              <RefreshCw className="w-3.5 h-3.5" />
                              <span>Khôi phục đơn (Pending)</span>
                            </button>
                          )}
                        </div>
                      </div>
                    </div>
                  )
                })
              )}
            </div>
          </div>
        )}

        {/* ===================== TAB: ĐÁNH GIÁ & BÌNH LUẬN ===================== */}
        {activeTab === 'reviews' && (
          <AdminReviewsTab />
        )}

        {/* ===================== TAB 5: STAFF & USER MANAGEMENT (ENHANCED!) ===================== */}
        {activeTab === 'users' && (
          <div className="space-y-4">
            
            {/* Filter & Action Bar */}
            <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-3 bg-white p-4 rounded-2xl border border-[#EBE7DC]">
              <div className="relative flex-1">
                <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-[#8C857B]" />
                <input
                  type="text"
                  value={userSearch}
                  onChange={(e) => setUserSearch(e.target.value)}
                  placeholder="Tìm theo họ tên, email hoặc số điện thoại..."
                  className="w-full text-xs pl-10 pr-4 py-2.5 rounded-xl border border-[#DDD6C4] outline-none focus:border-[#191614]"
                />
              </div>

              {/* Role Filter Pills */}
              <div className="flex items-center gap-1.5 overflow-x-auto">
                {[
                  { id: 'all', label: `Tất cả (${adminUsers.length})` },
                  { id: 'staff', label: `Nhân viên (${adminUsers.filter(u => u.role === 'SalesStaff' || u.role === 'WarehouseStaff').length})` },
                  { id: 'admin', label: `Quản trị (${adminUsers.filter(u => u.role === 'Admin').length})` },
                  { id: 'customer', label: `Độc giả (${adminUsers.filter(u => u.role === 'Customer').length})` },
                ].map(r => (
                  <button
                    key={r.id}
                    onClick={() => setUserRoleFilter(r.id as any)}
                    className={cn(
                      "px-3 py-2 rounded-xl text-xs font-bold transition-all whitespace-nowrap",
                      userRoleFilter === r.id
                        ? "bg-[#191614] text-white shadow-xs"
                        : "bg-[#F5F3ED] text-[#615C56] hover:bg-[#EBE7DC]"
                    )}
                  >
                    {r.label}
                  </button>
                ))}

                <button
                  onClick={() => {
                    setEditingUser({
                      fullName: '',
                      email: '',
                      phoneNumber: '',
                      roleValue: 1, // SalesStaff
                      isActive: true
                    })
                    setNewStaffPassword('')
                    setIsUserModalOpen(true)
                  }}
                  className="flex items-center gap-1.5 px-4 py-2.5 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-semibold shadow-xs transition-colors shrink-0 ml-1"
                >
                  <UserPlus className="w-4 h-4" />
                  <span>+ Thêm Nhân viên mới</span>
                </button>
              </div>
            </div>

            {/* Users List Cards */}
            <div className="bg-white rounded-3xl border border-[#EBE7DC] p-6 shadow-xs">
              <div className="divide-y divide-[#F5F3ED]">
                {filteredUsers.map((u) => (
                  <div key={u.id} className="py-4 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                    
                    <div className="flex items-start gap-3.5">
                      <div className="w-11 h-11 rounded-2xl bg-[#F5F3ED] flex items-center justify-center text-[#191614] font-serif font-bold text-lg shrink-0">
                        {u.fullName.charAt(0).toUpperCase()}
                      </div>
                      <div>
                        <div className="flex flex-wrap items-center gap-2">
                          <span className="font-serif font-bold text-sm text-[#191614]">{u.fullName}</span>
                          
                          {/* Role Badge */}
                          <span className={cn(
                            "px-2 py-0.5 rounded-md text-[10px] uppercase font-bold border",
                            u.role === 'Admin' ? "bg-amber-100 text-amber-900 border-amber-300" :
                            u.role === 'SalesStaff' ? "bg-blue-100 text-blue-900 border-blue-300" :
                            u.role === 'WarehouseStaff' ? "bg-cyan-100 text-cyan-900 border-cyan-300" :
                            "bg-gray-100 text-gray-800 border-gray-300"
                          )}>
                            {u.role === 'Admin' ? 'Toàn quyền Admin' :
                             u.role === 'SalesStaff' ? 'Staff / Bán hàng' :
                             u.role === 'WarehouseStaff' ? 'Staff / Quản lý kho' : 'Khách hàng'}
                          </span>

                          {/* Status Badge */}
                          <span className={cn(
                            "px-2 py-0.5 rounded-full text-[10px] font-semibold",
                            u.isActive ? "bg-emerald-50 text-emerald-700" : "bg-red-50 text-red-700"
                          )}>
                            {u.isActive ? '● Đang hoạt động' : '● Đã khóa'}
                          </span>
                        </div>

                        <p className="text-xs text-[#706B65] mt-1">
                          {u.email} {u.phoneNumber && `• SĐT: ${u.phoneNumber}`} • <span className="font-sans tabular-nums font-semibold">{u.totalOrders}</span> đơn hàng
                        </p>
                      </div>
                    </div>

                    {/* Actions */}
                    <div className="flex items-center gap-2 self-end sm:self-center">
                      <button
                        onClick={() => {
                          setResetTargetUser(u)
                          setResetNewPass('')
                          setIsResetPassModalOpen(true)
                        }}
                        className="flex items-center gap-1 px-3 py-1.5 rounded-xl border border-[#DDD6C4] hover:bg-[#F5F3ED] text-xs font-semibold text-[#423E3A] transition-colors"
                        title="Đặt lại mật khẩu"
                      >
                        <Key className="w-3.5 h-3.5 text-amber-600" />
                        <span>Đổi mật khẩu</span>
                      </button>

                      <button
                        onClick={() => {
                          setEditingUser(u)
                          setIsUserModalOpen(true)
                        }}
                        className="flex items-center gap-1 px-3 py-1.5 rounded-xl border border-[#DDD6C4] hover:bg-[#F5F3ED] text-xs font-semibold text-[#423E3A] transition-colors"
                        title="Sửa thông tin"
                      >
                        <Edit3 className="w-3.5 h-3.5" />
                        <span>Sửa</span>
                      </button>

                      {u.id !== user?.id && (
                        <button
                          onClick={() => handleToggleUserStatus(u)}
                          className={cn(
                            "px-3 py-1.5 rounded-xl text-xs font-semibold transition-colors",
                            u.isActive 
                              ? "border border-amber-300 text-amber-800 hover:bg-amber-50" 
                              : "border border-emerald-300 text-emerald-800 hover:bg-emerald-50"
                          )}
                        >
                          {u.isActive ? 'Khóa' : 'Mở khóa'}
                        </button>
                      )}

                      {u.id !== user?.id && (
                        <button
                          onClick={() => handleDeleteUser(u)}
                          className="p-1.5 rounded-xl border border-red-200 text-red-600 hover:bg-red-50 transition-colors"
                          title="Xóa tài khoản"
                        >
                          <Trash2 className="w-3.5 h-3.5" />
                        </button>
                      )}
                    </div>

                  </div>
                ))}
              </div>
            </div>

          </div>
        )}

      </div>

      {/* ===================== MODAL 1: ADD / EDIT BOOK ===================== */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-xs">
          <div className="w-full max-w-xl bg-white rounded-3xl border border-[#EBE7DC] shadow-2xl overflow-hidden max-h-[90vh] flex flex-col">
            <div className="px-6 py-4 border-b border-[#EBE7DC] flex items-center justify-between bg-[#FAF9F5]">
              <h3 className="font-serif text-lg font-bold text-[#191614]">
                {editingBook?.id ? 'Chỉnh sửa tựa sách' : 'Thêm sách mới vào kho'}
              </h3>
              <button onClick={() => setIsModalOpen(false)} className="p-1 rounded-lg text-[#8C857B] hover:text-[#191614]">
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleSaveBook} className="p-6 space-y-4 overflow-y-auto flex-1">
              <div>
                <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                  Tên tựa sách <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  required
                  value={editingBook?.title || ''}
                  onChange={(e) => setEditingBook({ ...editingBook, title: e.target.value })}
                  placeholder="Ví dụ: Đắc Nhân Tâm, Mắt Biếc..."
                  className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                />
              </div>

              {!editingBook?.id && (
                <div>
                  <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                    Tên tác giả
                  </label>
                  <input
                    type="text"
                    value={newAuthorName}
                    onChange={(e) => setNewAuthorName(e.target.value)}
                    placeholder="Ví dụ: Dale Carnegie, Nguyễn Nhật Ánh..."
                    className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                  />
                </div>
              )}

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                    Giá bìa (VNĐ) <span className="text-red-500">*</span>
                  </label>
                  <input
                    type="number"
                    required
                    min={0}
                    step={1000}
                    value={editingBook?.originalPrice || 0}
                    onChange={(e) => setEditingBook({ ...editingBook, originalPrice: Number(e.target.value) })}
                    className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                  />
                </div>
                <div>
                  <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                    Giá bán ưu đãi (VNĐ)
                  </label>
                  <input
                    type="number"
                    min={0}
                    step={1000}
                    value={editingBook?.salePrice || 0}
                    onChange={(e) => setEditingBook({ ...editingBook, salePrice: Number(e.target.value) })}
                    className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                    Số lượng trong kho
                  </label>
                  <input
                    type="number"
                    min={0}
                    value={editingBook?.stockQuantity || 0}
                    onChange={(e) => setEditingBook({ ...editingBook, stockQuantity: Number(e.target.value) })}
                    className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                  />
                </div>
                <div>
                  <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                    Thể loại
                  </label>
                  <select
                    value={editingBook?.categoryId || 1}
                    onChange={(e) => setEditingBook({ ...editingBook, categoryId: Number(e.target.value) })}
                    className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                  >
                    <option value={1}>Văn học</option>
                    <option value={2}>Kinh tế & Kinh doanh</option>
                    <option value={3}>Tâm lý & Kỹ năng sống</option>
                    <option value={4}>Công nghệ & Lập trình</option>
                    <option value={5}>Lịch sử & Triết học</option>
                    <option value={6}>Thiếu nhi</option>
                    <option value={7}>Khoa học & Vũ trụ</option>
                  </select>
                </div>
              </div>

              <div>
                <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                  Đường dẫn ảnh bìa thật (URL)
                </label>
                <input
                  type="url"
                  value={editingBook?.coverImageUrl || ''}
                  onChange={(e) => setEditingBook({ ...editingBook, coverImageUrl: e.target.value })}
                  placeholder="https://salt.tikicdn.com/cache/750x750/...jpg"
                  className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                />
              </div>

              <div className="pt-2 flex justify-end gap-2">
                <button
                  type="button"
                  onClick={() => setIsModalOpen(false)}
                  className="px-4 py-2 text-xs rounded-xl border border-[#DDD6C4] hover:bg-[#F5F3ED] text-[#423E3A] font-semibold"
                >
                  Hủy bỏ
                </button>
                <button
                  type="submit"
                  className="px-5 py-2 text-xs rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white font-semibold transition-colors shadow-xs"
                >
                  {editingBook?.id ? 'Lưu thay đổi' : 'Thêm sách vào kho'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* ===================== MODAL 2: ADD / EDIT AUTHOR ===================== */}
      {isAuthorModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-xs">
          <div className="w-full max-w-lg bg-white rounded-3xl border border-[#EBE7DC] shadow-2xl overflow-hidden flex flex-col">
            <div className="px-6 py-4 border-b border-[#EBE7DC] flex items-center justify-between bg-[#FAF9F5]">
              <div className="flex items-center gap-2">
                <Feather className="w-5 h-5 text-[#B84A39]" />
                <h3 className="font-serif text-lg font-bold text-[#191614]">
                  {editingAuthor?.id ? 'Chỉnh sửa tác giả' : 'Thêm tác giả mới'}
                </h3>
              </div>
              <button onClick={() => setIsAuthorModalOpen(false)} className="p-1 rounded-lg text-[#8C857B] hover:text-[#191614]">
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleSaveAuthor} className="p-6 space-y-4">
              <div>
                <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                  Tên tác giả <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  required
                  value={editingAuthor?.name || ''}
                  onChange={(e) => setEditingAuthor({ ...editingAuthor, name: e.target.value })}
                  placeholder="Ví dụ: Haruki Murakami, Rosie Nguyễn..."
                  className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                />
              </div>

              <div>
                <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                  Quốc tịch
                </label>
                <input
                  type="text"
                  value={editingAuthor?.nationality || ''}
                  onChange={(e) => setEditingAuthor({ ...editingAuthor, nationality: e.target.value })}
                  placeholder="Ví dụ: Việt Nam, Nhật Bản, Mỹ..."
                  className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                />
              </div>

              <div>
                <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                  Tiểu sử tác giả
                </label>
                <textarea
                  rows={3}
                  value={editingAuthor?.biography || ''}
                  onChange={(e) => setEditingAuthor({ ...editingAuthor, biography: e.target.value })}
                  placeholder="Đôi nét về sự nghiệp và tác phẩm tiêu biểu..."
                  className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                />
              </div>

              <div className="pt-2 flex justify-end gap-2">
                <button
                  type="button"
                  onClick={() => setIsAuthorModalOpen(false)}
                  className="px-4 py-2 text-xs rounded-xl border border-[#DDD6C4] hover:bg-[#F5F3ED] text-[#423E3A] font-semibold"
                >
                  Hủy bỏ
                </button>
                <button
                  type="submit"
                  className="px-5 py-2 text-xs rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white font-semibold transition-colors shadow-xs"
                >
                  {editingAuthor?.id ? 'Lưu thay đổi' : 'Thêm tác giả'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* ===================== MODAL 3: ADD / EDIT STAFF & USER ===================== */}
      {isUserModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-xs">
          <div className="w-full max-w-lg bg-white rounded-3xl border border-[#EBE7DC] shadow-2xl overflow-hidden flex flex-col">
            <div className="px-6 py-4 border-b border-[#EBE7DC] flex items-center justify-between bg-[#FAF9F5]">
              <div className="flex items-center gap-2">
                <UserPlus className="w-5 h-5 text-[#B84A39]" />
                <h3 className="font-serif text-lg font-bold text-[#191614]">
                  {editingUser?.id ? 'Chỉnh sửa tài khoản nhân viên' : 'Thêm nhân viên mới'}
                </h3>
              </div>
              <button onClick={() => setIsUserModalOpen(false)} className="p-1 rounded-lg text-[#8C857B] hover:text-[#191614]">
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleSaveUser} className="p-6 space-y-4">
              <div>
                <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                  Họ và tên <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  required
                  value={editingUser?.fullName || ''}
                  onChange={(e) => setEditingUser({ ...editingUser, fullName: e.target.value })}
                  placeholder="Ví dụ: Trần Văn Nam"
                  className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                />
              </div>

              <div>
                <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                  Email đăng nhập <span className="text-red-500">*</span>
                </label>
                <input
                  type="email"
                  required
                  disabled={!!editingUser?.id}
                  value={editingUser?.email || ''}
                  onChange={(e) => setEditingUser({ ...editingUser, email: e.target.value })}
                  placeholder="nhanvien2@bookstore.vn"
                  className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614] disabled:bg-[#F5F3ED]"
                />
              </div>

              {!editingUser?.id && (
                <div>
                  <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                    Mật khẩu khởi tạo <span className="text-red-500">*</span>
                  </label>
                  <input
                    type="password"
                    required
                    value={newStaffPassword}
                    onChange={(e) => setNewStaffPassword(e.target.value)}
                    placeholder="Tối thiểu 6 ký tự (Ví dụ: Staff@123)"
                    className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                  />
                </div>
              )}

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                    Số điện thoại
                  </label>
                  <input
                    type="tel"
                    value={editingUser?.phoneNumber || ''}
                    onChange={(e) => setEditingUser({ ...editingUser, phoneNumber: e.target.value })}
                    placeholder="0912 345 678"
                    className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                  />
                </div>

                <div>
                  <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                    Phân quyền (Vai trò)
                  </label>
                  <select
                    value={editingUser?.roleValue ?? 1}
                    onChange={(e) => setEditingUser({ ...editingUser, roleValue: Number(e.target.value) })}
                    className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                  >
                    <option value={1}>Nhân viên bán hàng (Sales)</option>
                    <option value={2}>Nhân viên thủ kho (Warehouse)</option>
                    <option value={3}>Quản trị viên (Admin)</option>
                    <option value={0}>Khách hàng (Customer)</option>
                  </select>
                </div>
              </div>

              <div className="pt-2 flex justify-end gap-2">
                <button
                  type="button"
                  onClick={() => setIsUserModalOpen(false)}
                  className="px-4 py-2 text-xs rounded-xl border border-[#DDD6C4] hover:bg-[#F5F3ED] text-[#423E3A] font-semibold"
                >
                  Hủy bỏ
                </button>
                <button
                  type="submit"
                  className="px-5 py-2 text-xs rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white font-semibold transition-colors shadow-xs"
                >
                  {editingUser?.id ? 'Lưu thay đổi' : 'Tạo nhân viên'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* ===================== MODAL 4: RESET PASSWORD FOR STAFF ===================== */}
      {isResetPassModalOpen && resetTargetUser && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-xs">
          <div className="w-full max-w-md bg-white rounded-3xl border border-[#EBE7DC] shadow-2xl p-6">
            <div className="flex items-center gap-2.5 mb-4">
              <div className="p-2 rounded-xl bg-amber-50 text-amber-800">
                <Key className="w-5 h-5" />
              </div>
              <div>
                <h3 className="font-serif text-lg font-bold text-[#191614]">Đặt lại mật khẩu</h3>
                <p className="text-xs text-[#706B65]">Cho tài khoản: <strong>{resetTargetUser.fullName}</strong></p>
              </div>
            </div>

            <form onSubmit={handleResetPassword} className="space-y-4">
              <div>
                <label className="block text-xs font-bold text-[#423E3A] uppercase tracking-wider mb-1">
                  Mật khẩu mới <span className="text-red-500">*</span>
                </label>
                <input
                  type="password"
                  required
                  value={resetNewPass}
                  onChange={(e) => setResetNewPass(e.target.value)}
                  placeholder="Nhập mật khẩu mới (tối thiểu 6 ký tự)"
                  className="w-full px-3.5 py-2 text-sm rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                />
              </div>

              <div className="flex justify-end gap-2 pt-2">
                <button
                  type="button"
                  onClick={() => setIsResetPassModalOpen(false)}
                  className="px-4 py-2 text-xs rounded-xl border border-[#DDD6C4] text-[#423E3A] font-semibold hover:bg-[#F5F3ED]"
                >
                  Hủy
                </button>
                <button
                  type="submit"
                  className="px-5 py-2 text-xs rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white font-semibold transition-colors"
                >
                  Xác nhận đặt lại
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* ===================== MODAL 5: TÁC PHẨM CỦA TÁC GIẢ ===================== */}
      {isAuthorBooksModalOpen && selectedAuthorForBooks && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-xs">
          <div className="w-full max-w-3xl bg-white rounded-3xl border border-[#EBE7DC] shadow-2xl overflow-hidden max-h-[90vh] flex flex-col animate-in fade-in zoom-in-95 duration-200">
            {/* Modal Header */}
            <div className="px-6 py-5 border-b border-[#EBE7DC] bg-[#FAF9F5] flex items-start justify-between">
              <div className="flex items-center gap-4">
                {selectedAuthorForBooks.avatarUrl ? (
                  <img
                    src={selectedAuthorForBooks.avatarUrl}
                    alt={selectedAuthorForBooks.name}
                    referrerPolicy="no-referrer"
                    onError={(e) => {
                      (e.target as HTMLImageElement).style.display = 'none';
                    }}
                    className="w-14 h-14 rounded-2xl object-cover shadow-md shrink-0 border border-[#DDD6C4]"
                  />
                ) : (
                  <div className="w-14 h-14 rounded-2xl bg-gradient-to-br from-[#191614] to-[#423E3A] text-white font-serif font-bold text-2xl flex items-center justify-center shadow-md shrink-0">
                    {selectedAuthorForBooks.name.charAt(0).toUpperCase()}
                  </div>
                )}
                <div>
                  <div className="flex items-center gap-2.5">
                    <h3 className="font-serif text-xl font-bold text-[#191614]">
                      {selectedAuthorForBooks.name}
                    </h3>
                    <span className="px-2.5 py-0.5 rounded-full text-xs font-bold bg-[#191614] text-white">
                      {authorBooksList.length} tác phẩm
                    </span>
                  </div>
                  <p className="text-xs text-[#706B65] mt-1 max-w-lg line-clamp-2">
                    {selectedAuthorForBooks.nationality ? <span className="font-semibold text-[#423E3A]">Quốc tịch: {selectedAuthorForBooks.nationality} • </span> : null}
                    {selectedAuthorForBooks.biography || 'Tác giả đối tác uy tín tại Bookstore.'}
                  </p>
                </div>
              </div>
              <button 
                onClick={() => setIsAuthorBooksModalOpen(false)} 
                className="p-1.5 rounded-xl hover:bg-[#EBE7DC] text-[#8C857B] hover:text-[#191614] transition-colors"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            {/* Modal Body: Book Grid */}
            <div className="p-6 overflow-y-auto flex-1 space-y-4">
              {loadingAuthorBooks ? (
                <div className="py-16 text-center text-sm text-[#8C857B] flex flex-col items-center gap-3">
                  <div className="w-6 h-6 border-2 border-[#191614] border-t-transparent rounded-full animate-spin" />
                  <span>Đang tải danh sách tác phẩm của {selectedAuthorForBooks.name}...</span>
                </div>
              ) : authorBooksList.length === 0 ? (
                <div className="py-16 text-center text-[#8C857B]">
                  <BookOpen className="w-10 h-10 mx-auto mb-2 text-[#DDD6C4]" />
                  <p className="font-medium text-sm text-[#423E3A]">Chưa có tác phẩm nào của tác giả này trong kho</p>
                  <p className="text-xs mt-1">Bạn có thể thêm sách mới và gán tên tác giả này.</p>
                </div>
              ) : (
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
                  {authorBooksList.map((book) => (
                    <div 
                      key={book.id} 
                      className="flex gap-3.5 p-3 rounded-2xl border border-[#EBE7DC] bg-[#FDFCF9] hover:border-[#B84A39] hover:shadow-sm transition-all"
                    >
                      <img
                        src={book.coverImageUrl || 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg'}
                        alt={book.title}
                        referrerPolicy="no-referrer"
                        onError={(e) => {
                          (e.target as HTMLImageElement).src = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg'
                        }}
                        className="w-16 h-22 object-cover rounded-xl border border-[#DDD6C4] shrink-0 shadow-xs"
                      />
                      <div className="flex-1 flex flex-col justify-between min-w-0">
                        <div>
                          <span className="text-[10px] px-2 py-0.5 rounded-md bg-[#F5F3ED] text-[#706B65] font-semibold border border-[#DDD6C4] inline-block mb-1">
                            {book.categoryName}
                          </span>
                          <h4 className="font-serif font-bold text-sm text-[#191614] line-clamp-1 hover:text-[#B84A39] transition-colors">
                            {book.title}
                          </h4>
                          <span className="text-[11px] text-[#8C857B] font-mono block mt-0.5">
                            ISBN: {book.isbn}
                          </span>
                        </div>

                        <div className="flex items-center justify-between pt-2 border-t border-[#F5F3ED] mt-2">
                          <div>
                            <span className="font-sans font-bold tabular-nums text-sm text-[#B84A39]">
                              {(book.salePrice || book.originalPrice).toLocaleString('vi-VN')} đ
                            </span>
                            <span className="text-[10px] text-emerald-700 ml-2 font-semibold font-sans tabular-nums">
                              Kho: {book.stockQuantity}
                            </span>
                          </div>

                          <div className="flex items-center gap-1">
                            <button
                              onClick={() => {
                                setIsAuthorBooksModalOpen(false)
                                setEditingBook(book)
                                setNewAuthorName(selectedAuthorForBooks.name)
                                setIsModalOpen(true)
                              }}
                              className="p-1.5 rounded-lg hover:bg-[#F5F3ED] text-[#706B65] hover:text-[#191614] transition-colors"
                              title="Sửa sách"
                            >
                              <Edit3 className="w-3.5 h-3.5" />
                            </button>
                            <Link 
                              to={`/books/${book.id}`} 
                              target="_blank" 
                              className="p-1.5 rounded-lg hover:bg-[#F5F3ED] text-[#706B65] hover:text-[#191614] transition-colors" 
                              title="Xem trang sách trên web"
                            >
                              <Eye className="w-3.5 h-3.5" />
                            </Link>
                          </div>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </div>

            {/* Modal Footer */}
            <div className="px-6 py-4 border-t border-[#EBE7DC] bg-[#FAF9F5] flex items-center justify-between">
              <button
                onClick={() => {
                  const authorName = selectedAuthorForBooks.name
                  setIsAuthorBooksModalOpen(false)
                  setSearchQuery(authorName)
                  setActiveTab('books')
                }}
                className="text-xs font-bold text-[#B84A39] hover:underline flex items-center gap-1"
              >
                <span>Xem và lọc tất cả trong tab Kho Sách →</span>
              </button>
              <button 
                onClick={() => setIsAuthorBooksModalOpen(false)} 
                className="px-5 py-2 text-xs rounded-xl bg-[#191614] hover:bg-[#423E3A] text-white font-semibold transition-colors"
              >
                Đóng
              </button>
            </div>
          </div>
        </div>
      )}

      {/* ===================== INVOICE PRINT MODAL ===================== */}
      <InvoiceModal
        isOpen={isInvoiceOpen}
        onClose={() => setIsInvoiceOpen(false)}
        data={selectedInvoiceData}
      />

    </div>
  )
}
