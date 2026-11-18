import { create } from 'zustand'
import { persist } from 'zustand/middleware'
import type { Book } from '@/types'

interface WishlistState {
  items: Book[]
  toggleWishlist: (book: Book) => void
  isInWishlist: (bookId: number) => boolean
  removeFromWishlist: (bookId: number) => void
  clearWishlist: () => void
}

export const useWishlistStore = create<WishlistState>()(
  persist(
    (set, get) => ({
      items: [],
      toggleWishlist: (book) =>
        set((state) => {
          const exists = state.items.some((b) => b.id === book.id)
          if (exists) {
            return { items: state.items.filter((b) => b.id !== book.id) }
          }
          return { items: [...state.items, book] }
        }),
      isInWishlist: (bookId) => get().items.some((b) => b.id === bookId),
      removeFromWishlist: (bookId) =>
        set((state) => ({ items: state.items.filter((b) => b.id !== bookId) })),
      clearWishlist: () => set({ items: [] }),
    }),
    { name: 'wishlist-storage' }
  )
)
