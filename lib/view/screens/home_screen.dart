// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           final posts = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: posts.length,
//             itemBuilder: (context, index) {
//               final post = posts[index];
//               return Card(
//                 margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 child: ListTile(
//                   title: Text(post['title']),
//                   subtitle: Text(post['content']),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           // Implement like functionality
//                         },
//                         icon: Icon(Icons.thumb_up),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           // Implement comment functionality
//                         },
//                         icon: Icon(Icons.comment),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/new-post');
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
// home_screen.dart
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:helloworld/view/newPostScreen.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           final posts = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: posts.length,
//             itemBuilder: (context, index) {
//               final post = posts[index];
//               return FutureBuilder<DocumentSnapshot>(
//                 future: FirebaseFirestore.instance.collection('users').doc(post['userId']).get(),
//                 builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
//                   if (userSnapshot.connectionState == ConnectionState.waiting) {
//                     return SizedBox(); // Return empty container while waiting
//                   }
//                   if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
//                     return SizedBox(); // Return empty container if user document doesn't exist
//                   }
//                   final userData = userSnapshot.data!.data() as Map<String, dynamic>;
//                   final userName = userData['name'] as String? ?? 'Unknown User';
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                     child: ListTile(
//                       title: Text(post['title']),
//                       subtitle: Text(post['content']),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               // Implement like functionality
//                             },
//                             icon: Icon(Icons.thumb_up),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               // Implement comment functionality
//                             },
//                             icon: Icon(Icons.comment),
//                           ),
//                         ],
//                       ),
//                       // Display the user's name
//                       leading: Text(userName),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/new-post');
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           final posts = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: posts.length,
//             itemBuilder: (context, index) {
//               final post = posts[index];
//               return FutureBuilder<DocumentSnapshot>(
//                 future: FirebaseFirestore.instance.collection('users').doc(post['userId']).get(),
//                 builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
//                   if (userSnapshot.connectionState == ConnectionState.waiting) {
//                     return SizedBox(); // Return empty container while waiting
//                   }
//                   if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
//                     return SizedBox(); // Return empty container if user document doesn't exist
//                   }
//                   final userData = userSnapshot.data!.data() as Map<String, dynamic>;
//                   final userName = userData['name'] as String? ?? 'Unknown User';
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                     child: ListTile(
//                       title: Text(post['title']),
//                       subtitle: Text(post['content']),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               // Implement like functionality
//                             },
//                             icon: Icon(Icons.thumb_up),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               // Implement comment functionality
//                             },
//                             icon: Icon(Icons.comment),
//                           ),
//                         ],
//                       ),
//                       // Display the user's name
//                       leading: Text(userName),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/new-post');
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:helloworld/view/newPostScreen.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           final posts = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: posts.length,
//             itemBuilder: (context, index) {
//               final post = posts[index];
//               return FutureBuilder<DocumentSnapshot>(
//                 future: FirebaseFirestore.instance.collection('users').doc(post['userId']).get(),
//                 builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
//                   if (userSnapshot.connectionState == ConnectionState.waiting) {
//                     return SizedBox(); // Return empty container while waiting
//                   }
//                   final userName = userSnapshot.data!.get('name') as String? ?? 'Unknown User';
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                     child: ListTile(
//                       title: Text(post['title']),
//                       subtitle: Text(post['content']),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               // Implement like functionality
//                             },
//                             icon: Icon(Icons.thumb_up),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               // Implement comment functionality
//                             },
//                             icon: Icon(Icons.comment),
//                           ),
//                         ],
//                       ),
//                       // Display the user's name
//                       leading: Text(userName),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostScreen()));
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: StreamBuilder<User?>(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Text('Home');
//             }
//             if (snapshot.hasData) {
//               return Text('Home - ${snapshot.data!.displayName ?? 'Unknown'}');
//             } else {
//               return Text('Home');
//             }
//           },
//         ),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           final posts = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: posts.length,
//             itemBuilder: (context, index) {
//               final post = posts[index];
//               return Card(
//                 margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 child: ListTile(
//                   title: Text(post['title']),
//                   subtitle: Text(post['content']),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           // Implement like functionality
//                         },
//                         icon: Icon(Icons.thumb_up),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           // Implement comment functionality
//                         },
//                         icon: Icon(Icons.comment),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/new-post');
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text('No posts available'),
//             );
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final post = snapshot.data!.docs[index];
//               final title = post['title'] ?? '';
//               final content = post['content'] ?? '';

//               return FutureBuilder<DocumentSnapshot>(
//                 future: FirebaseFirestore.instance.collection('users').doc(post['userId']).get(),
//                 builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
//                   if (userSnapshot.connectionState == ConnectionState.waiting || !userSnapshot.hasData) {
//                     return SizedBox();
//                   }
//                   final userData = userSnapshot.data!.data() as Map<String, dynamic>?;

//                   final username = userData?['userName'] ?? 'Unknown';

//                   return Card(
//                     margin: EdgeInsets.all(10),
//                     child: Padding(
//                       padding: EdgeInsets.all(10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             username,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             title,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             content,
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ],
//                       ),
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
//It works well
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(
//                     child: Text('No posts available'),
//                   );
//                 }

//                 return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     var post = snapshot.data!.docs[index];
//                     var title = post['title'];
//                     var content = post['content'];
//                     var userName = post['userName']; // Corrected field name

//                     return Card(
//                       margin: EdgeInsets.all(10),
//                       child: Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               userName ?? 'Unknown User', // Display a default if userName is null
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                               title ?? 'Untitled',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                               content ?? '',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ElevatedButton.icon(
//                                   onPressed: () {
//                                     // Implement like functionality
//                                   },
//                                   icon: Icon(Icons.thumb_up),
//                                   label: Text('Like'),
//                                 ),
//                                 ElevatedButton.icon(
//                                   onPressed: () {
//                                     // Implement comment functionality
//                                   },
//                                   icon: Icon(Icons.comment),
//                                   label: Text('Comment'),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/new-post');
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HomeScreen(),
//   ));
// }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:helloworld/view/screens/comment_screen.dart';
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(
//                     child: Text('No posts available'),
//                   );
//                 }

//                 return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     var post = snapshot.data!.docs[index];
//                     var title = post['title'];
//                     var content = post['content'];
//                     var userName = post['userName']; // Corrected field name
//                     var postId = post.id; // Get the ID of the post
//                     var likes = post['likes'] ?? 0; // Get the likes count or default to 0
//                     return FutureBuilder(
//                     future: FirebaseFirestore.instance
//                         .collection('posts')
//                         .doc(postId)
//                         .collection('comments')
//                         .get(),
//                     builder: (context, AsyncSnapshot<QuerySnapshot> commentsSnapshot) {
//                       if (commentsSnapshot.connectionState ==
//                           ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       }
//                       if (!commentsSnapshot.hasData) {
//                         return Text('0 Comments');
//                       }

//                       var commentsCount = commentsSnapshot.data!.docs.length;


//                     return Card(
//                       margin: EdgeInsets.all(10),
//                       child: Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               userName ?? 'Unknown User', // Display a default if userName is null
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                               title ?? 'Untitled',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                               content ?? '',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ElevatedButton.icon(
//                                   onPressed: () {
//                                     // Implement like functionality
//                                     _likePost(postId);
//                                   },
//                                   icon: Icon(Icons.thumb_up),
//                                   label: Text('Like ($likes)'),
//                                   // style: ElevatedButton.styleFrom(
//                                   //   backgroundColor: Theme.of(context).primaryColorDark, // Use dark theme color
//                                   // ),
//                                 ),
//                                 ElevatedButton.icon(
//                                   onPressed: () {
//                                     // Implement comment functionality
//                                     _navigateToCommentsScreen(context, postId);
//                                   },
//                                   icon: Icon(Icons.comment),
//                                   label: Text('Comment($commentsCount)'),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/new-post');
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   // Function to handle liking a post
//   void _likePost(String postId) {
//   // Reference to the document of the post
//   var postRef = FirebaseFirestore.instance.collection('posts').doc(postId);

//   // Increment the like count in Firestore using a transaction
//   FirebaseFirestore.instance.runTransaction((transaction) async {
//     DocumentSnapshot snapshot = await transaction.get(postRef);

//     if (snapshot.exists) {
//       // Get the current like count
//       Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//       int currentLikes = (data['likes'] ?? 0) as int;

//       // Increment the like count by 1
//       int newLikes = currentLikes + 1;

//       // Update the like count in Firestore
//       transaction.update(postRef, {'likes': newLikes});
//     }
//   }).then((value) {
//     // Like count updated successfully
//     // Update the UI by calling setState to rebuild the widget
//     setState(() {});
//   }).catchError((error) {
//     // Handle errors here if any
//     print("Failed to like post: $error");
//   });
// }


//   // Function to navigate to the comments screen
//   void _navigateToCommentsScreen(BuildContext context, String postId) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => CommentScreen(postId: postId),
//     ),
//   );
// }
// }
// void main() {
//   runApp(MaterialApp(
//     home: HomeScreen(),
//     theme: ThemeData.dark(), // Set the theme to dark
//     // Define routes for '/comments' and '/new-post' if needed
//     // routes: {
//     //   '/comments': (context) => CommentsScreen(),
//     //   '/new-post': (context) => NewPostScreen(),
//     // },
//   ));
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:helloworld/view/screens/comment_screen.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(
//                     child: Text('No posts available'),
//                   );
//                 }

//                 return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     var post = snapshot.data!.docs[index];
//                     var title = post['title'];
//                     var content = post['content'];
//                     var userName = post['userName']; // Corrected field name
//                     var postId = post.id; // Get the ID of the post
//                     var likes = post['likes'] ?? 0; // Get the likes count or default to 0

//                     return FutureBuilder(
//                       future: FirebaseFirestore.instance
//                           .collection('posts')
//                           .doc(postId)
//                           .collection('comments')
//                           .get(),
//                       builder: (context, AsyncSnapshot<QuerySnapshot> commentsSnapshot) {
//                         if (commentsSnapshot.connectionState == ConnectionState.waiting) {
//                           return CircularProgressIndicator();
//                         }
//                         if (!commentsSnapshot.hasData) {
//                           return Text('0 Comments');
//                         }

//                         var commentsCount = commentsSnapshot.data!.docs.length;

//                         return Card(
//                           margin: EdgeInsets.all(10),
//                           child: Padding(
//                             padding: EdgeInsets.all(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   userName ?? 'Unknown User',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 SizedBox(height: 5),
//                                 Text(
//                                   title ?? 'Untitled',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                                 SizedBox(height: 5),
//                                 Text(
//                                   content ?? '',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     ElevatedButton.icon(
//                                       onPressed: () {
//                                         _likePost(postId);
//                                       },
//                                       icon: Icon(Icons.thumb_up),
//                                       label: Text('Like ($likes)'),
//                                     ),
//                                     ElevatedButton.icon(
//                                       onPressed: () {
//                                         _navigateToCommentsScreen(context, postId);
//                                       },
//                                       icon: Icon(Icons.comment),
//                                       label: Text('Comment ($commentsCount)'),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/new-post');
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   void _likePost(String postId) {
//     var postRef = FirebaseFirestore.instance.collection('posts').doc(postId);

//     FirebaseFirestore.instance.runTransaction((transaction) async {
//       DocumentSnapshot snapshot = await transaction.get(postRef);

//       if (snapshot.exists) {
//         Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//         int currentLikes = (data['likes'] ?? 0) as int;

//         int newLikes = currentLikes + 1;

//         transaction.update(postRef, {'likes': newLikes});
//       }
//     }).then((value) {
//       setState(() {});
//     }).catchError((error) {
//       print("Failed to like post: $error");
//     });
//   }

//   void _navigateToCommentsScreen(BuildContext context, String postId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CommentScreen(postId: postId),
//       ),
//     );
//   }
// }
// Import necessary packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helloworld/view/screens/comment_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No posts available'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data!.docs[index];
                    var title = post['title'];
                    var content = post['content'];
                    var userName = post['userName']; // Corrected field name
                    var postId = post.id; // Get the ID of the post
                    var likes = post['likes'] ?? 0; // Get the likes count or default to 0
                    var imageUrl = post['imageUrl']; // Get the image URL

                    return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('posts')
                          .doc(postId)
                          .collection('comments')
                          .get(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> commentsSnapshot) {
                        if (commentsSnapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (!commentsSnapshot.hasData) {
                          return Text('0 Comments');
                        }

                        var commentsCount = commentsSnapshot.data!.docs.length;

                        return Card(
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName ?? 'Unknown User',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  title ?? 'Untitled',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 5),
                                // Display image if available
                                imageUrl != null
                                    ? Image.network(
                                        imageUrl,
                                        width: double.infinity, // Make image fill the width
                                        height: 200, // Set image height as needed
                                        fit: BoxFit.cover, // Adjust the image size and aspect ratio
                                      )
                                    : SizedBox.shrink(), // Hide the image container if no image URL
                                SizedBox(height: 5),
                                Text(
                                  content ?? '',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        _likePost(postId);
                                      },
                                      icon: Icon(Icons.thumb_up),
                                      label: Text('Like ($likes)'),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        _navigateToCommentsScreen(context, postId);
                                      },
                                      icon: Icon(Icons.comment),
                                      label: Text('Comment ($commentsCount)'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new-post');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _likePost(String postId) {
    var postRef = FirebaseFirestore.instance.collection('posts').doc(postId);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(postRef);

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        int currentLikes = (data['likes'] ?? 0) as int;

        int newLikes = currentLikes + 1;

        transaction.update(postRef, {'likes': newLikes});
      }
    }).then((value) {
      setState(() {});
    }).catchError((error) {
      print("Failed to like post: $error");
    });
  }

  void _navigateToCommentsScreen(BuildContext context, String postId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentScreen(postId: postId),
      ),
    );
  }
}
