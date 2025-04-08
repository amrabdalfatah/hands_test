import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/auth/main_page.dart';
import 'features/student/home_screen.dart';
import 'features/auth/interpreter_register_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/splash_screen.dart';
import 'features/auth/student_register_screen.dart';

import 'core/helper/binding.dart';

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
        '/LoginScreen': (context) => LoginScreen(showSplashScreen: null),
        '/HomeScreen': (context) => HomeScreen(),
        '/SplashScreen': (context) => SplashScreen(
              showLoginPage: () {},
            ),
      },
    );
  }
}
