import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/main_page.dart';
import '../pages/home_screen.dart';
import '../pages/interpreter_register_screen.dart';
import '../pages/login_screen.dart';
import '../pages/splash_screen.dart';
import '../pages/student_register_screen.dart';
import 'core/helper/binding.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      home: MainPage(),
      routes: {
        '/StudentRegisterScreen': (context) => StudentRegisterScreen(),
        '/InterpreterRegisterScreen': (context) => InterpreterRegisterScreen(),
        '/LoginScreen': (context) => LoginScreen(
              showSplashScreen: null,
            ),
        '/HomeScreen': (context) => HomeScreen(),
        '/SplashScreen': (context) => SplashScreen(
              showLoginPage: () {},
            ) //mainpage
      },
    );
  }
}
