import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/blocs/card/bloc/cardEvents.dart';
import 'package:project/blocs/card/bloc/cardStates.dart';
import 'package:project/blocs/card/model/cardModel.dart';
import 'package:project/blocs/card/repo/cardRepo.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository cardRepository;

  CardBloc(this.cardRepository) : super(CardInitialState()) {
    on<AddButtonPressed>((event, emit) async {
      emit(CardLoadingState());
      try {
        final newCard = CardModel(
          cardNumber: event.cardModel.cardNumber,
          expiryDate: event.cardModel.expiryDate,
          cardHolder: event.cardModel.cardHolder,
          cardType: event.cardModel.cardType,
          cvv: event.cardModel.cvv,
          virtualNumber: event.cardModel.virtualNumber,
        );

        newCard.userUid = FirebaseAuth.instance.currentUser?.uid;
        await cardRepository.addCard(newCard);
        emit(CardSuccessState());
      } catch (e) {
        ;
        emit(CardErrorState('Failed to add card: $e'));
      }
    });

    on<GettingCards>((event, emit) async {
      emit(CardLoadingState());
      try {
        final List<CardModel> cards = await cardRepository.getCards();
        emit(CardLoadedState(cards));
      } catch (e) {
        emit(CardErrorState('Failed to load cards: $e'));
      }
    });

    on<DeleteCard>((event, emit) async {
      emit(CardLoadingState());
      try {
        await cardRepository.deleteCard(event.virtualNumber);
        emit(CardSuccessState());
      } catch (e) {
        emit(CardErrorState('Failed to delete card: $e'));
      }
    });

    on<CardFreeze>((event, emit) async {
      emit(CardLoadingState());
      try {
        await cardRepository.cardFreeze(event.virtualNumber);
        emit(CardLoadedState(await cardRepository.getCards()));
      } catch (e) {
        emit(CardErrorState('Failed to update card: $e'));
      }
    });
  }
}
