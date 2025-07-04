#!/bin/bash
# Windows Git Bash script untuk upload ke GitHub

# Konfigurasi user
git config --global user.name "kangbobi"
git config --global user.email "devprogramming.bs@gmail.com"

echo "======================================"
echo "       GitHub Upload Script"
echo "       (Windows Git Bash)"
echo "======================================"
echo

# Cek apakah git sudah terinstall
if ! command -v git &> /dev/null; then
    echo "ERROR: Git tidak ditemukan. Pastikan Git sudah terinstall."
    read -p "Tekan Enter untuk keluar..."
    exit 1
fi

echo "Pilih mode push:"
echo "1. Push awal (init repository, add remote, push pertama kali)"
echo "2. Push update (commit dan push perubahan)"
echo "3. Exit"
echo
read -p "Masukkan pilihan [1/2/3]: " mode

case $mode in
    1)
        echo
        echo "Menjalankan setup repository awal..."
        
        # Inisialisasi repository jika belum ada
        if [ ! -d ".git" ]; then
            echo "Inisialisasi git repository..."
            git init
            if [ $? -ne 0 ]; then
                echo "ERROR: Gagal inisialisasi repository"
                read -p "Tekan Enter untuk keluar..."
                exit 1
            fi
        else
            echo "Repository git sudah ada."
        fi
        
        # Input URL repository
        read -p "Masukkan URL repository GitHub (https://github.com/username/repo.git): " remoteurl
        
        # Validasi URL remote
        if [ -z "$remoteurl" ]; then
            echo "ERROR: URL remote tidak boleh kosong."
            read -p "Tekan Enter untuk keluar..."
            exit 1
        fi
        
        # Cek apakah remote origin sudah ada
        if git remote get-url origin &> /dev/null; then
            echo "Remote origin sudah ada, menghapus dan menambah ulang..."
            git remote remove origin
        fi
        
        echo "Menambahkan remote origin..."
        git remote add origin "$remoteurl"
        if [ $? -ne 0 ]; then
            echo "ERROR: Gagal menambahkan remote origin"
            read -p "Tekan Enter untuk keluar..."
            exit 1
        fi
        
        echo "Menambahkan semua file..."
        git add .
        
        echo "Melakukan commit awal..."
        git commit -m "Initial commit: Setup Telegraf UI for Frappe"
        if [ $? -ne 0 ]; then
            echo "WARNING: Tidak ada perubahan untuk di-commit atau commit gagal"
        fi
        
        echo "Mengubah branch ke main..."
        git branch -M main
        
        echo "Melakukan push ke GitHub..."
        git push -u origin main
        if [ $? -ne 0 ]; then
            echo "ERROR: Gagal push ke GitHub"
            read -p "Tekan Enter untuk keluar..."
            exit 1
        fi
        
        echo
        echo "SUCCESS: Repository berhasil di-push ke GitHub!"
        ;;
    2)
        echo
        echo "Menjalankan update repository..."
        
        # Cek apakah ada remote origin
        if ! git remote get-url origin &> /dev/null; then
            echo "ERROR: Remote origin belum dikonfigurasi. Gunakan mode 1 terlebih dahulu."
            read -p "Tekan Enter untuk keluar..."
            exit 1
        fi
        
        # Input pesan commit custom
        read -p "Masukkan pesan commit (kosong untuk default): " commitmsg
        if [ -z "$commitmsg" ]; then
            commitmsg="Update: auto commit via upload_github_bash.sh"
        fi
        
        echo "Menambahkan semua perubahan..."
        git add .
        
        echo "Melakukan commit dengan pesan: $commitmsg"
        git commit -m "$commitmsg"
        if [ $? -ne 0 ]; then
            echo "WARNING: Tidak ada perubahan untuk di-commit"
            read -p "Tekan Enter untuk keluar..."
            exit 0
        fi
        
        echo "Melakukan push ke GitHub..."
        git push origin main
        if [ $? -ne 0 ]; then
            echo "ERROR: Gagal push ke GitHub"
            read -p "Tekan Enter untuk keluar..."
            exit 1
        fi
        
        echo
        echo "SUCCESS: Perubahan berhasil di-push ke GitHub!"
        ;;
    3)
        echo "Keluar dari script..."
        exit 0
        ;;
    *)
        echo "ERROR: Pilihan mode tidak valid. Harap pilih 1, 2, atau 3."
        read -p "Tekan Enter untuk keluar..."
        exit 1
        ;;
esac

echo
read -p "Tekan Enter untuk keluar..."
