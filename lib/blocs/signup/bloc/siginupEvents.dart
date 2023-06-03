import 'package:equatable/equatable.dart';
import 'package:project/blocs/signup/model/siginupModel.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupButtonPressed extends SignupEvent {
  final SignupModel signupModel;

  SignupButtonPressed(this.signupModel);

  @override
  List<Object> get props => [signupModel];
}

class Loading extends SignupEvent {}
