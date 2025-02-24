import 'package:ahh/shourtcuts/coustm%20logo.dart';
import 'package:ahh/shourtcuts/coustom%20button.dart';
import 'package:ahh/shourtcuts/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _Sign();
}

class _Sign extends State<Sign> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
              SizedBox(
                height: 60,
              ),
              logo(),
              SizedBox(
                height: 20,
              ),
              Text(
                "Signup",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "login to continue to the app",
                style: TextStyle(color: Colors.grey[500], fontSize: 15),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                "Username ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Coustemtext(hinttext: "enter your Name", mycontroller: username),
              Text(
                "Email ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Coustemtext(hinttext: "enter your Email", mycontroller: email),
              SizedBox(
                height: 10,
              ),
              Text(
                "Password ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Coustemtext(
                  hinttext: "enter your password", mycontroller: password),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topRight,
                child: Text("Enter a password ?"),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          butn(
            title: "login",
            onPressed: () async {
              try {
                final credential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email.text,
                  password: password.text,
                );
                Navigator.of(context).pushReplacementNamed("home");
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e);
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed("Logn");
            },
            child: Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "If you have an account? "),
                    TextSpan(
                      text: "Login",
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
