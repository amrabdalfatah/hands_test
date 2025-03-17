 
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class InterpreterRegisterScreen extends StatefulWidget {
  //final VoidCallback showLoginPage;
  const InterpreterRegisterScreen({super.key}) ;

  @override
  _InterpreterRegisterScreen createState() => _InterpreterRegisterScreen();
}

class _InterpreterRegisterScreen extends State<InterpreterRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDBE8E6),
      body: Center(
        child: SingleChildScrollView(
          child: Column( 
            children: [
              Container(
                height: 200,
                color: Color(0xFFDBE8E6),
                child: Image.asset('assets/images/handsinwords_logo.png', height: 300),
              ),
              Container(
                height: 50,
                width: 400,
                color: Color(0xFFDBE8E6),
                child: Text(
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
                color: Color(0xFFDBE8E6),
                child: Text(
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
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: 310,
                decoration: BoxDecoration( 
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
                      border: InputBorder.none , 
                      hintText: "Enter your full name",
                      ),
                      ),
                  ),
                ),
                ),
              const SizedBox(height: 15),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: 310,
                decoration: BoxDecoration( 
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
                      border: InputBorder.none , 
                      hintText: "Enter email address",
                      ),
                      ),
                  ),
                ),
                ),
              const SizedBox(height: 15),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: 310,
                decoration: BoxDecoration( 
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                      border: InputBorder.none , 
                      hintText: "Enter Password",
                      ),
                      ),
                  ),
                ),
                ) ,
              const SizedBox(height: 15),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: 310,
                decoration: BoxDecoration( 
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                      border: InputBorder.none , 
                      hintText: "Confirm Password",
                      ),
                      ),
                  ),
                ),
                ),
              const SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  //height: 40,
                  width: 310,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color:  Color(0xFF45CECE), 
                  border: Border.all(color: Colors.white),),
                  child: Center(
                  child: GestureDetector(
                    onTap: () {
                        Navigator.pushNamed(context, '/HomeScreen');
                      },
                    child: Text( 'Register',
                    style: TextStyle(
                    color: Colors.white , 
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                                   ),
                  )
                ,)
                ),
              ),
              const SizedBox(height: 10),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Already have an account ? ', 
              style: TextStyle( 
              color: Colors.black,
              fontSize: 15,
               )
               ),
                 GestureDetector(
                  onTap: () {
                  Navigator.pushNamed(context, '/LoginScreen');
                },
                  child: Text('Sign In', 
                  style: TextStyle( 
                  fontWeight: FontWeight.w900,
                  color:  Color.fromARGB(255, 57, 171, 171), 
                  fontSize: 16,
                   )
                   ),
                 ),
               ]
              ), 
            ],
          ),
        ),
      ),
    );
  }
}
  

