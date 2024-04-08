// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:helloworld/view/screens/news_screen.dart';
// import 'package:helloworld/view/screens/people_screen.dart';
// import 'package:helloworld/view/screens/post_screen.dart';
// import 'package:helloworld/view/screens/tools_screen.dart';
// import 'package:helloworld/view/screens/weather_screen.dart';
// import 'package:helloworld/view/screens/home_screen.dart';

// class HomeView extends StatefulWidget {
//   @override
//   // ignore: library_private_types_in_public_api
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   int _currentIndex = 0; // Index of the currently selected screen
//   bool isDarkMode = false;

//   final List<Widget> _screens = [
//     HomeScreen(),
//     PeopleScreen(),
//     PostScreen(),
//     ToolsScreen(),
//     NewsScreen(),
//   ];

//   void _handleViewProfile() {
//     // Implement the logic for viewing the user profile
//   }

//   void _handleEditProfile() {
//     // Implement the logic for editing the user profile
//   }

//   void _handleChangeTheme() {
//     setState(() {
//       isDarkMode = !isDarkMode;
//     });

//     ThemeData newTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();
//     Get.changeTheme(newTheme);
//   }

//   void _handleLogout() {
//     // Implement the logic for logging out
//   }

//   void _handleBottomNavigationTap(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   void _handleWeatherForecast() {
//     // Implement the logic for handling weather forecast tap
//     print('Weather Forecast tapped');
//     // Navigate to the WeatherScreen
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => WeatherScreen()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crop Connect'),
//         leading: PopupMenuButton(
//           icon: Icon(Icons.menu),
//           itemBuilder: (context) => [
//             PopupMenuItem(
//               child: ListTile(
//                 leading: Icon(Icons.account_circle),
//                 title: Text('View Profile'),
//                 onTap: _handleViewProfile,
//               ),
//             ),
//             PopupMenuItem(
//               child: ListTile(
//                 leading: Icon(Icons.edit),
//                 title: Text('Edit Profile'),
//                 onTap: _handleEditProfile,
//               ),
//             ),
//             PopupMenuItem(
//               child: ListTile(
//                 leading: Icon(Icons.color_lens),
//                 title: Text('Change Theme'),
//                 onTap: _handleChangeTheme,
//               ),
//             ),
//             PopupMenuItem(
//               child: ListTile(
//                 leading: Icon(Icons.logout),
//                 title: Text('Logout'),
//                 onTap: _handleLogout,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.wb_sunny),
//             onPressed: _handleWeatherForecast,
//           ),
//         ],
//       ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _screens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'People',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Post',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.build),
//             label: 'Tools',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.article),
//             label: 'News',
//           ),
//         ],
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         currentIndex: _currentIndex,
//         onTap: _handleBottomNavigationTap,
//       ),
//     );
//   }
// }
// Existing imports...
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helloworld/view/screens/news_screen.dart';
import 'package:helloworld/view/screens/profile_screen.dart';
import 'package:helloworld/view/screens/post_screen.dart';
import 'package:helloworld/view/screens/tools_screen.dart';
import 'package:helloworld/view/screens/weather_screen.dart';
import 'package:helloworld/view/screens/home_screen.dart';
import 'package:helloworld/view/screens/send_notification.dart';
import 'package:helloworld/view/login_view.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart'; // Import translator package
// class HomeView extends StatefulWidget {
//   @override
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   int _currentIndex = 0;
//   bool isDarkMode = false;
//   String selectedLanguage = 'English';

//   final List<Widget> _screens = [
//     HomeScreen(),
//     MainScreen(),
//     PlantDiseaseDetectionScreen(),
//     NotificationScreen(),
//     NewsScreen(),
//   ];

//   final List<String> languages = ['English', 'Kannada', 'Hindi', 'Telugu', 'Tamil'];

//   Map<String, Map<String, String>> translations = {
//     'English': {},
//   };

//   void _handleViewProfile() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ProfileScreen()),
//     );
//   }

//   void _handleChangeTheme() {
//     setState(() {
//       isDarkMode = !isDarkMode;
//     });

//     ThemeData newTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();
//     Get.changeTheme(newTheme);
//   }

//   void _handleLogout(BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => LoginView()),
//         (route) => false,
//       );
//     } catch (e) {
//       print("Error signing out: $e");
//     }
//   }

