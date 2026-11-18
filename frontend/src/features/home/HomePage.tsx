import { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { 
  BookOpen, 
  ArrowRight, 
  Sparkles, 
  TrendingUp, 
  Award, 
  Truck, 
  ShieldCheck, 
  RotateCcw, 
  Gift, 
  ChevronRight, 
  Star,
  Flame,
  Feather
} from 'lucide-react'
import BookCard from '@/features/books/BookCard'
import apiClient from '@/api/client'
import type { Book } from '@/types'

// Curated high quality mock books with real cover photography
const defaultBooks: Book[] = [
  {
    id: 1,
    isbn: "978-604-1-16503-4",
    title: "Nhà Giả Kim (The Alchemist)",
    originalPrice: 89000,
    salePrice: 69000,
    stockQuantity: 120,
    pageCount: 228,
    publishYear: 2020,
    language: "vi",
    coverImageUrl: "https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg",
    isAvailable: true,
    category: { id: 1, name: "Văn học", slug: "van-hoc", bookCount: 245 },
    authors: [{ id: 1, name: "Paulo Coelho" }],
    averageRating: 4.9,
    reviews: [{}, {}, {}, {}] as any
  },
  {
    id: 2,
    isbn: "978-604-58-9442-5",
    title: "Đắc Nhân Tâm",
    originalPrice: 96000,
    salePrice: 75000,
    stockQuantity: 200,
    pageCount: 320,
    publishYear: 2021,
    language: "vi",
    coverImageUrl: "https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg",
    isAvailable: true,
    category: { id: 3, name: "Tâm lý & Kỹ năng", slug: "tam-ly-ky-nang", bookCount: 156 },
    authors: [{ id: 2, name: "Dale Carnegie" }],
    averageRating: 4.8,
    reviews: [{}, {}, {}] as any
  },
  {
    id: 3,
    isbn: "978-604-1-17855-3",
    title: "Sapiens: Lược Sử Loài Người",
    originalPrice: 219000,
    salePrice: 175000,
    stockQuantity: 85,
    pageCount: 560,
    publishYear: 2021,
    language: "vi",
    coverImageUrl: "https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg",
    isAvailable: true,
    category: { id: 4, name: "Lịch sử & Triết học", slug: "lich-su-triet-hoc", bookCount: 98 },
    authors: [{ id: 3, name: "Yuval Noah Harari" }],
    averageRating: 4.9,
    reviews: [{}, {}, {}, {}, {}] as any
  },
  {
    id: 4,
    isbn: "978-604-56-8219-0",
    title: "Atomic Habits: Thay Đổi Tí Hon",
    originalPrice: 169000,
    salePrice: 135000,
    stockQuantity: 150,
    pageCount: 388,
    publishYear: 2022,
    language: "vi",
    coverImageUrl: "https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg",
    isAvailable: true,
    category: { id: 3, name: "Tâm lý & Kỹ năng", slug: "tam-ly-ky-nang", bookCount: 156 },
    authors: [{ id: 4, name: "James Clear" }],
    averageRating: 4.9,
    reviews: [{}, {}, {}, {}] as any
  },
  {
    id: 5,
    isbn: "978-604-1-19223-8",
    title: "Mắt Biếc",
    originalPrice: 110000,
    salePrice: 88000,
    stockQuantity: 140,
    pageCount: 296,
    publishYear: 2021,
    language: "vi",
    coverImageUrl: "https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/df/fe/df/08a4a624353b4289b877cf3bced910e4.jpg",
    isAvailable: true,
    category: { id: 1, name: "Văn học", slug: "van-hoc", bookCount: 245 },
    authors: [{ id: 5, name: "Nguyễn Nhật Ánh" }],
    averageRating: 4.7,
    reviews: [{}, {}, {}] as any
  },
  {
    id: 6,
    isbn: "978-604-58-8821-9",
    title: "Muôn Kiếp Nhân Sinh",
    originalPrice: 168000,
    salePrice: 138000,
    stockQuantity: 95,
    pageCount: 420,
    publishYear: 2020,
    language: "vi",
    coverImageUrl: "https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg",
    isAvailable: true,
    category: { id: 4, name: "Lịch sử & Triết học", slug: "lich-su-triet-hoc", bookCount: 98 },
    authors: [{ id: 6, name: "Nguyên Phong" }],
    averageRating: 4.8,
    reviews: [{}, {}, {}, {}] as any
  },
  {
    id: 7,
    isbn: "978-604-1-18012-9",
    title: "Cho Tôi Xin Một Vé Đi Tuổi Thơ",
    originalPrice: 90000,
    salePrice: 72000,
    stockQuantity: 110,
    pageCount: 212,
    publishYear: 2021,
    language: "vi",
    coverImageUrl: "https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/a0/a3/2b/006dac88a54de6057ebc9e922069d2bd.jpg",
    isAvailable: true,
    category: { id: 1, name: "Văn học", slug: "van-hoc", bookCount: 245 },
    authors: [{ id: 5, name: "Nguyễn Nhật Ánh" }],
    averageRating: 4.6,
    reviews: [{}, {}] as any
  },
  {
    id: 8,
    isbn: "978-604-2-19822-7",
    title: "Dế Mèn Phiêu Lưu Ký",
    originalPrice: 55000,
    salePrice: 45000,
    stockQuantity: 100,
    pageCount: 184,
    publishYear: 2022,
    language: "vi",
    coverImageUrl: "https://salt.tikicdn.com/cache/750x750/ts/product/a5/65/4c/2da4aa944b6f280afbd694ac1a129682.jpeg",
    isAvailable: true,
    category: { id: 5, name: "Thiếu nhi", slug: "thieu-nhi", bookCount: 132 },
    authors: [{ id: 7, name: "Tô Hoài" }],
    averageRating: 4.8,
    reviews: [{}, {}, {}] as any
  }
]

const categoriesData = [
  { id: 1, name: 'Văn học Cổ điển & Đương đại', slug: 'van-hoc', bookCount: '45+ tác phẩm', tag: 'Tiểu thuyết, Thơ ca', color: 'bg-[#F2ECE1] text-[#9E3A2B] border-[#DDD6C4]' },
  { id: 2, name: 'Kinh tế & Tư duy Khởi nghiệp', slug: 'kinh-te', bookCount: '40+ tác phẩm', tag: 'Đầu tư, Quản trị', color: 'bg-[#F5F3ED] text-[#B86B35] border-[#EBE7DC]' },
  { id: 3, name: 'Tâm lý & Nghệ thuật Sống', slug: 'tam-ly-ky-nang', bookCount: '40+ tác phẩm', tag: 'Chữa lành, Thấu hiểu', color: 'bg-[#EBF2EB] text-[#2D5A43] border-[#D3E2D3]' },
  { id: 4, name: 'Công nghệ & Lập trình', slug: 'cong-nghe-lap-trinh', bookCount: '35+ tác phẩm', tag: 'AI, DevOps, Coding', color: 'bg-[#EAF2F8] text-[#2471A3] border-[#D4E6F1]' },
  { id: 5, name: 'Lịch sử & Triết học Thế giới', slug: 'lich-su-triet-hoc', bookCount: '25+ tác phẩm', tag: 'Văn minh, Tư tưởng', color: 'bg-[#F4EFEA] text-[#7A4B3A] border-[#E5DACF]' },
]

export default function HomePage() {
  const [books, setBooks] = useState<Book[]>(defaultBooks)
  const [activeTab, setActiveTab] = useState<'all' | 'vanhoc' | 'kinhte' | 'tamly'>('all')
  const [authors, setAuthors] = useState<Array<{ id: number; name: string; nationality?: string; biography?: string; avatarUrl?: string; bookCount: number }>>([
    { id: 2, name: 'Dale Carnegie', nationality: 'Mỹ', biography: 'Bậc thầy nghệ thuật giao tiếp và thuyết phục nhân tâm.', avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=80', bookCount: 7 },
    { id: 5, name: 'Nguyễn Nhật Ánh', nationality: 'Việt Nam', biography: 'Nhà văn của tuổi thơ với những tác phẩm trong trẻo đầy hoài niệm.', avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=400&q=80', bookCount: 8 },
    { id: 3, name: 'Yuval Noah Harari', nationality: 'Israel', biography: 'Sử gia lỗi lạc, tác giả bộ ba Sapiens và Homo Deus.', avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=400&q=80', bookCount: 3 },
    { id: 1, name: 'Paulo Coelho', nationality: 'Brazil', biography: 'Tác giả kiệt tác Nhà Giả Kim bán chạy toàn cầu.', avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80', bookCount: 1 },
    { id: 4, name: 'James Clear', nationality: 'Mỹ', biography: 'Chuyên gia thế giới về thói quen nguyên tử Atomic Habits.', avatarUrl: 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=400&q=80', bookCount: 1 },
    { id: 6, name: 'Tô Hoài', nationality: 'Việt Nam', biography: 'Cây đại thụ văn học thiếu nhi với Dế Mèn Phiêu Lưu Ký.', avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80', bookCount: 3 },
  ])

  useEffect(() => {
    apiClient.get('/books', { params: { pageSize: 32 } })
      .then(res => {
        if (res.data && res.data.items && res.data.items.length > 0) {
          // Merge API data with rich cover images if missing
          const apiBooks = res.data.items.map((b: any, idx: number) => ({
            ...b,
            coverImageUrl: b.coverImageUrl || defaultBooks[idx % defaultBooks.length].coverImageUrl
          }))
          setBooks(apiBooks)
        }
      })
      .catch(() => {
        // Fallback already in place
      })

    apiClient.get('/authors')
      .then(res => {
        if (Array.isArray(res.data) && res.data.length > 0) {
          setAuthors(res.data.slice(0, 6))
        }
      })
      .catch(() => {})
  }, [])

  const filteredBooks = books.filter(b => {
    if (activeTab === 'all') return true
    if (activeTab === 'vanhoc') return b.category?.slug === 'van-hoc' || b.category?.id === 1
    if (activeTab === 'kinhte') return b.category?.slug === 'kinh-te' || b.category?.id === 2
    if (activeTab === 'tamly') return b.category?.slug === 'tam-ly-ky-nang' || b.category?.id === 3
    return true
  })

  return (
    <div className="space-y-16 pb-20">
      
      {/* ================= 1. ARTISAN EDITORIAL HERO ================= */}
      <section className="relative overflow-hidden bg-gradient-to-b from-[#F5F3ED] via-[#FAFAF7] to-[#FAFAF7] pt-10 pb-16 border-b border-[#EBE7DC]">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">
            
            {/* Left Content */}
            <div className="lg:col-span-7 space-y-6">
              <div className="inline-flex items-center gap-2 rounded-full bg-[#EBE7DC] px-3.5 py-1 text-xs font-semibold text-[#615C56]">
                <Sparkles className="h-3.5 w-3.5 text-[#B84A39]" />
                <span>TUYỂN TẬP ĐẶC BIỆT MÙA ĐỌC SÁCH 2026</span>
              </div>

              <h1 className="font-serif text-4xl sm:text-5xl lg:text-6xl font-bold text-[#191614] leading-[1.15] tracking-tight">
                Nuôi dưỡng tâm hồn <br />
                <span className="italic font-normal text-[#B84A39]">qua từng trang viết.</span>
              </h1>

              <p className="text-base sm:text-lg text-[#615C56] max-w-xl leading-relaxed">
                Nơi hội tụ những kiệt tác văn học trường tồn, những cuốn sách khai mở tư duy và ấn phẩm bìa cứng độc bản dành riêng cho độc giả yêu sách.
              </p>

              {/* Action Buttons */}
              <div className="flex flex-wrap items-center gap-4 pt-2">
                <Link
                  to="/books"
                  className="inline-flex items-center gap-2 rounded-xl bg-[#191614] px-7 py-4 text-sm font-semibold text-[#FAFAF7] shadow-lg hover:bg-[#B84A39] transition-all duration-300 hover:shadow-xl hover:-translate-y-0.5"
                >
                  <BookOpen className="h-4 w-4 text-[#D97706]" />
                  <span>Khám phá tủ sách</span>
                  <ArrowRight className="h-4 w-4" />
                </Link>

                <Link
                  to="/books"
                  className="inline-flex items-center gap-2 rounded-xl border border-[#DDD6C4] bg-white px-6 py-4 text-sm font-semibold text-[#191614] hover:bg-[#F5F3ED] hover:border-[#8C857B] transition-all"
                >
                  <Flame className="h-4 w-4 text-[#B84A39]" />
                  <span>Sách bán chạy</span>
                </Link>
              </div>

              {/* Social Proof */}
              <div className="pt-6 flex items-center gap-4 border-t border-[#EBE7DC]">
                <div className="flex -space-x-2">
                  {['https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=100&q=80',
                    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=100&q=80',
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=100&q=80'
                  ].map((src, i) => (
                    <img key={i} src={src} alt="Reader" className="h-8 w-8 rounded-full border-2 border-white object-cover shadow-sm" />
                  ))}
                </div>
                <div className="text-xs text-[#615C56]">
                  <strong className="text-[#191614] font-bold">25.000+ độc giả</strong> trên toàn quốc đã chọn Bookstore
                </div>
              </div>
            </div>

            {/* Right 3D Visual Book Showcase */}
            <div className="lg:col-span-5 relative flex justify-center items-center">
              <div className="relative w-full max-w-md aspect-[4/5] flex items-center justify-center">
                
                {/* Decorative background glow */}
                <div className="absolute inset-0 bg-gradient-to-tr from-[#DDD6C4]/40 to-transparent rounded-full filter blur-3xl -z-10" />

                {/* Back Book (Slanted left) */}
                <div className="absolute left-4 top-8 w-44 aspect-[3/4.2] rounded-xl overflow-hidden shadow-2xl -rotate-6 transform transition-transform hover:-rotate-3 duration-300 border border-[#DDD6C4]">
                  <img
                    src="https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg"
                    alt="Sapiens: Lược Sử Loài Người"
                    className="h-full w-full object-cover"
                  />
                </div>

                {/* Front Main Book (Center) */}
                <div className="relative z-10 w-56 aspect-[3/4.2] rounded-xl overflow-hidden shadow-[0_20px_40px_rgba(0,0,0,0.25)] border-2 border-white/60 transform rotate-3 hover:rotate-0 transition-transform duration-300">
                  <img
                    src="https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg"
                    alt="Nhà Giả Kim"
                    className="h-full w-full object-cover"
                  />
                  <div className="absolute top-3 right-3 bg-[#B84A39] text-white text-[10px] font-bold px-2 py-0.5 rounded shadow">
                    BÁN CHẠY #1
                  </div>
                </div>

                {/* Floating "Book of the Month" pill badge */}
                <div className="absolute -bottom-2 -left-2 z-20 bg-white/95 backdrop-blur-md rounded-2xl p-4 shadow-xl border border-[#EBE7DC] flex items-center gap-3">
                  <div className="h-10 w-10 rounded-xl bg-[#F5F3ED] flex items-center justify-center text-[#B84A39]">
                    <Award className="h-5 w-5" />
                  </div>
                  <div>
                    <span className="block text-[11px] font-bold uppercase tracking-wider text-[#B84A39]">Sách Của Tháng</span>
                    <strong className="text-xs font-serif text-[#191614]">Nhà Giả Kim — Paulo Coelho</strong>
                    <div className="flex items-center gap-1 text-[11px] text-[#F59E0B] mt-0.5">
                      <Star className="h-3 w-3 fill-[#F59E0B]" />
                      <span className="font-semibold text-[#191614]">4.9</span>
                      <span className="text-[#8C857B]">(1.4k đánh giá)</span>
                    </div>
                  </div>
                </div>

              </div>
            </div>

          </div>
        </div>
      </section>

      {/* ================= 2. TRUST COMMITMENTS BAR ================= */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 bg-white rounded-2xl p-6 border border-[#EBE7DC] shadow-sm">
          <div className="flex items-center gap-3.5 p-2">
            <div className="h-11 w-11 shrink-0 rounded-xl bg-[#F5F3ED] flex items-center justify-center text-[#B84A39]">
              <Truck className="h-5 w-5" />
            </div>
            <div>
              <h4 className="text-xs font-bold text-[#191614]">Miễn phí vận chuyển</h4>
              <p className="text-[11px] text-[#615C56]">Đơn hàng từ 250.000đ</p>
            </div>
          </div>

          <div className="flex items-center gap-3.5 p-2">
            <div className="h-11 w-11 shrink-0 rounded-xl bg-[#EBF2EB] flex items-center justify-center text-[#2D5A43]">
              <ShieldCheck className="h-5 w-5" />
            </div>
            <div>
              <h4 className="text-xs font-bold text-[#191614]">100% Sách Thật</h4>
              <p className="text-[11px] text-[#615C56]">Bản quyền từ NXB uy tín</p>
            </div>
          </div>

          <div className="flex items-center gap-3.5 p-2">
            <div className="h-11 w-11 shrink-0 rounded-xl bg-[#F5F3ED] flex items-center justify-center text-[#B84A39]">
              <RotateCcw className="h-5 w-5" />
            </div>
            <div>
              <h4 className="text-xs font-bold text-[#191614]">Đổi trả trong 7 ngày</h4>
              <p className="text-[11px] text-[#615C56]">Nếu có lỗi in ấn, rách bìa</p>
            </div>
          </div>

          <div className="flex items-center gap-3.5 p-2">
            <div className="h-11 w-11 shrink-0 rounded-xl bg-[#FFF8E7] flex items-center justify-center text-[#B45309]">
              <Gift className="h-5 w-5" />
            </div>
            <div>
              <h4 className="text-xs font-bold text-[#191614]">Đóng gói mỹ thuật</h4>
              <p className="text-[11px] text-[#615C56]">Tặng kèm bookmark độc bản</p>
            </div>
          </div>
        </div>
      </section>

      {/* ================= 3. BEAUTIFULLY REDESIGNED CATEGORIES ================= */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="flex items-end justify-between mb-8">
          <div>
            <div className="text-xs font-bold uppercase tracking-wider text-[#B84A39] mb-1">
              Danh Mục Chọn Lọc
            </div>
            <h2 className="font-serif text-2xl sm:text-3xl font-bold text-[#191614]">
              Khám phá theo thể loại
            </h2>
          </div>
          <Link 
            to="/books" 
            className="inline-flex items-center gap-1 text-xs sm:text-sm font-semibold text-[#B84A39] hover:underline"
          >
            Xem tất cả thể loại <ChevronRight className="h-4 w-4" />
          </Link>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-4">
          {categoriesData.map((cat) => (
            <Link
              key={cat.id}
              to={`/books?category=${cat.id}`}
              className={`group flex flex-col justify-between p-5 rounded-2xl border ${cat.color} hover:shadow-md hover:-translate-y-1 transition-all duration-300`}
            >
              <div>
                <span className="text-[11px] font-semibold text-[#615C56] opacity-75 block mb-1">
                  {cat.tag}
                </span>
                <h3 className="font-serif text-base font-bold text-[#191614] leading-snug group-hover:text-[#B84A39] transition-colors">
                  {cat.name}
                </h3>
              </div>
              
              <div className="mt-6 flex items-center justify-between pt-3 border-t border-black/5">
                <span className="text-xs font-medium text-[#615C56]">
                  {cat.bookCount}
                </span>
                <div className="h-6 w-6 rounded-full bg-white/80 flex items-center justify-center text-[#191614] shadow-sm group-hover:bg-[#191614] group-hover:text-white transition-colors">
                  <ArrowRight className="h-3 w-3" />
                </div>
              </div>
            </Link>
          ))}
        </div>
      </section>

      {/* ================= 4. NEW ARRIVALS & FILTER TABS ================= */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="flex flex-col md:flex-row md:items-end justify-between gap-4 mb-8">
          <div>
            <div className="inline-flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-[#2D5A43] mb-1">
              <Sparkles className="h-3.5 w-3.5" />
              <span>Vừa Cập Bến Kệ Sách</span>
            </div>
            <h2 className="font-serif text-2xl sm:text-3xl font-bold text-[#191614]">
              Tác phẩm mới &amp; Chọn lọc
            </h2>
          </div>

          {/* Filter Pills */}
          <div className="flex items-center gap-1.5 overflow-x-auto pb-2 scrollbar-none">
            {[
              { id: 'all', label: 'Tất cả sách' },
              { id: 'vanhoc', label: 'Văn học' },
              { id: 'kinhte', label: 'Kinh tế' },
              { id: 'tamly', label: 'Tâm lý & Kỹ năng' },
            ].map(tab => (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id as any)}
                className={`rounded-full px-4 py-2 text-xs font-semibold whitespace-nowrap transition-all ${
                  activeTab === tab.id
                    ? 'bg-[#191614] text-white shadow-sm'
                    : 'bg-white text-[#615C56] border border-[#EBE7DC] hover:bg-[#F5F3ED]'
                }`}
              >
                {tab.label}
              </button>
            ))}
          </div>
        </div>

        {/* Books Grid */}
        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-4 gap-5">
          {filteredBooks.slice(0, 8).map((book) => (
            <BookCard key={book.id} book={book} />
          ))}
        </div>
      </section>

      {/* ================= 5. CURATOR SPOTLIGHT BANNER ================= */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="relative overflow-hidden rounded-3xl bg-[#191614] text-white p-8 sm:p-12 lg:p-16 border border-[#2C2825] shadow-2xl">
          <div className="relative z-10 grid grid-cols-1 lg:grid-cols-12 gap-8 items-center">
            
            <div className="lg:col-span-8 space-y-4">
              <span className="inline-block bg-[#B84A39] text-white text-xs font-bold uppercase tracking-wider px-3 py-1 rounded-full">
                TÁC PHẨM CỦA THẾ KỶ
              </span>
              <h3 className="font-serif text-3xl sm:text-4xl font-bold leading-tight">
                Sapiens: Lược Sử Loài Người — Yuval Noah Harari
              </h3>
              <p className="text-sm sm:text-base text-[#DDD6C4] leading-relaxed max-w-2xl">
                "100.000 năm trước, có ít nhất sáu loài người cùng sinh sống trên Trái đất. Hôm nay chỉ còn lại một: Homo sapiens. Chuyện gì đã xảy ra với những loài còn lại? Và điều gì sẽ xảy ra với chúng ta?"
              </p>
              <div className="pt-2 flex flex-wrap gap-4 items-center">
                <Link
                  to="/books/3"
                  className="rounded-xl bg-[#B84A39] hover:bg-[#9E3A2B] px-6 py-3 text-sm font-semibold text-white shadow-lg transition-all"
                >
                  Mua ngay — 175.000đ (Tiết kiệm 20%)
                </Link>
                <Link
                  to="/books/3"
                  className="rounded-xl border border-white/20 hover:bg-white/10 px-6 py-3 text-sm font-semibold text-white transition-all"
                >
                  Đọc thử trích đoạn
                </Link>
              </div>
            </div>

            <div className="lg:col-span-4 flex justify-center">
              <div className="w-48 aspect-[3/4.2] rounded-xl overflow-hidden shadow-2xl border-2 border-white/20 transform rotate-3">
                <img
                  src="https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg"
                  alt="Sapiens: Lược Sử Loài Người"
                  className="h-full w-full object-cover"
                />
              </div>
            </div>

          </div>
        </div>
      </section>

      {/* ================= 6. BESTSELLERS RANKING ================= */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="flex items-end justify-between mb-8">
          <div>
            <div className="inline-flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-[#B84A39] mb-1">
              <TrendingUp className="h-3.5 w-3.5" />
              <span>Bảng Xếp Hạng Độc Giả</span>
            </div>
            <h2 className="font-serif text-2xl sm:text-3xl font-bold text-[#191614]">
              Top 4 Sách Bán Chạy Nhất
            </h2>
          </div>
          <Link to="/books" className="text-xs sm:text-sm font-semibold text-[#B84A39] hover:underline">
            Xem toàn bộ bảng xếp hạng &gt;
          </Link>
        </div>

        <div className="grid grid-cols-2 sm:grid-cols-2 md:grid-cols-4 gap-5">
          {books.slice(0, 4).map((book, index) => (
            <BookCard key={book.id} book={book} rank={index + 1} />
          ))}
        </div>
      </section>

      {/* ================= 6.5. FEATURED AUTHORS ================= */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="flex items-end justify-between mb-8">
          <div>
            <div className="inline-flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-[#B84A39] mb-1">
              <Feather className="h-3.5 w-3.5" />
              <span>Cây Bút Tuyển Chọn</span>
            </div>
            <h2 className="font-serif text-2xl sm:text-3xl font-bold text-[#191614]">
              Gương Mặt Tác Giả Tiêu Biểu
            </h2>
          </div>
          <Link to="/books" className="text-xs sm:text-sm font-semibold text-[#B84A39] hover:underline">
            Khám phá trọn bộ tác phẩm &gt;
          </Link>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
          {authors.map((author) => (
            <Link
              key={author.id}
              to={`/books?authorId=${author.id}&author=${encodeURIComponent(author.name)}`}
              className="group bg-white rounded-2xl border border-[#EBE7DC] p-5 shadow-xs hover:border-[#B84A39] hover:shadow-md transition-all flex flex-col justify-between"
            >
              <div>
                <div className="flex items-start justify-between gap-3 mb-3">
                  <div className="flex items-center gap-3">
                    {author.avatarUrl ? (
                      <img
                        src={author.avatarUrl}
                        alt={author.name}
                        referrerPolicy="no-referrer"
                        onError={(e) => {
                          (e.target as HTMLImageElement).style.display = 'none';
                        }}
                        className="w-12 h-12 rounded-xl object-cover shadow-xs border border-[#DDD6C4] shrink-0 group-hover:scale-105 transition-transform"
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
                          Quốc tịch: {author.nationality}
                        </span>
                      )}
                    </div>
                  </div>

                  <span className="px-2.5 py-1 rounded-full text-xs font-bold bg-[#F5F3ED] text-[#191614] border border-[#DDD6C4] shrink-0 group-hover:bg-[#191614] group-hover:text-white transition-colors">
                    {author.bookCount} tác phẩm
                  </span>
                </div>

                <p className="text-xs text-[#615C56] line-clamp-2 leading-relaxed mt-2">
                  {author.biography || 'Tác giả tuyển chọn tại Bookstore.'}
                </p>
              </div>

              <div className="mt-4 pt-3 border-t border-[#F5F3ED] flex items-center justify-between text-xs font-bold text-[#B84A39]">
                <span>Xem các tác phẩm của {author.name}</span>
                <ArrowRight className="w-4 h-4 transform group-hover:translate-x-1 transition-transform" />
              </div>
            </Link>
          ))}
        </div>
      </section>

      {/* ================= 7. NEWSLETTER CLUB ================= */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="rounded-3xl bg-[#F5F3ED] border border-[#EBE7DC] p-8 sm:p-12 text-center max-w-3xl mx-auto space-y-4">
          <span className="text-xs font-bold uppercase tracking-wider text-[#B84A39]">
            CÂU LẠC BỘ BẠN ĐỌC BOOKSTORE
          </span>
          <h3 className="font-serif text-2xl sm:text-3xl font-bold text-[#191614]">
            Nhận gợi ý sách hay mỗi thứ Sáu hàng tuần
          </h3>
          <p className="text-sm text-[#615C56] max-w-lg mx-auto">
            Không thư rác. Chỉ gửi bài điểm sách cô đọng, trích đoạn tinh hoa và mã giảm giá 15% cho thành viên mới.
          </p>
          <div className="flex max-w-md mx-auto gap-2 pt-2">
            <input
              type="email"
              placeholder="Nhập địa chỉ email của bạn..."
              className="flex-1 text-xs sm:text-sm rounded-xl border border-[#DDD6C4] bg-white px-4 py-3 outline-none focus:border-[#191614]"
            />
            <button
              onClick={() => alert('Cảm ơn bạn đã tham gia câu lạc bộ đọc sách!')}
              className="rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white px-5 py-3 text-xs sm:text-sm font-semibold transition-colors"
            >
              Đăng ký
            </button>
          </div>
        </div>
      </section>

    </div>
  )
}
