import 'dart:async' ;

import 'package:flutter/material.dart';
import 'package:helloworld/utils/global.colors.dart';
import 'package:helloworld/view/login_view.dart';
import 'package:get/get.dart';
//import 'package:helloworld/services/firebase_auth_services.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(LoginView());
    });
    return Scaffold(
        backgroundColor: GlobalColors.mainColor,
        body: const Center(
          child: Text(
            'CropConnect',
            style: TextStyle(
              color: Colors.black,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
