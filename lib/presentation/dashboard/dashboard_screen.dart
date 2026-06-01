import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_strings.dart';
import '../../data/models/room_model.dart';
import '../../viewmodels/room_viewmodel.dart';
import 'widgets/floor_tab.dart';
import 'widgets/room_card.dart';
import 'widgets/stat_card.dart';
import 'widgets/shimmer_loading.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<RoomViewModel>();
    final isRelator = viewModel.selectedRole == Role.relator;
    final isBiro = viewModel.selectedRole == Role.biro;

    // Define colors & icons dynamically based on selected role
    final List<Color> gradientColors = isBiro
        ? [
            const Color(0xff2A0E2D),
            AppColors.biroPurple,
            const Color(0xff6F2672),
          ]
        : [
            const Color(0xff122E58),
            AppColors.primaryBlue,
            const Color(0xff25589E),
          ];

    final Color shadowColor = isBiro ? AppColors.biroPurple : AppColors.primaryBlue;
    
    final IconData roleIcon = isBiro
        ? Icons.business_outlined
        : (isRelator ? Icons.admin_panel_settings_outlined : Icons.person_outline);
        
    final String roleText = isBiro
        ? AppStrings.headerBiro
        : (isRelator ? AppStrings.headerRelator : AppStrings.headerStudent);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header Section with Premium Gradient and Graphic Shapes
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 24, left: 20, right: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Decorative Circle 1
                Positioned(
                  top: -80,
                  right: -40,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.04),
                    ),
                  ),
                ),
                // Decorative Circle 2
                Positioned(
                  bottom: -60,
                  left: -20,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.03),
                    ),
                  ),
                ),
                
                // Actual Header content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FIKTI UMSU',
                              style: textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Role tag badge with soft blur-like border
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.18),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    roleIcon,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    roleText,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        // Switch role and reset database action buttons
                        Row(
                          children: [
                            // Reset button
                            IconButton(
                              icon: const Icon(Icons.refresh, color: Colors.white70),
                              tooltip: 'Reset Data',
                              onPressed: () {
                                viewModel.resetData();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Data ruangan di-reset ke status awal'),
                                    backgroundColor: AppColors.primaryBlue,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                            // Exit/Logout button
                            IconButton(
                              icon: const Icon(Icons.logout, color: Colors.white70),
                              tooltip: 'Ubah Peran',
                              onPressed: () {
                                viewModel.clearSelectedRole();
                                context.go(AppRoutes.roleSelection);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Statistics Row
                    Row(
                      children: [
                        StatCard(
                          label: AppStrings.active,
                          count: viewModel.countActive,
                          borderColor: AppColors.successGreen,
                          backgroundColor: AppColors.successGreen.withOpacity(0.1),
                        ),
                        const SizedBox(width: 12),
                        StatCard(
                          label: AppStrings.waiting,
                          count: viewModel.countWaiting,
                          borderColor: AppColors.warningOrange,
                          backgroundColor: AppColors.warningOrange.withOpacity(0.1),
                        ),
                        const SizedBox(width: 12),
                        StatCard(
                          label: AppStrings.empty,
                          count: viewModel.countEmpty,
                          borderColor: AppColors.neutralGray,
                          backgroundColor: AppColors.neutralGray.withOpacity(0.1),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Main Body
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                viewModel.resetData();
              },
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                children: [
                  // Search Bar with soft shadows
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: viewModel.setSearchQuery,
                      decoration: InputDecoration(
                        hintText: 'Cari ruangan, dosen, atau mata kuliah...',
                        hintStyle: textTheme.bodyMedium?.copyWith(
                          color: AppColors.neutralGray,
                        ),
                        prefixIcon: const Icon(Icons.search, color: AppColors.neutralGray),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, color: AppColors.neutralGray),
                                onPressed: () {
                                  _searchController.clear();
                                  viewModel.setSearchQuery('');
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.secondaryBlue, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Status Filter Chips (Creativity feature)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _FilterChip(
                          label: 'Semua',
                          isSelected: viewModel.statusFilter == null,
                          onSelected: () => viewModel.setStatusFilter(null),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Dosen Masuk',
                          isSelected: viewModel.statusFilter == RoomStatus.dosenMasuk,
                          onSelected: () => viewModel.setStatusFilter(RoomStatus.dosenMasuk),
                          color: AppColors.successGreen,
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Menunggu',
                          isSelected: viewModel.statusFilter == RoomStatus.menunggu,
                          onSelected: () => viewModel.setStatusFilter(RoomStatus.menunggu),
                          color: AppColors.warningOrange,
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Tidak Masuk',
                          isSelected: viewModel.statusFilter == RoomStatus.dosenTidakMasuk,
                          onSelected: () => viewModel.setStatusFilter(RoomStatus.dosenTidakMasuk),
                          color: AppColors.errorRed,
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Kosong',
                          isSelected: viewModel.statusFilter == RoomStatus.kosong,
                          onSelected: () => viewModel.setStatusFilter(RoomStatus.kosong),
                          color: AppColors.neutralGray,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Floor Switcher Tab
                  FloorTab(
                    activeFloor: viewModel.selectedFloor,
                    onFloorChanged: viewModel.setSelectedFloor,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Room Grid or Shimmer skeleton loader
                  viewModel.isLoading
                      ? const ShimmerLoading()
                      : viewModel.filteredRooms.isEmpty
                          ? _buildEmptyState(textTheme)
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.95,
                              ),
                              itemCount: viewModel.filteredRooms.length,
                              itemBuilder: (context, index) {
                                final room = viewModel.filteredRooms[index];
                                return RoomCard(
                                  room: room,
                                  onTap: () {
                                    viewModel.setActiveRoom(room);
                                    context.push(AppRoutes.roomDetail);
                                  },
                                );
                              },
                            ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_outlined,
            size: 64,
            color: AppColors.neutralGray.withOpacity(0.6),
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak Ada Ruangan',
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coba sesuaikan pencarian atau filter status Anda.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;
  final Color? color;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? AppColors.primaryBlue;

    return GestureDetector(
      onTap: onSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withOpacity(0.12) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? activeColor : Colors.grey[200]!,
            width: 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: activeColor.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            if (color != null) ...[
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? activeColor : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
