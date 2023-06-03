import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/blocs/update/model/updateModel.dart';

class UpdateUIRepository {
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserByUid(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.size > 0) {
        return querySnapshot.docs.first;
      } else {
        throw Exception('User not found');
      }
    });
  }

  updateUser(String uid, UpdateUserModel updatedUser) async {
    User? user = FirebaseAuth.instance.currentUser;

    await user
        ?.updateEmail(updatedUser.email)
        .then((value) => {
              FirebaseAuth.instance.currentUser
                  ?.updatePassword(updatedUser.password),
              print("User email updated successfully!")
            })
        .onError((error, stackTrace) => {
              print("Failed to update user email: $error"),
              updatedUser.email = user.email!
            });

    print(updatedUser.toJson());
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(updatedUser.toJson());
  }

  deleteUser() {
    print("gere");
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('users').doc(user?.uid).delete();
    print("deleted");
    return FirebaseAuth.instance.currentUser?.delete();
  }
}