//   void _handleBottomNavigationTap(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   void _handleWeatherForecast() {
//     print('Weather Forecast tapped');
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => WeatherScreen()),
//     );
//   }

//   void _handleLanguageSelection(String? language) async {
//     if (language != null) {
//       setState(() {
//         selectedLanguage = language;
//       });
//       print('Selected Language: $language');
//       final translator = GoogleTranslator();
//       for (var screen in _screens) {
//         String screenKey = screen.runtimeType.toString();
//         Map<String, String> translatedText = translations[screenKey] ?? {};
//         for (var key in translations[screenKey]!.keys) {
//           String text = translations[screenKey]![key]!;
//           String targetLanguageCode = _getLanguageCode(language);
//           Translation translation = await translator.translate(text, to: targetLanguageCode);
//           translatedText[key] = translation.text ?? text;
//         }
//         translations[screenKey] = translatedText;
//       }
//     }
//   }

//   String _getLanguageCode(String language) {
//     switch (language) {
//       case 'Kannada':
//         return 'kn';
//       case 'Hindi':
//         return 'hi';
//       case 'Telugu':
//         return 'te';
//       case 'Tamil':
//         return 'ta';
//       default:
//         return 'en';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crop Connect'),
//         leading: IconButton(
//           icon: Icon(Icons.translate),
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 title: Text('Select Language'),
//                 content: DropdownButton<String>(
//                   value: selectedLanguage,
//                   onChanged: _handleLanguageSelection,
//                   items: languages.map((String language) {
//                     return DropdownMenuItem<String>(
//                       value: language,
//                       child: Text(language),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             );
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.wb_sunny),
//             onPressed: _handleWeatherForecast,
//           ),
//           PopupMenuButton(
//             icon: Icon(Icons.menu),
//             itemBuilder: (context) => [
//               PopupMenuItem(
//                 child: ListTile(
//                   leading: Icon(Icons.account_circle),
//                   title: Text('View Profile'),
//                   onTap: _handleViewProfile,
//                 ),
//               ),
//               PopupMenuItem(
//                 child: ListTile(
//                   leading: Icon(Icons.color_lens),
//                   title: Text('Change Theme'),
//                   onTap: _handleChangeTheme,
//                 ),
//               ),
//               PopupMenuItem(
//                 child: ListTile(
//                   leading: Icon(Icons.logout),
//                   title: Text('Logout'),
//                   onTap: () => _handleLogout(context),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _screens.map((screen) {
//           String screenKey = screen.runtimeType.toString();
//           return _translateWidget(screen, screenKey);
//         }).toList(),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.build),
//             label: 'Space',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Post',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notify',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.article),
//             label: 'News',
//           ),
//         ],
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         currentIndex: _currentIndex,
//         onTap: _handleBottomNavigationTap,
//       ),
//     );
//   }

//   Future<void> _translateTexts(String screenKey) async {
//     if (translations[screenKey] == null) {
//       translations[screenKey] = {};
//     }
//     Map<String, String> textMap = translations[screenKey]!;
//     final translator = GoogleTranslator();
//     for (var key in textMap.keys) {
//       String text = textMap[key]!;
//       String targetLanguageCode = _getLanguageCode(selectedLanguage);
//       Translation translation = await translator.translate(text, to: targetLanguageCode);
//       textMap[key] = translation.text ?? text;
//     }
//   }

//   Widget _translateWidget(Widget widget, String screenKey) {
//     return FutureBuilder(
//       future: _translateTexts(screenKey),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error translating text'));
//         } else {
//           return _cloneWidget(widget);
//         }
//       },
//     );
//   }

//   Widget _cloneWidget(Widget widget) {
//     return _modifier(widget);
//   }

// Widget _modifier(Widget widget) {
//   if (widget is Text) {
//     Text textWidget = widget;
//     String? translatedText = translations[textWidget.data ?? '']?.values.firstWhere(
//   (element) => element.isNotEmpty,
//   orElse: () => '',);

