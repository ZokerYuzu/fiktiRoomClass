# LAPORAN AKHIR PROJEK PENGEMBANGAN APLIKASI MOBILE
## FIKTI Room — Monitoring Ketersediaan Ruangan FIKTI UMSU

### **Identitas Kelompok**
* **Nama Kelompok**: Mancing Mania
* **Anggota**:
  1. **Yudha Pratama** (NPM: 2309010351)
  2. **M. Fauzan Azhimi** (NPM: 2309010248)
* **Program Studi**: Teknologi Informasi / Ilmu Komputer (FIKTI UMSU)

---

### **1. Ringkasan Projek**
**FIKTI Room** adalah aplikasi mobile berbasis Android/iOS yang dirancang untuk memantau status ketersediaan dan penggunaan ruangan kelas di Lantai 6 & 7 FIKTI UMSU. Aplikasi ini berjalan secara lokal (*localhost*) dan berfungsi memfasilitasi integrasi informasi kehadiran dosen secara cepat guna meminimalkan ketidakpastian jadwal perkuliahan bagi mahasiswa.

---

### **2. Tech Stack & Arsitektur**
* **Framework**: Flutter Stable (Dart)
* **Arsitektur**: MVVM (Model-View-ViewModel)
* **State Management**: Provider
* **Penyimpanan Lokal**: SharedPreferences (untuk persistensi peran pengguna)
* **Navigasi**: GoRouter

---

### **3. Fitur Utama & Keunggulan Sistem**
* **Multi-Role System**:
  * **Biro Akademik (Admin)**: Memiliki kendali penuh untuk meng-override status ruangan dan mengedit jadwal kelas (dosen, matkul, jam) secara real-time.
  * **Relator Kelas**: Melakukan konfirmasi kehadiran dosen ("Dosen Masuk" / "Tidak Masuk") pada sesi yang aktif.
  * **Mahasiswa**: Memantau ruangan secara *read-only* (bebas dari gangguan modifikasi data).
* **Fitur Kreativitas & UI/UX Premium**:
  * **Pulsing Dot Status**: Animasi melingkar berdenyut halus pada dot status ruangan aktif.
  * **Tactile Feedbacks**: Efek kartu sedikit mengecil secara elastis saat ditekan, memberikan sensasi tombol fisik.
  * **Shimmer Skeleton Loading**: Efek memuat kerangka bayangan gradien mengkilap yang modern.
  * **Top Slide-in SnackBar**: Notifikasi berbentuk kapsul melayang yang meluncur di bagian atas layar.

---

### **4. Sumber Daya & Tautan**
* **Repositori GitHub**: [https://github.com/ZokerYuzu/fiktiRoomClass](https://github.com/ZokerYuzu/fiktiRoomClass)
* **Tautan Google Drive (.APK)**: [MASUKKAN_LINK_GDRIVE_APK_DISINI]
* **Tautan Screenshot Aplikasi**: [MASUKKAN_LINK_SS_APK_DISINI]
