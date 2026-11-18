@echo off
chcp 65001 > nul
echo ========================================================
echo   BOOKSTORE WEB APPLICATION (.NET 10 + React 19)
echo ========================================================
echo.
echo [1/2] Đang khởi động Backend .NET 10 (http://localhost:5000)...
start "Bookstore Backend (.NET 10)" cmd /k "cd backend\src\Bookstore.API && dotnet run --urls http://localhost:5000"

echo [2/2] Đang khởi động Frontend React 19 (http://localhost:5173)...
start "Bookstore Frontend (React 19)" cmd /k "cd frontend && npm run dev"

echo.
echo ========================================================
echo   Hệ thống đang chạy:
echo   - Frontend: http://localhost:5173
echo   - Backend API: http://localhost:5000/swagger
echo ========================================================
echo Nhấn phím bất kỳ để thoát cửa sổ này (các server vẫn chạy).
pause > nul
