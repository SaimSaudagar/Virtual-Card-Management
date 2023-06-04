import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/blocs/signup/model/siginupModel.dart';

class SignupRepository {
  Future<void> signup(SignupModel user, String email, String password) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userDocRef =
        usersCollection.doc(userCredential.user?.uid);
    userDocRef
        .set({
          'uid': userCredential.user?.uid,
          'firstName': user.firstName,
          'lastName': user.lastName,
          'phoneNumber': user.phonenumber,
          'gender': user.gender,
          'balance': 5000.0,
          'profilePic': '',
          'expense': 0.0,
        })
        .then((value) => print("Data set successfully"))
        .catchError((error) => print("Failed to set data: $error"));
  }
}
