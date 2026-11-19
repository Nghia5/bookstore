import { useEffect } from 'react'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { Toaster } from 'sonner'
import Layout from './components/layout/Layout'
import HomePage from './features/home/HomePage'
import BooksPage from './features/books/BooksPage'
import BookDetailPage from './features/books/BookDetailPage'
import CartPage from './features/cart/CartPage'
import LoginPage from './features/auth/LoginPage'
import RegisterPage from './features/auth/RegisterPage'
import AdminDashboard from './features/admin/AdminDashboard'
import ProfilePage from './features/profile/ProfilePage'
import { useAuthStore } from './stores/authStore'

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      refetchOnWindowFocus: false,
      staleTime: 1000 * 60 * 5, // 5 minutes
    },
  },
})

export default function App() {
  useEffect(() => {
    // Validate session token on startup
    useAuthStore.getState().checkSession()
  }, [])

  return (
    <QueryClientProvider client={queryClient}>
      <BrowserRouter>
        <Routes>
          <Route element={<Layout />}>
            <Route path="/" element={<HomePage />} />
            <Route path="/books" element={<BooksPage />} />
            <Route path="/books/:id" element={<BookDetailPage />} />
            <Route path="/categories" element={<BooksPage />} />
            <Route path="/bestsellers" element={<BooksPage />} />
            <Route path="/cart" element={<CartPage />} />
            <Route path="/login" element={<LoginPage />} />
            <Route path="/register" element={<RegisterPage />} />
            <Route path="/profile" element={<ProfilePage />} />
            <Route path="/orders" element={<ProfilePage />} />
          </Route>
          <Route path="/admin" element={<AdminDashboard />} />
        </Routes>
      </BrowserRouter>
      <Toaster 
        position="top-right" 
        richColors 
        duration={3000} 
        closeButton 
        toastOptions={{
          duration: 3000,
        }}
      />
    </QueryClientProvider>
  )
}
