import { Link } from 'react-router-dom'
import { Star, ShoppingBag, Eye, Heart } from 'lucide-react'
import { formatPrice, cn } from '@/lib/utils'
import { useCartStore } from '@/stores/cartStore'
import { useWishlistStore } from '@/stores/wishlistStore'
import type { Book } from '@/types'
import { toast } from 'sonner'
import { useRequireAuth } from '@/lib/useRequireAuth'

// Curated authentic Vietnamese book covers
const fallbackCovers = [
  'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg', // Nhà Giả Kim
  'https://salt.tikicdn.com/cache/750x750/ts/product/73/ac/e1/41f2139e7511de8b97a2a500032c46c9.jpg', // Đắc Nhân Tâm
  'https://cdn1.fahasa.com/media/catalog/product/8/9/8935270703554.jpg', // Sapiens
  'https://cdn1.fahasa.com/media/catalog/product/u/n/untitled-1_4_160.jpg', // Atomic Habits
  'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/df/fe/df/08a4a624353b4289b877cf3bced910e4.jpg', // Mắt Biếc
  'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/a0/a3/2b/006dac88a54de6057ebc9e922069d2bd.jpg', // Cho Tôi Xin Một Vé Đi Tuổi Thơ
  'https://salt.tikicdn.com/cache/750x750/ts/product/18/fc/21/df00fdfb5982181b5ce2a514d34ef19e.jpg', // Muôn Kiếp Nhân Sinh
  'https://salt.tikicdn.com/cache/750x750/ts/product/a5/65/4c/2da4aa944b6f280afbd694ac1a129682.jpeg', // Dế Mèn Phiêu Lưu Ký
  'https://cdn1.fahasa.com/media/catalog/product/8/9/8936107813361.jpg', // Clean Code
  'https://cdn1.fahasa.com/media/catalog/product/8/9/8935235241848.jpg', // Totto-chan
]

interface BookCardProps {
  book: Book
  rank?: number
}

