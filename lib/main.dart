import 'package:fest_app/config/app_theme.dart';
import 'package:fest_app/firebase_options.dart';
import 'package:fest_app/shared/views/bottom_nav_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/services/notification_services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await _requestNotificationPermission();

  await Get.putAsync(() => NotificationService().init());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

Future<void> _requestNotificationPermission() async {
  final status = await Permission.notification.status;
  if (!status.isGranted) {
    await Permission.notification.request();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tatva',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      home: BottomNavView(),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetX Notifications')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            try{
            Get.find<NotificationService>().showNotification(
              id: 0, 
              title: 'Hello There!', 
              body: 'This is a test notification from GetX Service.',
            );
          }catch(e){
            print('Error showing notification: $e');
          }},
          child: const Text('Show Notification'),
        ),
      ),
    );
  }
}