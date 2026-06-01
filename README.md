# FIKTI Room
Aplikasi Mobile Ketersediaan Ruangan FIKTI UMSU

Aplikasi mobile untuk memantau status dan ketersediaan ruangan kelas di FIKTI UMSU (Lantai 6 dan Lantai 7). Aplikasi ini dibangun menggunakan Flutter dengan arsitektur MVVM (Model-View-ViewModel) dan state management menggunakan Provider.

## Tech Stack
- **Framework**: Flutter Stable
- **Language**: Dart
- **State Management**: Provider
- **Navigation**: GoRouter
- **Persistence**: SharedPreferences (untuk menyimpan peran terpilih secara lokal)
- **Design System**: Google Fonts (Inter) & Material Design 3

## Fitur Utama
1. **Splash Screen**: Branding FIKTI Room dengan animasi fade-in yang halus.
2. **Role Selection (Pilih Peran)**:
   - **Relator Kelas**: Memiliki kontrol penuh untuk memperbarui status kehadiran dosen di ruangan.
   - **Mahasiswa**: Tampilan read-only untuk memantau ketersediaan ruangan secara real-time.
3. **Dashboard Real-Time**:
   - **Statistik Header**: Menampilkan jumlah ruangan dengan status *Aktif* (Dosen Masuk), *Menunggu*, dan *Kosong*.
   - **Tab Lantai**: Peralihan mudah antara Lantai 6 dan Lantai 7.
   - **Pencarian Pintar**: Cari ruangan berdasarkan nomor kelas, nama dosen, atau mata kuliah.
   - **Filter Status (Kreativitas)**: Memfilter ruangan secara instan berdasarkan status (Semua, Dosen Masuk, Menunggu, Tidak Masuk, Kosong).
   - **Reset & Refresh (Kreativitas)**: Menarik ke bawah (pull-to-refresh) atau mengetuk tombol refresh di header untuk menyetel ulang data kembali ke status awal (seed data).
4. **Room Detail (Detail Ruangan)**:
   - Informasi detail tentang dosen, mata kuliah, waktu, dan lantai kelas.
   - Panel konfirmasi kehadiran dosen ("Dosen Masuk" / "Dosen Tidak Masuk") yang hanya tampil untuk Relator Kelas.
   - Notifikasi snackbar/toast adaptif setelah berhasil memperbarui status ruangan.

## Cara Menjalankan
1. Clone repository ini.
2. Jalankan perintah untuk mengunduh package dependencies:
   ```bash
   flutter pub get
   ```
3. Hubungkan perangkat fisik Android/iOS atau jalankan emulator.
4. Jalankan aplikasi:
   ```bash
   flutter run
   ```

## Struktur Folder (Clean MVVM)
```
lib/
├── main.dart                       # Entry point aplikasi
├── app.dart                        # Konfigurasi routing & providers
├── core/
│   ├── constants/
│   │   ├── app_colors.dart         # Color palette dari PRD
│   │   ├── app_strings.dart        # Kumpulan teks/label UI
│   │   └── app_routes.dart         # Route paths navigasi
│   └── theme/
│       └── app_theme.dart          # Tema visual & typography
├── data/
│   ├── models/
│   │   └── room_model.dart         # Model data ruangan dan enum status
│   └── repositories/
│       └── room_repository.dart    # Penyedia data awal (seed data)
├── presentation/
│   ├── splash/
│   │   └── splash_screen.dart      # Splash screen & logika inisialisasi
│   ├── role_selection/
│   │   └── role_selection_screen.dart # Layar pemilihan peran user
│   ├── dashboard/
│   │   ├── dashboard_screen.dart   # Layar dashboard utama
│   │   └── widgets/
│   │       ├── floor_tab.dart      # Tombol pemilih lantai
│   │       ├── room_card.dart      # Kartu informasi ruangan grid
│   │       └── stat_card.dart      # Kartu informasi statistik header
│   └── room_detail/
│       ├── room_detail_screen.dart # Layar informasi detail ruangan
│       └── widgets/
│           ├── status_badge.dart   # Badge indikator status ruangan
│           └── confirmation_buttons.dart # Tombol konfirmasi untuk Relator
└── viewmodels/
    └── room_viewmodel.dart         # State management logika bisnis & filter
```

## Seed Data Distribusi (Data Awal)
| Ruangan | Lantai | Dosen | Mata Kuliah | Waktu | Status Awal |
| :---: | :---: | :---: | :---: | :---: | :---: |
| 601 | 6 | Dosen A | Pemrograman Web | 08:00 - 09:40 | Menunggu |
| 602 | 6 | Dosen B | Basis Data | 08:00 - 09:40 | Menunggu |
| 603 | 6 | Dosen C | Jaringan Komputer | 08:00 - 09:40 | Menunggu |
| 604 | 6 | Dosen D | Kecerdasan Buatan | 08:00 - 09:40 | Menunggu |
| 701 | 7 | Dosen A | Struktur Data | 10:00 - 11:40 | Menunggu |
| 702 | 7 | Dosen B | Sistem Operasi | 10:00 - 11:40 | Menunggu |
| 703 | 7 | - | - | - | Kosong |
| 704 | 7 | - | - | - | Kosong |
| 705 | 7 | Dosen C | Rekayasa Perangkat Lunak | 10:00 - 11:40 | Menunggu |
| 706 | 7 | Dosen D | Keamanan Siber | 10:00 - 11:40 | Menunggu |
| 707 | 7 | - | - | - | Kosong |
| 708 | 7 | - | - | - | Kosong |

## Screenshots
*(Tambahkan screenshot antarmuka aplikasi di sini)*
- Splash Screen
- Pemilihan Peran (Role Selection)
- Dashboard Mahasiswa vs Relator Kelas
- Layar Detail & Form Konfirmasi Kehadiran Dosen
- Notifikasi Sukses Perubahan Status
