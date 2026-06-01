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

### 1. Sistem Multi-Peran (Multi-Role Support)
- 🏢 **Biro Akademik (Super-Administrator)**: Memiliki wewenang tertinggi untuk meng-override status ruangan apapun serta mengedit data jadwal perkuliahan (Nama Dosen, Mata Kuliah, Jam Mulai/Selesai) secara real-time dari aplikasi.
- 🎓 **Relator Kelas**: Memiliki kontrol untuk mengonfirmasi kehadiran dosen di ruangan kelas yang aktif pada hari itu.
- 👁️ **Mahasiswa**: Peran bersifat *read-only* untuk memantau ketersediaan ruangan secara real-time.

### 2. Status Ruangan Komprehensif
- 🟢 **Dosen Masuk** (Aktif)
- 🟡 **Menunggu** (Menanti Konfirmasi)
- 🔴 **Dosen Tidak Masuk** (Absen)
- ⚫ **Kosong** (Tidak ada perkuliahan)
- 🟣 **Perbaikan** (Dalam Pemeliharaan / Maintenance Mode) - *Eksklusif Biro*
- 🔵 **Ujian** (Dipakai Ujian / Exam Mode) - *Eksklusif Biro*

### 3. Dashboard Real-Time
- **Statistik Header**: Menampilkan jumlah ruangan dengan status *Aktif*, *Menunggu*, dan *Kosong*.
- **Tab Lantai**: Peralihan mudah antara Lantai 6 dan Lantai 7.
- **Pencarian Pintar**: Cari ruangan berdasarkan nomor kelas, nama dosen, atau mata kuliah.
- **Filter Status (Kreativitas)**: Memfilter ruangan secara instan berdasarkan status (Semua, Dosen Masuk, Menunggu, Tidak Masuk, Kosong, Perbaikan, Ujian).
- **Reset & Refresh (Kreativitas)**: Menarik ke bawah (pull-to-refresh) atau mengetuk tombol refresh di header untuk menyetel ulang data kembali ke status awal (seed data).

### 4. Animasi & Desain UI/UX Premium (Penyempurnaan Visual)
- **Animasi Berdenyut (*Pulsing Dot Indicator*)**: Dot warna di pojok kanan atas kartu berdenyut lembut untuk menunjukkan status kelas aktif secara berkala.
- **Umpan Balik Taktil (*Tactile Scale Feedbacks*)**: Efek kartu sedikit mengecil secara elastis (scale `0.95`) saat ditekan untuk mensimulasikan tombol nyata.
- **Kerangka Memuat Data (*Shimmer Skeleton Loading*)**: Animasi gradien menyapu saat memuat data, memberikan *perceived performance* yang lebih baik daripada spinner tradisional.
- **Notifikasi Slide-in Atas (*Top Slide-in SnackBar*)**: Pemberitahuan melayang di atas layar (kapsul melengkung) saat Relator atau Biro melakukan pembaruan status.
- **Transisi Hero Mulus (*Hero Transitions*)**: Perpindahan visual teks nomor ruangan dari Dashboard ke judul Detail Ruangan yang mengalir lancar.

---

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

---

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
│   │       ├── stat_card.dart      # Kartu informasi statistik header
│   │       ├── pulsing_dot.dart    # Indikator status berdenyut
│   │       ├── tactile_pressable.dart # Efek elastis saat menekan kartu
│   │       └── shimmer_loading.dart # Animasi loading skeleton
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
- Splash Screen (Animasi fade-in logo FIKTI UMSU)
- Layar Pemilihan Peran (Biro Akademik, Relator Kelas, Mahasiswa)
- Dashboard Utama (Statistik real-time, filter status chip, pencarian text-field)
- Layar Detail Ruangan & Panel Aksi (Override Status Biro, Form Edit Jadwal, Banner Read-only Mahasiswa)
- Top Slide-in Toast Notification
