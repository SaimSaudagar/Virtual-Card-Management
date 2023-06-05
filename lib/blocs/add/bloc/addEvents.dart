import 'package:equatable/equatable.dart';
import 'package:project/blocs/add/model/addModel.dart';

abstract class AddEvents extends Equatable {
  const AddEvents();

  @override
  List<Object?> get props => [];
}

class TransactionAddButtonPressed extends AddEvents {
  final AddModel addModel;

  TransactionAddButtonPressed(this.addModel);

  @override
  List<Object> get props => [addModel];
}

class GetTransactions extends AddEvents {}

class Loading extends AddEvents {}
