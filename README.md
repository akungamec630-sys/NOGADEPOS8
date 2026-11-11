# POS Toko – paket build

## Perubahan pada HTML (www/index.html)
- Daftar hasil pencarian produk: baris yang AKAN di-input (dipilih panah/Enter) berwarna solid teal + garis kuning di kiri;
  baris yang hanya dilewati kursor mouse berwarna tint lembut. Light & dark mode.
- Penyesuaian layar HP (safe-area, padding). Ekspor CSV/backup memakai Simpan/Bagikan saat berjalan di APK.

## Fitur khusus APK
- Tombol Enter/=> di keyboard HP: ada tombol "✓ Masuk" di samping Qty sebagai cadangan.
- Ikon ⌨️ / 📷 di Kasir untuk memilih ketik atau scan barcode dengan kamera (ML Kit, modul Google diunduh sekali).
- Printer struk: Bluetooth HP lewat aplikasi RawBT (pasangkan printer di Bluetooth HP & di RawBT).

## Perubahan terbaru
- **Perbaikan barcode "tidak dikenal"**: pencarian/scan barcode di Kasir sekarang toleran terhadap spasi/karakter tersembunyi, huruf besar-kecil, barcode tersimpan sebagai angka (bukan teks), nol di depan (UPC-A 12 digit = EAN-13 dengan 0 di depan), apostrof Excel, dan akhiran ".0". Data produk dinormalisasi otomatis saat aplikasi dibuka dan setelah Pulihkan backup / Impor CSV. Barcode/kode yang disimpan lewat Ubah barang juga dibersihkan, dan cek duplikat tidak lagi peka huruf besar-kecil/spasi.
- **Detail transaksi (khusus Owner)**: di Riwayat, klik baris transaksi untuk melihat daftar produk yang terjual (qty, harga, diskon, subtotal, total, bayar, kembali) + tombol Cetak. Di mode Kasir, klik baris tidak melakukan apa-apa.
- **Hapus barang khusus Owner**: di menu Barang, mode Kasir hanya punya tombol Ubah; tombol Hapus hanya muncul di mode Owner.
- **Scan kamera di form barang**: kolom Barcode di Barang → + Barang / Ubah punya tombol 📷. Di APK, kamera otomatis terbuka saat menambah barang baru
  dan angka barcode terbaca langsung masuk ke kolom. (Matikan buka-otomatis dengan `AUTO_SCAN_NEW=false` di `www/index.html`; tombol 📷 tetap ada.)
  Jika barcode sudah dipakai barang lain, muncul peringatan.
- **PPN dihapus**: baris PPN di Kasir, pengaturan PPN (%), serta baris PPN di struk (browser & ESC/POS) sudah dihilangkan. Total = subtotal - diskon.
- **Centang "Cetak struk setelah bayar"** di Kasir (di atas tombol BAYAR). Pilihan diingat antar sesi. Cetak ulang dari Riwayat tetap berfungsi.

## APK (tanpa Android Studio)
1. Upload folder ini ke repo GitHub.
2. Tab Actions → "Build APK" → Run workflow.
3. Unduh `POS-Toko-apk` → `app-debug.apk`, instal di HP.
Lokal: `npm install && npx cap add android && npx cap sync android && cd android && ./gradlew assembleDebug`

## Desktop
- Nativefier (butuh URL hosting): `nativefier/build.bat https://domain-anda/index.html`
- Offline penuh (tanpa hosting): `cd electron-offline && npm install && npm run dist`

## Catatan
- Data tersimpan di IndexedDB per aplikasi: data di APK/desktop TIDAK sama dengan data di browser. Pindahkan via backup/restore.
- Web Serial/WebUSB (scanner serial, printer ESC/POS) tidak tersedia di Android WebView dan di Nativefier.
  Scanner mode keyboard tetap jalan. Cetak struk di desktop: pakai mode "driver Windows".

## Perbaikan bug "registerPlugin is not a function"
- `@capacitor/core` tidak ikut dimuat di halaman web, sehingga `Capacitor.registerPlugin` tidak ada.
- `www/index.html` sekarang memakai `Capacitor.nativePromise` (disediakan native-bridge) lewat fungsi `plug()`.
  `nativeSave()` (backup/ekspor) juga memakai `plug()`. Berlaku untuk RawBT, Filesystem, Share, dan scanner.
- Nama file konfigurasi harus `capacitor.config.json` (titik, bukan garis bawah).

## Lisensi / aktivasi (Mode Owner & Pengaturan)
- Mode Owner (otomatis juga Pengaturan/Laporan) terkunci sampai pembeli memasukkan **Key Registrasi**. Dialog aktivasi menampilkan **Kode Perangkat** (8 karakter, acak, dibuat saat aplikasi pertama dibuka) dan kontak penjual 085252371110 (tombol WhatsApp/Telepon).
- Key dibuat dengan **POS-Keygen** (`keygen.html`, tanda tangan digital Ed25519). Aplikasi hanya memuat kunci PUBLIK (konstanta `PUB` di `www/index.html`), jadi key tidak bisa dipalsukan dari isi APK. Key hanya cocok dengan satu Kode Perangkat dan cukup dimasukkan sekali.
- Menghapus data aplikasi / instal ulang / ganti HP menghasilkan Kode Perangkat baru, sehingga perlu key baru.
- Folder POS-Keygen (berisi `private.key`) JANGAN diunggah ke GitHub. Tidak perlu secret GitHub atau pengaturan build tambahan.
- `LIC_STRICT=true` di `www/index.html` mengunci seluruh aplikasi (bukan hanya Owner) sampai diaktifkan.
