import { useState, useEffect, useMemo, useRef } from 'react'
import { useSearchParams } from 'react-router-dom'
import { 
  Search, 
  SlidersHorizontal, 
  X, 
  BookOpen, 
  RotateCcw, 
  ArrowUpDown, 
  ChevronLeft, 
  ChevronRight,
  Filter
} from 'lucide-react'
import BookCard from './BookCard'
import type { Book } from '@/types'
import { cn, removeVietnameseTones } from '@/lib/utils'
import apiClient from '@/api/client'

interface CategoryItem {
  id: number
  name: string
  slug?: string
  bookCount?: number
}

const defaultCategories: CategoryItem[] = [
  { id: 0, name: 'Tất cả thể loại', bookCount: 1000 },
  { id: 1, name: 'Văn học', slug: 'van-hoc', bookCount: 225 },
  { id: 2, name: 'Kinh tế & Kinh doanh', slug: 'kinh-te', bookCount: 200 },
  { id: 3, name: 'Tâm lý & Kỹ năng sống', slug: 'tam-ly-ky-nang', bookCount: 190 },
  { id: 4, name: 'Công nghệ & Lập trình', slug: 'cong-nghe-lap-trinh', bookCount: 155 },
  { id: 5, name: 'Lịch sử & Triết học', slug: 'lich-su-triet-hoc', bookCount: 115 },
  { id: 6, name: 'Văn học Thiếu nhi', slug: 'thieu-nhi', bookCount: 65 },
  { id: 7, name: 'Khoa học & Vũ trụ', slug: 'khoa-hoc', bookCount: 50 },
]

const priceRanges = [
  { label: 'Tất cả mức giá', min: 0, max: Infinity },
  { label: 'Dưới 100.000đ', min: 0, max: 100000 },
  { label: '100.000đ – 150.000đ', min: 100000, max: 150000 },
  { label: 'Trên 150.000đ', min: 150000, max: Infinity },
]

const sortOptions = [
  { value: 'newest', label: 'Mới nhất' },
  { value: 'price_asc', label: 'Giá: Thấp đến Cao' },
  { value: 'price_desc', label: 'Giá: Cao đến Thấp' },
  { value: 'name_asc', label: 'Tên sách: A - Z' },
]

const fallbackBooks: Book[] = [
  {
    id: 1,
    isbn: "978-604-1-16503-4",
    title: "Nhà Giả Kim (The Alchemist)",
    originalPrice: 89000,
    salePrice: 69000,
    stockQuantity: 120,
    language: "vi",
    isAvailable: true,
    coverImageUrl: "https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg",
    authors: [{ id: 1, name: "Paulo Coelho" }],
    category: { id: 1, name: "Văn học", slug: "van-hoc", bookCount: 45 },
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
    language: "vi",
    isAvailable: true,
    coverImageUrl: "https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg",
    authors: [{ id: 2, name: "Dale Carnegie" }],
    category: { id: 3, name: "Tâm lý & Kỹ năng sống", slug: "tam-ly-ky-nang", bookCount: 40 },
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
    language: "vi",
    isAvailable: true,
    coverImageUrl: "https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg",
    authors: [{ id: 3, name: "Yuval Noah Harari" }],
    category: { id: 5, name: "Lịch sử & Triết học", slug: "lich-su-triet-hoc", bookCount: 25 },
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
    language: "vi",
    isAvailable: true,
    coverImageUrl: "https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg",
    authors: [{ id: 4, name: "James Clear" }],
    category: { id: 3, name: "Tâm lý & Kỹ năng sống", slug: "tam-ly-ky-nang", bookCount: 40 },
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
    language: "vi",
    isAvailable: true,
    coverImageUrl: "https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/df/fe/df/08a4a624353b4289b877cf3bced910e4.jpg",
    authors: [{ id: 5, name: "Nguyễn Nhật Ánh" }],
    category: { id: 1, name: "Văn học", slug: "van-hoc", bookCount: 45 },
    averageRating: 4.7,
    reviews: [{}, {}, {}] as any
  },
  {
    id: 6,
    isbn: "978-604-58-8821-9",
    title: "Muôn Kiếp Nhân Sinh - Tập 1",
    originalPrice: 168000,
    salePrice: 138000,
    stockQuantity: 95,
    language: "vi",
    isAvailable: true,
    coverImageUrl: "https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg",
    authors: [{ id: 6, name: "Nguyên Phong" }],
    category: { id: 5, name: "Lịch sử & Triết học", slug: "lich-su-triet-hoc", bookCount: 25 },
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
    language: "vi",
    isAvailable: true,
    coverImageUrl: "https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/a0/a3/2b/006dac88a54de6057ebc9e922069d2bd.jpg",
    authors: [{ id: 5, name: "Nguyễn Nhật Ánh" }],
    category: { id: 1, name: "Văn học", slug: "van-hoc", bookCount: 45 },
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
    language: "vi",
    isAvailable: true,
    coverImageUrl: "https://salt.tikicdn.com/cache/750x750/ts/product/a5/65/4c/2da4aa944b6f280afbd694ac1a129682.jpeg",
    authors: [{ id: 7, name: "Tô Hoài" }],
    category: { id: 6, name: "Văn học Thiếu nhi", slug: "thieu-nhi", bookCount: 15 },
    averageRating: 4.8,
    reviews: [{}, {}, {}] as any
  }
]

