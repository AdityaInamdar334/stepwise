import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz; // Corrected import
import 'package:timezone/data/latest.dart' as tz;

import '../services/pedometer_service.dart';
import '../services/permission_service.dart';
import '../services/notification_service.dart';

class StepCounterScreen extends StatefulWidget {
  @override
  _StepCounterScreenState createState() => _StepCounterScreenState();
}

class _StepCounterScreenState extends State<StepCounterScreen> {
  final PedometerService _pedometerService = PedometerService();
  final PermissionService _permissionService = PermissionService();
  final NotificationService _notificationService = NotificationService();
  String _steps = '0';
  String _calories = '0';
  String _distance = '0';
  bool _isWalking = false;
  StreamSubscription<StepCount>? _stepCountSubscription;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin(); // Add this line


  @override
  void initState() {
    super.initState();
    _init();
    _showDailyNotification();
  }

  void _init() async {
    final hasPermission = await _permissionService.checkActivityPermission();
    if (hasPermission) {
      _startStepCounter();
    } else {
      _requestPermissionAndStart();
    }
  }

  Future<void> _requestPermissionAndStart() async {
    final status = await _permissionService.requestActivityPermission();
    if (status == PermissionStatus.granted) {
      _startStepCounter();
    } else {
      _showPermissionDeniedDialog();
    }
  }

  void _startStepCounter() {
    _pedometerService.startListening();
    setState(() {
      _steps = _pedometerService.steps;
      _calories = _pedometerService.calories;
      _distance = _pedometerService.distance;
    });

    _stepCountSubscription = _pedometerService.stepCountSubscription;
    _stepCountSubscription?.onData((event) {
      setState(() {
        _steps = _pedometerService.steps;
        _calories = _pedometerService.calories;
        _distance = _pedometerService.distance;
        _isWalking = int.parse(_steps) > 0;
      });
    });
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Permission Denied"),
        content: const Text(
            "To track your steps, the app needs permission to access your activity data. Please enable it in your device settings."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pedometerService.stopListening();
    _pedometerService.dispose();
    _stepCountSubscription?.cancel();
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your_channel_id', 'Your Channel Name',
        channelDescription: 'Description of your channel',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0,
        'Step Goal Achieved!',
        'You have reached your daily step goal!',
        notificationDetails,
        payload: 'item x');
  }

  Future<void> _showDailyNotification() async {
    await _notificationService.showDailyNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Steps:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              _steps,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Calories:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              _calories,
              style: const TextStyle(fontSize: 36),
            ),
            const SizedBox(height: 20),
            const Text(
              'Distance (meters):',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              _distance,
              style: const TextStyle(fontSize: 36),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_isWalking) {
                  _showNotification();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Great job! Keep walking!"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Start walking to track your steps!"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text(_isWalking ? 'Show Notification' : 'Start Walking'),
            ),
          ],
        ),
      ),
    );
  }
}

