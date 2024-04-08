// import 'package:flutter/material.dart';
// import 'package:helloworld/utils/global.colors.dart';
// import 'package:helloworld/view/widgets/button.global.dart';
// import 'package:helloworld/view/widgets/text.form.global.dart';
// import 'package:helloworld/services/firebase_auth_services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SignUpView extends StatefulWidget {
//   SignUpView({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _SignUpViewState createState() => _SignUpViewState();
// }

// class _SignUpViewState extends State<SignUpView> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   void _handleSignUp(BuildContext context) async {
//     String name = nameController.text;
//     String email = emailController.text;
//     String password = passwordController.text;

//     User? user = await FirebaseAuthService().signUpWithEmailAndPassword(
//       email,
//       password,
//       name,
//     );

//     if (user != null) {
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Sign up failed. Please try again.')),
//       );
//     }
//   }

//   Future<void> _pickProfileImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     // Handle the picked image as needed
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   child: Text(
//                     'CropConnect',
//                     style: TextStyle(
//                       color: GlobalColors.mainColor,
//                       fontSize: 35,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 InkWell(
//                   onTap: _pickProfileImage,
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.grey[300],
//                     // Display the selected image if available
//                     backgroundImage: null,
//                     child: Icon(
//                       Icons.camera_alt,
//                       size: 30,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormGlobal(
//                   controller: nameController,
//                   text: 'Full Name',
//                   obscure: false,
//                   textInputType: TextInputType.text,
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormGlobal(
//                   controller: emailController,
//                   text: 'Email',
//                   obscure: false,
//                   textInputType: TextInputType.emailAddress,
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormGlobal(
//                   controller: passwordController,
//                   text: 'Password',
//                   obscure: true,
//                   textInputType: TextInputType.text,
//                 ),
//                 const SizedBox(height: 10),
//                 ButtonGlobal(
//                   text: 'Sign Up',
//                   onPressed: () => _handleSignUp(context),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 50,
//         color: Colors.white,
//         alignment: Alignment.center,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Already have an account?',
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 'Login',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   color: GlobalColors.mainColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:helloworld/utils/global.colors.dart';
import 'package:helloworld/view/widgets/button.global.dart';
import 'package:helloworld/view/widgets/text.form.global.dart';
import 'package:helloworld/services/firebase_auth_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpView extends StatefulWidget {
  SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void _handleSignUp(BuildContext context) async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String phoneNumber = phoneNumberController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      User? user = await FirebaseAuthService().signUpWithEmailAndPassword(
        email,
        password,
        name,
      );

      if (user != null) {
        // Add user details to Firestore
        await addUserToFirestore(user.uid, name, email, phoneNumber);

        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up failed. Please try again.')),
        );
      }
    } else if (phoneNumber.isNotEmpty) {
      // Handle sign up with phone number
      // You can implement this part based on your requirements
    } else {
      // Handle empty email/password or phone number
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter email/password or phone number')),
      );
    }
  }

  Future<void> addUserToFirestore(
    String userId,
    String name,
    String email,
    String phoneNumber,
  ) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('users').doc(userId).set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
      });

      print('User added to Firestore');
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }
  }

  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    // Handle the picked image as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'CropConnect',
                    style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: _pickProfileImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    // Display the selected image if available
                    backgroundImage: null,
                    child: Icon(
                      Icons.camera_alt,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormGlobal(
                  controller: nameController,
                  text: 'Full Name',
                  obscure: false,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                TextFormGlobal(
                  controller: emailController,
                  text: 'Email',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                TextFormGlobal(
                  controller: passwordController,
                  text: 'Password',
                  obscure: true,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                TextFormGlobal(
                  controller: phoneNumberController,
                  text: 'Phone Number',
                  obscure: false,
                  textInputType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                ButtonGlobal(
                  text: 'Sign Up',
                  onPressed: () => _handleSignUp(context),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Already have an account?',
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: GlobalColors.mainColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
