// ProfileScreen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _currentUser;
  late Map<String, dynamic> _userData = {}; // Initialize with an empty map

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    _currentUser = _auth.currentUser!;
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(_currentUser.uid).get();
    setState(() {
      _userData = userSnapshot.data() as Map<String, dynamic>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: _userData.isNotEmpty // Check if _userData is not empty before using it
          ? Center(
              child: Card(
                margin: EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'User Profile',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.0),
                      ListTile(
                        title: Text(
                          'Name:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(_userData['name']),
                      ),
                      ListTile(
                        title: Text(
                          'Email:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(_userData['email']),
                      ),
                      ListTile(
                        title: Text(
                          'Phone Number:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(_userData['phoneNumber']),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}



// class _ProfileScreenState extends State<ProfileScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   late User _currentUser;
//   late Map<String, dynamic> _userData;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentUser();
//   }

//   Future<void> _getCurrentUser() async {
//     _currentUser = _auth.currentUser!;
//     DocumentSnapshot userSnapshot =
//         await _firestore.collection('users').doc(_currentUser.uid).get();
//     setState(() {
//       _userData = userSnapshot.data() as Map<String, dynamic>;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: _userData != null
//           ? Center(
//               child: Card(
//                 margin: EdgeInsets.all(16.0),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'User Profile',
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 10.0),
//                       ListTile(
//                         title: Text(
//                           'Name:',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Text(_userData['name']),
//                       ),
//                       ListTile(
//                         title: Text(
//                           'Email:',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Text(_userData['email']),
//                       ),
//                       ListTile(
//                         title: Text(
//                           'Phone Number:',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Text(_userData['phoneNumber']),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           : Center(
//               child: CircularProgressIndicator(),
//             ),
//     );
//   }
// }
