import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(Homepage());
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _homepage();
}

class _homepage extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("moh"),
            actions: [
              IconButton(
                  onPressed: () async {
                    GoogleSignIn googleSignIn =GoogleSignIn();
                    googleSignIn.disconnect();
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("Logn", (route) => false);
                  },
                  icon: Icon(Icons.exit_to_app))
            ],
          ),
          body: ListView(
            children: [
              FirebaseAuth.instance.currentUser!.emailVerified
                  ? Text("welcome ")
                  : MaterialButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();
                      },
                      child: Text("Please verfy your email "),
                    )
            ],
          )),
    );
  }
}
