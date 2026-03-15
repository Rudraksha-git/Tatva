import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../core/models/event_model.dart';



class EventController extends GetxController {
  var isLoading = true.obs;

  // Stores the raw list of all events
  var allEvents = <EventModel>[].obs;

  // Active Filters
  var selectedLocation = 'All'.obs;
  var selectedCategory = 'All Events'.obs;

  final RxString searchQuery = ''.obs;
  final RxBool showOnlyWithRegistration = false.obs;

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

      final response = await _dio.get('https://tatva-backend-uct2.onrender.com/api/events/cultural');

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> rawData = [];

        // Safely extract the array whether it is wrapped in an object or not
        if (response.data is List) {
          rawData = response.data;
        } else if (response.data is Map && response.data.containsKey('data')) {
          rawData = response.data['data'];
        } else {
          throw Exception("Unexpected API format.");
        }

        var parsedEvents = rawData.map((json) => EventModel.fromJson(json)).toList();
        allEvents.assignAll(parsedEvents);
      }
    } catch (e) {
      Get.snackbar("Error", "Could not load events. Please try again.", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  // Reactive getter for the UI
  List<EventModel> get filteredEvents {
    return allEvents.where((event) {
      // 1. Filter by Location
      bool matchesLocation = selectedLocation.value == 'All' ||
          (event.location?.toUpperCase() == selectedLocation.value.toUpperCase());

      // 2. Filter by Category
      bool matchesCategory = selectedCategory.value == 'All Events' ||
          (event.category != null &&
              event.category!.toLowerCase().contains(selectedCategory.value.toLowerCase().trim()));

      return matchesLocation && matchesCategory;
    }).toList();
  }

  // Setters for UI Toggles
  void setLocation(String loc) => selectedLocation.value = loc;
  void setCategory(String cat) => selectedCategory.value = cat;
}