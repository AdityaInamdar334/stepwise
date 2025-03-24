import 'package:pedometer/pedometer.dart';
import 'dart:async';

class PedometerService {
  Stream<StepCount>? _stepCountStream;
  StreamSubscription<StepCount>? _stepCountSubscription;
  String _steps = '0';
  String _calories = '0';
  String _distance = '0';

  // Initialize the pedometer stream
  void startListening() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountSubscription = _stepCountStream?.listen(
      _onData,
      onError: _onError,
      onDone: _onDone,
      cancelOnError: true,
    );
  }

  //stop listening
  void stopListening(){
    _stepCountSubscription?.cancel();
  }

  // Get the current step count
  String get steps => _steps;
  String get calories => _calories;
  String get distance => _distance;

  // Handle new step data
  void _onData(StepCount event) {
    print(event);
    int steps = event.steps;
    double calories = steps * 0.04; // Simplified calorie calculation
    double distance = steps * 0.000762; // Simplified distance (meters)
    _steps = steps.toString();
    _calories = calories.toStringAsFixed(2);
    _distance = distance.toStringAsFixed(2);
  }

  // Handle errors
  void _onError(error) {
    print('Error with pedometer: $error');
    _steps = 'Error';
  }

  void _onDone() {
    print('Pedometer stream done');
  }

  // Dispose the stream subscription to prevent memory leaks
  void dispose() {
    _stepCountSubscription?.cancel();
  }
}

