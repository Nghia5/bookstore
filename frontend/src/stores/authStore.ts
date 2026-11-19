import { create } from 'zustand'
import { persist } from 'zustand/middleware'
import type { User } from '@/types'

/** Decode JWT payload without a library */
function decodeJwt(token: string): Record<string, any> | null {
  try {
    const base64 = token.split('.')[1].replace(/-/g, '+').replace(/_/g, '/')
    return JSON.parse(atob(base64))
  } catch { return null }
}

function isTokenExpired(token: string | null): boolean {
  if (!token) return true
  const payload = decodeJwt(token)
  if (!payload?.exp) return true
  return Date.now() >= payload.exp * 1000
}

interface AuthState {
  user: User | null
  token: string | null
  isAuthenticated: boolean
  login: (user: User, token: string) => void
  logout: () => void
  updateUser: (user: Partial<User>) => void
  checkSession: () => void
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set, get) => ({
      user: null,
      token: null,
      isAuthenticated: false,
      login: (user, token) => {
        localStorage.setItem('accessToken', token)
        set({ user, token, isAuthenticated: true })
      },
      logout: () => {
        localStorage.removeItem('accessToken')
        localStorage.removeItem('auth-storage')
        set({ user: null, token: null, isAuthenticated: false })
        if (typeof window !== 'undefined') window.location.assign('/')
      },
      updateUser: (userData) =>
        set((state) => ({
          user: state.user ? { ...state.user, ...userData } : null,
        })),
      checkSession: () => {
        const { token } = get()
        if (isTokenExpired(token)) {
          localStorage.removeItem('accessToken')
          localStorage.removeItem('auth-storage')
          set({ user: null, token: null, isAuthenticated: false })
        }
      },
    }),
    { name: 'auth-storage' }
  )
)
