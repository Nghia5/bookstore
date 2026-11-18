@echo off
chcp 65001 > nul
echo ========================================================
echo   ĐẨY CODE BOOKSTORE LÊN GITHUB (Nghia5/bookstore)
echo ========================================================
echo.

git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ========================================================
    echo   ĐÃ ĐẨY CODE LÊN GITHUB THÀNH CÔNG!
    echo   Xem repository tại: https://github.com/Nghia5/bookstore
    echo ========================================================
) else (
    echo.
    echo [!] Nếu gặp lỗi "Repository not found":
    echo     Hãy vào https://github.com/new và tạo repo tên là "bookstore" (để Public hoặc Private đều được), sau đó chạy lại file này!
)
pause
