// import 'package:flutter/material.dart';
// import 'package:helloworld/view/splash_view.dart';
// import 'package:get/get.dart';
// import 'package:firebase_core/firebase_core.dart';

// import 'package:flutter/foundation.dart';
// import 'package:helloworld/view/home_view.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//         apiKey: "AIzaSyD_d4yBafec9i9RXmtkP8KMOuF9pRD-Obg",
//         appId: "1:737118287855:web:f56437860bd8381374e81a",
//         messagingSenderId: "737118287855",
//         projectId: "farm-connect-5a8a0"
//     ),
//   );
//   runApp(const App());
// }

// class App extends StatelessWidget {
//   const App({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashView(),
//       routes: {
//         '/home': (context) => HomeView(),
//         // Add other routes if needed
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:helloworld/view/splash_view.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import flutter_localizations.dart
import 'package:helloworld/view/home_view.dart';
import 'package:helloworld/view/screens/weather_screen.dart';
import 'package:helloworld/view/screens/news_screen.dart';
import 'package:helloworld/view/screens/post_screen.dart';
import 'package:helloworld/view/screens/tools_screen.dart';
import 'package:translator/translator.dart';
import 'dart:convert';
import 'package:helloworld/view/newPostScreen.dart'; // Import the NewPostScreen

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyD_d4yBafec9i9RXmtkP8KMOuF9pRD-Obg",
        appId: "1:737118287855:web:f56437860bd8381374e81a",
        messagingSenderId: "737118287855",
        projectId: "farm-connect-5a8a0",
        storageBucket: "farm-connect-5a8a0.appspot.com",
    ),
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
      routes: {
        '/home': (context) => HomeView(),
        '/weather': (context) => WeatherScreen(),
        '/news': (context) => NewsScreen(),
        '/post': (context) => PlantDiseaseDetectionScreen(),
        '/new-post': (context) => NewPostScreen(), // Define the route for NewPostScreen
        '/tools': (context) => MainScreen(),
      },
    );
  }
}
