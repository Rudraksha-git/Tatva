import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  final RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: _selectedIndex.value);
  }

  void changeIndex(int index) {
    _selectedIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(int index) {
    _selectedIndex.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
