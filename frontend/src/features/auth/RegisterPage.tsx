import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { z } from 'zod'
import { BookOpen, Eye, EyeOff } from 'lucide-react'
import { cn } from '@/lib/utils'
import apiClient from '@/api/client'
import { toast } from 'sonner'

const registerSchema = z
  .object({
    fullName: z.string().min(2, 'Họ và tên phải có ít nhất 2 ký tự'),
    email: z.string().email('Email không đúng định dạng'),
    phoneNumber: z.string().optional(),
    password: z.string().min(6, 'Mật khẩu phải có ít nhất 6 ký tự'),
    confirmPassword: z.string(),
  })
  .refine((data) => data.password === data.confirmPassword, {
    message: 'Mật khẩu xác nhận không khớp',
    path: ['confirmPassword'],
  })

type RegisterForm = z.infer<typeof registerSchema>

export default function RegisterPage() {
  const [showPassword, setShowPassword] = useState(false)
  const [errorMessage, setErrorMessage] = useState('')
  const navigate = useNavigate()

  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<RegisterForm>({
    resolver: zodResolver(registerSchema),
  })

  const onSubmit = async (data: RegisterForm) => {
    try {
      setErrorMessage('')
      const response = await apiClient.post('/auth/register', {
        fullName: data.fullName.trim(),
        email: data.email.trim(),
        phoneNumber: data.phoneNumber?.trim() || null,
        password: data.password,
      })

      const { user } = response.data
      toast.success(`Đăng ký thành công! Chào mừng ${user.fullName}. Vui lòng đăng nhập để tiếp tục.`)
      navigate('/login', { state: { email: data.email.trim() } })
    } catch (err: any) {
      const msg = err.response?.data?.message || 'Đăng ký không thành công. Email có thể đã tồn tại.'
      setErrorMessage(msg)
      toast.error(msg)
    }
  }

  return (
    <div className="flex min-h-[calc(100vh-12rem)] items-center justify-center px-4 py-12">
      <div className="w-full max-w-md">
        
        {/* Logo & Heading */}
        <div className="mb-8 text-center">
          <div className="mx-auto mb-4 flex h-14 w-14 items-center justify-center rounded-2xl bg-[#191614] text-white shadow-md">
            <BookOpen className="h-7 w-7 text-[#D97706]" strokeWidth={2} />
          </div>
          <h1 className="font-serif text-3xl font-bold text-[#191614]">Tạo tài khoản mới</h1>
          <p className="mt-1 text-sm text-[#615C56]">Gia nhập cộng đồng người yêu sách Bookstore</p>
        </div>

        {/* Form Card */}
        <div className="rounded-3xl border border-[#EBE7DC] bg-white p-6 sm:p-8 shadow-sm">
          {errorMessage && (
            <div className="mb-5 rounded-xl bg-red-50 border border-red-200 p-3 text-xs text-red-600 font-medium">
              {errorMessage}
            </div>
          )}

          <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
            
            {/* Full Name */}
            <div>
              <label className="mb-1.5 block text-xs font-bold uppercase tracking-wider text-[#191614]">
                Họ và tên của bạn *
              </label>
              <input
                type="text"
                {...register('fullName')}
                placeholder="Nguyễn Văn Độc Giả"
                className={cn(
                  'w-full rounded-xl border bg-[#FAFAF7] px-4 py-3 text-sm text-[#191614] placeholder:text-[#8C857B] outline-none transition-colors focus:bg-white focus:border-[#191614]',
                  errors.fullName ? 'border-red-400' : 'border-[#DDD6C4]'
                )}
              />
              {errors.fullName && <p className="mt-1 text-xs text-red-500">{errors.fullName.message}</p>}
            </div>

            {/* Email */}
            <div>
              <label className="mb-1.5 block text-xs font-bold uppercase tracking-wider text-[#191614]">
                Địa chỉ Email *
              </label>
              <input
                type="email"
                {...register('email')}
                placeholder="docgia@gmail.com"
                className={cn(
                  'w-full rounded-xl border bg-[#FAFAF7] px-4 py-3 text-sm text-[#191614] placeholder:text-[#8C857B] outline-none transition-colors focus:bg-white focus:border-[#191614]',
                  errors.email ? 'border-red-400' : 'border-[#DDD6C4]'
                )}
              />
              {errors.email && <p className="mt-1 text-xs text-red-500">{errors.email.message}</p>}
            </div>

            {/* Phone */}
            <div>
              <label className="mb-1.5 block text-xs font-bold uppercase tracking-wider text-[#191614]">
                Số điện thoại (tùy chọn)
              </label>
              <input
                type="tel"
                {...register('phoneNumber')}
                placeholder="0987 654 321"
                className="w-full rounded-xl border border-[#DDD6C4] bg-[#FAFAF7] px-4 py-3 text-sm text-[#191614] placeholder:text-[#8C857B] outline-none transition-colors focus:bg-white focus:border-[#191614]"
              />
            </div>

            {/* Password */}
            <div>
              <label className="mb-1.5 block text-xs font-bold uppercase tracking-wider text-[#191614]">
                Mật khẩu (tối thiểu 6 ký tự) *
              </label>
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

            {/* Confirm Password */}
            <div>
              <label className="mb-1.5 block text-xs font-bold uppercase tracking-wider text-[#191614]">
                Xác nhận mật khẩu *
              </label>
              <input
                type={showPassword ? 'text' : 'password'}
                {...register('confirmPassword')}
                placeholder="••••••••"
                className={cn(
                  'w-full rounded-xl border bg-[#FAFAF7] px-4 py-3 text-sm text-[#191614] placeholder:text-[#8C857B] outline-none transition-colors focus:bg-white focus:border-[#191614]',
                  errors.confirmPassword ? 'border-red-400' : 'border-[#DDD6C4]'
                )}
              />
              {errors.confirmPassword && <p className="mt-1 text-xs text-red-500">{errors.confirmPassword.message}</p>}
            </div>

            {/* Submit Button */}
            <button
              type="submit"
              disabled={isSubmitting}
              className="w-full rounded-xl bg-[#191614] hover:bg-[#B84A39] py-3.5 text-sm font-semibold text-white shadow-lg transition-all disabled:opacity-50 mt-2"
            >
              {isSubmitting ? 'Đang tạo tài khoản...' : 'Đăng ký ngay'}
            </button>
          </form>

          {/* Login Link */}
          <div className="mt-6 pt-5 text-center text-xs text-[#615C56] border-t border-[#F5F3ED]">
            Bạn đã có tài khoản?{' '}
            <Link to="/login" className="font-bold text-[#B84A39] hover:underline">
              Đăng nhập tại đây
            </Link>
          </div>

        </div>

      </div>
    </div>
  )
}
