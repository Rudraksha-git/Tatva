import 'package:fest_app/config/app_colors.dart';
import 'package:fest_app/config/app_sizes.dart';
import 'package:fest_app/shared/widgets/custom_app_bar.dart';
import 'package:fest_app/shared/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SportsEventView extends StatelessWidget {
  const SportsEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Sports Arena',
        showBackButton: false,
        notificationCount: 3, // Example count to show the red badge
      ),
      body: ListView(
        padding: AppSizes.p20,
        children: [
          EventCard(
            eventName: 'Football',
            category: '7-a-side',
            date: 'Mar 16',
            time: '10:00 AM',
            location: 'Ground',
            isSports: true,
            limit: '10 Participants',
            description:
                'Join us for a thrilling football tournament. Show your skills and win exciting prizes!',
            onRegister: () {
              Get.snackbar(
                'Registration',
                'You have registered for Football',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.primaryBlue,
                colorText: AppColors.white,
              );
            },
          ),
          AppSizes.gapH24,
          EventCard(
            eventName: 'Cricket',
            category: '11-a-side',
            date: 'Mar 18',
            time: '2:00 PM',
            location: 'Ground',
            isSports: true,
            limit: '10 Participants',
            description:
                'Join us for a thrilling cricket tournament. Show your skills and win exciting prizes!',
            onRegister: () {
              // Handle registration
            },
          ),
        ],
      ),
    );
  }
}
