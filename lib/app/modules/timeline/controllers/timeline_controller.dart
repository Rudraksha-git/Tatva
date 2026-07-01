import 'dart:convert';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:fest_app/app/data/models/timeline_model.dart'; // Adjust import path if needed

class TimelineController extends GetxController {
  // Observables for state
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  // Observables for data
  var patnaEvents = <FestEvent>[].obs;
  var bihtaEvents = <FestEvent>[].obs;

  // Default location
  var currentLocation = 'Patna'.obs;

  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  void toggleLocation(String loc) {
    currentLocation.value = loc;
  }

  // Dynamically returns the list based on the selected location
  List<FestEvent> get activeEvents =>
      currentLocation.value == 'Bihta' ? bihtaEvents : patnaEvents;

  Future<void> fetchEvents() async {
    try {
      isLoading(true);
      hasError(false);

      // Fetch both files concurrently for better performance
      final responses = await Future.wait([
        _dio.get('https://raw.githubusercontent.com/tanay4768/MockData2/refs/heads/main/patna_events.json'),
        _dio.get('https://raw.githubusercontent.com/tanay4768/MockData2/refs/heads/main/bihta_events.json'),
      ]);

      patnaEvents.value = _parseEvents(responses[0].data);
      bihtaEvents.value = _parseEvents(responses[1].data);

    } on DioException catch (e) {
      hasError(true);
      errorMessage.value = 'Network error: ${e.message}';
    } catch (e) {
      hasError(true);
      errorMessage.value = 'Failed to load events: $e';
    } finally {
      isLoading(false);
    }
  }

  List<FestEvent> _parseEvents(dynamic responseData) {
    List<dynamic> data;
    if (responseData is String) {
      data = jsonDecode(responseData);
    } else {
      data = responseData;
    }
    return data.map((json) => FestEvent.fromJson(json as Map<String, dynamic>)).toList();
  }
}