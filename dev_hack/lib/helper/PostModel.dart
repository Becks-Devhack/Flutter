import 'package:flutter/foundation.dart';

class FitBitRowData{
  final double breathing_rate;
  final double sleep_hrs;
  final double heart_rate;

  FitBitRowData(
      this.breathing_rate,
      this.sleep_hrs,
      this.heart_rate
      );

  factory FitBitRowData.fromJson(Map<String, dynamic> json) {
    return FitBitRowData(
      json['breathing_rate'] as double,
      json['sleep_hrs'] as double,
      json['heart_rate'] as double,
    );
  }
}

class StressLevel {
  final int stress_level;

  StressLevel(this.stress_level);

  factory StressLevel.fromJson(Map<String, dynamic> json) {
    return StressLevel(json['stress_level'] as int);
  }
}

class VacantionNeeded{
  final int take_vacantion;

  VacantionNeeded(this.take_vacantion);

  factory VacantionNeeded.fromJson(Map<String, dynamic> json) {
    return VacantionNeeded(json['take_vacantion'] as int);
  }
}

class StressLevelInterval{
  final int stress_level;
  final String day;

  StressLevelInterval(this.stress_level, this.day);

  factory StressLevelInterval.fromJson(Map<String, dynamic> json) {
    return StressLevelInterval(
        json['stress_level' as int],
        json['day'] as String
    );
  }
}