import 'dart:async';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class HomeController extends GetxController {
  // Target date for TATVA '26
  final DateTime festStartDate = DateTime(2026, 3, 16, 9, 0, 0);

  // Observable time values
  var days = '00'.obs;
  var hours = '00'.obs;
  var minutes = '00'.obs;
  var seconds = '00'.obs;
  var isFestLive = false.obs;

  // API Data States
  var announcements = <Map<String, dynamic>>[].obs;
  var isAnnouncementsLoading = true.obs;

  var trendingEvents = <Map<String, dynamic>>[].obs;
  var isTrendingLoading = true.obs;

  Timer? _timer;
  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    _startCountdown();
    fetchAnnouncements();
    fetchTrendingEvents();
  }

  // --- FETCH ANNOUNCEMENTS ---
  Future<void> fetchAnnouncements() async {
    try {
      isAnnouncementsLoading(true);
      final response = await _dio.get('https://tatva-backend-uct2.onrender.com/api/announcements');

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> rawData = [];
        if (response.data is List) {
          rawData = response.data;
        } else if (response.data is Map && response.data.containsKey('data')) {
          rawData = response.data['data'];
        }

        var fetchedAnnouncements = rawData.map((item) {
          return {
            "title": item["title"]?.toString() ?? "Update",
            "body": item["body"]?.toString() ?? "No details provided.",
            "time": item["createdAt"] != null ? _formatRelativeTime(item["createdAt"]) : "Recently",
            "isNew": "true", // Mark as new for UI styling
          };
        }).toList();

        announcements.assignAll(fetchedAnnouncements);
      }
    } catch (e) {
      print("Error fetching announcements: $e");
    } finally {
      isAnnouncementsLoading(false);
    }
  }

  // --- FETCH TRENDING EVENTS ---
  Future<void> fetchTrendingEvents() async {
    try {
      isTrendingLoading(true);
      // Fetching cultural events to display as trending on the home screen
      final response = await _dio.get('https://tatva-backend-uct2.onrender.com/api/events/cultural');

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> rawData = [];
        if (response.data is List) {
          rawData = response.data;
        } else if (response.data is Map && response.data.containsKey('data')) {
          rawData = response.data['data'];
        }

        // Take only the top 5 events for the Home Screen carousel
        var fetchedEvents = rawData.map((e) => e as Map<String, dynamic>).take(5).toList();
        trendingEvents.assignAll(fetchedEvents);
      }
    } catch (e) {
      print("Error fetching trending events: $e");
    } finally {
      isTrendingLoading(false);
    }
  }

  // --- HELPER: FORMAT TIME ---
  String _formatRelativeTime(String isoDate) {
    try {
      DateTime dt = DateTime.parse(isoDate).toLocal();
      Duration diff = DateTime.now().difference(dt);

      if (diff.inMinutes < 60) return "${diff.inMinutes} mins ago";
      if (diff.inHours < 24) return "${diff.inHours} hrs ago";
      if (diff.inDays == 1) return "1 day ago";
      return "${diff.inDays} days ago";
    } catch (e) {
      return "Recently";
    }
  }

  // --- COUNTDOWN LOGIC ---
  void _startCountdown() {
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    final difference = festStartDate.difference(now);

    if (difference.isNegative) {
      _timer?.cancel();
      days.value = '00'; hours.value = '00'; minutes.value = '00'; seconds.value = '00';
      isFestLive.value = true;
    } else {
      days.value = difference.inDays.toString().padLeft(2, '0');
      hours.value = (difference.inHours % 24).toString().padLeft(2, '0');
      minutes.value = (difference.inMinutes % 60).toString().padLeft(2, '0');
      seconds.value = (difference.inSeconds % 60).toString().padLeft(2, '0');
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}