//     return Text(
//       translatedText ?? textWidget.data ?? '',
//       key: textWidget.key,
//       style: textWidget.style,
//       strutStyle: textWidget.strutStyle,
//       textAlign: textWidget.textAlign,
//       textDirection: textWidget.textDirection,
//       locale: textWidget.locale,
//       softWrap: textWidget.softWrap,
//       overflow: textWidget.overflow,
//       textScaleFactor: textWidget.textScaleFactor,
//       maxLines: textWidget.maxLines,
//       semanticsLabel: textWidget.semanticsLabel,
//       textWidthBasis: textWidget.textWidthBasis,
//     );
//   } else if (widget is Container) {
//     Container container = widget;
//     return Container(
//       key: container.key,
//       alignment: container.alignment,
//       padding: container.padding,
//       margin: container.margin,
//       decoration: container.decoration,
//       foregroundDecoration: container.foregroundDecoration,
//       constraints: container.constraints,
//       transform: container.transform,
//       child: _modifier(container.child!),
//     );
//   } else if (widget is Row) {
//     Row row = widget;
//     return Row(
//       key: row.key,
//       mainAxisAlignment: row.mainAxisAlignment,
//       mainAxisSize: row.mainAxisSize,
//       crossAxisAlignment: row.crossAxisAlignment,
//       textBaseline: row.textBaseline,
//       textDirection: row.textDirection,
//       verticalDirection: row.verticalDirection,
//       children: row.children.map((child) => _modifier(child)).toList(),
//     );
//   } else if (widget is Column) {
//     Column column = widget;
//     return Column(
//       key: column.key,
//       mainAxisAlignment: column.mainAxisAlignment,
//       mainAxisSize: column.mainAxisSize,
//       crossAxisAlignment: column.crossAxisAlignment,
//       textBaseline: column.textBaseline,
//       textDirection: column.textDirection,
//       verticalDirection: column.verticalDirection,
//       children: column.children.map((child) => _modifier(child)).toList(),
//     );
//   } else if (widget is SingleChildScrollView) {
//     SingleChildScrollView singleChildScrollView = widget;
//     return SingleChildScrollView(
//       key: singleChildScrollView.key,
//       scrollDirection: singleChildScrollView.scrollDirection,
//       reverse: singleChildScrollView.reverse,
//       padding: singleChildScrollView.padding,
//       primary: singleChildScrollView.primary,
//       physics: singleChildScrollView.physics,
//       controller: singleChildScrollView.controller,
//       child: _modifier(singleChildScrollView.child!),
//     );
//   } else {
//     return widget;
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  bool isDarkMode = false;
  String selectedLanguage = 'English';

  final List<Widget> _screens = [
    HomeScreen(),
    MainScreen(),
    PlantDiseaseDetectionScreen(),
    NotificationScreen(),
    NewsScreen(),
  ];

  final List<String> languages = ['English', 'Kannada', 'Hindi', 'Telugu', 'Tamil'];

  Map<String, Map<String, String>> translations = {
    'English': {},
  };

  void _handleViewProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  void _handleChangeTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });

    ThemeData newTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();
    Get.changeTheme(newTheme);
  }

  void _handleLogout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
        (route) => false,
      );
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  void _handleBottomNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _handleWeatherForecast() {
    print('Weather Forecast tapped');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WeatherScreen()),
    );
  }

  Future<void> _handleLanguageSelection(String? language) async {
    if (language != null) {
      setState(() {
        selectedLanguage = language;
      });
      print('Selected Language: $language');
      await _loadTranslations(language);
    }
  }

 Future<void> _loadTranslations(String language) async {
  String jsonContent = await rootBundle.loadString('assets/lang/$language.json');
  Map<String, dynamic> translatedData = json.decode(jsonContent);
  translations[language] = Map<String, String>.from(translatedData);
  setState(() {});
}


  String _translate(String key) {
    return translations[selectedLanguage]?[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_translate('Crop Connect')),
        leading: IconButton(
          icon: Icon(Icons.translate),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(_translate('select_language')),
                content: DropdownButton<String>(
                  value: selectedLanguage,
                  onChanged: _handleLanguageSelection,
                  items: languages.map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.wb_sunny),
            onPressed: _handleWeatherForecast,
          ),
          PopupMenuButton(
            icon: Icon(Icons.menu),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text(_translate('view profile')),
                  onTap: _handleViewProfile,
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.color_lens),
                  title: Text(_translate('change theme')),
                  onTap: _handleChangeTheme,
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(_translate('Logout')),
                  onTap: () => _handleLogout(context),
                ),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens.map((screen) {
          String screenKey = screen.runtimeType.toString();
          return _translateWidget(screen, screenKey);
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: _translate('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: _translate('Space'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: _translate('Post'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: _translate('Notify'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: _translate('News'),
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _handleBottomNavigationTap,
      ),
    );
  }

  Future<void> _translateTexts(String screenKey) async {
    if (translations[screenKey] == null) {
      translations[screenKey] = {};
    }
    Map<String, String> textMap = translations[screenKey]!;
    final translator = GoogleTranslator();
    for (var key in textMap.keys) {
      String text = textMap[key]!;
      String targetLanguageCode = _getLanguageCode(selectedLanguage);
      Translation translation = await translator.translate(text, to: targetLanguageCode);
      textMap[key] = translation.text ?? text;
    }
  }
  Widget _translateWidget(Widget widget, String screenKey) {
    return FutureBuilder(
      future: _translateTexts(screenKey),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(_translate('error_translating')));
        } else {
          return _cloneWidget(widget);
        }
      },
    );
  }

  Widget _cloneWidget(Widget widget) {
    return _modifier(widget);
  }

  Widget _modifier(Widget widget) {
    if (widget is Text) {
      Text textWidget = widget;
      String? translatedText = translations[textWidget.data ?? '']?.values.firstWhere(
            (element) => element.isNotEmpty,
        orElse: () => '',);

      return Text(
        translatedText ?? textWidget.data ?? '',
        key: textWidget.key,
        style: textWidget.style,
        strutStyle: textWidget.strutStyle,
        textAlign: textWidget.textAlign,
        textDirection: textWidget.textDirection,
        locale: textWidget.locale,
        softWrap: textWidget.softWrap,
        overflow: textWidget.overflow,
        textScaleFactor: textWidget.textScaleFactor,
        maxLines: textWidget.maxLines,
        semanticsLabel: textWidget.semanticsLabel,
        textWidthBasis: textWidget.textWidthBasis,
      );
    } else if (widget is Container) {
      Container container = widget;
      return Container(
        key: container.key,
        alignment: container.alignment,
        padding: container.padding,
        margin: container.margin,
        decoration: container.decoration,
        foregroundDecoration: container.foregroundDecoration,
        constraints: container.constraints,
        transform: container.transform,
        child: _modifier(container.child!),
      );
    } else if (widget is Row) {
      Row row = widget;
      return Row(
        key: row.key,
        mainAxisAlignment: row.mainAxisAlignment,
        mainAxisSize: row.mainAxisSize,
        crossAxisAlignment: row.crossAxisAlignment,
        textBaseline: row.textBaseline,
        textDirection: row.textDirection,
        verticalDirection: row.verticalDirection,
        children: row.children.map((child) => _modifier(child)).toList(),
      );
    } else if (widget is Column) {
      Column column = widget;
      return Column(
        key: column.key,
        mainAxisAlignment: column.mainAxisAlignment,
        mainAxisSize: column.mainAxisSize,
        crossAxisAlignment: column.crossAxisAlignment,
        textBaseline: column.textBaseline,
        textDirection: column.textDirection,
        verticalDirection: column.verticalDirection,
        children: column.children.map((child) => _modifier(child)).toList(),
      );
    } else if (widget is SingleChildScrollView) {
      SingleChildScrollView singleChildScrollView = widget;
      return SingleChildScrollView(
        key: singleChildScrollView.key,
        scrollDirection: singleChildScrollView.scrollDirection,
        reverse: singleChildScrollView.reverse,
        padding: singleChildScrollView.padding,
        primary: singleChildScrollView.primary,
        physics: singleChildScrollView.physics,
        controller: singleChildScrollView.controller,
        child: _modifier(singleChildScrollView.child!),
      );
    } else {
      return widget;
    }
  }

  String _getLanguageCode(String language) {
    switch (language) {
      case 'Kannada':
        return 'kn';
      case 'Hindi':
        return 'hi';
      case 'Telugu':
        return 'te';
      case 'Tamil':
        return 'ta';
      default:
        return 'en';
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:helloworld/view/screens/news_screen.dart';
// import 'package:helloworld/view/screens/profile_screen.dart';
// import 'package:helloworld/view/screens/post_screen.dart';
// import 'package:helloworld/view/screens/tools_screen.dart';
// import 'package:helloworld/view/screens/weather_screen.dart';
// import 'package:helloworld/view/screens/home_screen.dart';
// import 'package:helloworld/view/screens/send_notification.dart';
// import 'package:helloworld/view/login_view.dart';
// import 'package:get/get.dart';
// import 'package:translator/translator.dart'; // Import translator package

// class HomeView extends StatefulWidget {
//   @override
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   int _currentIndex = 0; // Index of the currently selected screen
//   bool isDarkMode = false;
//   String selectedLanguage = 'English'; // Default language

//   final List<Widget> _screens = [
//     HomeScreen(),
//     MainScreen(),
//     PlantDiseaseDetectionScreen(),
//     NotificationScreen(),
//     NewsScreen(),
//   ];

//   // Translation options
//   final List<String> languages = ['English', 'Kannada', 'Hindi', 'Telugu', 'Tamil'];

//   void _handleViewProfile() {
//     // Implement the logic for viewing the user profile
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ProfileScreen()),
//     );
//   }

//   void _handleChangeTheme() {
//     setState(() {
//       isDarkMode = !isDarkMode;
//     });

//     ThemeData newTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();
//     Get.changeTheme(newTheme);
//   }

//   void _handleLogout(BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       // Navigate to the login screen with a MaterialPageRoute and remove all other routes from the navigation stack
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => LoginView()),
//         (route) => false,
//       );
//     } catch (e) {
//       print("Error signing out: $e");
//     }
//   }

