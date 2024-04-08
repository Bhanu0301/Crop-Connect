// import 'package:flutter/material.dart';
// import 'package:helloworld/utils/global.colors.dart';
// import 'package:helloworld/view/widgets/button.global.dart';
// import 'package:helloworld/view/widgets/text.form.global.dart';
// import 'package:helloworld/view/signup_view.dart';
// import 'package:helloworld/services/firebase_auth_services.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class LoginView extends StatelessWidget {
//   LoginView({Key? key}) : super(key: key);
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   void _handleSignIn(BuildContext context) async {
//     String email = emailController.text;
//     String password = passwordController.text;

//     User? user =
//         await FirebaseAuthService().signInWithEmailAndPassword(email, password);

//     if (user != null) {
//       // Authentication successful, navigate to home page
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       // Show an error snackbar or dialog
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Login failed. Check your credentials.')),
//       );
//     }
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
//                 const SizedBox(height: 50),
//                 Text(
//                   'Login to your Account',
//                   style: TextStyle(
//                     color: GlobalColors.textColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 //Email Input
//                 TextFormGlobal(
//                   controller: emailController,
//                   text: 'Email',
//                   obscure: false,
//                   textInputType: TextInputType.emailAddress,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 //password Input
//                 TextFormGlobal(
//                   controller: passwordController,
//                   text: 'Password',
//                   textInputType: TextInputType.text,
//                   obscure: true,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 // Forgot Password
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       // Implement the logic for forgot password
//                       print('Forgot Password tapped');
//                     },
//                     child: Text(
//                       'Forgot Password?',
//                       style: TextStyle(
//                         color: GlobalColors.mainColor,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 ),
//                 ButtonGlobal(
//                   text: 'Sign In',
//                   onPressed: () => _handleSignIn(context),
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
//             Text(
//               'Don\'t have an account?',
//             ),
//             InkWell(
//               onTap: () {
//                 // Navigate to SignUpView when SignUp is tapped
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SignUpView()),
//                 );
//               },
//               child: Text(
//                 'SignUp',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   color: GlobalColors.mainColor,
//                 ),
//               ),
//             )
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
import 'package:helloworld/view/signup_view.dart';
import 'package:helloworld/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helloworld/view/phoneSignIn.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _handleSignIn(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user =
        await FirebaseAuthService().signInWithEmailAndPassword(email, password);

    if (user != null) {
      // Authentication successful, navigate to home page
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show an error snackbar or dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Check your credentials.')),
      );
    }
  }

  void _handlePhoneSignIn(BuildContext context) async {
    // Navigate to the phone number sign-in screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhoneSignInScreen()),
    );
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
                const SizedBox(height: 50),
                Text(
                  'Login to your Account',
                  style: TextStyle(
                    color: GlobalColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                // Email Input
                TextFormGlobal(
                  controller: emailController,
                  text: 'Email',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                // Password Input
                TextFormGlobal(
                  controller: passwordController,
                  text: 'Password',
                  textInputType: TextInputType.text,
                  obscure: true,
                ),
                const SizedBox(height: 10),
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Implement the logic for forgot password
                      print('Forgot Password tapped');
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: GlobalColors.mainColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                ButtonGlobal(
                  text: 'Sign In',
                  onPressed: () => _handleSignIn(context),
                ),
                const SizedBox(height: 10),
                ButtonGlobal(
                  text: 'Sign In with Phone',
                  onPressed: () => _handlePhoneSignIn(context),
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
            Text(
              'Don\'t have an account?',
            ),
            InkWell(
              onTap: () {
                // Navigate to SignUpView when SignUp is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpView()),
                );
              },
              child: Text(
                'SignUp',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: GlobalColors.mainColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
