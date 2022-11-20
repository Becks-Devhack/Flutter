import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hack/screens/DownloadScreen.dart';
import 'package:dev_hack/screens/LoadingScreen.dart';
import 'package:dev_hack/screens/PaymentCheckoutScreen.dart';
import 'package:dev_hack/screens/appFeatures_screen.dart';
import 'package:dev_hack/screens/carousel_screen.dart';
import 'package:dev_hack/screens/login_page.dart';
import 'package:dev_hack/screens/register_screen.dart';
import 'package:dev_hack/screens/splash.dart';
import 'package:dev_hack/screens/upload_employee.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        LoginPage.routeName: (ctx) => LoginPage(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        CarouselScreen.routeName: (ctx) => CarouselScreen(),
        UploadEmployee.routeName: (ctx) => UploadEmployee(),
        AppFeaturesScreen.routeName: (ctx) => AppFeaturesScreen(),
        PaymentCheckoutScreen.routeName: (ctx) => PaymentCheckoutScreen(),
        LoadingScreen.routeName: (ctx) => LoadingScreen(),
        DownloadScreen.routeName: (ctx) => DownloadScreen(),
      },
      home: const Splash(title: "splash_screen"),
    );
  }
}