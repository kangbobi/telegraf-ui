git config --global user.name "your-username"
git config --global user.email "your-email@example.com"
git add .
git commit -m "Update: auto commit via upload_github.bat"
git push origin main
pause
@echo off
REM Batch file untuk upload ke GitHub

REM Konfigurasi user (edit jika perlu)
git config --global user.name "your-username"
git config --global user.email "your-email@example.com"

echo Pilih mode push:
echo 1. Push awal (init repository, add remote, push pertama kali)
echo 2. Push update (commit & push perubahan)
set /p mode="Masukkan pilihan [1/2]: "

if "%mode%"=="1" (
    REM Inisialisasi repository jika belum ada
    if not exist ".git" (
        git init
    )
    set /p remoteurl="Masukkan URL repository GitHub: "
    git remote add origin %remoteurl%
    git add .
    git commit -m "Initial commit via upload_github.bat"
    git branch -M main
    git push -u origin main
) else (
    git add .
    git commit -m "Update: auto commit via upload_github.bat"
    git push origin main
)

