import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fest_app/config/app_colors.dart';

import '../../config/app_sizes.dart';
import '../controllers/event_controller.dart';
import '../widgets/eventCard.dart';
import 'event_detail_view.dart';




class CulturalEventView extends StatelessWidget {
  const CulturalEventView({super.key});

  @override
  Widget build(BuildContext context) {
    final EventController controller = Get.put(EventController());
    final List<String> categories = ['All Events', 'Music', 'Dance', 'Drama', 'Fashion', 'Art', 'Photography'];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
        title: 'Cultural Events',
        showBackButton: false,
        notificationCount: 3,
    ),
    body: Column(
    children: [
    // 1. Location Toggle Switch
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    child: Container(
    height: 44,
    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(22)),
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
    boxShadow: isSelected ? [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 4, offset: const Offset(0, 2))] : [],
    ),
    alignment: Alignment.center,
    child: Text(
    loc,
    style: TextStyle(color: isSelected ? Colors.white : Colors.grey[600], fontWeight: isSelected ? FontWeight.bold : FontWeight.w600, fontSize: 14),
    ),
    ),
    ),
    );
    }).toList()
    );
  }),
  ),
  ),

  // 2. Category Tab Bar
  Container(
  height: 45,
  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
  child: Obx(() {
  String currentCategory = controller.selectedCategory.value;
  return ListView.builder(
  scrollDirection: Axis.horizontal,
  padding: const EdgeInsets.symmetric(horizontal: 10),
  itemCount: categories.length,
  itemBuilder: (context, index) {
  String cat = categories[index];
  bool isSelected = currentCategory == cat;
  return GestureDetector(
  onTap: () => controller.setCategory(cat),
  child: Container(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  margin: const EdgeInsets.symmetric(horizontal: 4),
  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isSelected ? Colors.deepOrange : Colors.transparent, width: 3))),
  alignment: Alignment.center,
  child: Text(cat, style: TextStyle(color: isSelected ? Colors.deepOrange : Colors.grey[500], fontWeight: isSelected ? FontWeight.bold : FontWeight.w600, fontSize: 14)),
  ),
  );
  },
  );
  }),
  ),

  // 3. Filtered Events List
  Expanded(
  child: Obx(() {
  if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
  if (controller.filteredEvents.isEmpty) return Center(child: Text("No events match your filters.", style: TextStyle(color: Colors.grey[500], fontSize: 16)));

  return ListView.separated(
  padding: const EdgeInsets.all(20),
  itemCount: controller.filteredEvents.length,
  separatorBuilder: (_, __) => const SizedBox(height: 24),
  itemBuilder: (context, index) {
  var event = controller.filteredEvents[index];
  String displayDate = event.startDate != null ? _formatDate(event.startDate!) : 'TBA';
  String displayTime = event.schedule?.time ?? event.schedule?.prelims ?? 'TBA';
  String imgUrl = _getPlaceholderImage(event.category);

  return EventCard(
  eventName: event.event ?? 'Unknown Event',
  category: event.category ?? 'Uncategorized',
  date: displayDate,
  time: displayTime,
  location: event.venue ?? 'TBA',
  description: event.description ?? '',
  imageUrl: imgUrl,
  isRegistrationOpen: event.registrationOpen ?? false,
  onRegister: () => _handleRegistration(event.event),
  onCardTap: () {
  Get.to(() => CulturalEventDetailView(
  event: event,
  imageUrl: imgUrl,
  displayDate: displayDate,
  displayTime: displayTime,
  ));
  },
  );
  },
  );
  }),
  ),
  ],
  ),
  );
}

void _handleRegistration(String? eventName) {
  Get.snackbar('Registration Started', 'You are registering for $eventName', snackPosition: SnackPosition.BOTTOM, backgroundColor: AppColors.primaryBlue ?? Colors.blue, colorText: Colors.white, margin: const EdgeInsets.all(16));
}

String _formatDate(String rawDate) {
  try {
    DateTime dt = DateTime.parse(rawDate);
    List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return "${months[dt.month - 1]} ${dt.day}";
  } catch (e) {
    return rawDate;
  }
}

String _getPlaceholderImage(String? category) {
  if (category == null) return 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30';
  String cat = category.toLowerCase();
  if (cat.contains('dance')) return 'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad';
  if (cat.contains('music') || cat.contains('singing')) return 'https://images.unsplash.com/photo-1516280440502-6c39f0ed26f7';
  if (cat.contains('drama') || cat.contains('theatre')) return 'https://images.unsplash.com/photo-1507676184212-d0330a15183e';
  if (cat.contains('art') || cat.contains('design') || cat.contains('photo')) return 'https://images.unsplash.com/photo-1513364776144-60967b0f800f';
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