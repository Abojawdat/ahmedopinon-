// import 'package:ahh/home.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:ahh/auth/login.dart';
import 'package:ahh/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/signup.dart';
import 'catogares/add.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('======================User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey[300],
              titleTextStyle: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              iconTheme: IconThemeData(color: Colors.orange))),
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? Homepage()
          : Logn(),
      routes: {
        "Sign": (context) => Sign(),
        "Logn": (context) => Logn(),
        "home": (context) => Homepage(),
        "Addcat": (context) => Addcat(),

      },
    );
  }
}
//
// mohammad
