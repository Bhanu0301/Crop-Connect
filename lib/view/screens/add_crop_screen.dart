// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';

// class AddCropScreen extends StatefulWidget {
//   @override
//   _AddCropScreenState createState() => _AddCropScreenState();
// }

// class _AddCropScreenState extends State<AddCropScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _numberController = TextEditingController();
  
//   File? _image;

//   void _submitCrop(BuildContext context) async {
//     final String name = _nameController.text;
//     final String quantity = _quantityController.text;
//     final String price = _priceController.text;
//     final String location = _locationController.text;
//     final String number = _numberController.text;
//     if (name.isNotEmpty && quantity.isNotEmpty && price.isNotEmpty && location.isNotEmpty && number.isNotEmpty) {
//       try {
//         String imageUrl = await _uploadImage();
//         await FirebaseFirestore.instance.collection('crops').add({
//           'name': name,
//           'quantity': quantity,
//           'price': price,
//           'location': location,
//           'number': number,
//           'imageUrl': imageUrl,
//         });
//         Navigator.pop(context);
//       } catch (e) {
//         print('Error adding crop: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to add crop. Please try again.')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter all details for the crop.')),
//       );
//     }
//   }

//   Future<String> _uploadImage() async {
//     if (_image == null) {
//       return '';
//     }
//     try {
//       Reference storageReference = FirebaseStorage.instance.ref().child('crop_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
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

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Add New Crop'),
//     ),
//     body: Padding(
//       padding: EdgeInsets.all(20.0),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Crop Name'),
//             ),
//             TextField(
//               controller: _quantityController,
//               decoration: InputDecoration(labelText: 'Quantity'),
//             ),
//             TextField(
//               controller: _priceController,
//               decoration: InputDecoration(labelText: 'Price'),
//             ),
//             TextField(
//               controller: _locationController,
//               decoration: InputDecoration(labelText: 'Location'),
//             ),
//             TextField(
//               controller: _numberController,
//               decoration: InputDecoration(labelText: 'Number'),
//               keyboardType: TextInputType.number,
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
//               onPressed: () => _submitCrop(context),
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddCropScreen extends StatefulWidget {
  @override
  _AddCropScreenState createState() => _AddCropScreenState();
}

class _AddCropScreenState extends State<AddCropScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  
  File? _image;

  void _submitCrop(BuildContext context) async {
    final String name = _nameController.text;
    final String quantity = _quantityController.text;
    final String price = _priceController.text;
    final String location = _locationController.text;
    final String number = _numberController.text;
    if (name.isNotEmpty && quantity.isNotEmpty && price.isNotEmpty && location.isNotEmpty && number.isNotEmpty) {
      try {
        String imageUrl = await _uploadImage();
        await FirebaseFirestore.instance.collection('crops').add({
          'name': name,
          'quantity': quantity,
          'price': price,
          'location': location,
          'number': number,
          'imageUrl': imageUrl,
        });
        Navigator.pop(context);
      } catch (e) {
        print('Error adding crop: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add crop. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter all details for the crop.')),
      );
    }
  }

  Future<String> _uploadImage() async {
    if (_image == null) {
      return '';
    }
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child('crop_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
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
        title: Text('Add New Crop'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Crop Name'),
              ),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              TextField(
                controller: _numberController,
                decoration: InputDecoration(labelText: 'Number'),
                keyboardType: TextInputType.number,
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
                onPressed: () => _submitCrop(context),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
