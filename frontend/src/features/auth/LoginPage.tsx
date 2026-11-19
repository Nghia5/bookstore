import { useState } from 'react'
import { Link, useNavigate, useLocation } from 'react-router-dom'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { z } from 'zod'
import { BookOpen, Eye, EyeOff, ShieldCheck, UserCheck } from 'lucide-react'
import { cn } from '@/lib/utils'
import apiClient from '@/api/client'
import { useAuthStore } from '@/stores/authStore'
import { toast } from 'sonner'

const loginSchema = z.object({
  email: z.string().email('Email không đúng định dạng'),
  password: z.string().min(6, 'Mật khẩu phải có ít nhất 6 ký tự'),
})

type LoginForm = z.infer<typeof loginSchema>

export default function LoginPage() {
  const [showPassword, setShowPassword] = useState(false)
  const [errorMessage, setErrorMessage] = useState('')
  const login = useAuthStore((s) => s.login)
  const navigate = useNavigate()

  const {
    register,
    handleSubmit,
    setValue,
    formState: { errors, isSubmitting },
  } = useForm<LoginForm>({
    resolver: zodResolver(loginSchema),
    defaultValues: {
      email: '',
      password: '',
    },
  })

  const onSubmit = async (data: LoginForm) => {
    try {
      setErrorMessage('')
      const response = await apiClient.post('/auth/login', {
        email: data.email.trim(),
        password: data.password,
      })

      const { user, token } = response.data
      login(user, token)
      toast.success(`Đăng nhập thành công! Chào mừng ${user.fullName}`)
      
      // Chuyển hướng thông minh theo quyền hạn người dùng
      if (user.role === 'Admin') {
        navigate('/admin')
      } else {
        navigate('/')
      }
    } catch (err: any) {
      const msg = err.response?.data?.message || 'Email hoặc mật khẩu không chính xác.'
      setErrorMessage(msg)
      toast.error(msg)
    }
  }

  // Helper quick-fill demo credentials
  const fillCredentials = (email: string, pass: string) => {
    setValue('email', email, { shouldValidate: true })
    setValue('password', pass, { shouldValidate: true })
    setErrorMessage('')
  }

  return (
    <div className="flex min-h-[calc(100vh-12rem)] items-center justify-center px-4 py-12">
      <div className="w-full max-w-md">
        
        {/* Logo & Heading */}
        <div className="mb-8 text-center">
          <div className="mx-auto mb-4 flex h-14 w-14 items-center justify-center rounded-2xl bg-[#191614] text-white shadow-md">
            <BookOpen className="h-7 w-7 text-[#D97706]" strokeWidth={2} />
          </div>
          <h1 className="font-serif text-3xl font-bold text-[#191614]">Chào mừng trở lại</h1>
          <p className="mt-1 text-sm text-[#615C56]">Đăng nhập vào tài khoản Bookstore của bạn</p>
        </div>

        {/* Quick fill test accounts banner */}
        <div className="mb-5 rounded-2xl border border-[#DDD6C4] bg-[#F5F3ED] p-3.5 text-xs text-[#615C56]">
          <span className="font-bold text-[#191614] block mb-2">⚡ Tài khoản thử nghiệm nhanh:</span>
          <div className="flex gap-2">
            <button
              type="button"
              onClick={() => fillCredentials('admin@bookstore.vn', 'Admin@123')}
              className="flex-1 flex items-center justify-center gap-1.5 rounded-lg bg-white border border-[#DDD6C4] py-1.5 px-2 hover:bg-[#191614] hover:text-white transition-colors font-medium text-[#191614]"
            >
              <ShieldCheck className="h-3.5 w-3.5 text-[#B84A39]" />
              <span>Admin (Quản trị)</span>
            </button>
            <button
              type="button"
              onClick={() => fillCredentials('docgia@gmail.com', 'User@123')}
              className="flex-1 flex items-center justify-center gap-1.5 rounded-lg bg-white border border-[#DDD6C4] py-1.5 px-2 hover:bg-[#191614] hover:text-white transition-colors font-medium text-[#191614]"
            >
              <UserCheck className="h-3.5 w-3.5 text-[#2D5A43]" />
              <span>Độc giả (Customer)</span>
            </button>
          </div>
        </div>

        {/* Form Card */}
        <div className="rounded-3xl border border-[#EBE7DC] bg-white p-6 sm:p-8 shadow-sm">
          {errorMessage && (
            <div className="mb-5 rounded-xl bg-red-50 border border-red-200 p-3 text-xs text-red-600 font-medium">
              {errorMessage}
            </div>
          )}

          <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
            
            {/* Email */}
            <div>
              <label className="mb-1.5 block text-xs font-bold uppercase tracking-wider text-[#191614]">
                Địa chỉ Email
              </label>
              <input
                type="email"
                {...register('email')}
                placeholder="admin@bookstore.vn"
                className={cn(
                  'w-full rounded-xl border bg-[#FAFAF7] px-4 py-3 text-sm text-[#191614] placeholder:text-[#8C857B] outline-none transition-colors focus:bg-white focus:border-[#191614]',
                  errors.email ? 'border-red-400' : 'border-[#DDD6C4]'
                )}
              />
              {errors.email && <p className="mt-1 text-xs text-red-500">{errors.email.message}</p>}
            </div>

            {/* Password */}
            <div>
              <div className="mb-1.5 flex items-center justify-between">
                <label className="text-xs font-bold uppercase tracking-wider text-[#191614]">
                  Mật khẩu
                </label>
                <Link to="#" className="text-xs text-[#B84A39] hover:underline font-medium">
                  Quên mật khẩu?
                </Link>
              </div>
              <div className="relative">
                <input
                  type={showPassword ? 'text' : 'password'}
                  {...register('password')}
                  placeholder="••••••••"
                  className={cn(
                    'w-full rounded-xl border bg-[#FAFAF7] px-4 py-3 pr-10 text-sm text-[#191614] placeholder:text-[#8C857B] outline-none transition-colors focus:bg-white focus:border-[#191614]',
                    errors.password ? 'border-red-400' : 'border-[#DDD6C4]'
                  )}
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3.5 top-1/2 -translate-y-1/2 text-[#8C857B] hover:text-[#191614] transition-colors"
                >
                  {showPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                </button>
              </div>
              {errors.password && <p className="mt-1 text-xs text-red-500">{errors.password.message}</p>}
            </div>

            {/* Submit Button */}
            <button
              type="submit"
              disabled={isSubmitting}
              className="w-full rounded-xl bg-[#191614] hover:bg-[#B84A39] py-3.5 text-sm font-semibold text-white shadow-lg transition-all disabled:opacity-50 mt-2"
            >
              {isSubmitting ? 'Đang xác thực tài khoản...' : 'Đăng nhập ngay'}
            </button>
          </form>

          {/* Register Link */}
          <div className="mt-6 pt-5 text-center text-xs text-[#615C56] border-t border-[#F5F3ED]">
            Bạn chưa có tài khoản?{' '}
            <Link to="/register" className="font-bold text-[#B84A39] hover:underline">
              Tạo tài khoản mới
            </Link>
          </div>

        </div>

      </div>
    </div>
  )
}
