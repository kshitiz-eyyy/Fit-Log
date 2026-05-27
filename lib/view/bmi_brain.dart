import 'dart:math';

class BMIBrain {
  final double height; // in cm
  final double weight; // in kg

  BMIBrain({required this.height, required this.weight});

  // Calculate the raw BMI value
  double calculateBMI() {
    double heightInMeters = height / 100;
    return weight / pow(heightInMeters, 2);
  }

  // Determine the weight category string
  String getCategory(double bmi) {
    if (bmi < 18.5) return "UNDERWEIGHT";
    if (bmi >= 18.5 && bmi < 25) return "NORMAL";
    if (bmi >= 25 && bmi < 30) return "OVERWEIGHT";
    return "OBESE";
  }

  // Determine the feedback summary message
  String getFeedback(double bmi) {
    if (bmi < 18.5) {
      return "Based on your height and weight, you are below the standard range. Consider a nutrition plan.";
    } else if (bmi >= 18.5 && bmi < 25) {
      return "Based on your height and weight, you are in a healthy, optimal range. Keep maintaining your lifestyle!";
    } else if (bmi >= 25 && bmi < 30) {
      return "Based on your height and weight, you are within the athletic-overweight range. Focus on body composition.";
    } else {
      return "Based on your height and weight, you are within the obese range. Focus on active cardio and dietary adjustments.";
    }
  }

  // Map the BMI score to a percentage width (0.0 to 1.0) for our visual linear progress bar
  double getProgressValue(double bmi) {
    if (bmi < 18.5) return 0.3;
    if (bmi >= 18.5 && bmi < 25) return 0.5;
    if (bmi >= 25 && bmi < 30) return 0.75;
    return 1.0;
  }
}