import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/blocs/signup/model/siginupModel.dart';
// import 'package:project/transaction/transaction.dart';

abstract class UserHomeState extends Equatable {
  const UserHomeState();

  @override
  List<Object> get props => [];
}

class UserHomeInitial extends UserHomeState {}

class UserHomeLoading extends UserHomeState {}

class UserHomeSuccess extends UserHomeState {
  final SignupModel user;

  const UserHomeSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserHomeFailure extends UserHomeState {
  final String errorMessage;

  const UserHomeFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
