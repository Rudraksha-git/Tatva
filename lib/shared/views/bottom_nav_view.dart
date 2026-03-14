import 'package:fest_app/shared/views/event_view.dart';
import 'package:fest_app/shared/views/sports_event_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_sizes.dart';
import '../../config/app_colors.dart';
import '../controllers/bottom_nav_controller.dart';
import '../../student/views/profile_view.dart';
import 'home_view.dart';

class BottomNavView extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    // Basic screens to verify routing - these should be replaced with actual view widgets
    final List<Widget> screens = [
     HomeView(),// Replace with HomeView
      const CulturalEventView(), // Cultural Events
       SportsEventView(), // Sports Events (You can pass a parameter to filter if your EventView supports it)
      const ProfileView(),
    ];

    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        physics: const ClampingScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return Obx(
      () => SafeArea(
        child: Container(
          width: Get.width * 0.9,
          margin: const EdgeInsets.only(
            left: AppSizes.x16,
            right: AppSizes.x16,
            bottom: AppSizes.x16,
          ), // Adds margin around the nav bar
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppSizes.x24,
            ), // Circular on all corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              AppSizes.x24,
            ), // Circular on all corners
            child: BottomNavigationBar(
              currentIndex: controller.selectedIndex,
              onTap: controller.changeIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(Get.context!).colorScheme.surface,
              selectedItemColor: AppColors.orangeRed,
              unselectedItemColor: Colors.grey.shade500,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              items: [
                _navItem(Icons.home_rounded, 'HOME', 0),
                _navItem(Icons.theater_comedy_outlined, 'CULTURAL', 1),
                _navItem(Icons.sports_soccer_rounded, 'SPORTS', 2),
                _navItem(Icons.person_outline_rounded, 'PROFILE', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem(IconData icon, String label, int index) {
    // final bool isSelected = controller.selectedIndex == index;
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        // decoration: BoxDecoration(
        //   color:
        //       isSelected
        //           ? AppColors.orangeRed.withValues(alpha: 0.1)
        //           : Colors.transparent,
        //   borderRadius: BorderRadius.circular(12),
        // ),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}
