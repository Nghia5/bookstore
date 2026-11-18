import { create } from 'zustand'
import { persist } from 'zustand/middleware'
import type { Book, CartItem } from '@/types'

interface CartState {
  items: CartItem[]
  appliedVoucherCode: string | null
  setAppliedVoucher: (code: string | null) => void
  addItem: (book: Book, quantity?: number) => void
  removeItem: (bookId: number) => void
  updateQuantity: (bookId: number, quantity: number) => void
  clearCart: () => void
  getTotal: () => number
  getItemCount: () => number
}

export const useCartStore = create<CartState>()(
  persist(
    (set, get) => ({
      items: [],
      appliedVoucherCode: 'WELCOME10', // Default starter voucher
      setAppliedVoucher: (code) => set({ appliedVoucherCode: code }),
      addItem: (book, quantity = 1) =>
        set((state) => {
          const existing = state.items.find((i) => i.bookId === book.id)
          if (existing) {
            return {
              items: state.items.map((i) =>
                i.bookId === book.id ? { ...i, quantity: i.quantity + quantity } : i
              ),
            }
          }
          return {
            items: [...state.items, { id: Date.now(), bookId: book.id, book, quantity }],
          }
        }),
      removeItem: (bookId) =>
        set((state) => ({ items: state.items.filter((i) => i.bookId !== bookId) })),
      updateQuantity: (bookId, quantity) =>
        set((state) => ({
          items: quantity <= 0
            ? state.items.filter((i) => i.bookId !== bookId)
            : state.items.map((i) => (i.bookId === bookId ? { ...i, quantity } : i)),
        })),
      clearCart: () => set({ items: [] }),
      getTotal: () =>
        get().items.reduce((sum, item) => sum + (item.book.salePrice ?? item.book.originalPrice) * item.quantity, 0),
      getItemCount: () => get().items.reduce((sum, item) => sum + item.quantity, 0),
    }),
    { name: 'cart-storage' }
  )
)
