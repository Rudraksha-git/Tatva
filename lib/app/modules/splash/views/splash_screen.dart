import 'dart:async';
import 'dart:math' as math;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fest_app/app/data/services/notification_services.dart';
import 'package:fest_app/app/modules/bottom_nav/views/bottom_nav_view.dart';

// Adjust this import to point to your HomeView


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _spinController;
  late AnimationController _pulseController;
  late AnimationController _entranceController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bottomFadeAnimation;

  @override
  void initState() {
    super.initState();



    // 1. Spinning Rings Controller (Continuous)
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    // 2. Pulsing Glow Controller (Continuous heartbeat)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // 3. Entrance Animation (Runs once for the logos)
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Main logo fade & scale
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.0, 0.6, curve: Curves.easeIn)),
    );
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack)),
    );

    // Bottom sponsor logo fade (Delayed)
    _bottomFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.6, 1.0, curve: Curves.easeIn)),
    );

    _entranceController.forward();
        _setupFCM();

    // Navigate to Home after 4.5 seconds
    Timer(const Duration(milliseconds: 4500), () {
      Get.off(
            () => BottomNavView(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 800),
      );
    });
  }

  @override
  void dispose() {
    _spinController.dispose();
    _pulseController.dispose();
    _entranceController.dispose();
    super.dispose();
  }
Future<void> _setupFCM() async {
    // 3. SUBSCRIBE EVERYONE TO A TOPIC
    await FirebaseMessaging.instance.subscribeToTopic('all_users');

    // 4. HANDLE FOREGROUND MESSAGES
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        // Trigger your existing local notification service
        Get.find<NotificationService>().showNotification(
          id: message.hashCode, 
          title: message.notification!.title ?? 'New Notification', 
          body: message.notification!.body ?? '',
        );
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070714), // Deep cosmic navy/black
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Dynamic Pulsing Nebula Background
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.6 + (_pulseController.value * 0.15),
                      colors: [
                        const Color(0xFFFF5722).withOpacity(0.15), // Warm orange glow matching TATVA logo
                        const Color(0xFF070714),
                      ],
                    ),
                  ),
                );
              },
            ),
        
            // // 2. Outer Spinning Ring (Cyan - matches HackSlash logo)
            // AnimatedBuilder(
            //   animation: _spinController,
            //   builder: (context, child) {
            //     return Transform.rotate(
            //       angle: _spinController.value * 2.0 * math.pi,
            //       child: _buildOrbitalRing(size: 340, color: const Color(0xFF00FFA3).withOpacity(0.2), strokeWidth: 1.5, isDashed: true),
            //     );
            //   },
            // ),
        
            // // 3. Inner Spinning Ring (Orange - matches TATVA logo)
            // AnimatedBuilder(
            //   animation: _spinController,
            //   builder: (context, child) {
            //     return Transform.rotate(
            //       angle: -(_spinController.value * 3.0 * math.pi),
            //       child: _buildOrbitalRing(size: 260, color: const Color(0xFFFF5722).withOpacity(0.4), strokeWidth: 1),
            //     );
            //   },
            // ),
        
            // 4. Center: Main TATVA Logo & Tagline
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // The TATVA '26 Logo
                    Image.asset(
                      'assets/images/tatva_logo.png', // Ensure this matches your pubspec.yaml
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 24),
        
                    // // Futuristic Theme Subtitle
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    //   decoration: BoxDecoration(
                    //       color: const Color(0xFFFF5722).withOpacity(0.1),
                    //       borderRadius: BorderRadius.circular(20),
                    //       border: Border.all(color: const Color(0xFFFF5722).withOpacity(0.3)),
                    //       boxShadow: [
                    //         BoxShadow(color: const Color(0xFFFF5722).withOpacity(0.2), blurRadius: 10)
                    //       ]
                    //   ),
                    //   child: const Text(
                    //     "MIRROR OF THE COSMOS",
                    //     style: TextStyle(
                    //       color: Color(0xFFFFCC80),
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.w800,
                    //       letterSpacing: 4.0,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
        
            // 5. Bottom: "Powered By" & HackSlash Logo
            Positioned(
              bottom: 50,
              child: FadeTransition(
                opacity: _bottomFadeAnimation,
                child: Column(
                  children: [
                    const Text(
                      "DEVELOPED BY",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // The HackSlash Logo
                    Image.asset(
                      'assets/images/hackslash-logo.png', // Ensure this matches your pubspec.yaml
                      height: 35, // Keep it scaled down appropriately
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build the cosmic/futuristic rings
  Widget _buildOrbitalRing({required double size, required Color color, required double strokeWidth, bool isDashed = false}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: strokeWidth,
        ),
      ),
      child: isDashed
          ? Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(
            colors: [color, Colors.transparent, color, Colors.transparent],
            stops: const [0.0, 0.25, 0.5, 0.75],
          ),
        ),
      )
          : null,
    );
  }
}