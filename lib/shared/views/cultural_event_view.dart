import 'package:fest_app/config/app_colors.dart';
import 'package:fest_app/config/app_sizes.dart';
import 'package:fest_app/shared/widgets/custom_app_bar.dart';
import 'package:fest_app/shared/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CulturalEventView extends StatelessWidget {
  const CulturalEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Cultural Events',
        showBackButton: false,
        notificationCount: 3, // Example count to show the red badge
      ),
      body: ListView(
        padding: AppSizes.p20,
        children: [
          EventCard(
            eventName: 'Dance Competition',
            category: 'Dance',
            date: 'Mar 16',
            time: '10:00 AM',
            location: 'OAT',
            description:
                'Join us for a dance competition. Show your skills and win exciting prizes!',
            onRegister: () {
              Get.snackbar(
                'Registration',
                'You have registered for Dance Competition',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.primaryBlue,
                colorText: AppColors.white,
              );
            },
          ),
          AppSizes.gapH24,
          EventCard(
            eventName: 'Singing Competition',
            category: 'Singing',
            date: 'Mar 18',
            time: '2:00 PM',
            location: 'Auditorium',
            description:
                'Join us for a singing competition. Show your skills and win exciting prizes!',
            onRegister: () {
              Get.snackbar(
                'Registration',
                'You have registered for Singing Competition',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.primaryBlue,
                colorText: AppColors.white,
              );
            },
          ),
        ],
      ),
    );
  }
}
