import 'package:ahh/auth/signup.dart';
import 'package:ahh/shourtcuts/coustm%20logo.dart';
import 'package:ahh/shourtcuts/coustom%20button.dart';
import 'package:ahh/shourtcuts/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Logn extends StatefulWidget {
  const Logn({super.key});

  @override
  State<Logn> createState() => _Logn();
}

class _Logn extends State<Logn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
  }

  Future<void> resetPassword() async {
    if (email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your email first")),
      );
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Password Reset"),
          content: Text("A password reset link has been sent to your email."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  Future<void> login() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both email and password")),
      );
      return;
    }
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      if (credential.user!.emailVerified) {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Email Verification"),
            content: Text("Please check your email and verify your account."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided.';
      } else {
        errorMessage = "Error: ${e.message}";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60),
                  logo(),
                  SizedBox(height: 20),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Login to continue to the app",
                    style: TextStyle(color: Colors.grey[500], fontSize: 15),
                  ),
                  SizedBox(height: 7),
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Coustemtext(hinttext: "Enter your email", mycontroller: email),
                  SizedBox(height: 10),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Coustemtext(hinttext: "Enter your password", mycontroller: password),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: resetPassword,
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text("Forgot password?"),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
              SizedBox(height: 8),
              butn(
                title: "Login",
                onPressed: login, // Calls the login function
              ),
              SizedBox(height: 20),
              Text(
                "Or login with",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(height: 8),
              MaterialButton(
                color: Colors.red,
                height: 60,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
                onPressed: signInWithGoogle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Google ", style: TextStyle(color: Colors.white)),
                    Icon(Icons.gpp_good_outlined, color: Colors.white)
                  ],
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed("Sign");
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
