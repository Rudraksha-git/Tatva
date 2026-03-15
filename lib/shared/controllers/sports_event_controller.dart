import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../core/models/sports_event_model.dart';


class SportsEventController extends GetxController {
  var isLoading = true.obs;

  // Stores the raw list of all sports events
  var allEvents = <SportsEventModel>[].obs;

  final RxString searchQuery = ''.obs;
  final RxBool showOnlyWithRegistration = false.obs;


  // Active Filters
  var selectedLocation = 'All'.obs;
  var selectedSport = 'All Sports'.obs;

  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      await Future.delayed(Duration.zero);
      isLoading(true);

      // Adjust this URL to your actual Sports API endpoint
      final response = await _dio.get('https://tatva-backend-uct2.onrender.com/api/events/sports');

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> rawData = [];

        if (response.data is List) {
          rawData = response.data;
        } else if (response.data is Map && response.data.containsKey('data')) {
          rawData = response.data['data'];
        } else {
          throw Exception("Unexpected API format.");
        }

        var parsedEvents = rawData.map((json) => SportsEventModel.fromJson(json)).toList();
        allEvents.assignAll(parsedEvents);
      }
    } catch (e) {
      Get.snackbar("Error", "Could not load sports events. Please try again.", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  // Reactive getter for the UI
  List<SportsEventModel> get filteredEvents {
    return allEvents.where((event) {
      // 1. Filter by Location
      bool matchesLocation = selectedLocation.value == 'All' ||
          (event.location?.toUpperCase() == selectedLocation.value.toUpperCase());

      // 2. Filter by Sport Type
      bool matchesSport = selectedSport.value == 'All Sports' ||
          (event.sport != null &&
              event.sport!.toLowerCase().contains(selectedSport.value.toLowerCase().trim()));

      return matchesLocation && matchesSport;
    }).toList();
  }

  void setLocation(String loc) => selectedLocation.value = loc;
  void setSport(String sport) => selectedSport.value = sport;
}