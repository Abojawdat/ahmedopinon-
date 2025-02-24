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
            actions: [],
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
