import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    DocumentReference? imageRefernce =
        _firestore.collection('users').doc(user?.uid);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Information'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: imageRefernce.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No user data found'));
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: data['images'] != null
                        ? NetworkImage(data['images'])
                        : const AssetImage('assets/images/user_icon.png'),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Name: ${data['name']}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Email: ${data['email']}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
