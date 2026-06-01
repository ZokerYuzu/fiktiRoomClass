class AppStrings {
  AppStrings._();

  static const String appName = 'FIKTI Room';
  static const String appSubtitle = 'Sistem Informasi Ruangan FIKTI UMSU';
  
  static const String selectRole = 'Pilih Peran Anda';
  static const String selectRoleDesc = 'Silakan pilih peran untuk masuk ke dashboard';
  
  static const String roleRelator = 'Relator Kelas';
  static const String roleRelatorDesc = 'Dapat mengkonfirmasi kehadiran dosen di ruangan';
  
  static const String roleStudent = 'Mahasiswa';
  static const String roleStudentDesc = 'Hanya dapat melihat status ruangan secara real-time';

  static const String roleBiro = 'Biro Akademik';
  static const String roleBiroDesc = 'Super-administrator untuk mengubah jadwal dan meng-override status ruangan';

  static const String headerRelator = 'RELATOR KELAS';
  static const String headerStudent = 'MAHASISWA';
  static const String headerBiro = 'BIRO AKADEMIK';

  static const String active = 'Aktif';
  static const String waiting = 'Menunggu';
  static const String empty = 'Kosong';
  static const String absent = 'Dosen Tidak Masuk';
  static const String maintenance = 'Perbaikan';
  static const String exam = 'Ujian';

  static const String floor6 = 'Lantai 6';
  static const String floor7 = 'Lantai 7';

  static const String roomDetailTitle = 'Detail Ruangan';
  static const String lecturer = 'Nama Dosen';
  static const String course = 'Mata Kuliah';
  static const String time = 'Waktu';
  static const String status = 'Status';

  static const String btnDosenMasuk = 'Dosen Masuk';
  static const String btnDosenTidakMasuk = 'Dosen Tidak Masuk';

  static const String toastSuccessIn = 'Status diubah: Dosen Masuk';
  static const String toastSuccessOut = 'Status diubah: Dosen Tidak Masuk';
  static const String toastScheduleUpdated = 'Jadwal ruangan berhasil diperbarui';
  static const String toastStatusOverridden = 'Status ruangan berhasil di-override';
}
