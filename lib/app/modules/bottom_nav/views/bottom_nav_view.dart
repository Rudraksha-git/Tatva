import 'package:fest_app/shared/views/event_view.dart';
import 'package:fest_app/shared/views/sports_event_view.dart';
import 'package:fest_app/shared/views/timeline.dart' hide AppColors;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_sizes.dart';
import '../../config/app_colors.dart';
import '../controllers/bottom_nav_controller.dart';
import 'home_view.dart';
import 'live_event.dart';

class BottomNavView extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    // Basic screens to verify routing - these should be replaced with actual view widgets
    final List<Widget> screens = [
     HomeView(),// Replace with HomeView
      const CulturalEventView(), // Cultural Events
      const LiveEventsView(),
       SportsEventView(), // Sports Events (You can pass a parameter to filter if your EventView supports it)
      TimelineScreen(), // Replace with TimelineView 
    ];

    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        physics: const BouncingScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return Obx(() {
      int currentIndex = controller.selectedIndex;

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.x16,
            right: AppSizes.x16,
            bottom: AppSizes.x16,
          ),
          child: SizedBox(
            height: 90,
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none, // Allows the ripple animation to expand smoothly
              children: [
                // 1. The Main Navigation Bar Box
                Container(
                  width: Get.width * 0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.x24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.x24),
                    child: BottomNavigationBar(
                      currentIndex: currentIndex,
                      onTap: controller.changeIndex,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Theme.of(Get.context!).colorScheme.surface,
                      selectedItemColor: AppColors.orangeRed,
                      unselectedItemColor: Colors.grey.shade400,
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                      selectedFontSize: 10,
                      unselectedFontSize: 10,
                      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, height: 1.5),
                      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, height: 1.5),
                      elevation: 0,
                      items: [
                        _navItem(Icons.home_rounded, 'HOME', 0, currentIndex),
                        _navItem(Icons.theater_comedy_outlined, 'CULTURAL', 1, currentIndex),
                        // INVISIBLE PLACEHOLDER
                        const BottomNavigationBarItem(
                          icon: SizedBox(height: 28),
                          label: '',
                        ),
                        _navItem(Icons.sports_soccer_rounded, 'SPORTS', 3, currentIndex),
                        _navItem(Icons.timeline_rounded, 'TIMELINE', 4, currentIndex),
                      ],
                    ),
                  ),
                ),

                // 2. The Custom ANIMATED "LIVE" Button
                Positioned(
                  top: -8, // Shifted up slightly to center the ripples visually
                  child: PulsingLiveNavButton(
                    isSelected: currentIndex == 2,
                    onTap: () => controller.changeIndex(2),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Updated Nav Item with Animated Background Pill
  BottomNavigationBarItem _navItem(IconData icon, String label, int index, int selectedIndex) {
    final bool isSelected = selectedIndex == index;

    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.orangeRed.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}

// --- UPGRADED: RIPPLE PULSE NAV BUTTON ---
class PulsingLiveNavButton extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const PulsingLiveNavButton({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<PulsingLiveNavButton> createState() => _PulsingLiveNavButtonState();
}

class _PulsingLiveNavButtonState extends State<PulsingLiveNavButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Continuous loop from 0.0 to 1.0 for the outward ripple effect
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Builder for an individual expanding ripple ring
  Widget _buildRipple(double value) {
    return Opacity(
      opacity: (1.0 - value).clamp(0.0, 1.0), // Fades out completely as it reaches max size
      child: Transform.scale(
        scale: 1.0 + (value * 0.3), // Expands outward smoothly
        child: Container(
          height: widget.isSelected ? 62.0 : 56.0,
          width: widget.isSelected ? 62.0 : 56.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.redAccent.withOpacity(0.4), // Sharp outer ring
              width: 2,
            ),
            color: Colors.redAccent.withOpacity(0.5), // Soft inner glow
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final value1 = _animationController.value;
          // Offset the second ripple by 50% for a continuous "double pulse" effect
          final value2 = (value1 + 0.1) % 1.0;

          return SizedBox(
            height: 80, // Bounding box for the ripples
            width: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // The Expanding Rings
                _buildRipple(value1),
                _buildRipple(value2),

                // The Main Solid Button
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: widget.isSelected ? 62 : 56,
                  width: widget.isSelected ? 62 : 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.orangeAccent.shade400,
                        Colors.redAccent.shade700,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.surface,
                      width: 3, // Premium cutout border
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.whatshot_rounded, // The "Fire" icon for live/hype action!
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}