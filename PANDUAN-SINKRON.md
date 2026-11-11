# Panduan Sinkronisasi 2 HP (Firebase)

1. https://console.firebase.google.com -> Add project (Google Analytics boleh dimatikan).
2. Build -> Authentication -> Get started -> Sign-in method -> Email/Password -> Enable.
   Tab Users -> Add user -> isi email (boleh fiktif, mis. toko@tokosaya.com) + password. Catat keduanya.
3. Build -> Firestore Database -> Create database -> pilih lokasi (asia-southeast2 Jakarta) -> Production mode.
4. Firestore -> tab Rules -> ganti isinya dengan yang di bawah -> Publish:

rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}

5. Project settings (ikon roda gigi) -> General -> catat "Project ID".
   Di bagian "Your apps" tambahkan app Web (</>) -> salin nilai apiKey (AIzaSy...).
6. HP 1: Pengaturan -> Sinkronisasi -> isi Project ID, API Key, Email, Password, Kode HP = 1 -> Simpan & Hubungkan.
7. HP 2 (APK baru terpasang): isi data yang sama, Kode HP = 2 -> Simpan & Hubungkan.
