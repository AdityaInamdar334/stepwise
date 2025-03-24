
import 'package:flutter/material.dart';

// Example of a helper function for calculating BMI (you can add more)
double calculateBMI(double weightInKg, double heightInMeters) {
  if (heightInMeters <= 0) {
    return 0; // Or handle the error as you prefer
  }
  return weightInKg / (heightInMeters * heightInMeters);
}

//Helper function for showing a snackbar
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}