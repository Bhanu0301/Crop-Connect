// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:helloworld/view/screens/home_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// class NotificationScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('notifications')
//             .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//             .orderBy('createdAt', descending: true)
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text('No notifications available'),
//             );
//           }

//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               var notification = snapshot.data!.docs[index];
//               var message = notification['message'];

//               return ListTile(
//                 title: Text(message),
//                 // Add navigation to the post when tapped
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => HomeScreen(),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helloworld/view/screens/home_screen.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No notifications available'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var notification = snapshot.data!.docs[index];
              var message = notification['message'];
              var read = notification['read'] ?? false; // Use default value if isRead field is not present
              var notificationId = notification.id; // Get the document ID

              return ListTile(
                leading: Icon(
                  Icons.notifications, // Use any icon that represents notifications
                  color: read ? Colors.grey : Colors.blue, // Different color for read and unread notifications
                ),
                title: Text(
                  message,
                  style: TextStyle(
                    fontWeight: read ? FontWeight.normal : FontWeight.bold, // Bold text for unread notifications
                  ),
                ),
                // Add navigation to the post when tapped
                onTap: () {
                  // Update isRead field to true when notification is tapped
                  FirebaseFirestore.instance.collection('notifications').doc(notificationId).update({'read': true});
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:helloworld/view/screens/home_screen.dart';

// class NotificationScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('notifications')
//             .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//             .orderBy('createdAt', descending: true)
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text('No notifications available'),
//             );
//           }

//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               var notification = snapshot.data!.docs[index];
//               var message = notification['message'];
//               var read = notification['read'] ?? false; // Use default value if isRead field is not present

//               return ListTile(
//                 leading: Icon(
//                   Icons.notifications, // Use any icon that represents notifications
//                   color: read ? Colors.grey : Colors.blue, // Different color for read and unread notifications
//                 ),
//                 title: Text(
//                   message,
//                   style: TextStyle(
//                     fontWeight: read ? FontWeight.normal : FontWeight.bold, // Bold text for unread notifications
//                   ),
//                 ),
//                 // Add navigation to the post when tapped
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => HomeScreen(),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
