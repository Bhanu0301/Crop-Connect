// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:helloworld/utils/send_notification.dart';
// class ToolsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tools'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ToolList(),
//           ),
//           AddToolButton(),
//         ],
//       ),
//     );
//   }
// }
// Future<void> sendNotification(String recipientId, String message) async {
//   try {
//     // Send notification implementation
//     print('Notification sent to $recipientId: $message');
//   } catch (e) {
//     print('Failed to send notification: $e');
//   }
// }

// Future<void> storeNotification(String recipientId, String message) async {
//   try {
//     await FirebaseFirestore.instance.collection('notifications').add({
//       'recipientId': recipientId,
//       'message': message,
//       'timestamp': DateTime.now(), // Add a timestamp to sort notifications
//     });
//     print('Notification stored successfully');
//   } catch (e) {
//     print('Failed to store notification: $e');
//   }
// }

// class ToolList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('tools').snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(child: Text('No tools added yet.'));
//         }
//         return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             var tool = snapshot.data!.docs[index];
//             var name = tool['name'];
//             var price = tool['price'];
//             var contact = tool['contact'];
//             var location = tool['location'];
//             var imageUrl = tool['imageUrl'];

//             return Container(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Left section for image
//                       if (imageUrl != null)
//                         Container(
//                           width: 100,
//                           height: 100,
//                           margin: EdgeInsets.only(right: 16),
//                           child: Image.network(imageUrl, fit: BoxFit.cover),
//                         )
//                       else
//                         Container(
//                           width: 100,
//                           height: 100,
//                           margin: EdgeInsets.only(right: 16),
//                           child: Icon(Icons.image_not_supported),
//                         ),
//                       // Right section for details
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               name,
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(height: 8),
//                             Text('Price: $price'),
//                             Text('Contact: $contact'),
//                             Text('Location: $location'),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.call),
//                         onPressed: () {
//                           // Implement logic to call the contact number
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.message),
//                         onPressed: () {
//                           // Implement logic to send a message to the contact number
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.send),
//                         onPressed: () async {
//                           String toolOwnerId = tool['toolOwnerId']; // Retrieve the tool owner's ID
//                           String message = 'User has requested your tool: $name'; // Construct notification message
//                           sendNotification(toolOwnerId, message); // Call the method to send the notification
//                           storeNotification(toolOwnerId, message); // Store notification details in Firestore
//                         },
//                       ),
                      

//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }


// Future<String?> getToolOwnerId(String toolId) async {
//   try {
//     var toolSnapshot = await FirebaseFirestore.instance.collection('tools').doc(toolId).get();
//     if (toolSnapshot.exists) {
//       return toolSnapshot['toolOwnerId'];
//     } else {
//       return null; // Handle case where tool does not exist
//     }
//   } catch (e) {
//     print('Error getting tool owner ID: $e');
//     return null;
//   }
// }

// class AddToolButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => AddToolScreen()),
//         );
//       },
//       child: Text('Add New Tool'),
//     );
//   }
// }

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

// Import necessary packages
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:helloworld/view/screens/send_notification.dart';

// class ToolsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tools'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ToolList(),
//           ),
//           AddToolButton(),
//         ],
//       ),
//     );
//   }
// }

// class ToolList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('tools').snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(child: Text('No tools added yet.'));
//         }
//         return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             var tool = snapshot.data!.docs[index];
//             var name = tool['name'];
//             var price = tool['price'];
//             var contact = tool['contact'];
//             var location = tool['location'];
//             var imageUrl = tool['imageUrl'];

//             return ToolListItem(
//               name: name,
//               price: price,
//               contact: contact,
//               location: location,
//               imageUrl: imageUrl,
//               toolId: tool.id,
//             );
//           },
//         );
//       },
//     );
//   }
// }
// Future<void> storeNotification(String recipientId, String message) async {
//   try {
//     await FirebaseFirestore.instance.collection('notifications').add({
//       'recipientId': recipientId,
//       'message': message,
//       'timestamp': DateTime.now(), // Add a timestamp to sort notifications
//     });
//     print('Notification stored successfully');
//   } catch (e) {
//     print('Failed to store notification: $e');
//   }
// }
// Future<String?> getToolOwnerId(String toolId) async {
//   try {
//     var toolSnapshot = await FirebaseFirestore.instance.collection('tools').doc(toolId).get();
//     if (toolSnapshot.exists) {
//       return toolSnapshot['ownerId'];
//     } else {
//       return null; // Handle case where tool does not exist
//     }
//   } catch (e) {
//     print('Error getting tool owner ID: $e');
//     return null;
//   }
// }

// class ToolListItem extends StatelessWidget {
//   final String name;
//   final String price;
//   final String contact;
//   final String location;
//   final String? imageUrl;
//   final String toolId;