export default function BookCard({ book, rank }: BookCardProps) {
  const addItem = useCartStore((s) => s.addItem)
  const { isInWishlist, toggleWishlist } = useWishlistStore()
  const isFav = isInWishlist(book.id)
  const requireAuth = useRequireAuth()

  const coverUrl = book.coverImageUrl || fallbackCovers[(book.id || 1) % fallbackCovers.length]

  const discountPercent = book.salePrice
    ? Math.round(((book.originalPrice - book.salePrice) / book.originalPrice) * 100)
    : 0

  const handleAddToCart = (e: React.MouseEvent) => {
    e.preventDefault()
    e.stopPropagation()
    requireAuth(() => {
      addItem(book, 1)
      toast.success(`Đã thêm "${book.title}" vào giỏ hàng!`)
    }, 'Vui lòng đăng nhập để thêm sách vào giỏ hàng.')
  }

  const handleToggleWishlist = (e: React.MouseEvent) => {
    e.preventDefault()
    e.stopPropagation()
    requireAuth(() => {
      toggleWishlist(book)
      if (isFav) {
        toast.success(`Đã bỏ "${book.title}" khỏi danh sách yêu thích`)
      } else {
        toast.success(`Đã thêm "${book.title}" vào danh sách yêu thích!`)
      }
    }, 'Vui lòng đăng nhập để thêm vào danh sách yêu thích.')
  }

  const authorName = book.authors && book.authors.length > 0 
    ? book.authors.map(a => a.name).join(', ') 
    : 'Tác giả'

  return (
    <div className="group relative flex flex-col bg-white rounded-2xl p-3.5 border border-[#EBE7DC] hover:border-[#DDD6C4] transition-all duration-300 hover:-translate-y-1.5 hover:shadow-[0_12px_28px_rgba(25,22,20,0.08)]">
      {/* Ranking Badge */}
      {rank && (
        <div className="absolute -top-2.5 -left-2.5 z-20 flex h-7 w-7 items-center justify-center rounded-full bg-[#191614] font-serif text-xs font-bold text-[#F5F3ED] shadow-md border-2 border-white">
          {rank}
        </div>
      )}

      {/* Book Cover Image Container */}
      <div className="relative aspect-[3/4.2] w-full overflow-hidden rounded-xl bg-[#F5F3ED] mb-3.5">
        <Link to={`/books/${book.id}`} className="block h-full w-full">
          <img
            src={coverUrl}
            alt={book.title}
            referrerPolicy="no-referrer"
            className="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105"
            loading="lazy"
            onError={(e) => {
              (e.target as HTMLImageElement).src = fallbackCovers[(book.id || 1) % fallbackCovers.length]
            }}
          />
        </Link>

        {/* Wishlist Button */}
        <button
          onClick={handleToggleWishlist}
          className={cn(
            "absolute top-2.5 left-2.5 z-20 flex h-7 w-7 items-center justify-center rounded-full bg-white/90 backdrop-blur-xs shadow-sm transition-all hover:scale-110",
            isFav ? "text-red-500" : "text-[#706B65] hover:text-red-500"
          )}
          title={isFav ? "Bỏ yêu thích" : "Lưu vào sách yêu thích"}
        >
          <Heart className={cn("w-3.5 h-3.5", isFav && "fill-red-500 text-red-500")} />
        </button>

        {/* Discount Badge */}
        {discountPercent > 0 && (
          <div className="absolute top-2.5 right-2.5 z-10 rounded-md bg-[#B84A39] px-2 py-0.5 text-[11px] font-bold text-white shadow-sm">
            -{discountPercent}%
          </div>
        )}

        {/* Hover Quick Actions */}
        <div className="absolute inset-x-2 bottom-2 z-10 flex gap-1.5 opacity-0 translate-y-2 transition-all duration-300 group-hover:opacity-100 group-hover:translate-y-0">
          <button
            onClick={handleAddToCart}
            className="flex-1 flex items-center justify-center gap-1.5 rounded-lg bg-[#191614] hover:bg-[#B84A39] py-2 px-3 text-xs font-medium text-white shadow-lg transition-colors backdrop-blur-sm"
          >
            <ShoppingBag className="h-3.5 w-3.5" />
            <span>Thêm giỏ</span>
          </button>
          <Link
            to={`/books/${book.id}`}
            className="flex items-center justify-center rounded-lg bg-white/90 hover:bg-white p-2 text-[#191614] shadow-lg transition-colors"
            title="Xem chi tiết"
          >
            <Eye className="h-3.5 w-3.5" />
          </Link>
        </div>
      </div>

      {/* Book Info */}
      <div className="flex flex-1 flex-col justify-between">
        <div>
          {book.category?.name && (
            <span className="text-[10px] uppercase font-semibold tracking-wider text-[#D97706] mb-1 block">
              {book.category.name}
            </span>
          )}

          <Link to={`/books/${book.id}`}>
            <h3 className="font-serif text-sm font-bold text-[#191614] line-clamp-2 leading-snug group-hover:text-[#B84A39] transition-colors mb-1">
              {book.title}
            </h3>
          </Link>

          <p className="text-xs text-[#615C56] line-clamp-1 mb-2">
            {book.authors && book.authors.length > 0 ? (
              book.authors.map((a, idx) => (
                <span key={a.id || idx}>
                  <Link
                    to={`/books?authorId=${a.id}&author=${encodeURIComponent(a.name)}`}
                    onClick={(e) => e.stopPropagation()}
                    className="hover:text-[#B84A39] hover:underline transition-colors"
                    title={`Xem các tác phẩm của tác giả ${a.name}`}
                  >
                    {a.name}
                  </Link>
                  {idx < book.authors!.length - 1 ? ', ' : ''}
                </span>
              ))
            ) : (
              <span>{authorName}</span>
            )}
          </p>
        </div>

        <div>
          {/* Rating */}
          <div className="flex items-center gap-1 mb-2">
            <div className="flex text-[#F59E0B]">
              {[1, 2, 3, 4, 5].map((s) => (
                <Star
                  key={s}
                  className={`h-3 w-3 ${
                    s <= Math.round(book.averageRating || 5)
                      ? 'fill-[#F59E0B] text-[#F59E0B]'
                      : 'text-[#DDD6C4]'
                  }`}
                />
              ))}
            </div>
            <span className="text-[11px] font-medium text-[#8C857B] ml-0.5">
              {book.averageRating ? book.averageRating.toFixed(1) : '5.0'}
            </span>
          </div>

          {/* Pricing */}
          <div className="flex items-baseline gap-2 pt-1 border-t border-[#F5F3ED]">
            <span className="font-bold text-sm text-[#B84A39] font-sans tabular-nums">
              {formatPrice(book.salePrice ?? book.originalPrice)}
            </span>
            {book.salePrice && (
              <span className="text-xs text-[#8C857B] line-through font-sans tabular-nums">
                {formatPrice(book.originalPrice)}
              </span>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}
