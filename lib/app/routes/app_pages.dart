import 'package:get/get.dart';

import '../modules/aboutus/views/aboutus_view.dart';
import '../modules/announcements/views/all_announcement_view.dart';
import '../modules/bottom_nav/bindings/bottom_nav_binding.dart';
import '../modules/bottom_nav/views/bottom_nav_view.dart';
import '../modules/event/bindings/event_binding.dart';
import '../modules/event/views/event_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sponsors/views/sponsors_view.dart';
import '../modules/sports_event/bindings/sports_event_binding.dart';
import '../modules/sports_event/views/sports_event_view.dart';
import '../modules/splash/views/splash_screen.dart';
import '../modules/timeline/bindings/timeline_binding.dart';
import '../modules/timeline/views/timeline_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.bottomNav,
      page: () => BottomNavView(),
      binding: BottomNavBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.event,
      page: () => const CulturalEventView(),
      binding: EventBinding(),
    ),
    GetPage(
      name: Routes.sportsEvent,
      page: () => const SportsEventView(),
      binding: SportsEventBinding(),
    ),
    GetPage(
      name: Routes.timeline,
      page: () => TimelineScreen(),
      binding: TimelineBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: Routes.aboutus,
      page: () => AboutUsView(),
    ),
    GetPage(
      name: Routes.sponsors,
      page: () => SponsorsView(),
    ),
    GetPage(
      name: Routes.announcements,
      page: () => AllAnnouncementsView(),
    ),
  ];
}
