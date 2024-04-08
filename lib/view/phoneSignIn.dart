import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helloworld/services/firebase_auth_services.dart';

class PhoneSignInScreen extends StatefulWidget {
  @override
  _PhoneSignInScreenState createState() => _PhoneSignInScreenState();
}

class _PhoneSignInScreenState extends State<PhoneSignInScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String? _verificationId; // Updated to allow null values
  bool _isPhoneNumberCorrect = false;

  void _handlePhoneSignIn() async {
    String phoneNumber = _phoneNumberController.text.trim();
    String fullPhoneNumber = '+91$phoneNumber'; // Fixed country code

    bool phoneNumberExists = await _checkPhoneNumberExists(phoneNumber);

    if (phoneNumberExists) {
      setState(() {
        _isPhoneNumberCorrect = true;
      });
    } else {
      setState(() {
        _isPhoneNumberCorrect = false;
      });
      print('Phone number not found in database');
      // Show a snackbar or dialog to inform the user
    }
  }

  Future<bool> _checkPhoneNumberExists(String phoneNumber) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      QuerySnapshot querySnapshot =
          await users.where('phoneNumber', isEqualTo: phoneNumber).get();

      if (querySnapshot.docs.isNotEmpty) {
        print('Phone number found in database');
        print('Document data:');
        querySnapshot.docs.forEach((doc) {
          print(
              'Name: ${doc['name']}, Email: ${doc['email']}, PhoneNumber: ${doc['phoneNumber']}');
        });
        // Navigate to home screen if number exists
        Navigator.pushReplacementNamed(context, '/home');
        return true;
      } else {
        print('Phone number not found in database');
        return false;
      }
    } catch (e) {
      print('Error checking phone number existence: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your phone number to sign in:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Phone Number',
              ),
            ),
            SizedBox(height: 10),
            Visibility(
              visible: _isPhoneNumberCorrect,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'OTP',
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _handlePhoneSignIn,
              child: Text('Sign In with Phone Number'),
            ),
          ],
        ),
      ),
    );
  }
}