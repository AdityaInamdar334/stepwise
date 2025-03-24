import 'package:pedometer/pedometer.dart';
import 'dart:async';

class PedometerService {
  Stream<StepCount>? _stepCountStream;
  String _steps = '0';
  String _calories = '0';
  String _distance = '0';

  String get steps => _steps;
  String get calories => _calories;
  String get distance => _distance;

  // Add this getter
  StreamSubscription<StepCount>? get stepCountSubscription =>
      _stepCountStream?.listen(_onData,
          onError: _onError, onDone: _onDone, cancelOnError: true);

  void startListening() {
    _stepCountStream = Pedometer.stepCountStream;
  }

  void _onData(StepCount event) {
    _steps = event.steps.toString();
    _calories = _calculateCalories(event.steps).toStringAsFixed(2);
    _distance = _calculateDistance(event.steps).toStringAsFixed(2);
  }

  void _onError(error) {
    print('Error: $error');
  }

  void _onDone() {
    print('Done');
  }

  double _calculateCalories(int steps) {
    // Basic calorie calculation (adjust as needed)
    return steps * 0.05;
  }

  double _calculateDistance(int steps) {
    // Basic distance calculation (adjust as needed)
    return steps * 0.762;
  }

  void stopListening() {
    _stepCountStream?.listen((event) {}).cancel();
  }

  void dispose() {
    //  _stepCountStream?.cancel();  // Remove this line
  }
}

