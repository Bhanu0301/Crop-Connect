import 'package:flutter/material.dart';
import 'package:helloworld/utils/global.colors.dart';
//import 'package:helloworld/view/home_view.dart'; // Import the file where your HomeView is defined

class ButtonGlobal extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Added this line

  const ButtonGlobal({Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Changed this line
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          color: GlobalColors.mainColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
