import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chess Royale', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Version: 1.0.0'),
            SizedBox(height: 20),
            Text('Developed by: Samarth Garge', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Samarth Garge', style: TextStyle(fontSize: 16)),
            Text('gargesamarth@gmail.com', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
