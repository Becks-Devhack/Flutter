import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'HomeScreen.dart';
import 'LoginScreen.dart';
// import 'PageManager.dart';
import 'SplashScreen.dart';
//import 'StartScreen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
//   var db = FirebaseFirestore.instance;
//   final user = <String, dynamic>{
//     "first": "Ada",
//     "last": "Lovelace",
//     "hospitalId": 2,
//     "born": 1815
//   };
//
// // Add a new document with a generated ID
//   db.collection("users").add(user).then((DocumentReference doc) =>
//       print('DocumentSnapshot added with ID: ${doc.id}'));

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.routName: (ctx) => LoginScreen(),
        // ReportScreen.routName: (ctx) => ReportScreen(),
        // MapScreen.routName: (ctx) => MapScreen(),
        //PageManager.routName: (ctx) => PageManager(),
        // Random.routName: (ctx) => Random(),
        // LoginPage.routName: (ctx) => LoginPage(title: 'Login UI'),
      },
      home: SplashScreen(),
    );
  }
}