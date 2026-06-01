import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/room_model.dart';
import 'pulsing_dot.dart';
import 'tactile_pressable.dart';

class RoomCard extends StatelessWidget {
  final RoomModel room;
  final VoidCallback onTap;

  const RoomCard({
    super.key,
    required this.room,
    required this.onTap,
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
        return 'TIDAK MASUK';
      case RoomStatus.kosong:
        return 'KOSONG';
      case RoomStatus.perbaikan:
        return 'PERBAIKAN';
      case RoomStatus.ujian:
        return 'UJIAN';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final statusColor = _getStatusColor(room.status);
    final isKosong = room.status == RoomStatus.kosong || room.status == RoomStatus.perbaikan;

    return TactilePressable(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              // Room Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Room ID Hero Transition (H2 typography style: 20sp Bold)
                  Hero(
                    tag: 'room_id_text_${room.id}',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'Ruangan ${room.id}',
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Lecturer Name
                  Text(
                    isKosong ? '-' : (room.lecturerName ?? '-'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isKosong ? AppColors.neutralGray : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  
                  // Course name
                  Text(
                    isKosong ? '-' : (room.courseName ?? 'Tidak ada kelas'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  
                  // Time & Status Badge
                  Row(
                    children: [
                      // Time Info
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 12,
                              color: isKosong ? AppColors.neutralGray : AppColors.secondaryBlue,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                isKosong ? '--:--' : '${room.startTime} - ${room.endTime}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodySmall?.copyWith(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Status Badge (Pill shape)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: statusColor.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          _getStatusText(room.status),
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              // Top-right indicator
              Positioned(
                top: 4,
                right: 4,
                child: isKosong
                    ? Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      )
                    : PulsingDot(
                        color: statusColor,
                        size: 9,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
