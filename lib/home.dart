import 'package:ahh/shourtcuts/coustom%20button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;

  Future<void> getData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid )
          .get();
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

  Future<void> deleteItem(String docId, int index) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(docId)
          .delete();
      setState(() {
        data.removeAt(index); // Remove the deleted item from the list
      });
    } catch (e) {
      print("Error deleting document: $e");
    }
  }

  void showDeleteDialog(String docId, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure you want to delete?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close the dialog
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              deleteItem(docId, index);
              Navigator.pop(context); // Close the dialog after deletion
            },
            child: const Text("OK", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () => Navigator.of(context).pushNamed("Addcat"),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        title: const Text("Home"),
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
                String docId = data[i].id; // Get document ID for deletion
                return InkWell(
                  onLongPress: () => showDeleteDialog(docId, i),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const Icon(Icons.folder_copy_outlined, size: 100),
                          Text(
                            data[i]['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              fontSize: 20,
                            ),
                          ),
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
