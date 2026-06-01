import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_strings.dart';
import '../../data/models/room_model.dart';
import '../../viewmodels/room_viewmodel.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final viewModel = context.read<RoomViewModel>();

    return Scaffold(
      body: Stack(
        children: [
          // Background subtle shapes/colors for premium aesthetics
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryBlue.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondaryBlue.withOpacity(0.05),
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  // Header Brand representation
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.school_outlined,
                      size: 40,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Screen Title
                  Text(
                    AppStrings.selectRole,
                    style: textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Screen Desc
                  Text(
                    AppStrings.selectRoleDesc,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Role Cards Section
                  _RoleCard(
                    title: AppStrings.roleBiro,
                    description: AppStrings.roleBiroDesc,
                    icon: Icons.business_outlined,
                    iconColor: AppColors.biroPurple,
                    onTap: () {
                      viewModel.setSelectedRole(Role.biro);
                      context.go(AppRoutes.dashboard);
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _RoleCard(
                    title: AppStrings.roleRelator,
                    description: AppStrings.roleRelatorDesc,
                    icon: Icons.admin_panel_settings_outlined,
                    iconColor: AppColors.primaryBlue,
                    onTap: () {
                      viewModel.setSelectedRole(Role.relator);
                      context.go(AppRoutes.dashboard);
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _RoleCard(
                    title: AppStrings.roleStudent,
                    description: AppStrings.roleStudentDesc,
                    icon: Icons.person_outline,
                    iconColor: AppColors.secondaryBlue,
                    onTap: () {
                      viewModel.setSelectedRole(Role.mahasiswa);
                      context.go(AppRoutes.dashboard);
                    },
                  ),
                  
                  const Spacer(flex: 2),
                  
                  // Footer branding info
                  Text(
                    'FIKTI UMSU • Development 2025/2026',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.neutralGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.surfaceGray,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Icon Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 28,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 16),
            
            // Middle Content Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            
            // Right Arrow
            const Icon(
              Icons.chevron_right,
              color: AppColors.neutralGray,
            ),
          ],
        ),
      ),
    );
  }
}
