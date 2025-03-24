import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'services/notification_service.dart'; // Import the service
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final NotificationService notificationService = NotificationService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/New_York'));
  await notificationService.init(); // Initialize the notification service
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Fitness Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'GoogleSans',
      ),
      home: SplashScreen(),
    );
  }
}
