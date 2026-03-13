import 'package:flutter/material.dart';
import 'package:fest_app/config/app_colors.dart';
import 'package:fest_app/config/app_sizes.dart';

class EventCard extends StatelessWidget {
  final String eventName;
  final String category;
  final String date;
  final String time;
  final String location;
  final String description;
  final String? imageUrl;
  final VoidCallback? onRegister;
  final bool? isSports;
  final String? limit;

  const EventCard({
    super.key,
    required this.eventName,
    required this.category,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    this.imageUrl,
    this.onRegister,
    this.isSports,
    this.limit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkGrey : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.x20),
        boxShadow: [
          BoxShadow(
            color:
                isDark
                    ? Colors.black.withValues(alpha: 0.5)
                    : AppColors.slate200.withValues(alpha: 0.8),
            blurRadius: AppSizes.x16,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color:
              isDark
                  ? AppColors.slate600.withValues(alpha: 0.3)
                  : AppColors.slate200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSizes.x20),
              topRight: Radius.circular(AppSizes.x20),
            ),
            child: Container(
              height: 180,
              color: isDark ? AppColors.slate600 : AppColors.blue50,
              // Replace Placeholder with CachedNetworkImage or similar if imageUrl is provided
              child:
                  imageUrl != null && imageUrl!.isNotEmpty
                      ? Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                _buildImagePlaceholder(isDark),
                      )
                      : _buildImagePlaceholder(isDark),
            ),
          ),

          // Content Section
          Padding(
            padding: AppSizes.p20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category & Date Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.x12,
                        vertical: AppSizes.x4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.orangeRed.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(AppSizes.x20),
                        border: Border.all(
                          color: AppColors.orangeRed.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        category.toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppColors.orangeRed,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_rounded,
                          size: AppSizes.x16,
                          color: AppColors.primaryBlue,
                        ),
                        AppSizes.gapW8,
                        Text(
                          date,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                AppSizes.gapH4,

                // Event Title
                Text(
                  eventName,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                  ),
                ),
                AppSizes.gapH12,

                // Time & Location Details
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: AppSizes.x18,
                      color: AppColors.slate500,
                    ),
                    AppSizes.gapW8,
                    Text(
                      time,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: AppSizes.x18,
                      color: AppColors.slate500,
                    ),
                    AppSizes.gapW8,
                    Text(
                      location,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
                AppSizes.gapH4,
                if (isSports != null && isSports == true)
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: AppSizes.x18,
                        color: AppColors.slate500,
                      ),
                      AppSizes.gapW8,
                      Text(
                        "Limit: $limit",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.slate500,
                        ),
                      ),
                    ],
                  ),
                // Description Divider
                Divider(
                  color:
                      isDark
                          ? AppColors.slate600.withValues(alpha: 0.3)
                          : AppColors.slate200,
                ),
                AppSizes.gapH4,
                // Description
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.slate400 : AppColors.slate600,
                    height: 1.5,
                  ),
                ),
                AppSizes.gapH16,

                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isSports != null && isSports == true
                              ? AppColors.orangeRed
                              : AppColors.amber300,
                      foregroundColor: AppColors.darkGrey,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.x12,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.x12),
                      ),
                    ),
                    child: Text(
                      'Register Now',
                      style: TextStyle(
                        fontSize: AppSizes.x16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                        color:
                            isSports != null && isSports == true
                                ? AppColors.white
                                : AppColors.darkGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder(bool isDark) {
    return Center(
      child: Icon(
        Icons.gamepad_outlined,
        size: AppSizes.x64,
        color:
            isDark
                ? AppColors.slate500.withValues(alpha: 0.5)
                : AppColors.primaryBlue.withValues(alpha: 0.2),
      ),
    );
  }
}
