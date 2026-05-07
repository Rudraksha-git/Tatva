import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../core/models/score_event_model.dart';
// Note: Ensure the path to your model is correct

class LiveEventController extends GetxController {
  var isLoading = true.obs;

  // The master list of all fetched events
  var allLiveEvents = <LiveEventModel>[].obs;

  // Active Filters
  var selectedCampus = 'Patna'.obs;
  var showOnlyLive = false.obs;
  var searchQuery = ''.obs;

  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchLiveScores();
  }

  // Actual API call to your backend
  Future<void> fetchLiveScores({bool isRefresh = false}) async {
    // Only show the central loading spinner if it's the first load
    if (!isRefresh) isLoading(true);

    try {
      final response = await _dio.get('https://tatva-backend-uct2.onrender.com/api/sports');

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> rawList = [];

        // Safely extract the data whether it's wrapped in an object or a direct array
        if (response.data is List) {
          rawList = response.data;
        } else if (response.data is Map && response.data.containsKey('data')) {
          rawList = response.data['data'];
        }

        var parsedEvents = rawList.map((json) => LiveEventModel.fromJson(json)).toList();
        allLiveEvents.assignAll(parsedEvents);
      }
    } catch (e) {
      Get.snackbar(
        "Connection Error",
        "Could not load live scores. Please check your connection and try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  // The dynamic getter that applies all 3 filters simultaneously
  List<LiveEventModel> get filteredEvents {
    return allLiveEvents.where((event) {
      // 1. Campus Filter
      bool matchesCampus = event.campus.toUpperCase() == selectedCampus.value.toUpperCase();

      // 2. Live Status Filter
      bool matchesLiveStatus = true;
      if (showOnlyLive.value) {
        matchesLiveStatus = event.isLive == true;
      }

      // 3. Search Bar Filter
      bool matchesSearch = true;
      if (searchQuery.value.trim().isNotEmpty) {
        matchesSearch = event.eventName
            .toLowerCase()
            .contains(searchQuery.value.trim().toLowerCase());
      }

      return matchesCampus && matchesLiveStatus && matchesSearch;
    }).toList();
  }

  // Setters for UI
  void setCampus(String campus) => selectedCampus.value = campus;
  void toggleLiveFilter(bool value) => showOnlyLive.value = value;
}