export default function BooksPage() {
  const [searchParams, setSearchParams] = useSearchParams()

  // Parse URL search parameters (Single source of truth)
  const categoryId = Number(searchParams.get('category')) || 0
  const searchQuery = searchParams.get('search') || ''
  const authorId = Number(searchParams.get('authorId')) || 0
  const authorQuery = searchParams.get('author') || ''
  const priceIndex = Number(searchParams.get('price')) || 0
  const sortBy = searchParams.get('sort') || 'newest'
  const currentPage = Number(searchParams.get('page')) || 1

  // Local state
  const [categories, setCategories] = useState<CategoryItem[]>(defaultCategories)
  const [searchInput, setSearchInput] = useState(searchQuery)
  const [booksList, setBooksList] = useState<Book[]>([])
  const [totalCount, setTotalCount] = useState<number>(0)
  const [totalPages, setTotalPages] = useState<number>(1)
  const [loading, setLoading] = useState<boolean>(true)
  const [showFilters, setShowFilters] = useState<boolean>(false)

  const booksGridRef = useRef<HTMLDivElement>(null)

  // 1. Fetch Categories dynamically from API
  useEffect(() => {
    apiClient.get('/categories')
      .then(res => {
        if (Array.isArray(res.data) && res.data.length > 0) {
          const totalAll = res.data.reduce((sum: number, c: any) => sum + (c.bookCount || 0), 0)
          setCategories([
            { id: 0, name: 'Tất cả thể loại', bookCount: totalAll },
            ...res.data
          ])
        }
      })
      .catch(() => {
        // Keep default categories if offline
      })
  }, [])

  // 2. Synchronize search input when URL param changes externally (e.g. Header search or category navigation)
  useEffect(() => {
    setSearchInput(searchQuery)
  }, [searchQuery])

  // 3. Debounce typing in search input to update URL query param
  useEffect(() => {
    const handler = setTimeout(() => {
      const currentParam = searchParams.get('search') || ''
      if (searchInput.trim() !== currentParam) {
        const next = new URLSearchParams(searchParams)
        if (searchInput.trim()) {
          next.set('search', searchInput.trim())
        } else {
          next.delete('search')
        }
        next.delete('page') // Reset to page 1 on new search
        setSearchParams(next, { replace: true })
      }
    }, 350)

    return () => clearTimeout(handler)
  }, [searchInput])

  // 4. Fetch books from backend using server-side filtering
  useEffect(() => {
    let isCancelled = false
    setLoading(true)

    const params: Record<string, any> = {
      page: currentPage,
      pageSize: 24,
      sortBy: sortBy
    }

    if (categoryId > 0) {
      params.categoryId = categoryId
    }

    if (authorId > 0) {
      params.authorId = authorId
    }

    if (searchQuery.trim()) {
      params.search = searchQuery.trim()
    } else if (authorQuery.trim() && !authorId) {
      params.search = authorQuery.trim()
    }

    if (priceIndex > 0 && priceIndex < priceRanges.length) {
      const range = priceRanges[priceIndex]
      if (range.min > 0) params.minPrice = range.min
      if (range.max < Infinity) params.maxPrice = range.max
    }

    apiClient.get('/books', { params })
      .then(res => {
        if (isCancelled) return
        if (res.data && res.data.items) {
          setBooksList(res.data.items)
          setTotalCount(res.data.totalCount ?? res.data.items.length)
          setTotalPages(res.data.totalPages ?? 1)
        } else {
          setBooksList([])
          setTotalCount(0)
          setTotalPages(1)
        }
      })
      .catch(err => {
        if (isCancelled) return
        console.error('Failed to fetch books from backend, using fallback:', err)
        // Fallback in-memory search
        let filtered = fallbackBooks
        if (categoryId > 0) {
          filtered = filtered.filter(b => b.category?.id === categoryId)
        }
        if (authorId > 0) {
          filtered = filtered.filter(b => b.authors?.some(a => a.id === authorId))
        } else if (authorQuery.trim()) {
          const aq = removeVietnameseTones(authorQuery)
          filtered = filtered.filter(b => b.authors?.some(a => removeVietnameseTones(a.name).includes(aq)))
        }
        if (searchQuery.trim()) {
          const q = removeVietnameseTones(searchQuery)
          filtered = filtered.filter(b => 
            removeVietnameseTones(b.title).includes(q) ||
            b.authors?.some(a => removeVietnameseTones(a.name).includes(q)) ||
            b.isbn.toLowerCase().includes(searchQuery.toLowerCase())
          )
        }
        if (priceIndex > 0 && priceIndex < priceRanges.length) {
          const range = priceRanges[priceIndex]
          filtered = filtered.filter(b => {
            const p = b.salePrice ?? b.originalPrice
            return p >= range.min && p <= range.max
          })
        }
        setBooksList(filtered)
        setTotalCount(filtered.length)
        setTotalPages(1)
      })
      .finally(() => {
        if (!isCancelled) setLoading(false)
      })

    return () => {
      isCancelled = true
    }
  }, [categoryId, searchQuery, authorId, authorQuery, priceIndex, sortBy, currentPage])

  // Filter change handlers
  const handleSelectCategory = (id: number) => {
    const next = new URLSearchParams(searchParams)
    if (id > 0) {
      next.set('category', id.toString())
    } else {
      next.delete('category')
    }
    next.delete('page')
    setSearchParams(next)
    setShowFilters(false)
  }

  const handleSelectPrice = (idx: number) => {
    const next = new URLSearchParams(searchParams)
    if (idx > 0) {
      next.set('price', idx.toString())
    } else {
      next.delete('price')
    }
    next.delete('page')
    setSearchParams(next)
  }

  const handleSelectSort = (sortVal: string) => {
    const next = new URLSearchParams(searchParams)
    if (sortVal && sortVal !== 'newest') {
      next.set('sort', sortVal)
    } else {
      next.delete('sort')
    }
    next.delete('page')
    setSearchParams(next)
  }

  const handlePageChange = (newPage: number) => {
    const next = new URLSearchParams(searchParams)
    if (newPage > 1) {
      next.set('page', newPage.toString())
    } else {
      next.delete('page')
    }
    setSearchParams(next)
    window.scrollTo({ top: 180, behavior: 'smooth' })
  }

  const resetFilters = () => {
    setSearchInput('')
    setSearchParams({})
  }

  // Active category item
  const currentCategory = useMemo(() => {
    return categories.find(c => c.id === categoryId)
  }, [categories, categoryId])

  const hasActiveFilters = categoryId > 0 || !!searchQuery.trim() || priceIndex > 0 || authorId > 0 || !!authorQuery.trim()

  return (
    <div className="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
      {/* Editorial Header */}
      <div className="mb-8">
        <div className="inline-flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-[#B84A39] mb-1.5">
          <BookOpen className="h-3.5 w-3.5" />
          <span>Kệ Sách Toàn Thư</span>
        </div>
        <h1 className="font-serif text-3xl sm:text-4xl font-bold text-[#191614] tracking-tight">
          {authorQuery.trim()
            ? `Tác phẩm của ${authorQuery}`
            : currentCategory && currentCategory.id > 0 
              ? currentCategory.name 
              : 'Tủ Sách Tuyển Chọn'}
        </h1>
        <p className="mt-2 text-sm text-[#615C56] max-w-2xl">
          {authorQuery.trim()
            ? `Tuyển chọn tất cả các đầu sách và tác phẩm kinh điển của tác giả ${authorQuery} hiện có tại Bookstore.`
            : currentCategory && currentCategory.id > 0
              ? `Khám phá các tựa sách thuộc chủ đề ${currentCategory.name} được bạn đọc yêu thích nhất.`
              : 'Khám phá hơn 1.000 ấn phẩm văn học, kinh tế, tâm lý kỹ năng và khoa học công nghệ.'}
        </p>
      </div>

      {/* Search & Actions Bar */}
      <div className="mb-6 flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-3">
        {/* Search Input */}
        <div className="relative flex-1">
          <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-[#8C857B]" />
          <input
            type="text"
            value={searchInput}
            onChange={(e) => setSearchInput(e.target.value)}
            placeholder="Tìm theo tên sách, tác giả hoặc mã ISBN (gõ có dấu hoặc không dấu)..."
            className="w-full rounded-xl border border-[#DDD6C4] bg-white py-3 pl-11 pr-10 text-sm text-[#191614] placeholder:text-[#8C857B] outline-none focus:border-[#191614] focus:ring-1 focus:ring-[#191614] transition-all shadow-xs"
          />
          {searchInput && (
            <button 
              onClick={() => {
                setSearchInput('')
                const next = new URLSearchParams(searchParams)
                next.delete('search')
                setSearchParams(next)
              }} 
              className="absolute right-3.5 top-1/2 -translate-y-1/2 text-[#8C857B] hover:text-[#191614] p-1"
              title="Xóa tìm kiếm"
            >
              <X className="h-4 w-4" />
            </button>
          )}
        </div>

        {/* Sort & Mobile Filter Toggle */}
        <div className="flex items-center gap-2.5">
          {/* Sort Dropdown */}
          <div className="relative flex items-center">
            <ArrowUpDown className="absolute left-3.5 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-[#8C857B] pointer-events-none" />
            <select
              value={sortBy}
              onChange={(e) => handleSelectSort(e.target.value)}
              className="appearance-none rounded-xl border border-[#DDD6C4] bg-white py-3 pl-9 pr-8 text-xs font-semibold text-[#191614] hover:border-[#191614] outline-none cursor-pointer shadow-xs transition-colors"
            >
              {sortOptions.map(opt => (
                <option key={opt.value} value={opt.value}>{opt.label}</option>
              ))}
            </select>
          </div>

          {/* Mobile Filter Button */}
          <button
            onClick={() => setShowFilters(!showFilters)}
            className="lg:hidden flex items-center justify-center gap-2 rounded-xl border border-[#DDD6C4] bg-white px-4 py-3 text-xs font-bold text-[#191614] shadow-xs"
          >
            <SlidersHorizontal className="h-3.5 w-3.5" />
            <span>Bộ lọc {hasActiveFilters && '•'}</span>
          </button>
        </div>
      </div>

      {/* Active Filter Chips */}
      {hasActiveFilters && (
        <div className="mb-6 flex flex-wrap items-center gap-2 bg-[#F5F3ED]/80 p-3 rounded-xl border border-[#EBE7DC]">
          <span className="text-xs font-semibold text-[#615C56] flex items-center gap-1.5 mr-1">
            <Filter className="h-3 w-3 text-[#B84A39]" />
            Bộ lọc đang chọn:
          </span>

          {categoryId > 0 && currentCategory && (
            <span className="inline-flex items-center gap-1 rounded-lg bg-white px-2.5 py-1 text-xs font-medium text-[#191614] border border-[#DDD6C4] shadow-xs">
              Thể loại: <strong>{currentCategory.name}</strong>
              <button onClick={() => handleSelectCategory(0)} className="hover:text-[#B84A39]">
                <X className="h-3 w-3" />
              </button>
            </span>
          )}

          {searchQuery.trim() && (
            <span className="inline-flex items-center gap-1 rounded-lg bg-white px-2.5 py-1 text-xs font-medium text-[#191614] border border-[#DDD6C4] shadow-xs">
              Từ khóa: <strong>"{searchQuery.trim()}"</strong>
              <button onClick={() => {
                setSearchInput('')
                const next = new URLSearchParams(searchParams)
                next.delete('search')
                setSearchParams(next)
              }} className="hover:text-[#B84A39]">
                <X className="h-3 w-3" />
              </button>
            </span>
          )}

          {priceIndex > 0 && (
            <span className="inline-flex items-center gap-1 rounded-lg bg-white px-2.5 py-1 text-xs font-medium text-[#191614] border border-[#DDD6C4] shadow-xs">
              Mức giá: <strong>{priceRanges[priceIndex].label}</strong>
              <button onClick={() => handleSelectPrice(0)} className="hover:text-[#B84A39]">
                <X className="h-3 w-3" />
              </button>
            </span>
          )}

          {(authorId > 0 || authorQuery.trim()) && (
            <span className="inline-flex items-center gap-1.5 rounded-lg bg-[#191614] text-white px-3 py-1 text-xs font-medium shadow-xs">
              Tác giả: <strong className="text-amber-300">{authorQuery.trim() || `ID #${authorId}`}</strong>
              <button 
                onClick={() => {
                  const next = new URLSearchParams(searchParams)
                  next.delete('authorId')
                  next.delete('author')
                  next.delete('page')
                  setSearchParams(next)
                }} 
                className="hover:text-red-300 ml-0.5 p-0.5"
                title="Bỏ lọc tác giả"
              >
                <X className="h-3.5 w-3.5" />
              </button>
            </span>
          )}

          <button
            onClick={resetFilters}
            className="ml-auto text-xs text-[#B84A39] hover:underline font-semibold flex items-center gap-1"
          >
            <RotateCcw className="h-3 w-3" />
            Xóa tất cả
          </button>
        </div>
      )}

      {/* Main Layout: Sidebar + Grid */}
      <div className="flex flex-col lg:flex-row gap-8" ref={booksGridRef}>
        
        {/* Desktop Sidebar Filters */}
        <aside className={cn(
          "lg:w-64 shrink-0 space-y-6 bg-white rounded-2xl p-6 border border-[#EBE7DC] shadow-sm self-start sticky top-24",
          showFilters ? "block" : "hidden lg:block"
        )}>
          <div className="flex items-center justify-between pb-3 border-b border-[#F5F3ED]">
            <h3 className="font-serif text-base font-bold text-[#191614]">Thể loại sách</h3>
            {hasActiveFilters && (
              <button
                onClick={resetFilters}
                className="text-xs text-[#B84A39] hover:underline flex items-center gap-1 font-medium"
              >
                <RotateCcw className="h-3 w-3" />
                Đặt lại
              </button>
            )}
          </div>

          {/* Category List */}
          <div>
            <div className="space-y-1">
              {categories.map((cat) => {
                const isSelected = categoryId === cat.id
                return (
                  <button
                    key={cat.id}
                    onClick={() => handleSelectCategory(cat.id)}
                    className={cn(
                      "w-full flex items-center justify-between rounded-xl px-3 py-2.5 text-xs font-medium transition-all text-left",
                      isSelected
                        ? "bg-[#191614] text-white font-semibold shadow-xs"
                        : "text-[#615C56] hover:bg-[#F5F3ED] hover:text-[#191614]"
                    )}
                  >
                    <span className="truncate pr-2">{cat.name}</span>
                    {cat.bookCount !== undefined && (
                      <span className={cn(
                        "text-[10px] px-1.5 py-0.5 rounded-full",
                        isSelected 
                          ? "bg-white/20 text-white font-bold" 
                          : "bg-[#F5F3ED] text-[#8C857B] font-semibold"
                      )}>
                        {cat.bookCount}
                      </span>
                    )}
                  </button>
                )
              })}
            </div>
          </div>

          {/* Price Range Filter */}
          <div className="pt-4 border-t border-[#F5F3ED]">
            <h4 className="text-xs font-bold uppercase tracking-wider text-[#8C857B] mb-3">
              Mức giá
            </h4>
            <div className="space-y-2">
              {priceRanges.map((range, idx) => (
                <label
                  key={idx}
                  className="flex items-center gap-2.5 text-xs text-[#615C56] hover:text-[#191614] cursor-pointer py-0.5 select-none"
                >
                  <input
                    type="radio"
                    name="priceFilter"
                    checked={priceIndex === idx}
                    onChange={() => handleSelectPrice(idx)}
                    className="accent-[#191614] h-3.5 w-3.5 cursor-pointer"
                  />
                  <span>{range.label}</span>
                </label>
              ))}
            </div>
          </div>
        </aside>

        {/* Books Results Main Grid */}
        <main className="flex-1">
          {/* Results Summary Bar */}
          <div className="flex items-center justify-between mb-4 pb-2 border-b border-[#F5F3ED]">
            <span className="text-xs font-medium text-[#615C56]">
              Tìm thấy <strong className="text-[#191614] font-bold">{totalCount}</strong> cuốn sách
              {currentCategory && currentCategory.id > 0 && (
                <span> trong <em>{currentCategory.name}</em></span>
              )}
            </span>
            {totalPages > 1 && (
              <span className="text-xs text-[#8C857B]">
                Trang {currentPage} / {totalPages}
              </span>
            )}
          </div>

          {/* Loading Skeletons */}
          {loading ? (
            <div className="grid grid-cols-2 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-3 xl:grid-cols-4 gap-5">
              {[...Array(8)].map((_, i) => (
                <div key={i} className="animate-pulse rounded-2xl bg-white p-3.5 border border-[#EBE7DC] space-y-3">
                  <div className="w-full aspect-[3/4.2] bg-[#F5F3ED] rounded-xl" />
                  <div className="h-4 bg-[#F5F3ED] rounded w-3/4" />
                  <div className="h-3 bg-[#F5F3ED] rounded w-1/2" />
                  <div className="h-4 bg-[#F5F3ED] rounded w-1/3" />
                </div>
              ))}
            </div>
          ) : booksList.length === 0 ? (
            /* Empty State */
            <div className="rounded-2xl bg-white border border-[#EBE7DC] p-12 text-center shadow-xs">
              <div className="mx-auto h-16 w-16 rounded-full bg-[#F5F3ED] flex items-center justify-center text-[#8C857B] mb-4">
                <BookOpen className="h-8 w-8 text-[#DDD6C4]" />
              </div>
              <h3 className="font-serif text-lg font-bold text-[#191614]">Không tìm thấy ấn phẩm phù hợp</h3>
              <p className="mt-1.5 text-xs text-[#615C56] max-w-sm mx-auto">
                Rất tiếc, không có ấn phẩm nào khớp với bộ lọc hoặc từ khóa "{searchQuery}". Bạn có thể thử tìm kiếm không dấu hoặc xóa bớt bộ lọc.
              </p>
              <button
                onClick={resetFilters}
                className="mt-5 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white px-5 py-2.5 text-xs font-semibold shadow-xs transition-colors"
              >
                Xóa tất cả bộ lọc &amp; xem tất cả sách
              </button>
            </div>
          ) : (
            /* Books Grid */
            <>
              <div className="grid grid-cols-2 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-3 xl:grid-cols-4 gap-5">
                {booksList.map((book) => (
                  <BookCard key={book.id} book={book} />
                ))}
              </div>

              {/* Pagination Controls */}
              {totalPages > 1 && (
                <div className="mt-10 flex items-center justify-center gap-2 pt-6 border-t border-[#EBE7DC]">
                  <button
                    onClick={() => handlePageChange(currentPage - 1)}
                    disabled={currentPage <= 1}
                    className="flex items-center gap-1 rounded-xl border border-[#DDD6C4] bg-white px-3.5 py-2 text-xs font-semibold text-[#191614] hover:bg-[#F5F3ED] disabled:opacity-40 disabled:pointer-events-none transition-all"
                  >
                    <ChevronLeft className="h-4 w-4" />
                    <span>Trước</span>
                  </button>

                  <div className="flex items-center gap-1">
                    {[...Array(totalPages)].map((_, i) => {
                      const pageNum = i + 1
                      // Show page 1, current page +- 1, and last page
                      if (
                        pageNum === 1 || 
                        pageNum === totalPages || 
                        (pageNum >= currentPage - 1 && pageNum <= currentPage + 1)
                      ) {
                        return (
                          <button
                            key={pageNum}
                            onClick={() => handlePageChange(pageNum)}
                            className={cn(
                              "h-9 w-9 rounded-xl text-xs font-bold transition-all",
                              currentPage === pageNum
                                ? "bg-[#191614] text-white shadow-xs"
                                : "bg-white border border-[#DDD6C4] text-[#615C56] hover:bg-[#F5F3ED] hover:text-[#191614]"
                            )}
                          >
                            {pageNum}
                          </button>
                        )
                      }
                      if (pageNum === currentPage - 2 || pageNum === currentPage + 2) {
                        return <span key={pageNum} className="px-1 text-xs text-[#8C857B]">...</span>
                      }
                      return null
                    })}
                  </div>

                  <button
                    onClick={() => handlePageChange(currentPage + 1)}
                    disabled={currentPage >= totalPages}
                    className="flex items-center gap-1 rounded-xl border border-[#DDD6C4] bg-white px-3.5 py-2 text-xs font-semibold text-[#191614] hover:bg-[#F5F3ED] disabled:opacity-40 disabled:pointer-events-none transition-all"
                  >
                    <span>Sau</span>
                    <ChevronRight className="h-4 w-4" />
                  </button>
                </div>
              )}
            </>
          )}
        </main>

      </div>
    </div>
  )
}