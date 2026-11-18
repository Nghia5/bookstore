# 📚 Bookstore Web Application (.NET 10 LTS & React 19)

Hệ thống bán sách trực tuyến và quản lý cửa hàng sách với phong cách thiết kế **"Hiệu sách cổ điển & Ấm áp" (Warm Literary Indie Bookshop)** — sử dụng bảng màu giấy ngà, gỗ mun, đất nung và nghệ thuật typography chuẩn tiếng Việt.

---

## 🏛️ Kiến Trúc Hệ Thống

Dự án được xây dựng theo chuẩn **Clean Architecture (Onion Architecture)**:

```text
bookstore/
├── backend/
│   ├── Bookstore.slnx
│   └── src/
│       ├── Bookstore.Domain/          # Thực thể nghiệp vụ, Enums, Interfaces (POCO)
│       ├── Bookstore.Application/     # CQRS, DTOs, Mappings, Validation
│       ├── Bookstore.Infrastructure/  # EF Core 10, DbContext, MSSQL, Seeder, Repositories
│       └── Bookstore.API/             # REST API Controllers, JWT Auth, Swagger, Middleware
├── frontend/
│   ├── src/
│   │   ├── api/                      # Axios client cấu hình interceptors JWT
│   │   ├── components/layout/        # Header, Footer phong cách tiệm sách
│   │   ├── features/                 # Home, Books, BookDetail, Cart, Auth
│   │   ├── stores/                   # Zustand stores (Cart, Auth persisted)
│   │   └── types/                    # TypeScript interfaces
└── start-dev.bat                      # Script 1-click chạy cả Backend & Frontend
```

---

## ⚙️ Công Nghệ Sử Dụng

### 1. Backend (.NET 10 LTS)
- **Framework:** .NET 10.0 (LTS), ASP.NET Core 10 Web API, C# 14
- **ORM:** Entity Framework Core 10 (Code-First & Migration)
- **Cơ sở dữ liệu:** Microsoft SQL Server (tự động tạo bảng & seed dữ liệu mẫu)
- **Bảo mật:** JWT Bearer Authentication, SHA-256 Password Hashing, CORS Policy
- **Tài liệu API:** Swagger UI / OpenAPI 3.0 (`http://localhost:5000/swagger`)
- **Logging:** Serilog structured console logging

### 2. Frontend (React 19 + TypeScript)
- **Framework & Build:** React 19.3, Vite 6.0, TypeScript 5.7+
- **Styling:** Tailwind CSS 4 với bảng màu custom:
  - Giấy ngà: `#F8F5EE`
  - Gỗ mun espresso: `#251B14`
  - Đất nung terracotta: `#A44A3F`
  - Ánh đồng cổ copper: `#B86B35`
  - Lá thông sage: `#5F7359`
- **Typography:** `Playfair Display` (tiêu đề serif cổ điển) kết hợp `Be Vietnam Pro` (nội dung thanh thoát)
- **State Management:** Zustand (Cart & Auth với LocalStorage persistence)
- **Routing:** React Router v7
- **Icons & Notification:** Lucide React, Sonner Toast

---

## 🚀 Hướng Dẫn Chạy Dự Án

### Cách 1: Chạy nhanh bằng file Batch (Khuyên dùng trên Windows)
Nhấp đúp chuột vào file:
```cmd
start-dev.bat
```

### Cách 2: Chạy thủ công từng thành phần

#### Bước 1: Khởi động Backend
```powershell
cd D:\Code\DevOps\bookstore\backend\src\Bookstore.API
dotnet run --urls "http://localhost:5000"
```
> Khi khởi động lần đầu, hệ thống sẽ tự động khởi tạo database `BookstoreDb` và nạp sẵn 8 tác phẩm kinh điển, danh mục, tác giả, nhà xuất bản và tài khoản quản trị.

- **Swagger API Docs:** [http://localhost:5000/swagger](http://localhost:5000/swagger)

#### Bước 2: Khởi động Frontend
Mở một cửa sổ terminal khác:
```powershell
cd D:\Code\DevOps\bookstore\frontend
npm run dev
```

- **Giao diện Web:** [http://localhost:5173](http://localhost:5173)

---

## 🔑 Tài Khoản Thử Nghiệm

| Vai trò | Email | Mật khẩu | Quyền hạn |
|---|---|---|---|
| **Quản trị viên (Admin)** | `admin@bookstore.vn` | `Admin@123` | Toàn quyền quản trị hệ thống |
| **Độc giả (Customer)** | `docgia@gmail.com` | `User@123` | Đặt sách, bình luận, quản lý giỏ |
