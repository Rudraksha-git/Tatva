import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'all_anouncement._view.dart';
import 'event_detail_view.dart';

// Import your other screens


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const CustomAppBar(
        title: 'TATVA \'26',
        showBackButton: false,
        notificationCount: 3,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hero Banner with Glassmorphic Countdown
            _buildHeroBanner(controller),

            // 2. Modern Quick Links (Explore section removed, pure links kept)


            // 3. Announcements Section (API Driven)
            _buildAnnouncementsSection(controller),

            // 4. Trending Events Carousel (API Driven)
            _buildTrendingEventsSection(controller),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- 1. HERO BANNER ---
  Widget _buildHeroBanner(HomeController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('assets/tatvabg.jpeg'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
            stops: const [0.2, 1.0],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                  color: const Color(0xFFFFCA28),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFFFFCA28).withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))
                  ]
              ),
              child: const Text(
                "MIRROR OF THE COSMOS",
                style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5),
              ),
            ),
            const SizedBox(height: 20),

            // Glassmorphic Panel
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                  ),
                  child: Column(
                    children: [
                      const Text("FEST BEGINS IN", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 3)),
                      const SizedBox(height: 12),
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTimeBox(controller.days.value, "DAYS"),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text(":", style: TextStyle(color: Colors.white54, fontSize: 24, fontWeight: FontWeight.bold))),
                          _buildTimeBox(controller.hours.value, "HRS"),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text(":", style: TextStyle(color: Colors.white54, fontSize: 24, fontWeight: FontWeight.bold))),
                          _buildTimeBox(controller.minutes.value, "MIN"),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text(":", style: TextStyle(color: Colors.white54, fontSize: 24, fontWeight: FontWeight.bold))),
                          _buildTimeBox(controller.seconds.value, "SEC", isAccent: true),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeBox(String value, String label, {bool isAccent = false}) {
    return Column(
      children: [
        Text(
            value,
            style: TextStyle(
                color: isAccent ? const Color(0xFFFFCA28) : Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
                shadows: [
                  if (isAccent) BoxShadow(color: const Color(0xFFFFCA28).withOpacity(0.5), blurRadius: 10)
                ]
            )
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
      ],
    );
  }

  // --- 2. QUICK LINKS SECTION ---


  Widget _buildModernLink(IconData icon, String label, Color bgColor, Color iconColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 70, width: 70,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: iconColor.withOpacity(0.15), blurRadius: 12, offset: const Offset(0, 6))],
            ),
            child: Icon(icon, color: iconColor, size: 32),
          ),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87)),
        ],
      ),
    );
  }

  // --- 3. ANNOUNCEMENTS SECTION ---
  Widget _buildAnnouncementsSection(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Announcements", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black87, letterSpacing: -0.5)),
                TextButton(
                  onPressed: () => Get.to(() => AllAnnouncementsView(controller: controller)),
                  child: const Text("See All", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 140,
            child: Obx(() {
              if (controller.isAnnouncementsLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.announcements.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_off_outlined, color: Colors.grey[400], size: 32),
                      const SizedBox(height: 8),
                      Text("No announcements.", style: TextStyle(color: Colors.grey[500], fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  ),
                );
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.announcements.length,
                itemBuilder: (context, index) {
                  var ann = controller.announcements[index];
                  bool isNew = ann["isNew"] == "true";

                  return Container(
                    width: 280,
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey[200]!),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                ann["title"] ?? "Update",
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isNew)
                              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            ann["body"] ?? "",
                            style: TextStyle(fontSize: 13, color: Colors.grey[600], height: 1.4),
                            maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(ann["time"] ?? "", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.blue[400])),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // --- 4. TRENDING EVENTS SECTION ---
  Widget _buildTrendingEventsSection(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Trending Events", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black87, letterSpacing: -0.5)),
              TextButton(onPressed: () {}, child: const Text("View All", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 290,
          child: Obx(() {
            if (controller.isTrendingLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.trendingEvents.isEmpty) {
              return Center(
                child: Text("No trending events found.", style: TextStyle(color: Colors.grey[500], fontSize: 14)),
              );
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.trendingEvents.length,
              itemBuilder: (context, index) {
                var event = controller.trendingEvents[index];

                String title = event['event'] ?? event['sport'] ?? 'Upcoming Event';
                String location = event['venue'] ?? event['location'] ?? 'TBA';
                String category = event['category'] ?? event['type'] ?? 'EVENT';
                String date = _formatDate(event['startDate']);

                MaterialColor badgeColor = _getBadgeColor(category);
                String badgeText = _getShortCategory(category);
                String imageUrl = _getPlaceholderImage(category);

                return _buildMiniEventCard(title, date, location, badgeText, badgeColor, imageUrl);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildMiniEventCard(String title, String date, String location, String badgeText, MaterialColor badgeColor, String imageUrl) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 16, bottom: 12, top: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(imageUrl, height: 140, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: badgeColor[50], borderRadius: BorderRadius.circular(8)),
                      child: Text(badgeText, style: TextStyle(color: badgeColor[700], fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 6),
                    Text(date, style: TextStyle(color: Colors.grey[700], fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 6),
                    Expanded(child: Text(location, style: TextStyle(color: Colors.grey[700], fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER METHODS ---

  String _formatDate(String? rawDate) {
    if (rawDate == null) return "TBA";
    try {
      DateTime dt = DateTime.parse(rawDate);
      List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return "${months[dt.month - 1]} ${dt.day}";
    } catch (e) {
      return rawDate;
    }
  }

  MaterialColor _getBadgeColor(String category) {
    String cat = category.toLowerCase();
    if (cat.contains('dance')) return Colors.orange;
    if (cat.contains('music') || cat.contains('singing')) return Colors.blue;
    if (cat.contains('drama') || cat.contains('theatre')) return Colors.purple;
    if (cat.contains('sport') || cat.contains('football') || cat.contains('cricket')) return Colors.green;
    return Colors.teal;
  }

  String _getShortCategory(String category) {
    String cat = category.toLowerCase();
    if (cat.contains('dance')) return 'DANCE';
    if (cat.contains('music') || cat.contains('singing')) return 'MUSIC';
    if (cat.contains('drama') || cat.contains('theatre')) return 'DRAMA';
    if (cat.contains('sport')) return 'SPORTS';
    if (cat.contains('photo') || cat.contains('film')) return 'MEDIA';
    return 'EVENT';
  }

  String _getPlaceholderImage(String category) {
    String cat = category.toLowerCase();
    if (cat.contains('dance')) return 'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad';
    if (cat.contains('music') || cat.contains('singing')) return 'https://images.unsplash.com/photo-1516280440502-6c39f0ed26f7';
    if (cat.contains('drama') || cat.contains('theatre')) return 'https://images.unsplash.com/photo-1507676184212-d0330a15183e';
    if (cat.contains('sport') || cat.contains('football')) return 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211';
    return 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30';
  }
}