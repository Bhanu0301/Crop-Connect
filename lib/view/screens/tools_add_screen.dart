// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';

// class AddToolScreen extends StatefulWidget {
//   @override
//   _AddToolScreenState createState() => _AddToolScreenState();
// }

// class _AddToolScreenState extends State<AddToolScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _contactController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   File? _image;

//   void _submitTool(BuildContext context) async {
//     final String name = _nameController.text;
//     final String price = _priceController.text;
//     final String contact = _contactController.text;
//     final String location = _locationController.text;

//     if (name.isNotEmpty && price.isNotEmpty && contact.isNotEmpty && location.isNotEmpty) {
//       try {
//         String imageUrl = await _uploadImage();
//         await FirebaseFirestore.instance.collection('tools').add({
//           'name': name,
//           'price': price,
//           'contact': contact,
//           'location': location,
//           'imageUrl': imageUrl,
//         });
//         Navigator.pop(context);
//       } catch (e) {
//         print('Error adding tool: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to add tool. Please try again.')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter all details for the tool.')),
//       );
//     }
//   }

//   Future<String> _uploadImage() async {
//     if (_image == null) {
//       return '';
//     }
//     try {
//       Reference storageReference = FirebaseStorage.instance.ref().child('tool_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
//       UploadTask uploadTask = storageReference.putFile(_image!);
//       await uploadTask.whenComplete(() => null);
//       String downloadUrl = await storageReference.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print('Error uploading image: $e');
//       throw Exception('Failed to upload image');
//     }
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Tool'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Tool Name'),
//             ),
//             TextField(
//               controller: _priceController,
//               decoration: InputDecoration(labelText: 'Price'),
//             ),
//             TextField(
//               controller: _contactController,
//               decoration: InputDecoration(labelText: 'Contact'),
//             ),
//             TextField(
//               controller: _locationController,
//               decoration: InputDecoration(labelText: 'Location'),
//             ),
//             SizedBox(height: 20),
//             _image != null
//                 ? Image.file(_image!)
//                 : SizedBox(height: 0),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () => _pickImage(ImageSource.camera),
//                   icon: Icon(Icons.camera),
//                   label: Text('Take Photo'),
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: () => _pickImage(ImageSource.gallery),
//                   icon: Icon(Icons.image),
//                   label: Text('Choose from Gallery'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _submitTool(context),
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddToolScreen extends StatefulWidget {
  @override
  _AddToolScreenState createState() => _AddToolScreenState();
}

class _AddToolScreenState extends State<AddToolScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  File? _image;

  void _submitTool(BuildContext context) async {
    final String name = _nameController.text;
    final String price = _priceController.text;
    final String contact = _contactController.text;
    final String location = _locationController.text;

    if (name.isNotEmpty && price.isNotEmpty && contact.isNotEmpty && location.isNotEmpty) {
      try {
        String imageUrl = await _uploadImage();
        await FirebaseFirestore.instance.collection('tools').add({
          'name': name,
          'price': price,
          'contact': contact,
          'location': location,
          'imageUrl': imageUrl,
        });
        Navigator.pop(context);
      } catch (e) {
        print('Error adding tool: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add tool. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter all details for the tool.')),
      );
    }
  }

  Future<String> _uploadImage() async {
    if (_image == null) {
      return '';
    }
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child('tool_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = storageReference.putFile(_image!);
      await uploadTask.whenComplete(() => null);
      String downloadUrl = await storageReference.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception('Failed to upload image');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Tool'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Tool Name'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: _contactController,
                decoration: InputDecoration(labelText: 'Contact'),
              ),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              SizedBox(height: 20),
              _image != null
                  ? Image.file(_image!)
                  : SizedBox(height: 0),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: Icon(Icons.camera),
                      label: Text('Take Photo'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: Icon(Icons.image),
                      label: Text('Choose from Gallery'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submitTool(context),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
