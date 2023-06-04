import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/blocs/update/bloc/updateEvents.dart';
import 'package:project/blocs/update/bloc/updateStates.dart';
import 'package:project/blocs/update/model/updateModel.dart';
import 'package:project/blocs/update/repo/updateRepo.dart';

class UpdateUIBloc extends Bloc<UpdateUIEvent, UpdateUIState> {
  final UpdateUIRepository repository;

  UpdateUIBloc(this.repository) : super(UpdateUIInitial()) {
    on<UserLoadEvent>((event, emit) async {
      emit(UpdateUIProcessing());
      try {
        User? user = FirebaseAuth.instance.currentUser;

        await repository
            .getUserByUid(user!.uid)
            .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.exists) {
            Map<String, dynamic> data = snapshot.data()!;
            if (data != null) {
              print(data);
              UpdateUserModel userData = UpdateUserModel.fromJson(data);
              userData.email = FirebaseAuth.instance.currentUser!.email!;
              print(userData);
              emit(UpdateUISuccess(userData));
            } else {
              emit(UpdateUIError("User data is null"));
            }
          } else {
            emit(UpdateUIError("User not found"));
          }
        });
      } catch (e) {
        emit(UpdateUIError('Failed to load user information'));
      }
    });

    on<UpdateButtonPressed>((event, emit) async {
      emit(UpdateUIProcessing());
      UpdateUserModel userData = UpdateUserModel(
          email: '',
          password: '',
          firstName: '',
          lastName: '',
          phoneNumber: '');
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user?.email != event.updatedUser.email ||
            event.updatedUser.password != '') {
          await repository
              .updateUser(user!.uid, event.updatedUser)
              .then((value) {
            emit(UpdatedUserLogout());
          });
        } else {
          await repository
              .updateUser(user!.uid, event.updatedUser)
              .then((value) {
            emit(UpdatedUser());
          });
        }
      } catch (e) {
        emit(UpdateUIError('Failed to update user information'));
      }
    });

    on<DeleteButtonPressed>((event, emit) async {
      emit(UpdateUIProcessing());
      try {
        print("Deleting");
        await repository.deleteUser();
        print("Deleted");
        emit(DeletedUser());
      } catch (e) {
        emit(UpdateUIError('Failed to delete user information'));
      }
    });
  }
}
