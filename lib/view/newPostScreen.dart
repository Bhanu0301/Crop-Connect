import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  File? _imageFile;

  void _submitPost(BuildContext context) async {
    final String title = _titleController.text;
    final String content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String? imageUrl;
          if (_imageFile != null) {
            imageUrl = await _uploadImage(_imageFile!);
          }

          await FirebaseFirestore.instance.collection('posts').add({
            'userId': user.uid,
            'title': title,
            'content': content,
            'userName': user.displayName,
            'likes': 0,
            'imageUrl': imageUrl,
          });
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User not authenticated. Please login.')),
          );
        }
      } catch (e) {
        print('Error submitting post: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit post. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter title and content for the post.')),
      );
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final storageRef = FirebaseStorage.instance.ref().child('posts/${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(imageFile);
      return await storageRef.getDownloadURL();
    }
  } catch (e) {
    print('Error uploading image: $e');
  }
  return null;
}


  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: null,
            ),
            SizedBox(height: 20),
            _imageFile != null
                ? Image.file(_imageFile!)
                : Container(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera),
                  label: Text('Take Photo'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icon(Icons.image),
                  label: Text('Gallery'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _submitPost(context),
              child: Text('Submit'),
            ),
          ],
        ),
      ), 
    );
  }
}
