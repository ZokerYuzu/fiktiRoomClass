import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/room_model.dart';

class StatusBadge extends StatelessWidget {
  final RoomStatus status;

  const StatusBadge({
    super.key,
    required this.status,
  });

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

  String _getStatusText(RoomStatus status) {
    switch (status) {
      case RoomStatus.dosenMasuk:
        return 'DOSEN MASUK';
      case RoomStatus.menunggu:
        return 'MENUNGGU';
      case RoomStatus.dosenTidakMasuk:
        return 'DOSEN TIDAK MASUK';
      case RoomStatus.kosong:
        return 'RUANGAN KOSONG';
      case RoomStatus.perbaikan:
        return 'DALAM PERBAIKAN';
      case RoomStatus.ujian:
        return 'DIPAKAI UJIAN';
    }
  }

  IconData _getStatusIcon(RoomStatus status) {
    switch (status) {
      case RoomStatus.dosenMasuk:
        return Icons.check_circle_outline;
      case RoomStatus.menunggu:
        return Icons.hourglass_empty_outlined;
      case RoomStatus.dosenTidakMasuk:
        return Icons.cancel_outlined;
      case RoomStatus.kosong:
        return Icons.meeting_room_outlined;
      case RoomStatus.perbaikan:
        return Icons.build_outlined;
      case RoomStatus.ujian:
        return Icons.assignment_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = _getStatusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getStatusIcon(status),
            color: color,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            _getStatusText(status),
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
