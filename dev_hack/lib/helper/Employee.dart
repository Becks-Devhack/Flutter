import 'dart:core';
import 'dart:math';
import 'package:random_password_generator/random_password_generator.dart';

Random random = new Random();

class Employee {
  late String email;
  late String full_name;
  late String password;
  String status = 'Employee';
  String id_company = 'F5nZvvHRYSVGoj2VGcsB';
  int wellness_score = random.nextInt(0) + 10;

  Employee(this.email, this.full_name) {
    final password = RandomPasswordGenerator();
    this.password = password.randomPassword(numbers: true, specialChar: false, passwordLength: 10);
  }

  Employee.fromEmployee(this.email, this.full_name, this.password, this.wellness_score, this.id_company, this.status);

  factory Employee.FromJson(Map<String, dynamic> json) {
    return Employee.fromEmployee(
      json['email'],
      json['full_name'],
      json['password'],
      json['wellness_score'],
      json['id_company'],
      json['status']
    );
  }
}