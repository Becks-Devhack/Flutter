import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum LoginResponse{
  LoignSuccessful,
  LoginError
}

enum LogoutResponse{
  LogoutSuccessful,
  LogoutError
}

class LoginUser {
  // common
  late String _email;
  late String _password;

 LoginUser(this._email, this._password);

  Future<LoginResponse> loginUser() async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      return LoginResponse.LoignSuccessful;
    } on FirebaseAuthException catch (e) {
      print (e.message);
    } catch (e) {
      print (e);
    }
    return LoginResponse.LoginError;
  }

  Future<void> logoutUser() async{
    await FirebaseAuth.instance.signOut();
  }
}