//   void _handleBottomNavigationTap(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   void _handleWeatherForecast() {
//     // Implement the logic for handling weather forecast tap
//     print('Weather Forecast tapped');
//     // Navigate to the WeatherScreen
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => WeatherScreen()),
//     );
//   }

//   // Function to handle language selection and translation
//   void _handleLanguageSelection(String? language) async {
//     if (language != null) {
//       setState(() {
//         selectedLanguage = language;
//       });
//       // Perform translation logic here based on the selected language
//       print('Selected Language: $language');
//       // Example translation using translator package
//       String textToTranslate = 'Hello, world!'; // Example text to translate
//       String targetLanguageCode = _getLanguageCode(language); // Get language code for translation
//       String translation = await _translateText(textToTranslate, to: targetLanguageCode);
//       print('Translated Text: $translation');
//     }
//   }

//   // Function to translate text using translator package
//   Future<String> _translateText(String text, {required String to}) async {
//     final translator = GoogleTranslator();
//     Translation translation = await translator.translate(text, to: to);
//     return translation.text ?? ''; // Return translated text, or empty string if translation is null
//   }

//   // Function to get language code for translation
//   String _getLanguageCode(String language) {
//     switch (language) {
//       case 'Kannada':
//         return 'kn';
//       case 'Hindi':
//         return 'hi';
//       case 'Telugu':
//         return 'te';
//       case 'Tamil':
//         return 'ta';
//       default:
//         return 'en'; // Default to English
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crop Connect'),
//         leading: IconButton(
//           icon: Icon(Icons.translate),
//           onPressed: () {
//             // Display language selection options upon clicking translation icon
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 title: Text('Select Language'),
//                 content: DropdownButton<String>(
//                   value: selectedLanguage,
//                   onChanged: _handleLanguageSelection,
//                   items: languages.map((String language) {
//                     return DropdownMenuItem<String>(
//                       value: language,
//                       child: Text(language),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             );
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.wb_sunny),
//             onPressed: _handleWeatherForecast,
//           ),
//           PopupMenuButton(
//             icon: Icon(Icons.menu),
//             itemBuilder: (context) => [
//               PopupMenuItem(
//                 child: ListTile(
//                   leading: Icon(Icons.account_circle),
//                   title: Text('View Profile'),
//                   onTap: _handleViewProfile,
//                 ),
//               ),
//               PopupMenuItem(
//                 child: ListTile(
//                   leading: Icon(Icons.color_lens),
//                   title: Text('Change Theme'),
//                   onTap: _handleChangeTheme,
//                 ),
//               ),
//               PopupMenuItem(
//                 child: ListTile(
//                   leading: Icon(Icons.logout),
//                   title: Text('Logout'),
//                   onTap: () => _handleLogout(context),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _screens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.build),
//             label: 'Space',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Post',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notify',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.article),
//             label: 'News',
//           ),
//         ],
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         currentIndex: _currentIndex,
//         onTap: _handleBottomNavigationTap,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:helloworld/view/screens/news_screen.dart';
// import 'package:helloworld/view/screens/profile_screen.dart';
// import 'package:helloworld/view/screens/post_screen.dart';
// import 'package:helloworld/view/screens/tools_screen.dart';
// import 'package:helloworld/view/screens/weather_screen.dart';
// import 'package:helloworld/view/screens/home_screen.dart';
// import 'package:helloworld/view/screens/send_notification.dart';
// import 'package:helloworld/view/login_view.dart';
// import 'package:get/get.dart';
// import 'package:translator/translator.dart'; // Import translator package

