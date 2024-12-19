import 'package:flutter/material.dart';

class TimeScreen extends StatelessWidget {
  const TimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          "Kalender",
         style: TextStyle(color: Colors.white), 
        ),
      ),
      body: const Center(
        child: Text(
          "Halaman Kalender",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
