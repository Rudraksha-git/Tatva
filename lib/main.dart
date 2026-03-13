import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await Get.putAsync(() => NotificationService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tatva',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
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