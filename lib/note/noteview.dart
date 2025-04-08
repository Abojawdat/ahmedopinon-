import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class notview extends StatefulWidget {
  final String categoryid ;
  const notview({super.key, required this.categoryid});

  @override
  State<notview> createState() => _notview();
}

class _notview extends State<notview> {

  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;

  // Fetch categories from Firestore
  Future<void> getData() async {
    setState(() => isLoading = true);
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .doc(widget.categoryid).collection("notes").get();
      setState(() {
        data = querySnapshot.docs;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }


  // // Delete category
  // Future<void> deleteItem(String docId, int index) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('categories')
  //         .doc(docId)
  //         .delete();
  //     setState(() {
  //       data.removeAt(index); // Remove deleted item from the list
  //     });
  //   } catch (e) {
  //     print("Error deleting document: $e");
  //   }
  // }
  //
  // // Confirm delete dialog
  // void showDeleteDialog(String docId, int index) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text("Are you sure you want to delete?"),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text("Cancel"),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             deleteItem(docId, index);
  //             Navigator.pop(context);
  //           },
  //           child: const Text("OK", style: TextStyle(color: Colors.red)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Sign out user
  Future<void> handleSignOut() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
      }
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushNamedAndRemoveUntil("Logn", (route) => false);
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.orange,
      //   onPressed: () => Navigator.of(context).pushNamed("Addcat"),
      //   child: const Icon(Icons.add, color: Colors.white),
      // ),
      appBar: AppBar(
        title: const Text("Note view"),
        actions: [
          IconButton(
            onPressed: handleSignOut,
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 160,
        ),
        itemBuilder: (context, i) {
          String docId = data[i].id;

          return InkWell(
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                     mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${data[i]['name']}")
                      ],)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
