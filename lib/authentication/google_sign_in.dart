import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<User?> signInWithGoogle() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;
      
       // Save user data to Firestore
      DocumentReference userDoc = firestore.collection('users').doc(user!.uid);

      userDoc.set({
        'uid': user.uid,
        'name': user.displayName,
        'email': user.email,
        'image': user.photoURL,
      }, SetOptions(merge: true));
  return userCredential.user;
}


// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'profile_screen.dart';

// class GoogleSignIn extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   Future<void> _signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//     if (googleUser == null) {
//       // User canceled the sign-in
//       return;
//     }

//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     UserCredential userCredential = await _auth.signInWithCredential(credential);
//     User? user = userCredential.user;

//     if (user != null) {
//       // Save user data to Firestore
//       DocumentReference userDoc = _firestore.collection('users').doc(user.uid);

//       userDoc.set({
//         'uid': user.uid,
//         'name': user.displayName,
//         'email': user.email,
//         'image': user.photoURL,
//       }, SetOptions(merge: true));
//     }
//   }
// }

// final userEmail = googleUser.email;
  // print(userEmail);