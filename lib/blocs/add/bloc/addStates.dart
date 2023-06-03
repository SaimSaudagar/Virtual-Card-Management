import 'package:equatable/equatable.dart';
import 'package:project/blocs/add/model/addModel.dart';

class AddState extends Equatable {
  const AddState();

  @override
  List<Object> get props => [];
}

class LoadingState extends AddState {}

class InitalState extends AddState {}

class AddErrorState extends AddState {
  final String message;

  AddErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SuccessState extends AddState {}

class LoadedState extends AddState {
  final List<AddModel> add;

  const LoadedState(this.add);

  @override
  List<Object> get props => [add];
}
