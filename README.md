
# Telegraf UI for Frappe
![CI](https://github.com/kangbobi/telegraf_ui/actions/workflows/ci.yml/badge.svg)

Manajemen konfigurasi Telegraf multi-host melalui antarmuka Frappe + SSH.

## Fitur
- Edit dan deploy `telegraf.conf` via SSH
- Multi-host support
- Dashboard status agent
- Editor berbasis React-style di Desk

## Instalasi

```bash
bench get-app telegraf_ui https://github.com/kangbobi/telegraf_ui.git
bench --site your-site-name install-app telegraf_ui
```

## Konfigurasi
1. Tambahkan DocType `Telegraf Host`
2. Atur koneksi SSH untuk masing-masing host
3. Akses halaman `Telegraf Config Editor` di Desk