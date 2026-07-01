import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedThemeToggle extends StatelessWidget {
  const AnimatedThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      onPressed: () {
        Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          return RotationTransition(
            turns:
                child.key == const ValueKey('icon_moon')
                    ? Tween<double>(begin: 0.5, end: 1.0).animate(animation)
                    : Tween<double>(begin: 1.0, end: 0.5).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: Icon(
          isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
          key: ValueKey(isDark ? 'icon_moon' : 'icon_sun'),
          color: isDark ? const Color(0xFFF4F4F8) : const Color(0xFFFFD700),
        ),
      ),
    );
  }
}
