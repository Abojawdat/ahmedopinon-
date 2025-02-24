import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              IconButton(onPressed: ()async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil("Logn", (route) => false);
              }, icon: Icon(Icons.exit_to_app))
            ],
          ),
          body: ListView(
            children: [
              Text(
                "how are you ",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.red,
                    fontFamily: "Oswald-VariableFont_wght"),
              ),
            ],
          )),
    );
  }
}
