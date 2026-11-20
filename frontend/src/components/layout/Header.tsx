import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { Search, ShoppingBag, User, Menu, X, BookOpen, ChevronDown, ShieldCheck } from 'lucide-react'
import { useCartStore } from '@/stores/cartStore'
import { useAuthStore } from '@/stores/authStore'
import { cn } from '@/lib/utils'

export default function Header() {
  const [mobileOpen, setMobileOpen] = useState(false)
  const [searchFocused, setSearchFocused] = useState(false)
  const [searchTerm, setSearchTerm] = useState('')
  const itemCount = useCartStore((s) => s.getItemCount())
  const { isAuthenticated, user, logout } = useAuthStore()
  const navigate = useNavigate()

  const navLinks = [
    { to: '/', label: 'Trang chủ' },
    { to: '/books', label: 'Tủ sách' },
    { to: '/books?category=1', label: 'Văn học' },
    { to: '/books?category=2', label: 'Kinh tế' },
    { to: '/books?category=3', label: 'Kỹ năng sống' },
    { to: '/books?category=4', label: 'Công nghệ' },
  ]

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault()
    if (searchTerm.trim()) {
      navigate(`/books?search=${encodeURIComponent(searchTerm.trim())}`)
    }
  }

  return (
    <header className="sticky top-0 z-50 border-b border-[#EBE7DC] bg-white/95 backdrop-blur-md shadow-xs">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="flex h-18 items-center justify-between gap-4">
          
          {/* Brand Logo */}
          <Link to="/" className="flex items-center gap-2.5 shrink-0 group">
            <div className="h-10 w-10 rounded-xl bg-[#191614] flex items-center justify-center text-white shadow-sm group-hover:bg-[#B84A39] transition-colors">
              <BookOpen className="h-5 w-5 text-[#F5F3ED]" strokeWidth={2} />
            </div>
            <div className="leading-tight">
              <span className="block font-serif text-2xl font-bold tracking-tight text-[#191614]">
                Bookstore
              </span>
              <span className="block text-[10px] uppercase tracking-[0.2em] font-semibold text-[#8C857B]">
                Tiệm Sách Tri Thức
              </span>
            </div>
          </Link>

          {/* Desktop Navigation */}
          <nav className="hidden lg:flex items-center gap-1">
            {navLinks.map((link) => (
              <Link
                key={link.to}
                to={link.to}
                className="px-3.5 py-2 text-sm font-semibold text-[#423E3A] hover:text-[#B84A39] transition-colors rounded-lg hover:bg-[#F5F3ED]"
              >
                {link.label}
              </Link>
            ))}
          </nav>

          {/* Search Bar + Actions */}
          <div className="flex items-center gap-3">
            {/* Search Input */}
            <form onSubmit={handleSearch} className="relative hidden md:block">
              <div className={cn(
                "flex items-center rounded-xl border px-3.5 py-2 transition-all duration-300",
                searchFocused 
                  ? "w-72 border-[#191614] bg-white shadow-sm ring-1 ring-[#191614]/10" 
                  : "w-56 border-[#DDD6C4] bg-[#F5F3ED]"
              )}>
                <Search className="h-4 w-4 text-[#8C857B] shrink-0" />
                <input
                  type="text"
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  placeholder="Tìm tác phẩm, tác giả..."
                  className="ml-2.5 w-full bg-transparent text-xs sm:text-sm text-[#191614] placeholder:text-[#8C857B] outline-none"
                  onFocus={() => setSearchFocused(true)}
                  onBlur={() => setSearchFocused(false)}
                />
              </div>
            </form>

            {/* Admin Badge Shortcut */}
            {isAuthenticated && user?.role === 'Admin' && (
              <Link
                to="/admin"
                className="hidden sm:flex items-center gap-1.5 rounded-xl bg-amber-50 border border-amber-300 px-3 py-2 text-xs font-bold text-amber-900 hover:bg-amber-100 transition-all shadow-xs"
                title="Bảng điều khiển Quản trị viên"
              >
                <ShieldCheck className="h-4 w-4 text-amber-700" />
                <span>Quản trị</span>
              </Link>
            )}

            {/* Shopping Cart Button */}
            <Link
              to="/cart"
              className="relative flex items-center justify-center h-10 w-10 rounded-xl border border-[#EBE7DC] bg-[#FAFAF7] hover:bg-[#F5F3ED] text-[#191614] hover:border-[#DDD6C4] transition-all"
              title="Xem giỏ hàng"
            >
              <ShoppingBag className="h-5 w-5" />
              {itemCount > 0 && (
                <span className="absolute -top-1.5 -right-1.5 flex h-5 w-5 items-center justify-center rounded-full bg-[#B84A39] text-[10px] font-bold text-white shadow-sm">
                  {itemCount}
                </span>
              )}
            </Link>

            {/* User Account / Auth */}
            {isAuthenticated ? (
              <div className="relative group">
                <button className="flex items-center gap-2 rounded-xl border border-[#DDD6C4] bg-[#F5F3ED] px-3.5 py-2 text-xs sm:text-sm font-semibold text-[#191614] hover:border-[#191614] transition-all">
                  <User className="h-4 w-4 text-[#B84A39]" />
                  <span className="max-w-[100px] truncate">{user?.fullName || 'Tài khoản'}</span>
                  <ChevronDown className="h-3 w-3 text-[#8C857B]" />
                </button>
                <div className="absolute right-0 top-full mt-2 w-48 rounded-xl border border-[#EBE7DC] bg-white p-1.5 shadow-xl opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all z-50">
                  <div className="px-3 py-2 text-xs text-[#8C857B] border-b border-[#F5F3ED]">
                    Xin chào, <strong className="text-[#191614]">{user?.fullName}</strong>
                  </div>
                  <Link to="/orders" className="block rounded-lg px-3 py-2 text-xs sm:text-sm text-[#191614] hover:bg-[#F5F3ED] transition-colors">Lịch sử đơn hàng</Link>
                  <Link to="/profile" className="block rounded-lg px-3 py-2 text-xs sm:text-sm text-[#191614] hover:bg-[#F5F3ED] transition-colors">Thông tin cá nhân</Link>
                  {user?.role === 'Admin' && (
                    <Link to="/admin" className="block rounded-lg px-3 py-2 text-xs sm:text-sm text-[#B84A39] font-semibold hover:bg-[#F5F3ED] transition-colors">Bảng điều khiển Admin</Link>
                  )}
                  <hr className="my-1 border-[#F5F3ED]" />
                  <button onClick={logout} className="block w-full rounded-lg px-3 py-2 text-left text-xs sm:text-sm text-red-600 hover:bg-red-50 transition-colors font-medium">Đăng xuất</button>
                </div>
              </div>
            ) : (
              <Link
                to="/login"
                className="rounded-xl bg-[#191614] px-4 py-2.5 text-xs sm:text-sm font-semibold text-white hover:bg-[#B84A39] shadow-sm transition-all"
              >
                Đăng nhập
              </Link>
            )}

            {/* Mobile Hamburger */}
            <button
              className="p-2 lg:hidden text-[#191614] rounded-lg hover:bg-[#F5F3ED]"
              onClick={() => setMobileOpen(!mobileOpen)}
            >
              {mobileOpen ? <X className="h-6 w-6" /> : <Menu className="h-6 w-6" />}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile Drawer */}
      {mobileOpen && (
        <div className="lg:hidden border-t border-[#EBE7DC] bg-white px-4 py-4 space-y-2 shadow-lg">
          {navLinks.map((link) => (
            <Link
              key={link.to}
              to={link.to}
              className="block rounded-xl px-4 py-2.5 text-sm font-semibold text-[#191614] hover:bg-[#F5F3ED]"
              onClick={() => setMobileOpen(false)}
            >
              {link.label}
            </Link>
          ))}
        </div>
      )}
    </header>
  )
}
