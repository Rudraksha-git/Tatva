import 'package:get/get.dart';
import '../controllers/sports_event_controller.dart';

class SportsEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SportsEventController>(
      () => SportsEventController(),
    );
  }
}
