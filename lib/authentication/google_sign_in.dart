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
        'images': user.photoURL,
      }, SetOptions(merge: true));
  return userCredential.user;
}
