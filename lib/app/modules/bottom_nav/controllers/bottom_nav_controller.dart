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
    if (_selectedIndex.value == index) return;
    
    int previousIndex = _selectedIndex.value;
    _selectedIndex.value = index;
    
    // If jumping multiple tabs, jump instantly to avoid swiping through intermediate pages
    if ((index - previousIndex).abs() > 1) {
      pageController.jumpToPage(index);
    } else {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
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
