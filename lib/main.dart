// import 'package:ahh/home.dart';
// import 'package:ahh/home.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:ahh/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
//dgf
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Logn(),
      routes: {
        "Sign" :(context) => Sign(),
        "Logn" :(context) => Logn(),
      },
    );
  }
}
