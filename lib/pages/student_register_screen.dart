// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentRegisterScreen extends StatefulWidget {
  const StudentRegisterScreen({super.key});

  @override
  _StudentRegisterScreenState createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  // Text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  // ✅ Updated signUp function with error handling and validation
  Future<void> signUp() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showError("Email and password cannot be empty.");
      return;
    }

    if (!_emailController.text.contains("@")) {
      showError("Enter a valid email address.");
      return;
    }

    if (_passwordController.text.length < 6) {
      showError("Password must be at least 6 characters long.");
      return;
    }

    try {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // ✅ Navigate to HomeScreen only after successful registration
        Navigator.pushNamed(context, '/HomeScreen');
      } else {
        showError("Passwords do not match.");
      }
    } catch (e) {
      showError(e.toString());
    }
  }

  // Function to show error messages in a SnackBar
  void showError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
    );
  }

  // ✅ Password confirmation check
  bool passwordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmpasswordController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBE8E6),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                color: const Color(0xFFDBE8E6),
                child: Image.asset('assets/images/handsinwords_logo.png',
                    height: 300),
              ),
              Container(
                height: 50,
                width: 400,
                color: const Color(0xFFDBE8E6),
                child: const Text(
                  "Welcome To HandsInWords!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 68, 67, 67),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 400,
                color: const Color(0xFFDBE8E6),
                child: const Text(
                  "Let's get your task completed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 5, 5, 5),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Input Fields
              buildTextField("Enter your full name", false, null),
              const SizedBox(height: 15),
              buildTextField("Enter email address", false, _emailController),
              const SizedBox(height: 15),
              buildTextField("Enter Password", true, _passwordController),
              const SizedBox(height: 15),
              buildTextField(
                  "Confirm Password", true, _confirmpasswordController),
              const SizedBox(height: 15),
              buildTextField("Enter your University", false, null),
              const SizedBox(height: 18),

              // ✅ Fixed Register Button with signUp function
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: GestureDetector(
                  onTap: () async {
                    await signUp(); // Ensure registration completes before navigating
                  },
                  child: Container(
                    width: 310,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: const Color(0xFF45CECE),
                      border: Border.all(color: Colors.white),
                    ),
                    child: const Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account ? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/LoginScreen');
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 57, 171, 171),
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Extracted method to reduce code duplication for text fields
  Widget buildTextField(
      String hintText, bool obscureText, TextEditingController? controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        width: 310,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
            ),
          ),
        ),
      ),
    );
  }
}
