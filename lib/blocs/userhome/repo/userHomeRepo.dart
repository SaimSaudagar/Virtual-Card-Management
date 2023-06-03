import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserHomeRepository {
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

  Future<void> updateBalance(double balance) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({'balance': balance});
    } catch (error) {
      throw Exception('Failed to update balance: $error');
    }
  }

  Future<void> updateExpense(double expense) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({'expense': expense});
    } catch (error) {
      throw Exception('Failed to update balance: $error');
    }
  }
}
