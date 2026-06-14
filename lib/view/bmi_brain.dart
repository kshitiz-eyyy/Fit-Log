import 'dart:math';

class BMIBrain {
  final double height;
  final double weight;

  BMIBrain({required this.height, required this.weight});


  double calculateBMI() {
    double heightInMeters = height / 100;
    return weight / pow(heightInMeters, 2);
  }


  String getCategory(double bmi) {
    if (bmi < 18.5) return "UNDERWEIGHT";
    if (bmi >= 18.5 && bmi < 25) return "NORMAL";
    if (bmi >= 25 && bmi < 30) return "OVERWEIGHT";
    return "OBESE";
  }


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


  double getProgressValue(double bmi) {
    if (bmi < 18.5) return 0.3;
    if (bmi >= 18.5 && bmi < 25) return 0.5;
    if (bmi >= 25 && bmi < 30) return 0.75;
    return 1.0;
  }
}