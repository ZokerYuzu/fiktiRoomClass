import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class ConfirmationButtons extends StatelessWidget {
  final VoidCallback onConfirmIn;
  final VoidCallback onConfirmOut;

  const ConfirmationButtons({
    super.key,
    required this.onConfirmIn,
    required this.onConfirmOut,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Button: Dosen Masuk
        ElevatedButton.icon(
          onPressed: onConfirmIn,
          icon: const Icon(Icons.check, color: Colors.white),
          label: const Text(
            AppStrings.btnDosenMasuk,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.successGreen,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
        ),
        const SizedBox(height: 12),
        
        // Button: Dosen Tidak Masuk
        OutlinedButton.icon(
          onPressed: onConfirmOut,
          icon: const Icon(Icons.close, color: AppColors.errorRed),
          label: const Text(
            AppStrings.btnDosenTidakMasuk,
            style: TextStyle(
              color: AppColors.errorRed,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.errorRed, width: 1.5),
            foregroundColor: AppColors.errorRed,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
