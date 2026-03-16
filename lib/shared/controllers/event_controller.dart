import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../core/models/event_model.dart';

class EventController extends GetxController {
  var isLoading = true.obs;

  // Stores the raw list of all events
  var allEvents = <EventModel>[].obs;

  // Active Filters
  var selectedLocation = 'All'.obs;
  var selectedClub = 'All Clubs'.obs;

  // Rx variables for Search and Registration toggle
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
      Get.snackbar(
          "Error",
          "Could not load events. Please try again.",
          snackPosition: SnackPosition.BOTTOM
      );
    } finally {
      isLoading(false);
    }
  }

  // --- THE MAGIC HAPPENS HERE ---
  // Only returns clubs that actually have events at the currently selected campus
  List<String> get dynamicClubs {
    Set<String> uniqueClubs = {'All Clubs'};

    for (var event in allEvents) {
      // 1. Check if this specific event happens at the currently selected campus
      bool matchesLocation = selectedLocation.value == 'All' ||
          (event.location?.toUpperCase() == selectedLocation.value.toUpperCase());

      // 2. Only add the club to the list IF it has an event at this campus
      if (matchesLocation && event.club != null && event.club!.trim().isNotEmpty) {
        uniqueClubs.add(event.club!.trim());
      }
    }

    return uniqueClubs.toList();
  }

  // Reactive getter for the UI
  List<EventModel> get filteredEvents {
    return allEvents.where((event) {
      // 1. Filter by Location
      bool matchesLocation = selectedLocation.value == 'All' ||
          (event.location?.toUpperCase() == selectedLocation.value.toUpperCase());

      // 2. Filter by Club
      bool matchesClub = selectedClub.value == 'All Clubs' ||
          (event.club != null &&
              event.club!.trim().toLowerCase() == selectedClub.value.trim().toLowerCase());

      // 3. Filter by Registration URL
      bool matchesRegistration = true;
      if (showOnlyWithRegistration.value) {
        matchesRegistration = event.registrationUrl != null && event.registrationUrl!.isNotEmpty && event.registrationOpen!=false;
      }

      // 4. Filter by Search Query
      bool matchesSearch = true;
      if (searchQuery.value.trim().isNotEmpty) {
        final query = searchQuery.value.trim().toLowerCase();
        final name = (event.event ?? '').toLowerCase();
        final desc = (event.description ?? '').toLowerCase();
        final clubName = (event.club ?? '').toLowerCase();
        matchesSearch = name.contains(query) || desc.contains(query) || clubName.contains(query);
      }

      return matchesLocation && matchesClub && matchesRegistration && matchesSearch;
    }).toList();
  }

  // Setters for UI Toggles
  void setLocation(String loc) {
    selectedLocation.value = loc;

    // SAFETY CHECK: If user switches campuses, check if their currently
    // selected club exists at the new campus. If not, reset to 'All Clubs'.
    if (!dynamicClubs.contains(selectedClub.value)) {
      selectedClub.value = 'All Clubs';
    }
  }

  void setClub(String club) => selectedClub.value = club;
}