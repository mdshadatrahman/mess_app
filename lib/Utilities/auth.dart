import 'package:firebase_auth/firebase_auth.dart';
class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> registerUser(String email, String password) async {
    String isSuccess = '';
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      isSuccess = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        isSuccess = 'Weak password';
      } else if (e.code == 'email-already-in-use') {
        isSuccess = 'Email already exists';
      } else if (e.code == 'invalid-email') {
        isSuccess = 'Invalid email';
      } else if (e.code == 'operation-not-allowed') {
        isSuccess = 'Tell the developer to enable Email/Password Signup.';
      }
    }
    return isSuccess;
  }

  Future<String> loginUser(String email, String password) async {
    String isSuccess = '';
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isSuccess = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        isSuccess = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        isSuccess = 'Wrong password';
      } else if (e.code == 'invalid-email') {
        isSuccess = 'Invalid Email';
      } else if (e.code == 'user-disabled') {
        isSuccess = 'You have been banned';
      }
    }
    return isSuccess;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}

// Future<void> loginUser(String email, String password) async {
//   try {
//
//     await _auth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   } catch (e) {
//     print(e);
//   }
// }
