import 'package:sensors_plus/sensors_plus.dart';

abstract class SleepRepository {
  Stream<AccelerometerEvent> get accelerometerStream;
  Future<List<double>> getWeeklyHistory();
  Future<void> saveSleepSession(double hours);
}

class SleepRepositoryImpl implements SleepRepository {
  @override
  Stream<AccelerometerEvent> get accelerometerStream => accelerometerEvents;

  @override
  Future<List<double>> getWeeklyHistory() async {
    // Mocking a fetch from local storage or Firebase
    return [0.75, 0.5, 0.65, 0.8, 0.55, 0.9, 0.4];
  }

  @override
  Future<void> saveSleepSession(double hours) async {
    // Mocking a save to local storage or Firebase
    print("Saving sleep session: $hours hours");
  }
}
