import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../helper/Employee.dart';

//code for designing the UI of our text field where the user writes his email id or password

enum RegistrationResponse{
  RegistrationSuccessful,
  WeakPassword,
  EmailAlreadyInUse,
  OtherError
}

enum UserType{
  AppManager,
  Doctor,
  Patient
}

class RegistrationUser {
  //appManager
  String _hospitalName = '';
  String _firstName = '';
  String _lastName = '';
  UserType _user = UserType.AppManager;
  String _idDataBase = '';

  // doctors
  String _fullName = '';

  // common
  String _email = '';
  String _password = '';

  Employee employee = Employee('', '');
  String tag = '';

  RegistrationUser(this._hospitalName, this._firstName, this._lastName, this._email, this._password, this._user);
  RegistrationUser.FromRegistrationUser(this.employee, this.tag, this._user);

  Future<RegistrationResponse> registerUser() async {
    try{
      final credential;
      if (_user == UserType.Doctor) {
        credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: employee.email, password: employee.password);
      } else {
        credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      }

      switch(_user) {
        case UserType.AppManager:
          var db = FirebaseFirestore.instance;
          var newUser = <String, dynamic> {
            "company": _hospitalName,
            "firstName": _firstName,
            "lastName": _lastName,
            'email': _email,
            "password": _password,
            "id_company": _idDataBase,
            "status": "Admin"
          };
          await db.collection('company').add(newUser).then((DocumentReference doc) => _idDataBase = doc.path.split('/')[1]);
          db.collection('company').doc(_idDataBase).update({'id_company': _idDataBase});
          break;
        case UserType.Doctor:
          print('fjihdsasodiufjsd');
          var db = FirebaseFirestore.instance;
          var newUser = <String, dynamic>{
            'fullName': employee.full_name,
            'email': employee.email,
            'password': employee.password,
            'id_company': employee.id_company,
            'status': employee.status,
            'wellness': employee.wellness_score.toString(),
          };
          db.collection('company').doc(tag).collection('employee').add(newUser).then((value) => print(value.id));
          break;
      }

      return RegistrationResponse.RegistrationSuccessful;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return RegistrationResponse.WeakPassword;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return RegistrationResponse.EmailAlreadyInUse;
      }
    } catch (e) {
      print(e);
      return RegistrationResponse.OtherError;
    }

    return RegistrationResponse.OtherError;
  }
}