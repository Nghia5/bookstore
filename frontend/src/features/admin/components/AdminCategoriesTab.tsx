import { useState, useEffect } from 'react'
import { Plus, Search, Edit3, Trash2, FolderTree, BookOpen, AlertCircle, RefreshCw } from 'lucide-react'
import apiClient from '@/api/client'
import { toast } from 'sonner'
import { cn } from '@/lib/utils'

export interface CategoryItem {
  id: number
  name: string
  slug: string
  description?: string
  bookCount: number
}

interface AdminCategoriesTabProps {
  onSelectCategoryFilter?: (categoryId: number) => void
}

export default function AdminCategoriesTab({ onSelectCategoryFilter }: AdminCategoriesTabProps) {
  const [categories, setCategories] = useState<CategoryItem[]>([])
  const [loading, setLoading] = useState(false)
  const [search, setSearch] = useState('')

  // Modal create/edit
  const [isModalOpen, setIsModalOpen] = useState(false)
  const [editingCategory, setEditingCategory] = useState<Partial<CategoryItem> | null>(null)
  const [formName, setFormName] = useState('')
  const [formSlug, setFormSlug] = useState('')
  const [formDescription, setFormDescription] = useState('')
  const [isSubmitting, setIsSubmitting] = useState(false)

  const fetchCategories = async () => {
    try {
      setLoading(true)
      const res = await apiClient.get('/categories')
      setCategories(res.data || [])
    } catch {
      toast.error('Không thể tải danh sách thể loại sách.')
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchCategories()
  }, [])

  const handleOpenCreate = () => {
    setEditingCategory(null)
    setFormName('')
    setFormSlug('')
    setFormDescription('')
    setIsModalOpen(true)
  }

  const handleOpenEdit = (c: CategoryItem) => {
    setEditingCategory(c)
    setFormName(c.name)
    setFormSlug(c.slug)
    setFormDescription(c.description || '')
    setIsModalOpen(true)
  }

  const handleSave = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!formName.trim()) {
      toast.error('Tên thể loại không được để trống.')
      return
    }

    try {
      setIsSubmitting(true)
      if (editingCategory?.id) {
        // Update
        const res = await apiClient.put(`/categories/${editingCategory.id}`, {
          name: formName.trim(),
          slug: formSlug.trim(),
          description: formDescription.trim()
        })
        toast.success(res.data?.message || 'Đã cập nhật thể loại thành công!')
      } else {
        // Create
        await apiClient.post('/categories', {
          name: formName.trim(),
          slug: formSlug.trim(),
          description: formDescription.trim()
        })
        toast.success(`Đã thêm thể loại mới "${formName.trim()}"!`)
      }
      setIsModalOpen(false)
      fetchCategories()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Có lỗi xảy ra khi lưu thể loại.')
    } finally {
      setIsSubmitting(false)
    }
  }

  const handleDelete = async (c: CategoryItem) => {
    if (c.bookCount > 0) {
      toast.error(`Không thể xóa "${c.name}" vì đang có ${c.bookCount} cuốn sách liên kết! Vui lòng chuyển sách sang thể loại khác trước.`)
      return
    }

    if (!confirm(`Bạn có chắc chắn muốn xóa thể loại "${c.name}"?`)) return

    try {
      const res = await apiClient.delete(`/categories/${c.id}`)
      toast.success(res.data?.message || 'Đã xóa thể loại.')
      fetchCategories()
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Không thể xóa thể loại này.')
    }
  }

  const filtered = categories.filter(c => 
    c.name.toLowerCase().includes(search.toLowerCase()) ||
    (c.description && c.description.toLowerCase().includes(search.toLowerCase())) ||
    c.slug.toLowerCase().includes(search.toLowerCase())
  )

  const totalBooksAcrossCategories = categories.reduce((sum, c) => sum + (c.bookCount || 0), 0)

  return (
    <div className="space-y-4">
      {/* Header bar */}
      <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-3 bg-white p-4 rounded-2xl border border-[#EBE7DC]">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-xl bg-amber-50 border border-amber-200 flex items-center justify-center text-amber-800 shrink-0">
            <FolderTree className="w-5 h-5" />
          </div>
          <div>
            <h2 className="font-serif font-bold text-lg text-[#191614] flex items-center gap-2">
              <span>Quản lý Thể Loại & Danh Mục Sách</span>
              <span className="text-xs px-2 py-0.5 rounded-full bg-[#FAF9F5] border border-[#DDD6C4] font-sans font-bold text-[#615C56]">
                {categories.length} thể loại
              </span>
            </h2>
            <p className="text-xs text-[#706B65]">
              Tổng cộng <strong>{totalBooksAcrossCategories}</strong> đầu sách đã được phân loại theo danh mục
            </p>
          </div>
        </div>

        <div className="flex items-center gap-2">
          {/* Search */}
          <div className="relative">
            <Search className="w-4 h-4 text-[#8C857B] absolute left-3 top-2.5" />
            <input
              type="text"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder="Tìm theo tên thể loại..."
              className="pl-9 pr-3 py-2 text-xs rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614] w-48 sm:w-60"
            />
          </div>

          <button
            onClick={fetchCategories}
            className="p-2 text-[#706B65] hover:text-[#191614] rounded-xl hover:bg-[#F5F3ED] transition-colors"
            title="Làm mới"
          >
            <RefreshCw className={cn("w-4 h-4", loading && "animate-spin")} />
          </button>

          <button
            onClick={handleOpenCreate}
            className="px-4 py-2 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-bold flex items-center gap-1.5 transition-colors shadow-xs"
          >
            <Plus className="w-4 h-4" />
            <span>Thêm thể loại mới</span>
          </button>
        </div>
      </div>

      {/* Categories Grid / Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-3.5">
        {filtered.map((c) => (
          <div
            key={c.id}
            className="p-4 rounded-2xl bg-white border border-[#EBE7DC] hover:border-[#DDD6C4] transition-all shadow-2xs flex flex-col justify-between"
          >
            <div>
              <div className="flex items-start justify-between gap-2">
                <div className="flex items-center gap-2">
                  <div className="w-8 h-8 rounded-lg bg-[#FAF9F5] border border-[#DDD6C4] flex items-center justify-center text-[#B84A39] shrink-0 font-bold">
                    📁
                  </div>
                  <div>
                    <h3 className="font-serif font-bold text-sm text-[#191614]">
                      {c.name}
                    </h3>
                    <span className="font-mono text-[10px] text-[#8C857B] block">
                      slug: /{c.slug}
                    </span>
                  </div>
                </div>

                <span className="px-2.5 py-1 rounded-full text-xs font-bold font-sans tabular-nums bg-amber-50 text-amber-900 border border-amber-200 shrink-0">
                  {c.bookCount} sách
                </span>
              </div>

              <p className="text-xs text-[#615C56] mt-2.5 line-clamp-2 leading-relaxed">
                {c.description || 'Chưa có mô tả chi tiết cho thể loại này.'}
              </p>
            </div>

            <div className="mt-4 pt-3 border-t border-[#F5F3ED] flex items-center justify-between">
              {onSelectCategoryFilter ? (
                <button
                  type="button"
                  onClick={() => onSelectCategoryFilter(c.id)}
                  className="text-[11px] font-semibold text-sky-700 hover:underline flex items-center gap-1"
                >
                  <BookOpen className="w-3.5 h-3.5" />
                  <span>Xem {c.bookCount} sách</span>
                </button>
              ) : (
                <span className="text-[11px] text-[#8C857B]">ID: #{c.id}</span>
              )}

              <div className="flex items-center gap-1">
                <button
                  onClick={() => handleOpenEdit(c)}
                  className="p-1.5 rounded-lg text-[#615C56] hover:text-[#191614] hover:bg-[#F5F3ED] transition-colors"
                  title="Chỉnh sửa thể loại"
                >
                  <Edit3 className="w-4 h-4" />
                </button>
                <button
                  onClick={() => handleDelete(c)}
                  className="p-1.5 rounded-lg text-red-500 hover:text-red-700 hover:bg-red-50 transition-colors"
                  title="Xóa thể loại"
                >
                  <Trash2 className="w-4 h-4" />
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>

      {filtered.length === 0 && !loading && (
        <div className="bg-white rounded-2xl border border-[#EBE7DC] p-12 text-center">
          <AlertCircle className="w-10 h-10 text-[#DDD6C4] mx-auto mb-2" />
          <p className="text-sm text-[#706B65]">Không tìm thấy thể loại nào phù hợp với từ khóa.</p>
        </div>
      )}

      {/* Modal Add / Edit Category */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-xs">
          <div className="w-full max-w-md bg-white rounded-3xl p-6 shadow-2xl border border-[#DDD6C4] space-y-4">
            <div className="flex items-center justify-between pb-3 border-b border-[#F5F3ED]">
              <h3 className="font-serif font-bold text-base text-[#191614]">
                {editingCategory ? `Sửa thể loại: "${editingCategory.name}"` : 'Thêm thể loại sách mới'}
              </h3>
              <button
                onClick={() => setIsModalOpen(false)}
                className="p-1.5 text-[#8C857B] hover:text-[#191614] rounded-lg hover:bg-[#F5F3ED]"
              >
                ✕
              </button>
            </div>

            <form onSubmit={handleSave} className="space-y-3.5">
              <div>
                <label className="block text-xs font-semibold text-[#191614] mb-1">
                  Tên thể loại <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  required
                  value={formName}
                  onChange={(e) => {
                    setFormName(e.target.value)
                    if (!editingCategory) {
                      // Auto slugify
                      const slug = e.target.value
                        .toLowerCase()
                        .normalize('NFD')
                        .replace(/[\u0300-\u036f]/g, '')
                        .replace(/[đĐ]/g, 'd')
                        .replace(/[^a-z0-9\s-]/g, '')
                        .trim()
                        .replace(/\s+/g, '-')
                      setFormSlug(slug)
                    }
                  }}
                  placeholder="Ví dụ: Truyện Tranh & Manga, Khoa Học..."
                  className="w-full px-3 py-2 text-xs rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                />
              </div>

              <div>
                <label className="block text-xs font-semibold text-[#191614] mb-1">
                  Đường dẫn tĩnh (Slug)
                </label>
                <input
                  type="text"
                  value={formSlug}
                  onChange={(e) => setFormSlug(e.target.value)}
                  placeholder="truyen-tranh-manga"
                  className="w-full px-3 py-2 text-xs rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614] font-mono text-[#615C56]"
                />
                <span className="text-[10px] text-[#8C857B] mt-0.5 block">
                  Đường dẫn hiển thị trên thanh địa chỉ web (tự động tạo từ tên nếu để trống).
                </span>
              </div>

              <div>
                <label className="block text-xs font-semibold text-[#191614] mb-1">
                  Mô tả thể loại
                </label>
                <textarea
                  rows={3}
                  value={formDescription}
                  onChange={(e) => setFormDescription(e.target.value)}
                  placeholder="Giới thiệu khái quát về các tác phẩm thuộc thể loại này..."
                  className="w-full px-3 py-2 text-xs rounded-xl border border-[#DDD6C4] focus:outline-none focus:border-[#191614]"
                />
              </div>

              <div className="pt-2 flex items-center justify-end gap-2 border-t border-[#F5F3ED]">
                <button
                  type="button"
                  onClick={() => setIsModalOpen(false)}
                  className="px-4 py-2 rounded-xl border border-[#DDD6C4] text-xs font-semibold text-[#615C56] hover:bg-[#F5F3ED]"
                >
                  Hủy bỏ
                </button>
                <button
                  type="submit"
                  disabled={isSubmitting}
                  className="px-4 py-2 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white text-xs font-bold transition-colors disabled:opacity-50"
                >
                  {isSubmitting ? 'Đang lưu...' : (editingCategory ? 'Lưu thay đổi' : 'Tạo thể loại')}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  )
}