//   const ToolListItem({
//     required this.name,
//     required this.price,
//     required this.contact,
//     required this.location,
//     this.imageUrl,
//     required this.toolId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Left section for image
//               if (imageUrl != null)
//                 Container(
//                   width: 100,
//                   height: 100,
//                   margin: EdgeInsets.only(right: 16),
//                   child: Image.network(imageUrl!, fit: BoxFit.cover),
//                 )
//               else
//                 Container(
//                   width: 100,
//                   height: 100,
//                   margin: EdgeInsets.only(right: 16),
//                   child: Icon(Icons.image_not_supported),
//                 ),
//               // Right section for details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8),
//                     Text('Price: $price'),
//                     Text('Contact: $contact'),
//                     Text('Location: $location'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.call),
//                 onPressed: () {
//                   // Implement logic to call the contact number
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.message),
//                 onPressed: () {
//                   // Implement logic to send a message to the contact number
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.send),
//                 onPressed: () async {
//                   String? toolOwnerId = await getToolOwnerId(toolId); // Retrieve the tool owner's ID
//                   if (toolOwnerId != null) {
//                     String message = 'User has requested your tool: $name'; // Construct notification message
//                     //sendNotification(toolOwnerId, message); // Call the method to send the notification
//                     storeNotification(toolOwnerId, message); // Store notification details in Firestore
//                   } else {
//                     print('Error: Tool owner ID not found.');
//                   }
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AddToolButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => AddToolScreen()),
//         );
//       },
//       child: Text('Add New Tool'),
//     );
//   }
// }

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

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:helloworld/view/screens/add_crop_screen.dart';
// import 'package:helloworld/view/home_view.dart';
// import 'package:helloworld/view/screens/tools_add_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(('Farmers Space')),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'Tools'),
//               Tab(text: 'Crops'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             ToolsScreen(),
//             CropsScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ToolsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: ToolList(),
//           ),
//           AddToolButton(),
//         ],
//       ),
//     );
//   }
// }

// class ToolList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('tools').snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(child: Text('No tools added yet.'));
//         }
//         return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             var tool = snapshot.data!.docs[index];
//             var name = tool['name'];
//             var price = tool['price'];
//             var contact = tool['contact'];
//             var location = tool['location'];
//             var imageUrl = tool['imageUrl'];

//             return ToolListItem(
//               name: name,
//               price: price,
//               contact: contact,
//               location: location,
//               imageUrl: imageUrl,
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class ToolListItem extends StatelessWidget {
//   final String name;
//   final String price;
//   final String contact;
//   final String location;
//   final String? imageUrl;

//   const ToolListItem({
//     required this.name,
//     required this.price,
//     required this.contact,
//     required this.location,
//     this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(16),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (imageUrl != null)
//               Container(
//                 width: 100,
//                 height: 100,
//                 margin: EdgeInsets.only(right: 16),
//                 child: Image.network(imageUrl!, fit: BoxFit.cover),
//               )
//             else
//               Container(
//                 width: 100,
//                 height: 100,
//                 margin: EdgeInsets.only(right: 16),
//                 child: Icon(Icons.image_not_supported),
//               ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text('Price: $price'),
//                   Text('Contact: $contact'),
//                   Text('Location: $location'),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.topCenter,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.phone),
//                     onPressed: () {
//                       _makePhoneCall(contact);
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.mail),
//                     onPressed: () {
//                       _sendMessage(contact);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AddToolButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => AddToolScreen()),
//         );
//       },
//       child: Text('Add New Tool'),
//     );
//   }
// }

// class CropsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: CropList(),
//           ),
//           AddCropButton(),
//         ],
//       ),
//     );
//   }
// }

// class CropList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('crops').snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(child: Text('No crops added yet.'));
//         }
//         return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             var crop = snapshot.data!.docs[index];
//             var name = crop['name'];
//             var quantity = crop['quantity'];
//             var price = crop['price'];
//             var location = crop['location'];
//             var number = crop['number'];
//             var imageUrl = crop['imageUrl'];

