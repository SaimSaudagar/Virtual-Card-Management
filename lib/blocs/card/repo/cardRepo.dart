import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/blocs/card/model/cardModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class CardRepository {
  Future<void> addCard(CardModel card) async {
    List<CardModel> lst = await getCards();

    if (lst.length < 3) {
      print(card.virtualNumber);
      FirebaseFirestore.instance
          .collection('cards')
          .add(card.toJson())
          .then((value) => print("Data set successfully"))
          .catchError((error) => print("Failed to set data: $error"));
    } else {
      throw Exception('Card limit reached');
    }
  }

  Future<List<CardModel>> getCards() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('cards')
            .where('userUid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .get();
    final List<CardModel> cards = querySnapshot.docs
        .map((e) => CardModel.fromJson(e.data()))
        .toList(growable: false);
    return cards;
  }

  Future<void> deleteCard(String cardNumber) async {
    await FirebaseFirestore.instance
        .collection('cards')
        .where('cardNumber', isEqualTo: cardNumber)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference
            .delete()
            .then((value) => print("Data deleted successfully"))
            .catchError((error) => print("Failed to delete data: $error"));
      });
    }).catchError((error) => print("Failed to retrieve data: $error"));
  }
}
