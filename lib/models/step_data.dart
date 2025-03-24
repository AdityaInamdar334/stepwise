
class StepData {
  final int steps;
  final double calories;
  final double distance;
  final DateTime date;

  StepData({
    required this.steps,
    required this.calories,
    required this.distance,
    required this.date,
  });

  // You can add methods to format the data if needed
  String get formattedDate => "${date.year}-${date.month}-${date.day}";

  @override
  String toString() {
    return 'StepData{steps: $steps, calories: $calories, distance: $distance, date: $date}';
  }
}