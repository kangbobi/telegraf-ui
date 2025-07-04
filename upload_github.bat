@echo off
REM Konfigurasi user
git config --global user.name "kangbobi"
git config --global user.email "devprogramming.bs@gmail.com"

echo.
echo ====================================
echo       GitHub Upload Script
echo ====================================
echo.

REM Cek git
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Git tidak terinstall
    pause
    exit /b 1
)

echo Pilih mode:
echo 1. Setup awal repository
echo 2. Update dan push
echo 3. Keluar
echo.
set /p pilihan="Pilih [1/2/3]: "

if "%pilihan%"=="1" goto setup
if "%pilihan%"=="2" goto update
if "%pilihan%"=="3" goto keluar
echo Pilihan tidak valid
pause
exit /b 1

:setup
echo.
echo === SETUP REPOSITORY ===

if not exist ".git" (
    echo Membuat repository...
    git init
    if %errorlevel% neq 0 (
        echo ERROR: Gagal init
        pause
        exit /b 1
    )
)

set /p url="URL GitHub repo: "
if "%url%"=="" (
    echo ERROR: URL kosong
    pause
    exit /b 1
)

git remote remove origin >nul 2>&1
git remote add origin %url%
if %errorlevel% neq 0 (
    echo ERROR: Gagal add remote
    pause
    exit /b 1
)

git add .
git commit -m "Initial commit"
git branch -M main
git push -u origin main
if %errorlevel% neq 0 (
    echo ERROR: Gagal push
    pause
    exit /b 1
)

echo SUCCESS!
goto akhir

:update
echo.
echo === UPDATE REPOSITORY ===

git remote get-url origin >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Repository belum di-setup
    pause
    exit /b 1
)

set /p pesan="Pesan commit (Enter untuk default): "
if "%pesan%"=="" set pesan=Auto update

git add .
git commit -m "%pesan%"
git push origin main
if %errorlevel% neq 0 (
    echo ERROR: Gagal push
    pause
    exit /b 1
)

echo SUCCESS!
goto akhir

:keluar
echo Keluar...
exit /b 0

:akhir
echo.
pause

