import 'package:equatable/equatable.dart';
import 'package:project/blocs/card/model/cardModel.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object?> get props => [];
}

class AddButtonPressed extends CardEvent {
  final CardModel cardModel;

  AddButtonPressed(this.cardModel);

  @override
  List<Object> get props => [cardModel];
}

class GettingCards extends CardEvent {}

class GetCards extends CardEvent {
  final List<CardModel> cards;

  GetCards(this.cards);

  @override
  List<Object> get props => [];
}

class Loading extends CardEvent {}

class DeleteCard extends CardEvent {
  final String virtualNumber;

  const DeleteCard(this.virtualNumber);

  @override
  List<Object> get props => [virtualNumber];
}

class CardFreeze extends CardEvent {
  final String virtualNumber;

  const CardFreeze(this.virtualNumber);

  @override
  List<Object> get props => [virtualNumber];
}
