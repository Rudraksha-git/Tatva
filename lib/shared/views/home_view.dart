import 'dart:ui';
import 'package:fest_app/shared/controllers/bottom_nav_controller.dart';
import 'package:fest_app/shared/views/aboutus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/app_sizes.dart';
import '../controllers/home_controller.dart';
import 'all_anouncement._view.dart' hide CustomAppBar;

// Import your other screens

// Helper function to trigger the phone dialer safely
Future<void> _makePhoneCall(String phoneNumber) async {
  final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: cleanNumber,
  );
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    debugPrint('Could not launch $phoneNumber');
  }
}

// Helper function to trigger the email app
Future<void> _sendEmail(String email) async {
  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    debugPrint('Could not launch $email');
  }
}
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

            // 2. Announcements Section (API Driven)
            _buildAnnouncementsSection(controller),

               // 3. Messages from Leadership (Made more compact)

            _buildRulebookButton(),

            _buildMessagesSection(),

            // 4. Student Coordinators Contact Section (Made more compact)
            _buildCoordinatorsSection(),

            const SizedBox(height: 40),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // // --- 1. HERO BANNER ---
  // Widget _buildHeroBanner(HomeController controller) {
  //   return Container(
  //     margin: const EdgeInsets.fromLTRB(20, 16, 20, 24),
  //     height: 280,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(24),
  //       image: const DecorationImage(
  //         image: AssetImage('assets/tatvabg.jpeg'),
  //         fit: BoxFit.cover,
  //       ),
  //       boxShadow: [
  //         BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))
  //       ],
  //     ),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(24),
  //         gradient: LinearGradient(
  //           begin: Alignment.topCenter,
  //           end: Alignment.bottomCenter,
  //           colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
  //           stops: const [0.2, 1.0],
  //         ),
  //       ),
  //       padding: const EdgeInsets.all(24),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
  //             decoration: BoxDecoration(
  //                 color: const Color(0xFFFFCA28),
  //                 borderRadius: BorderRadius.circular(12),
  //                 boxShadow: [
  //                   BoxShadow(color: const Color(0xFFFFCA28).withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))
  //                 ]
  //             ),
  //             child: const Text(
  //               "ANNUAL SPORTS & CULTURAL",
  //               style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5),
  //             ),
  //           ),
  //           const SizedBox(height: 20),

  //           // Glassmorphic Panel
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(20),
  //             child: BackdropFilter(
  //               filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
  //               child: Container(
  //                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  //                 width: double.infinity,
  //                 decoration: BoxDecoration(
  //                   color: Colors.white.withOpacity(0.1),
  //                   borderRadius: BorderRadius.circular(20),
  //                   border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
  //                 ),
  //                 child: Obx(() {
  //                   if (controller.isFestLive.value) {
  //                     return const Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Text(
  //                           "FEST IS LIVE!",
  //                           style: TextStyle(
  //                               color: Color(0xFFFFCA28),
  //                               fontSize: 24,
  //                               fontWeight: FontWeight.w900,
  //                               letterSpacing: 2,
  //                               shadows: [
  //                                 BoxShadow(
  //                                     color: Color(0xFFFFCA28), blurRadius: 15)
  //                               ]),
  //                         ),
  //                         SizedBox(height: 8),
  //                         Text(
  //                           "16th March - 4th April",
  //                           style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
  //                         ),
  //                       ],
  //                     );
  //                   }
  //                   return Column(
  //                     children: [
  //                       const Text("FEST BEGINS IN", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 3)),
  //                       const SizedBox(height: 12),
  //                       Obx(() => Row(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               _buildTimeBox(controller.days.value, "DAYS"),
  //                               const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text(":", style: TextStyle(color: Colors.white54, fontSize: 24, fontWeight: FontWeight.bold))),
  //                               _buildTimeBox(controller.hours.value, "HRS"),
  //                               const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text(":", style: TextStyle(color: Colors.white54, fontSize: 24, fontWeight: FontWeight.bold))),
  //                               _buildTimeBox(controller.minutes.value, "MIN"),
  //                               const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text(":", style: TextStyle(color: Colors.white54, fontSize: 24, fontWeight: FontWeight.bold))),
  //                               _buildTimeBox(controller.seconds.value, "SEC", isAccent: true),
  //                             ],
  //                           )),
  //                     ],
  //                   );
  //                 }),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

