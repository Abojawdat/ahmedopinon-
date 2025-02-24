import 'package:flutter/material.dart';
class logo extends StatelessWidget {
  const logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 110,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(80)),
        child: Image.asset(
          "images/iamlogo.jpg",
          height: 80,
        ),
      ),
    );
  }
}
