import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/blocs/signup/model/siginupModel.dart';

class SignupRepository {
  Future<void> signup(SignupModel user) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );

    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userDocRef =
        usersCollection.doc(userCredential.user?.uid);
    userDocRef
        .set({
          'uid': userCredential.user?.uid,
          'email': user.email,
          'password': user.password,
          'firstName': user.firstName,
          'lastName': user.lastName,
          'phoneNumber': user.phonenumber,
          'gender': user.gender,
          'balance': 0.0,
          'profilePic': '',
          'expense': 0.0,
        })
        .then((value) => print("Data set successfully"))
        .catchError((error) => print("Failed to set data: $error"));
  }
}