// class HomeView extends StatefulWidget {
//   @override
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   int _currentIndex = 0; // Index of the currently selected screen
//   bool isDarkMode = false;
//   String selectedLanguage = 'English'; // Default language

//   final List<Widget> _screens = [
//     HomeScreen(),
//     MainScreen(),
//     PlantDiseaseDetectionScreen(),
//     NotificationScreen(),
//     NewsScreen(),
//   ];

//   // Translation options
//   final List<String> languages = ['English', 'Kannada', 'Hindi', 'Telugu', 'Tamil'];

//   void _handleViewProfile() {
//     // Implement the logic for viewing the user profile
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ProfileScreen()),
//     );
//   }

//   void _handleChangeTheme() {
//     setState(() {
//       isDarkMode = !isDarkMode;
//     });

//     ThemeData newTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();
//     Get.changeTheme(newTheme);
//   }

//   void _handleLogout(BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       // Navigate to the login screen with a MaterialPageRoute and remove all other routes from the navigation stack
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => LoginView()),
//         (route) => false,
//       );
//     } catch (e) {
//       print("Error signing out: $e");
//     }
//   }

//   void _handleBottomNavigationTap(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   void _handleWeatherForecast() {
//     // Implement the logic for handling weather forecast tap
//     print('Weather Forecast tapped');
//     // Navigate to the WeatherScreen
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => WeatherScreen()),
//     );
//   }