// --- 1. HERO BANNER ---
  Widget _buildHeroBanner(HomeController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      height: 320,
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
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            //   decoration: BoxDecoration(
            //       color: const Color(0xFFFFCA28),
            //       borderRadius: BorderRadius.circular(12),
            //       boxShadow: [
            //         BoxShadow(color: const Color(0xFFFFCA28).withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))
            //       ]
            //   ),
            //   child: const Text(
            //     "ANNUAL CULTURAL & SPORTS FEST",
            //     style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5),
            //   ),
            // ),
            const SizedBox(height: 20),

            // Glassmorphic Panel
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                  ),
                  child: Obx(() {
                    if (controller.isFestLive.value) {
                      // Removed 'const' from this Column
                      return Padding(
                        padding: const EdgeInsets.all(2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "FEST IS LIVE!",
                              style: TextStyle(
                                  color: Color(0xFFFFCA28),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2,
                                  shadows: [
                                    BoxShadow(
                                        color: Color(0xFFFFCA28), blurRadius: 15)
                                  ]),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "16th March - 4th April",
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 6),

                            // --- ADDED: Live Events Button ---
                            ElevatedButton(
                              onPressed: () {
                                // 1. Find your existing BottomNavController
                                final bottomNavController = Get.find<BottomNavController>();
                                bottomNavController.changeIndex(3);

                                // 2. Tell it to switch to the Timeline tab.
                                // Change '1' to whatever index your TimelineScreen is at in your bottom navigation!
                                 // This will switch to the Timeline tab
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFCA28),
                                foregroundColor: Colors.black87,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 8,
                                shadowColor: const Color(0xFFFFCA28).withOpacity(0.5),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.calendar_month_rounded, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    "Live Events",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // ----------------------------------
                          ],
                        ),
                      );
                    }
                    return Column(
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
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 5. RULEBOOK BUTTON SECTION ---
Widget _buildRulebookButton() {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
    child: InkWell(
      // Replace with your actual rulebook Google Drive or Website link
      onTap: () => _launchWebURL('https://drive.google.com/drive/folders/1CJ4cI8KokT7HoUDs_0ONfVTLnSD8ZmZu'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!, width: 1.5),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4)
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.purple[50], // A distinct color to make it stand out
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.menu_book_rounded, color: Colors.purple[700], size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Official Rulebook",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Guidelines and event details",
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.open_in_new_rounded, size: 18, color: Colors.grey[400]),
          ],
        ),
      ),
    ),
  );
}

