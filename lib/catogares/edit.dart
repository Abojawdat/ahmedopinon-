import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditCategoryScreen extends StatefulWidget {
  final String docId;
  const EditCategoryScreen({super.key, required this.docId});

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCategoryDetails();
  }

  // Fetch category details from Firestore
  Future<void> fetchCategoryDetails() async {
    setState(() => isLoading = true);
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('categories')
          .doc(widget.docId)
          .get();
      _nameController.text = doc['name']; // Pre-fill name field
    } catch (e) {
      print("Error fetching category: $e");
    }
    setState(() => isLoading = false);
  }

  // Save updated category name
  Future<void> saveCategory() async {
    if (_nameController.text.isEmpty) return;
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(widget.docId)
          .update({'name': _nameController.text});
      Navigator.pop(context, true); // Return true when category is updated
    } catch (e) {
      print("Error updating category: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Category")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Category Name"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveCategory,
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
