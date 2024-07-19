// import 'package:flutter/material.dart';

// class AboutScreen extends StatefulWidget {
//   const AboutScreen({super.key});

//   @override
//   State<AboutScreen> createState() => _AboutScreenState();
// }

// class _AboutScreenState extends State<AboutScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: Text('About Screen')),
//     );
//   }
// }

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
            Text('App Name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Version: 1.0.0'),
            SizedBox(height: 20),
            Text('Developed by:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Your Name', style: TextStyle(fontSize: 16)),
            Text('Your Email', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