// Helper function to open web links
Future<void> _launchWebURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (await canLaunchUrl(url)) {
    // LaunchMode.externalApplication forces it to open in the default browser (Chrome/Safari)
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    debugPrint('Could not launch $urlString');
  }
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


  // Widget _buildModernLink(IconData icon, String label, Color bgColor, Color iconColor, VoidCallback onTap) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Column(
  //       children: [
  //         Container(
  //           height: 70, width: 70,
  //           decoration: BoxDecoration(
  //             color: bgColor,
  //             borderRadius: BorderRadius.circular(20),
  //             boxShadow: [BoxShadow(color: iconColor.withOpacity(0.15), blurRadius: 12, offset: const Offset(0, 6))],
  //           ),
  //           child: Icon(icon, color: iconColor, size: 32),
  //         ),
  //         const SizedBox(height: 10),
  //         Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87)),
  //       ],
  //     ),
  //   );
  // }

  // --- 3. ANNOUNCEMENTS SECTION ---
  Widget _buildAnnouncementsSection(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
                  onPressed: () => Get.to(() => AllAnnouncementsView()),
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
  // Widget _buildTrendingEventsSection(HomeController controller) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             const Text("Trending Events", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black87, letterSpacing: -0.5)),
             
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 8),
  //       SizedBox(
  //         height: 290,
  //         child: Obx(() {
  //           if (controller.isTrendingLoading.value) {
  //             return const Center(child: CircularProgressIndicator());
  //           }

  //           if (controller.trendingEvents.isEmpty) {
  //             return Center(
  //               child: Text("No trending events found.", style: TextStyle(color: Colors.grey[500], fontSize: 14)),
  //             );
  //           }

  //           return ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             physics: const BouncingScrollPhysics(),
  //             padding: const EdgeInsets.symmetric(horizontal: 16),
  //             itemCount: controller.trendingEvents.length,
  //             itemBuilder: (context, index) {
  //               var event = controller.trendingEvents[index];

  //               String title = event['event'] ?? event['sport'] ?? 'Upcoming Event';
  //               String location = event['venue'] ?? event['location'] ?? 'TBA';
  //               String category = event['category'] ?? event['type'] ?? 'EVENT';
  //               String date = _formatDate(event['startDate']);

  //               MaterialColor badgeColor = _getBadgeColor(category);
  //               String badgeText = _getShortCategory(category);
  //               String imageUrl = event['posterUrl']?? _getPlaceholderImage(category);

  //               return _buildMiniEventCard(title, date, location, badgeText, badgeColor, imageUrl);
  //             },
  //           );
  //         }),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildMiniEventCard(String title, String date, String location, String badgeText, MaterialColor badgeColor, String imageUrl) {
  //   return Container(
  //     width: 250,
  //     margin: const EdgeInsets.only(right: 16, bottom: 12, top: 4),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(color: Colors.grey[200]!),
  //       boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 5))],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         ClipRRect(
  //           borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
  //           child: Image.network(imageUrl, height: 140, width: double.infinity, fit: BoxFit.cover),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis)),
  //                   Container(
  //                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                     decoration: BoxDecoration(color: badgeColor[50], borderRadius: BorderRadius.circular(8)),
  //                     child: Text(badgeText, style: TextStyle(color: badgeColor[700], fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 12),
  //               Row(
  //                 children: [
  //                   Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
  //                   const SizedBox(width: 6),
  //                   Text(date, style: TextStyle(color: Colors.grey[700], fontSize: 13, fontWeight: FontWeight.w500)),
  //                 ],
  //               ),
  //               const SizedBox(height: 6),
  //               Row(
  //                 children: [
  //                   Icon(Icons.location_on, size: 14, color: Colors.grey[500]),
  //                   const SizedBox(width: 6),
  //                   Expanded(child: Text(location, style: TextStyle(color: Colors.grey[700], fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis)),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }


