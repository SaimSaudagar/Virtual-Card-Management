import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/blocs/add/model/addModel.dart';
import 'package:project/blocs/signup/model/siginupModel.dart';
import 'package:project/blocs/userhome/repo/userHomeRepo.dart';

class AddRepository {
  Future<void> addTransaction(AddModel addModel) async {
    addModel.userUid = FirebaseAuth.instance.currentUser?.uid;

    final Map<String, dynamic> jsonData = addModel.toJson();

    await UserHomeRepository()
        .getUserByUid(addModel.userUid!)
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) async {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;

        SignupModel userData = SignupModel.fromJson(data);
        userData.expense += double.parse(addModel.amountTransacted);
        UserHomeRepository().updateExpense(userData.expense);
        if (userData.balance >= double.parse(addModel.amountTransacted)) {
          userData.balance =
              userData.balance - double.parse(addModel.amountTransacted);
          UserHomeRepository().updateBalance(userData.balance);

          FirebaseFirestore.instance
              .collection('transactions')
              .add(jsonData)
              .then((value) => print("Data set successfully"))
              .catchError((error) => print("Failed to set data: $error"));
        } else {
          throw Exception('Insufficient balance');
        }
      }
    });
  }

  Future<List<AddModel>> getTransactions() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('transactions')
              .where('userUid',
                  isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .get();

      final List<AddModel> transactions = querySnapshot.docs
          .map((e) => AddModel.fromJson(e.data()))
          .toList(growable: false);
      return transactions;
    } catch (error) {
      throw Exception('Failed to load cards: $error');
    }
  }
}