//             return CropListItem(
//               name: name,
//               quantity: quantity,
//               price: price,
//               location: location,
//               number: number,
//               imageUrl: imageUrl,
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class CropListItem extends StatelessWidget {
//   final String name;
//   final String quantity;
//   final String price;
//   final String location;
//   final String number;
//   final String? imageUrl;

//   const CropListItem({
//     required this.name,
//     required this.quantity,
//     required this.price,
//     required this.location,
//     required this.number,
//     this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(color: Colors.grey.shade300),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(16),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (imageUrl != null)
//               Container(
//                 width: 100,
//                 height: 100,
//                 margin: EdgeInsets.only(right: 16),
//                 child: Image.network(imageUrl!, fit: BoxFit.cover),
//               )
//             else
//               Container(
//                 width: 100,
//                 height: 100,
//                 margin: EdgeInsets.only(right: 16),
//                 child: Icon(Icons.image_not_supported),
//               ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text('Quantity: $quantity'),
//                   Text('Price: $price'),
//                   Text('Location: $location'),
//                   Text('Number: $number'),
//                 ],
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.phone),
//                   onPressed: () {
//                     _makePhoneCall(number);
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.mail),
//                   onPressed: () {
//                     _sendMessage(number);
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void _makePhoneCall(String phoneNumber) async {
//   String url = 'tel:$phoneNumber';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// void _sendMessage(String phoneNumber) async {
//   String url = 'sms:$phoneNumber';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// class AddCropButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => AddCropScreen()),
//         );
//       },
//       child: Text('Add New Crop'),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: MainScreen(),
//   ));
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:helloworld/view/screens/add_crop_screen.dart';
import 'package:helloworld/view/screens/tools_add_screen.dart';

void main() {
  runApp(MaterialApp(
    home: MainScreen(),
  ));
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Tools'),
                Tab(text: 'Crops'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ToolsScreen(),
                  CropsScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ToolsScreen extends StatefulWidget {
  @override
  _ToolsScreenState createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tools'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Set the background color here
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Tools',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ToolList(searchQuery: _searchQuery),
          ),
          AddToolButton(),
        ],
      ),
    );
  }
}

class CropsScreen extends StatefulWidget {
  @override
  _CropsScreenState createState() => _CropsScreenState();
}

class _CropsScreenState extends State<CropsScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crops'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Set the background color here
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Crops',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: CropList(searchQuery: _searchQuery),
          ),
          AddCropButton(),
        ],
      ),
    );
  }
}

class ToolList extends StatelessWidget {
  final String searchQuery;

  ToolList({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('tools').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No tools added yet.'));
        }
        var filteredTools = snapshot.data!.docs.where((tool) {
          var name = tool['name'].toString().toLowerCase();
          return name.contains(searchQuery.toLowerCase());
        }).toList();
        return ListView.builder(
          itemCount: filteredTools.length,
          itemBuilder: (context, index) {
            var tool = filteredTools[index];
            var name = tool['name'];
            var price = tool['price'];
            var contact = tool['contact'];
            var location = tool['location'];
            var imageUrl = tool['imageUrl'];

            return ToolListItem(
              name: name,
              price: price,
              contact: contact,
              location: location,
              imageUrl: imageUrl,
            );
          },
        );
      },
    );
  }
}

class CropList extends StatelessWidget {
  final String searchQuery;

  CropList({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('crops').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No crops added yet.'));
        }
        var filteredCrops = snapshot.data!.docs.where((crop) {
          var name = crop['name'].toString().toLowerCase();
          return name.contains(searchQuery.toLowerCase());
        }).toList();
        return ListView.builder(
          itemCount: filteredCrops.length,
          itemBuilder: (context, index) {
            var crop = filteredCrops[index];
            var name = crop['name'];
            var quantity = crop['quantity'];
            var price = crop['price'];
            var location = crop['location'];
            var number = crop['number'];
            var imageUrl = crop['imageUrl'];

            return CropListItem(
              name: name,
              quantity: quantity,
              price: price,
              location: location,
              number: number,
              imageUrl: imageUrl,
            );
          },
        );
      },
    );
  }
}

class ToolListItem extends StatelessWidget {
  final String name;
  final String price;
  final String contact;
  final String location;
  final String? imageUrl;

  const ToolListItem({
    required this.name,
    required this.price,
    required this.contact,
    required this.location,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(right: 16),
                child: Image.network(imageUrl!, fit: BoxFit.cover),
              )
            else
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(right: 16),
                child: Icon(Icons.image_not_supported),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Price: $price'),
                  Text('Contact: $contact'),
                  Text('Location: $location'),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.phone),
                    onPressed: () {
                      _makePhoneCall(contact);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.mail),
                    onPressed: () {
                      _sendMessage(contact);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddToolButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddToolScreen()),
        );
      },
      child: Text('Add New Tool'),
    );
  }
}

class CropListItem extends StatelessWidget {
  final String name;
  final String quantity;
  final String price;
  final String location;
  final String number;
  final String? imageUrl;

  const CropListItem({
    required this.name,
    required this.quantity,
    required this.price,
    required this.location,
    required this.number,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(right: 16),
                child: Image.network(imageUrl!, fit: BoxFit.cover),
              )
            else
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(right: 16),
                child: Icon(Icons.image_not_supported),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Quantity: $quantity'),
                  Text('Price: $price'),
                  Text('Location: $location'),
                  Text('Number: $number'),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.phone),
                  onPressed: () {
                    _makePhoneCall(number);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.mail),
                  onPressed: () {
                    _sendMessage(number);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddCropButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddCropScreen()),
        );
      },
      child: Text('Add New Crop'),
    );
  }
}

void _makePhoneCall(String phoneNumber) async {
  String url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _sendMessage(String phoneNumber) async {
  String url = 'sms:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
