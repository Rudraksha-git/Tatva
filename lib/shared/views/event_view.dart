import 'package:fest_app/shared/views/all_anouncement._view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fest_app/config/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/app_sizes.dart';
import '../controllers/event_controller.dart';
import '../widgets/eventCard.dart';
import 'event_detail_view.dart';

class CulturalEventView extends StatelessWidget {
  const CulturalEventView({super.key});

  @override
  Widget build(BuildContext context) {
    final EventController controller = Get.put(EventController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Cultural Events',
        showBackButton: false,
        onNotificationTap: () {
          Get.to(() => AllAnnouncementsView());
        },
        notificationCount: 3,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Location Toggle Switch
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Obx(() {
                  String currentLocation = controller.selectedLocation.value;
                  return Row(
                    children: ['All', 'Bihta', 'Patna'].map((loc) {
                      bool isSelected = currentLocation == loc;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => controller.setLocation(loc),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blue[600] : Colors.transparent,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: isSelected
                                  ? [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                                  : [],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              loc,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey[600],
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
            ),

            // 2. Club Tab Bar (DYNAMIC)
            Container(
              height: 45,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Obx(() {
                String currentClub = controller.selectedClub.value;
                List<String> clubs = controller.dynamicClubs;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: clubs.length,
                  itemBuilder: (context, index) {
                    String club = clubs[index];
                    bool isSelected = currentClub == club;

                    return GestureDetector(
                      onTap: () => controller.setClub(club),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isSelected ? Colors.deepOrange : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          club,
                          style: TextStyle(
                            color: isSelected ? Colors.deepOrange : Colors.grey[500],
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  // Search Bar
                  Expanded(
                    child: TextField(
                      onChanged: (val) => controller.searchQuery.value = val,
                      decoration: InputDecoration(
                        hintText: 'Search events...',
                        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Filter Toggle
                  Obx(() => Row(
                    children: [
                      Switch(
                        value: controller.showOnlyWithRegistration.value,
                        onChanged: (val) => controller.showOnlyWithRegistration.value = val,
                        activeColor: Colors.blue,
                      ),
                      Text(
                        'Reg Open',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),

            // 3. Filtered Events List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final filtered = controller.filteredEvents.where((event) {
                  if (controller.showOnlyWithRegistration.value &&
                      (event.registrationUrl == null || event.registrationUrl!.isEmpty)) {
                    return false;
                  }
                  final query = controller.searchQuery.value.trim().toLowerCase();
                  if (query.isEmpty) return true;
                  final name = (event.event ?? '').toLowerCase();
                  final desc = (event.description ?? '').toLowerCase();
                  final venue = (event.venue ?? '').toLowerCase();
                  final clubName = (event.club ?? '').toLowerCase();
                  return name.contains(query) ||
                      desc.contains(query) ||
                      venue.contains(query) ||
                      clubName.contains(query);
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      "No events match your filters.",
                      style: TextStyle(color: Colors.grey[500], fontSize: 16),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 24),
                  itemBuilder: (context, index) {
                    var event = filtered[index];
                    String displayDate =
                    event.startDate != null ? _formatDate(event.startDate!) : 'TBA';
                    String displayTime = event.schedule?.time ?? event.schedule?.prelims ?? 'TBA';
                    String imgUrl = event.posterUrl ?? _getPlaceholderImage(event.club);

                    return EventCard(
                      eventName: event.event ?? 'Unknown Event',
                      club: event.club ?? 'No Club',
                      date: displayDate,
                      time: displayTime,
                      location: event.venue ?? 'TBA',
                      description: event.description ?? '',
                      registrationUrl: event.registrationUrl,
                      registrationOpen: event.registrationOpen ?? false,
                      imageUrl: imgUrl,
                      onRegister: () => _handleRegistration(event.registrationUrl),
                      onCardTap: () {
                        Get.to(
                              () => CulturalEventDetailView(
                            event: event,
                            imageUrl: imgUrl,
                            displayDate: displayDate,
                            displayTime: displayTime,
                          ),
                        );
                      }, category: '',
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRegistration(String? uri) {
    if (uri == null) {
      Get.snackbar(
        "Registration URL Missing",
        "Sorry, the registration link for this event is currently unavailable.",
        backgroundColor: Colors.red[50],
        colorText: Colors.red[700],
      );
    } else {
      launchUrl(Uri.parse(uri));
    }
  }

  String _formatDate(String rawDate) {
    try {
      DateTime dt = DateTime.parse(rawDate);
      List<String> months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ];
      return "${months[dt.month - 1]} ${dt.day}";
    } catch (e) {
      return rawDate;
    }
  }

  String _getPlaceholderImage(String? club) {
    if (club == null) return 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30';
    String clubName = club.toLowerCase();
    if (clubName.contains('dance')) return 'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad';
    if (clubName.contains('music') || clubName.contains('singing')) {
      return 'https://images.unsplash.com/photo-1516280440502-6c39f0ed26f7';
    }
    if (clubName.contains('drama') || clubName.contains('theatre')) {
      return 'https://images.unsplash.com/photo-1507676184212-d0330a15183e';
    }
    if (clubName.contains('art') || clubName.contains('design') || clubName.contains('photo')) {
      return 'https://images.unsplash.com/photo-1513364776144-60967b0f800f';
    }
    return 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30';
  }
}

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
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: true,
      leading: showBackButton
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
                      notificationCount > 99 ? '99+' : notificationCount.toString(),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        height: 1,
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