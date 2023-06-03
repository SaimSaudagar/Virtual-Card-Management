import 'package:project/blocs/update/model/updateModel.dart';

abstract class UpdateUIState {}

class UpdateUIInitial extends UpdateUIState {}

class UpdateUIProcessing extends UpdateUIState {}

class DeletedUser extends UpdateUIState {}

class UpdateUISuccess extends UpdateUIState {
  final UpdateUserModel updatedUser;

  UpdateUISuccess(this.updatedUser);
}

class UpdatedUser extends UpdateUIState {}

class UpdatedUserLogout extends UpdateUIState {}

class UpdateUIError extends UpdateUIState {
  final String errorMessage;

  UpdateUIError(this.errorMessage);
}
