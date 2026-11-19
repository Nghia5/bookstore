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
  toggleSelect: (bookId: number) => void
  setAllSelected: (selected: boolean) => void
  removeSelected: () => void
  getSelectedItems: () => CartItem[]
  getSelectedTotal: () => number
  getTotal: () => number
  getItemCount: () => number
}

export const useCartStore = create<CartState>()(
  persist(
    (set, get) => ({
      items: [],
      appliedVoucherCode: null,
      setAppliedVoucher: (code) => set({ appliedVoucherCode: code }),
      addItem: (book, quantity = 1) =>
        set((state) => {
          const existing = state.items.find((i) => i.bookId === book.id)
          if (existing) {
            return {
              items: state.items.map((i) =>
                i.bookId === book.id
                  ? { ...i, quantity: i.quantity + quantity, addedAt: new Date().toISOString(), selected: true }
                  : i
              ),
            }
          }
          return {
            items: [...state.items, { id: Date.now(), bookId: book.id, book, quantity, addedAt: new Date().toISOString(), selected: true }],
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
      toggleSelect: (bookId) =>
        set((state) => ({
          items: state.items.map((i) =>
            i.bookId === bookId ? { ...i, selected: !(i.selected !== false) } : i
          ),
        })),
      setAllSelected: (selected) =>
        set((state) => ({ items: state.items.map((i) => ({ ...i, selected })) })),
      removeSelected: () =>
        set((state) => ({ items: state.items.filter((i) => i.selected === false) })),
      getSelectedItems: () => get().items.filter((i) => i.selected !== false),
      getSelectedTotal: () =>
        get().items
          .filter((i) => i.selected !== false)
          .reduce((sum, item) => sum + (item.book.salePrice ?? item.book.originalPrice) * item.quantity, 0),
      getTotal: () =>
        get().items.reduce((sum, item) => sum + (item.book.salePrice ?? item.book.originalPrice) * item.quantity, 0),
      getItemCount: () => get().items.reduce((sum, item) => sum + item.quantity, 0),
    }),
    { name: 'cart-storage' }
  )
)
