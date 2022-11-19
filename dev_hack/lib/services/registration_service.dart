import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  late String _hospitalName;
  late String _firstName;
  late String _lastName;
  late String _username;
  late UserType _user;
  late String _idDataBase;

  // doctors
  late String _fullName;
  late String _specialization;

  // common
  late String _email;
  late String _password;

  RegistrationUser(this._hospitalName, this._firstName, this._lastName, this._email, this._password, this._user);
  RegistrationUser.FromRegistrationUser(this._fullName, this._idDataBase, this._specialization, this._email, this._password, this._user);

  Future<RegistrationResponse> registerUser() async {
    try{
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);

      switch(_user) {
        case UserType.AppManager:
          var db = FirebaseFirestore.instance;
          var newUser = <String, dynamic> {
            "hospitalName": _hospitalName,
            "firstName": _firstName,
            "lastName": _lastName,
            'email': _email,
            "password": _password
          };
          db.collection('hospitals').add(newUser).then((DocumentReference doc) => _idDataBase = doc.id);
          break;
        case UserType.Doctor:
          var db = FirebaseFirestore.instance;
          var newUser = <String, dynamic>{
            'fullName': _fullName,
            'specialization': _specialization,
            'email': _email,
            'password': _password,
          };
          db.collection('hospitals').doc(_idDataBase).collection('doctors').add(newUser).then((value) => null);
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