import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/blocs/signup/bloc/siginupEvents.dart';
import 'package:project/blocs/signup/bloc/siginupStates.dart';
import 'package:project/blocs/signup/repo/siginupRepo.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepository signupRepository;

  SignupBloc(this.signupRepository) : super(SignupInitial()) {
    on<SignupButtonPressed>((event, emit) async {
      emit(SignupLoading());
      try {
        await signupRepository.signup(event.signupModel);

        emit(SignupSuccess());
      } catch (error) {
        emit(SignupFailure(error.toString()));
      }
    });
  }
}
