import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CommentScreen extends StatefulWidget {
  final String postId;

  const CommentScreen({required this.postId});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.postId)
                  .collection('comments')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No comments available'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var comment = snapshot.data!.docs[index];
                    var commentText = comment['comment'];
                    var commenterName = comment['commenterName'];

                    return ListTile(
                      title: Text(commentText),
                      subtitle: Text(commenterName),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _submitComment(widget.postId);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//   void _submitComment(String postId) async {
//     final String commentText = _commentController.text;

//     if (commentText.isNotEmpty) {
//       try {
//         final user = FirebaseAuth.instance.currentUser;
//         if (user != null) {
//           await FirebaseFirestore.instance
//               .collection('posts')
//               .doc(postId)
//               .collection('comments')
//               .add({
//             'comment': commentText,
//             'commenterName': user.displayName,
//           });
//           _commentController.clear();
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('User not authenticated. Please login.'),
//             ),
//           );
//         }
//       } catch (e) {
//         print('Error submitting comment: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to submit comment. Please try again.'),
//           ),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please enter a comment.'),
//         ),
//       );
//     }
//   }
// }
void _submitComment(String postId) async {
  final String commentText = _commentController.text;

  if (commentText.isNotEmpty) {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .add({
          'comment': commentText,
          'commenterName': user.displayName,
        });

        // Trigger notification if the commenter is not the post owner
        final post = await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .get();
        final postOwnerId = post['userId']; // Assuming 'userId' is the field that stores the post owner's ID
        if (user.uid != postOwnerId) {
          // Create notification
          await FirebaseFirestore.instance.collection('notifications').add({
            'userId': postOwnerId,
            'message': '${user.displayName} commented on your post.',
            'postId': postId,
            'createdAt': Timestamp.now(),
            'read': false,
          });
        }

        _commentController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User not authenticated. Please login.'),
          ),
        );
      }
    } catch (e) {
      print('Error submitting comment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit comment. Please try again.'),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please enter a comment.'),
      ),
    );
  }
}
}