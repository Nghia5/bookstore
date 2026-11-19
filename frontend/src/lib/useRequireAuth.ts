import { useNavigate, useLocation } from 'react-router-dom'
import { toast } from 'sonner'
import { useAuthStore } from '@/stores/authStore'

/** Returns a guard: runs the action only when logged in, otherwise sends the user to /login. */
export function useRequireAuth() {
  const isAuthenticated = useAuthStore((s) => s.isAuthenticated)
  const navigate = useNavigate()
  const location = useLocation()

  return (action: () => void, message = 'Vui lòng đăng nhập để sử dụng chức năng này.') => {
    if (!isAuthenticated) {
      toast.error(message)
      navigate('/login', { state: { from: location.pathname } })
      return false
    }
    action()
    return true
  }
}