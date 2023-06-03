import 'package:firebase_auth/firebase_auth.dart';

class LoginRepo {
  Future<bool> login(String email, String password) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user == null) {
      return false;
    }

    return true;
  }
}
