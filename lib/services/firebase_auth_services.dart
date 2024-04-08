import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user profile with name
      await credential.user?.updateDisplayName(name);

      return credential.user; // Return the user object
    } catch (e) {
      print("Error during sign up: $e");
      return null;
    }
  }

  Future<User?> signUpWithPhoneNumber(
    String phoneNumber,
    String name,
    PhoneVerificationCompleted verificationCompleted,
    PhoneVerificationFailed verificationFailed,
    PhoneCodeSent codeSent,
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
  ) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      print("Error during phone sign up: $e");
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user; // Return the user object
    } catch (e) {
      print("Error during sign in: $e");
      return null;
    }
  }
  // Future<void> addPost(String userId, Map<String, dynamic> postData) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .collection('posts')
  //         .add(postData);
  //   } catch (e) {
  //     print("Error adding post: $e");
  //   }
  // }
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }
}


// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseAuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<User?> signUpWithEmailAndPassword(
//       String email, String password, String name) async {
//     try {
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Update user profile with name
//       await credential.user?.updateDisplayName(name);

//       return credential.user;
//     } catch (e) {
//       print("Error during sign up: $e");
//       return null;
//     }
//   }

//   Future<User?> signInWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       UserCredential credential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return credential.user;
//     } catch (e) {
//       print("Error during sign in: $e");
//       return null;
//     }
//   }

//   Future<void> signOut() async {
//     await _auth.signOut();
//   }

//   Future<User?> getCurrentUser() async {
//     return _auth.currentUser;
//   }
// }
