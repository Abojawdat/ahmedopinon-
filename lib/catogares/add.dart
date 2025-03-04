import 'package:ahh/shourtcuts/coustom%20button.dart';
import 'package:ahh/shourtcuts/textfoormadd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Addcat extends StatefulWidget {
  const Addcat({super.key});

  @override
  State<Addcat> createState() => _AddcatState();
}

class _AddcatState extends State<Addcat> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  Future<void> addUser() async {
    if (formState.currentState!.validate()) {
      try {
        await categories.add({
          'name': name.text,
        });

        print("Category Added");
        Navigator.of(context).pushReplacementNamed("home");
      } catch (error) {
        print("Failed to add category: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: Form(
          key: formState,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  child: Coustemtextaddd(
                      hinttext: "Enter a name ", mycontroller: name)),
              butn(
                title: "Add",
                onPressed: () {
                  addUser();
                },
              )
            ],
          )),
    );
  }
}
