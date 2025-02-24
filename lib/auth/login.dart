import 'package:ahh/auth/signup.dart';
import 'package:ahh/shourtcuts/coustm%20logo.dart';
import 'package:ahh/shourtcuts/coustom%20button.dart';
import 'package:ahh/shourtcuts/textformfield.dart';
import 'package:flutter/material.dart';

class Logn extends StatefulWidget {
  const Logn({super.key});

  @override
  State<Logn> createState() => _Logn();
}

class _Logn extends State<Logn> {
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
                "login",
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
                child: Text("Forgot password ?"),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
         butn(title: "login",onPressed: (){},)
          ,SizedBox(
            height: 20,
          ),
          Text(
            "Or login with",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          MaterialButton(
              color: Colors.red,
              height: 60,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70)),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Google ",
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.gpp_good_outlined,
                    color: Colors.white,
                  )
                ],
              )),
          SizedBox(
            height: 20,
          ),
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
