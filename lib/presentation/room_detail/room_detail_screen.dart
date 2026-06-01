import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../data/models/room_model.dart';
import '../../viewmodels/room_viewmodel.dart';
import 'widgets/confirmation_buttons.dart';
import 'widgets/status_badge.dart';

class RoomDetailScreen extends StatelessWidget {
  const RoomDetailScreen({super.key});

  Color _getStatusColor(RoomStatus status) {
    switch (status) {
      case RoomStatus.dosenMasuk:
        return AppColors.successGreen;
      case RoomStatus.menunggu:
        return AppColors.warningOrange;
      case RoomStatus.dosenTidakMasuk:
        return AppColors.errorRed;
      case RoomStatus.kosong:
        return AppColors.neutralGray;
      case RoomStatus.perbaikan:
        return AppColors.maintenancePurple;
      case RoomStatus.ujian:
        return AppColors.examTeal;
    }
  }

  void _showNotification(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications_active_outlined, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          left: 16,
          right: 16,
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showEditScheduleDialog(
    BuildContext context,
    RoomModel room,
    RoomViewModel viewModel,
  ) {
    final formKey = GlobalKey<FormState>();
    String lecturer = room.lecturerName ?? '';
    String course = room.courseName ?? '';
    String startTime = room.startTime ?? '';
    String endTime = room.endTime ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            top: 24,
            left: 24,
            right: 24,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Edit Jadwal Kelas',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.biroPurple,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Lecturer
                  TextFormField(
                    initialValue: lecturer,
                    decoration: const InputDecoration(
                      labelText: 'Nama Dosen',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    onChanged: (val) => lecturer = val,
                  ),
                  const SizedBox(height: 16),
                  
                  // Course
                  TextFormField(
                    initialValue: course,
                    decoration: const InputDecoration(
                      labelText: 'Mata Kuliah',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.book_outlined),
                    ),
                    onChanged: (val) => course = val,
                  ),
                  const SizedBox(height: 16),
                  
                  // Time Slots
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: startTime,
                          decoration: const InputDecoration(
                            labelText: 'Mulai (HH:MM)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.access_time),
                          ),
                          onChanged: (val) => startTime = val,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          initialValue: endTime,
                          decoration: const InputDecoration(
                            labelText: 'Selesai (HH:MM)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.access_time),
                          ),
                          onChanged: (val) => endTime = val,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Save Button
                  ElevatedButton(
                    onPressed: () {
                      viewModel.updateRoomSchedule(
                        room.id,
                        lecturerName: lecturer.isEmpty ? null : lecturer,
                        courseName: course.isEmpty ? null : course,
                        startTime: startTime.isEmpty ? null : startTime,
                        endTime: endTime.isEmpty ? null : endTime,
                      );
                      Navigator.pop(context);
                      _showNotification(
                        context,
                        AppStrings.toastScheduleUpdated,
                        AppColors.successGreen,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.biroPurple,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Simpan Perubahan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBiroOverrideGrid(
    BuildContext context,
    RoomModel room,
    RoomViewModel viewModel,
  ) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.8,
      children: [
        _buildOverrideButton(context, room, viewModel, RoomStatus.dosenMasuk, 'DOSEN MASUK', AppColors.successGreen),
        _buildOverrideButton(context, room, viewModel, RoomStatus.menunggu, 'MENUNGGU', AppColors.warningOrange),
        _buildOverrideButton(context, room, viewModel, RoomStatus.dosenTidakMasuk, 'TIDAK MASUK', AppColors.errorRed),
        _buildOverrideButton(context, room, viewModel, RoomStatus.kosong, 'KOSONG', AppColors.neutralGray),
        _buildOverrideButton(context, room, viewModel, RoomStatus.perbaikan, 'PERBAIKAN', AppColors.maintenancePurple),
        _buildOverrideButton(context, room, viewModel, RoomStatus.ujian, 'UJIAN', AppColors.examTeal),
      ],
    );
  }

  Widget _buildOverrideButton(
    BuildContext context,
    RoomModel room,
    RoomViewModel viewModel,
    RoomStatus targetStatus,
    String label,
    Color color,
  ) {
    final isCurrent = room.status == targetStatus;
    
    return InkWell(
      onTap: () {
        if (!isCurrent) {
          viewModel.updateRoomStatus(room.id, targetStatus);
          _showNotification(context, 'Status diubah ke $label', color);
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isCurrent ? color : color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color,
            width: isCurrent ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isCurrent ? Colors.white : color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<RoomViewModel>();
    final room = viewModel.activeRoom;

    // Handle null room safety
    if (room == null) {
      return Scaffold(
        appBar: AppBar(title: const Text(AppStrings.roomDetailTitle)),
        body: const Center(child: Text('Ruangan tidak ditemukan.')),
      );
    }

    final isRelator = viewModel.selectedRole == Role.relator;
    final isBiro = viewModel.selectedRole == Role.biro;
    final statusColor = _getStatusColor(room.status);
    final isKosong = room.status == RoomStatus.kosong || room.status == RoomStatus.perbaikan;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Elegant Sliver App Bar with Dynamic Status Color
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: statusColor,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => context.pop(),
            ),
            actions: isBiro
                ? [
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white24,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit, color: Colors.white),
                      ),
                      tooltip: 'Edit Jadwal',
                      onPressed: () => _showEditScheduleDialog(context, room, viewModel),
                    ),
                  ]
                : null,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Hero(
                tag: 'room_id_text_${room.id}',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    'Ruangan ${room.id}',
                    style: textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        const Shadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [statusColor, statusColor.withOpacity(0.8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.meeting_room,
                    size: 80,
                    color: Colors.white.withOpacity(0.25),
                  ),
                ),
              ),
            ),
          ),

          // Content Details Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Badge Card
                  Center(
                    child: StatusBadge(status: room.status),
                  ),
                  const SizedBox(height: 24),

                  // Detail Cards
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.grey[100]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailItem(
                          context,
                          label: AppStrings.lecturer,
                          value: isKosong ? '-' : (room.lecturerName ?? '-'),
                          icon: Icons.person_outline,
                        ),
                        const Divider(height: 32),
                        _buildDetailItem(
                          context,
                          label: AppStrings.course,
                          value: isKosong ? '-' : (room.courseName ?? 'Tidak ada kelas'),
                          icon: Icons.book_outlined,
                        ),
                        const Divider(height: 32),
                        _buildDetailItem(
                          context,
                          label: AppStrings.time,
                          value: isKosong ? '-' : '${room.startTime} - ${room.endTime} WIB',
                          icon: Icons.access_time_outlined,
                        ),
                        const Divider(height: 32),
                        _buildDetailItem(
                          context,
                          label: 'Lantai',
                          value: 'Lantai ${room.floor}',
                          icon: Icons.layers_outlined,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),

                  // Actions Section (Relator / Biro Override Actions)
                  if (isBiro) ...[
                    Text(
                      'OVERRIDE STATUS RUANGAN (BIRO)',
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildBiroOverrideGrid(context, room, viewModel),
                  ] else if (isRelator && !isKosong) ...[
                    Text(
                      'KONFIRMASI KEHADIRAN DOSEN',
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ConfirmationButtons(
                      onConfirmIn: () {
                        viewModel.updateRoomStatus(room.id, RoomStatus.dosenMasuk);
                        _showNotification(
                          context, 
                          AppStrings.toastSuccessIn, 
                          AppColors.successGreen,
                        );
                        context.pop();
                      },
                      onConfirmOut: () {
                        viewModel.updateRoomStatus(room.id, RoomStatus.dosenTidakMasuk);
                        _showNotification(
                          context, 
                          AppStrings.toastSuccessOut, 
                          AppColors.errorRed,
                        );
                        context.pop();
                      },
                    ),
                  ] else if (isRelator && isKosong) ...[
                    // Empty status helper for Relators
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceGray,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.neutralGray.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: AppColors.neutralGray),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Ruangan ini kosong atau sedang dalam pemeliharaan. Tidak ada kelas yang perlu dikonfirmasi.',
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    // Read-only indicator for Student role
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceGray,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.secondaryBlue.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: AppColors.secondaryBlue),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Anda masuk sebagai Mahasiswa. Halaman ini bersifat Read-Only.',
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.surfaceGray,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryBlue,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
