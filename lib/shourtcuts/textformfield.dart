import 'package:flutter/material.dart';
class Coustemtext extends StatelessWidget {
  final String hinttext ;
  final TextEditingController mycontroller;

  const Coustemtext({super.key, required this.hinttext, required this.mycontroller});

  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
        controller: mycontroller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[400],
          hintText: hinttext,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(80),
              borderSide: BorderSide(color: Colors.grey)),
        ),
      );
  }
}
