import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
}