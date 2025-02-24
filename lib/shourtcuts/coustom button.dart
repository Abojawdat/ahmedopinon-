import 'package:flutter/material.dart';
class butn extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const butn({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.red,
      height: 60,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(color: Colors.white,fontSize: 18),
      ),
    );
  }
}
