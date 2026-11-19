export interface Book {
  id: number
  isbn: string
  title: string
  description?: string
  originalPrice: number
  salePrice?: number
  stockQuantity: number
  pageCount?: number
  publishYear?: number
  language: string
  coverImageUrl?: string
  isAvailable: boolean
  categoryId?: number
  category?: Category
  authors: Author[]
  reviews?: Review[]
  averageRating?: number
}

export interface Category {
  id: number
  name: string
  slug: string
  description?: string
  parentId?: number
  children?: Category[]
  bookCount: number
}

export interface Author {
  id: number
  name: string
  biography?: string
  nationality?: string
  avatarUrl?: string
}

export interface Review {
  id: number
  userId: number
  userName: string
  bookId: number
  rating: number
  comment?: string
  createdAt: string
}

export interface CartItem {
  id: number
  bookId: number
  book: Book
  quantity: number
  addedAt?: string
  selected?: boolean
}

export interface User {
  id: number
  email: string
  fullName: string
  phoneNumber?: string
  role: 'Customer' | 'SalesStaff' | 'WarehouseStaff' | 'Admin'
  isActive: boolean
}

export interface Order {
  id: number
  orderCode: string
  status: OrderStatus
  totalAmount: number
  discountAmount: number
  shippingFee: number
  finalAmount: number
  note?: string
  orderDate: string
  items: OrderItem[]
}

export interface OrderItem {
  id: number
  bookId: number
  bookTitle: string
  unitPrice: number
  quantity: number
  lineTotal: number
}

export type OrderStatus = 'Pending' | 'Confirmed' | 'Processing' | 'Shipped' | 'Delivered' | 'Cancelled' | 'Returned'

export interface ApiResponse<T> {
  data: T
  message: string
  success: boolean
}

export interface PaginatedResult<T> {
  items: T[]
  totalCount: number
  page: number
  pageSize: number
  totalPages: number
}
