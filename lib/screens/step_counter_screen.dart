import 'package:flutter/material.dart';
import '../services/pedometer_service.dart'; // Import the service
import '../services/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

class StepCounterScreen extends StatefulWidget {
  @override
  _StepCounterScreenState createState() => _StepCounterScreenState();
}

class _StepCounterScreenState extends State<StepCounterScreen> {
  final PedometerService _pedometerService = PedometerService();
  final PermissionService _permissionService = PermissionService();
  String _steps = '0';
  String _calories = '0';
  String _distance = '0';
  bool _isWalking = false;

  @override
  void initState() {
    super.initState();
    _init(); //call _init
  }

  void _init() async{ //create an async function
    final hasPermission = await _permissionService.checkActivityPermission();
    if(hasPermission){
      _startStepCounter();
    }
    else{
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
    _pedometerService.startListening(); // Start listening using the service
    // Update the UI with data from the service
    setState(() {
      _steps = _pedometerService.steps;
      _calories = _pedometerService.calories;
      _distance = _pedometerService.distance;
    });

    // Listen for changes in the step count and update the UI
    _pedometerService._stepCountSubscription?.onData((event) {
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
        title: Text("Permission Denied"),
        content: Text(
            "To track your steps, the app needs permission to access your activity data. Please enable it in your device settings."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              openAppSettings(); // Open app settings
            },
            child: Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pedometerService.stopListening();
    _pedometerService.dispose(); // Clean up the subscription
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Steps:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              _steps,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Calories:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              _calories,
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(height: 20),
            Text(
              'Distance (meters):',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              _distance,
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_isWalking) {
                  _showNotification();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Great job! Keep walking!"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
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

  Future<void> _showNotification() async {
    //moved the function here
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your_channel_id', 'Your Channel Name',
        channelDescription: 'Description of your channel',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'Step Goal Achieved!', 'You have reached your daily step goal!',
        notificationDetails,
        payload: 'item x');
  }
}