// --- 3. MESSAGES SECTION (Reduced Size & Fixed Image) ---
  Widget _buildMessagesSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Director's Message
          _buildLightMessageCard(
            title: "Message from the Director's Desk",
            subtitle: "Prof. P. K. Jain, Director, NIT Patna",
            message: "At our institute, we believe that true education extends beyond classrooms. Cultural, sports, and literary activities play a vital role in shaping confident, creative, and responsible individuals. The Student Activity Centre app is a step towards encouraging students to explore their talents, participate actively, and grow through diverse learning experiences.",
            imagePath: "assets/images/PKJDESKTOP.jpeg",
          ),

          const SizedBox(height: 12), // Reduced spacing

          // Fest President Message
          _buildLightMessageCard(
            title: "Message from Fest President",
            subtitle: "Prof. (Dr.) Prabhat Kumar, Dean Student Welfare, NIT Patna",
            message: "It gives me great pleasure to see the Student Activity Centre App becoming an integral part of our fest. The app has enabled seamless event updates and registrations, making participation easier for everyone. It reflects our commitment to creating an organized, engaging, and vibrant platform for students to celebrate talent and teamwork.",
            imagePath: "assets/images/PRHSWD.jpeg",
          ),
        ],
      ),
    );
  }

  Widget _buildLightMessageCard({required String title, required String subtitle, required String message, required String imagePath}) {
    return Container(
      padding: const EdgeInsets.all(16), // Reduced padding (was 20)
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // Slightly sharper corners
        border: Border.all(color: Colors.grey[200]!, width: 1.5),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // FIX: Robust image loading with ClipOval
              Container(
                width: 44, // Reduced size (was 52)
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                ),
                child: ClipOval(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback icon if asset is missing
                      return Container(
                        color: Colors.grey[100],
                        child: Icon(Icons.person, color: Colors.grey[400], size: 24),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87), // Reduced font
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blue[700]), // Reduced font
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12), // Reduced spacing
          Text(
            message,
            style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.4), // Reduced font and line-height
          ),
        ],
      ),
    );
  }

  // --- 4. FEST COORDINATORS SECTION (Reduced Size) ---
  Widget _buildCoordinatorsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!, width: 1.5),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0), // Reduced padding
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8), // Reduced padding
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.groups_rounded, color: Colors.blue[700], size: 18), // Reduced icon
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Student Coordinators",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black87), // Reduced font
                  ),
                ],
              ),
            ),

            // Coordinators List
            _buildCoordinatorItem("Manaswini Patil", "8275007608", "patilr.ug22.ar@nitp.ac.in"),
            Divider(height: 1, thickness: 1, color: Colors.grey[100], indent: 16, endIndent: 16),
            _buildCoordinatorItem("Harshvardhan Dansena", "8319728292", "harshvardhand.dd22.ce@nitp.ac.in"),
            const SizedBox(height: 4), // Reduced bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildCoordinatorItem(String name, String phone, String email) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Reduced padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar Placeholder
          Container(
            height: 40, // Reduced size (was 46)
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Icon(Icons.person_rounded, color: Colors.grey[400], size: 20),
          ),
          const SizedBox(width: 14),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87), // Reduced font
                ),
                const SizedBox(height: 6),

                // Clickable Phone Row
                GestureDetector(
                  onTap: () => _makePhoneCall(phone),
                  child: Row(
                    children: [
                      Icon(Icons.phone_outlined, size: 14, color: Colors.blue[600]),
                      const SizedBox(width: 8),
                      Text(
                        phone,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[700]), // Reduced font
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),

                // Clickable Email Row
                GestureDetector(
                  onTap: () => _sendEmail(email),
                  child: Row(
                    children: [
                      Icon(Icons.mail_outline_rounded, size: 14, color: Colors.blue[600]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          email,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey[600]), // Reduced font
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER METHODS ---

  // String _formatDate(String? rawDate) {
  //   if (rawDate == null) return "TBA";
  //   try {
  //     DateTime dt = DateTime.parse(rawDate);
  //     List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  //     return "${months[dt.month - 1]} ${dt.day}";
  //   } catch (e) {
  //     return rawDate;
  //   }
  // }

  // MaterialColor _getBadgeColor(String category) {
  //   String cat = category.toLowerCase();
  //   if (cat.contains('dance')) return Colors.orange;
  //   if (cat.contains('music') || cat.contains('singing')) return Colors.blue;
  //   if (cat.contains('drama') || cat.contains('theatre')) return Colors.purple;
  //   if (cat.contains('sport') || cat.contains('football') || cat.contains('cricket')) return Colors.green;
  //   return Colors.teal;
  // }

  // String _getShortCategory(String category) {
  //   String cat = category.toLowerCase();
  //   if (cat.contains('dance')) return 'DANCE';
  //   if (cat.contains('music') || cat.contains('singing')) return 'MUSIC';
  //   if (cat.contains('drama') || cat.contains('theatre')) return 'DRAMA';
  //   if (cat.contains('sport')) return 'SPORTS';
  //   if (cat.contains('photo') || cat.contains('film')) return 'MEDIA';
  //   return 'EVENT';
  // }

  // String _getPlaceholderImage(String category) {
  //   String cat = category.toLowerCase();
  //   if (cat.contains('dance')) return 'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad';
  //   if (cat.contains('music') || cat.contains('singing')) return 'https://images.unsplash.com/photo-1516280440502-6c39f0ed26f7';
  //   if (cat.contains('drama') || cat.contains('theatre')) return 'https://images.unsplash.com/photo-1507676184212-d0330a15183e';
  //   if (cat.contains('sport') || cat.contains('football')) return 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211';
  //   return 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30';
  // }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final int notificationCount;
  final List<Widget>? extraActions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.notificationCount = 0,
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
      title: Row(
        children: [
         Image.asset(
            'assets/images/tatva_logo.png',
            height: 32,
            width: 32,
          ),
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
        ],
      ),
      actions: [
        TextButton.icon(
          onPressed: () => Get.to(() => AboutUsView()),
          icon: Icon(Icons.info_outline_rounded, color: iconColor, size: AppSizes.x24),
          label: Text(
            "About Us",
            style: TextStyle(
              color: iconColor,
              fontWeight: FontWeight.w600,
              fontSize: AppSizes.x14,
            ),
          ),
        ),
        AppSizes.gapW8,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