//   // Function to handle language selection and translation
//   void _handleLanguageSelection(String? language) async {
//     if (language != null) {
//       setState(() {
//         selectedLanguage = language;
//       });
//       // Perform translation logic here based on the selected language
//       print('Selected Language: $language');
//       // Example translation using translator package
//       String textToTranslate = 'Hello, world!'; // Example text to translate
//       String targetLanguageCode = _getLanguageCode(language); // Get language code for translation
//       String translation = await _translateText(textToTranslate, to: targetLanguageCode);
//       print('Translated Text: $translation');
//     }
//   }

//   // Function to translate text using translator package
//   Future<String> _translateText(String text, {required String to}) async {
//     final translator = GoogleTranslator();
//     Translation translation = await translator.translate(text, to: to);
//     return translation.text ?? ''; // Return translated text, or empty string if translation is null
//   }

//   // Function to get language code for translation
//   String _getLanguageCode(String language) {
//     switch (language) {
//       case 'Kannada':
//         return 'kn';
//       case 'Hindi':
//         return 'hi';
//       case 'Telugu':
//         return 'te';
//       case 'Tamil':
//         return 'ta';
//       default:
//         return 'en'; // Default to English
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crop Connect'),
//         leading: IconButton(
//           icon: Icon(Icons.translate),
//           onPressed: () {
//             // Display language selection options upon clicking translation icon
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 title: Text('Select Language'),
//                 content: DropdownButton<String>(
//                   value: selectedLanguage,
//                   onChanged: _handleLanguageSelection,
//                   items: languages.map((String language) {
//                     return DropdownMenuItem<String>(
//                       value: language,
//                       child: Text(language),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             );
//           },
//         ),
//         actions: [
//           PopupMenuButton(
//             icon: Icon(Icons.menu),
//             itemBuilder: (context) => [
//               PopupMenuItem(
//                 child: ListTile(
//                   leading: Icon(Icons.account_circle),
//                   title: Text('View Profile'),
//                   onTap: _handleViewProfile,
//                 ),
//               ),
//               PopupMenuItem(
//                 child: ListTile(
//                   leading: Icon(Icons.color_lens),
//                   title: Text('Change Theme'),
//                   onTap: _handleChangeTheme,
//                 ),
//               ),
//               PopupMenuItem(
//                 child: ListTile(
//                   leading: Icon(Icons.logout),
//                   title: Text('Logout'),
//                   onTap: () => _handleLogout(context),
//                 ),
//               ),
//             ],
//           ),
//           IconButton(
//             icon: Icon(Icons.wb_sunny),
//             onPressed: _handleWeatherForecast,
//           ),
//         ],
//       ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _screens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.build),
//             label: 'Space',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Post',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notify',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.article),
//             label: 'News',
//           ),
//         ],
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         currentIndex: _currentIndex,
//         onTap: _handleBottomNavigationTap,
//       ),
//     );
//   }
// }


// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:helloworld/view/screens/news_screen.dart';
// import 'package:helloworld/view/screens/profile_screen.dart';
// import 'package:helloworld/view/screens/post_screen.dart';
// import 'package:helloworld/view/screens/tools_screen.dart';
// import 'package:helloworld/view/screens/weather_screen.dart';
// import 'package:helloworld/view/screens/home_screen.dart';
// import 'package:helloworld/view/screens/send_notification.dart';
// import 'package:helloworld/view/login_view.dart';

// class HomeView extends StatefulWidget {
//   @override
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   int _currentIndex = 0; // Index of the currently selected screen
//   bool isDarkMode = false;
//   String selectedLanguage = 'English'; // Default language

//   final List<Widget> _screens = [
//     HomeScreen(),
//     MainScreen(),
//     PlantDiseaseDetectionScreen(),
//     NotificationScreen(),
//     NewsScreen(),
//   ];

//   // Translation options
//   final List<String> languages = ['English', 'Kannada', 'Hindi', 'Telugu', 'Tamil'];

//   void _handleViewProfile() {
//     // Implement the logic for viewing the user profile
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ProfileScreen()),
//     );
//   }

//   void _handleChangeTheme() {
//     setState(() {
//       isDarkMode = !isDarkMode;
//     });

//     ThemeData newTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();
//     Get.changeTheme(newTheme);
//   }

//   void _handleLogout(BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       // Navigate to the login screen with a MaterialPageRoute and remove all other routes from the navigation stack
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => LoginView()),
//         (route) => false,
//       );
//     } catch (e) {
//       print("Error signing out: $e");
//     }
//   }

//   void _handleBottomNavigationTap(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   void _handleWeatherForecast() {
//     // Implement the logic for handling weather forecast tap
//     print('Weather Forecast tapped');
//     // Navigate to the WeatherScreen
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => WeatherScreen()),
//     );
//   }

//   // Function to handle language selection
//  void _handleLanguageSelection(String? language) {
//   if (language != null) {
//     setState(() {
//       selectedLanguage = language;
//     });
//     // Perform translation logic here based on the selected language
//     print('Selected Language: $language');
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crop Connect'),
//         leading: Row(
//           children: [
//             IconButton(
//               icon: Icon(Icons.translate),
//               onPressed: () {
//                 // Display language selection options upon clicking translation icon
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: Text('Select Language'),
//                     content: DropdownButton<String>(
//                       value: selectedLanguage,
//                       onChanged: _handleLanguageSelection,
//                       items: languages.map((String language) {
//                         return DropdownMenuItem<String>(
//                           value: language,
//                           child: Text(language),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             PopupMenuButton(
//               icon: Icon(Icons.menu),
//               itemBuilder: (context) => [
//                 PopupMenuItem(
//                   child: ListTile(
//                     leading: Icon(Icons.account_circle),
//                     title: Text('View Profile'),
//                     onTap: _handleViewProfile,
//                   ),
//                 ),
//                 PopupMenuItem(
//                   child: ListTile(
//                     leading: Icon(Icons.color_lens),
//                     title: Text('Change Theme'),
//                     onTap: _handleChangeTheme,
//                   ),
//                 ),
//                 PopupMenuItem(
//                   child: ListTile(
//                     leading: Icon(Icons.logout),
//                     title: Text('Logout'),
//                     onTap: () => _handleLogout(context),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.wb_sunny),
//             onPressed: _handleWeatherForecast,
//           ),
//         ],
//       ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _screens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.build),
//             label: 'Space',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Post',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notify',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.article),
//             label: 'News',
//           ),
//         ],
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         currentIndex: _currentIndex,
//         onTap: _handleBottomNavigationTap,
//       ),
//     );
//   }
// }