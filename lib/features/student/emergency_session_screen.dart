import 'package:flutter/material.dart';

class EmergencySessionScreen extends StatelessWidget {
  const EmergencySessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Saved Lectures"),
        backgroundColor:  Colors.white,
      ),
      body: const Center(
        child: Text(
          "Emergency Session Screen",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
