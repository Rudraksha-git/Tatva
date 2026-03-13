import 'package:fest_app/config/app_colors.dart';
import 'package:fest_app/config/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final int notificationCount;
  final VoidCallback? onNotificationTap;
  final List<Widget>? extraActions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.notificationCount = 0,
    this.onNotificationTap,
    this.extraActions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = isDark ? AppColors.white : AppColors.darkGrey;

    return AppBar(
      backgroundColor: isDark ? AppColors.darkGrey : AppColors.slate50,
      elevation: 0,
      centerTitle: true,
      leading:
          showBackButton
              ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: iconColor,
                  size: AppSizes.x20,
                ),
                onPressed: () => Get.back(),
              )
              : null,
      title: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: iconColor,
        ),
      ),
      actions: [
        ...?extraActions,
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.notifications_none_rounded,
                color: iconColor,
                size: AppSizes.x28,
              ),
              onPressed: onNotificationTap ?? () {},
            ),
            if (notificationCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.googleRed,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Center(
                    child: Text(
                      notificationCount > 99
                          ? '99+'
                          : notificationCount.toString(),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        height:
                            1, // Centers the text nicely without extra padding
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        ),
        AppSizes.gapW8,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
