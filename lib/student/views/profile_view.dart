import 'package:fest_app/config/app_colors.dart';
import 'package:fest_app/config/app_sizes.dart';
import 'package:fest_app/shared/widgets/custom_app_bar.dart';
import 'package:fest_app/shared/widgets/animated_theme_toggle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
        showBackButton: false,
        extraActions: [AnimatedThemeToggle(), SizedBox(width: AppSizes.x12)],
      ),
      body: SingleChildScrollView(
        padding: AppSizes.p20,
        child: Column(
          children: [
            // 1. Profile Header
            _buildProfileHeader(theme, isDark),
            AppSizes.gapH32,

            // 2. Stats Section
            _buildStatsSection(isDark, theme),
            AppSizes.gapH32,

            // 3. Registered Events Section
            _buildRegisteredEventsSection(theme, isDark),
            AppSizes.gapH16,

            // 4. Account Management Section
            _buildAccountManagement(theme, isDark),
            AppSizes.gapH24,
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme, bool isDark) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(
            AppSizes.x4,
          ), // Adds a gap to create the ring effect
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryBlue,
              width: AppSizes.x4,
            ),
          ),
          child: const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80',
            ),
          ),
        ),
        AppSizes.gapH16,
        Text(
          'Gaurav',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSizes.gapH4,
        Text(
          'Electronics Engineering',
          style: theme.textTheme.titleMedium?.copyWith(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
        AppSizes.gapH4,
        Text(
          '3rd Year • NIT Patna',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.slate500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(bool isDark, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatCard('12', 'Events', AppColors.primaryBlue, isDark, theme),
        _buildStatCard('05', 'Badges', AppColors.gold, isDark, theme),
        _buildStatCard('02', 'Awards', AppColors.googleRed, isDark, theme),
      ],
    );
  }

  Widget _buildStatCard(
    String count,
    String label,
    Color textColor,
    bool isDark,
    ThemeData theme,
  ) {
    return Container(
      width: Get.width * 0.25,
      padding: const EdgeInsets.symmetric(vertical: AppSizes.x16),
      decoration: BoxDecoration(
        color:
            isDark
                ? textColor.withValues(alpha: 0.1)
                : textColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSizes.x16),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisteredEventsSection(ThemeData theme, bool isDark) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Registered Events',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to all events
              },
              child: Text(
                'View All',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        AppSizes.gapH4,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          separatorBuilder: (context, index) => AppSizes.gapH8,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildEventChip(
                title: 'Hackathon 2026',
                date: 'Mar 16',
                time: '10:00 AM',
                imageUrl:
                    'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80',
                isDark: isDark,
                theme: theme,
              );
            } else {
              return _buildEventChip(
                title: 'Robotics Workshop',
                date: 'Mar 18',
                time: '2:00 PM',
                imageUrl:
                    'https://images.unsplash.com/photo-1561557944-6e7860d1a7eb?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80',
                isDark: isDark,
                theme: theme,
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildEventChip({
    required String title,
    required String date,
    required String time,
    required String imageUrl,
    required bool isDark,
    required ThemeData theme,
  }) {
    // Determine the width of the chip so it looks good in a scroll view
    // (making it slightly less than the screen width to indicate it's scrollable)
    double chipWidth = Get.width * 0.75;

    return Container(
      width: chipWidth,
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.x12,
        horizontal: AppSizes.x12,
      ),
      decoration: BoxDecoration(
        color:
            isDark
                ? AppColors.slate600.withValues(alpha: 0.3)
                : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.x16),
        border: Border.all(
          color: isDark ? Colors.transparent : AppColors.slate200,
        ),
        boxShadow:
            isDark
                ? []
                : [
                  BoxShadow(
                    color: AppColors.slate200.withValues(alpha: 0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppSizes.x16,
            backgroundImage: NetworkImage(imageUrl),
          ),
          AppSizes.gapW12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '$date • $time',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: isDark ? AppColors.slate400 : AppColors.slate400,
            size: AppSizes.x20,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountManagement(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSizes.gapH16,
        Container(
          decoration: BoxDecoration(
            color:
                isDark
                    ? AppColors.slate600.withValues(alpha: 0.2)
                    : AppColors.slate200.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSizes.x16),
            border: Border.all(
              color:
                  isDark
                      ? AppColors.slate600.withValues(alpha: 0.4)
                      : AppColors.slate200,
            ),
          ),
          child: Column(
            children: [
              _buildAccountTile(
                Icons.confirmation_num_outlined,
                'My Tickets',
                isDark,
                theme,
              ),
              _buildDivider(isDark),
              _buildAccountTile(
                Icons.person_outline_rounded,
                'Edit Profile',
                isDark,
                theme,
              ),
              _buildDivider(isDark),
              _buildAccountTile(
                Icons.settings_outlined,
                'Settings',
                isDark,
                theme,
              ),
              _buildDivider(isDark),
              _buildAccountTile(
                Icons.notifications_outlined,
                'Notifications',
                isDark,
                theme,
              ),
              _buildDivider(isDark),
              _buildAccountTile(
                Icons.logout_rounded,
                'Logout',
                isDark,
                theme,
                isDestructive: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountTile(
    IconData icon,
    String title,
    bool isDark,
    ThemeData theme, {
    bool isDestructive = false,
  }) {
    final color =
        isDestructive
            ? AppColors.googleRed
            : (isDark ? AppColors.slate200 : AppColors.darkGrey);
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing:
          isDestructive
              ? null
              : Icon(
                Icons.chevron_right_rounded,
                color: isDark ? AppColors.slate400 : AppColors.slate400,
              ),
      onTap: () {
        // Handle tile tap
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.x16),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.x16),
      child: Divider(
        color:
            isDark
                ? AppColors.slate600.withValues(alpha: 0.3)
                : AppColors.slate200,
        height: 1,
      ),
    );
  }
}
