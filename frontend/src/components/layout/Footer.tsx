import { BookOpen, Mail, MapPin, Phone } from 'lucide-react'
import { Link } from 'react-router-dom'

export default function Footer() {
  return (
    <footer className="border-t border-[#EBE7DC] bg-[#191614] text-[#DDD6C4]">
      {/* Quote Banner */}
      <div className="bg-[#2C2825] py-4 text-center border-b border-[#423E3A]/40 px-4">
        <p className="font-serif text-xs sm:text-sm italic text-[#EBE7DC]">
          "Một cuốn sách hay trên giá là người bạn thầm lặng; một cuốn sách trong tay là người bạn tri kỷ."
        </p>
      </div>

      <div className="mx-auto max-w-7xl px-4 py-14 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-10">
          
          {/* Brand Col */}
          <div className="md:col-span-1 space-y-3">
            <div className="flex items-center gap-2.5">
              <div className="h-9 w-9 rounded-lg bg-[#B84A39] flex items-center justify-center text-white">
                <BookOpen className="h-5 w-5" />
              </div>
              <span className="font-serif text-xl font-bold text-white">Bookstore</span>
            </div>
            <p className="text-xs text-[#8C857B] leading-relaxed">
              Không gian văn hóa và tri thức tuyển chọn. Nơi lưu giữ những cuốn sách có giá trị trường tồn cùng năm tháng.
            </p>
          </div>

          {/* Nav 1 */}
          <div>
            <h4 className="font-serif text-sm font-bold uppercase tracking-wider text-white mb-4">
              Khám phá tủ sách
            </h4>
            <ul className="space-y-2 text-xs">
              <li><Link to="/books" className="hover:text-[#B84A39] transition-colors">Tác phẩm kinh điển</Link></li>
              <li><Link to="/books?category=1" className="hover:text-[#B84A39] transition-colors">Văn học Việt Nam & Thế giới</Link></li>
              <li><Link to="/books?category=2" className="hover:text-[#B84A39] transition-colors">Kinh tế & Tư duy đầu tư</Link></li>
              <li><Link to="/books?category=3" className="hover:text-[#B84A39] transition-colors">Tâm lý & Nghệ thuật sống</Link></li>
            </ul>
          </div>

          {/* Nav 2 */}
          <div>
            <h4 className="font-serif text-sm font-bold uppercase tracking-wider text-white mb-4">
              Chính sách độc giả
            </h4>
            <ul className="space-y-2 text-xs">
              <li><Link to="#" className="hover:text-[#B84A39] transition-colors">Chính sách giao hàng toàn quốc</Link></li>
              <li><Link to="#" className="hover:text-[#B84A39] transition-colors">Đổi trả & hoàn tiền 7 ngày</Link></li>
              <li><Link to="#" className="hover:text-[#B84A39] transition-colors">Quy chuẩn đóng gói sách thật</Link></li>
              <li><Link to="#" className="hover:text-[#B84A39] transition-colors">Thành viên thân thiết</Link></li>
            </ul>
          </div>

          {/* Contact */}
          <div>
            <h4 className="font-serif text-sm font-bold uppercase tracking-wider text-white mb-4">
              Liên hệ hiệu sách
            </h4>
            <ul className="space-y-2.5 text-xs text-[#8C857B]">
              <li className="flex items-center gap-2">
                <MapPin className="h-4 w-4 text-[#B84A39] shrink-0" />
                <span>Hải Châu, TP. Đà Nẵng, Việt Nam</span>
              </li>
              <li className="flex items-center gap-2">
                <Phone className="h-4 w-4 text-[#B84A39] shrink-0" />
                <span>Hotline: 1900 6868</span>
              </li>
              <li className="flex items-center gap-2">
                <Mail className="h-4 w-4 text-[#B84A39] shrink-0" />
                <span>tiemsach@bookstore.vn</span>
              </li>
            </ul>
          </div>

        </div>
      </div>

      <div className="border-t border-[#2C2825] py-4 text-center text-xs text-[#615C56]">
        © 2026 Bookstore. Bản quyền thuộc về Hiệu Sách Tri Thức.
      </div>
    </footer>
  )
}
