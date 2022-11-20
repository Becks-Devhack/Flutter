import 'dart:core';

import 'package:random_password_generator/random_password_generator.dart';

class Employee {
  late String email;
  late String full_name;
  late String password;
  String status = 'Employee';
  String id_company = 'F5nZvvHRYSVGoj2VGcsB';
  int wellness_score = 0;

  Employee(this.email, this.full_name) {
    final password = RandomPasswordGenerator();
    this.password = password.randomPassword(numbers: true, specialChar: true, passwordLength: 10);
  }
}