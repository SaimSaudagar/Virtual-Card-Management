import 'package:project/blocs/update/model/updateModel.dart';

abstract class UpdateUIEvent {}

class UserLoadEvent extends UpdateUIEvent {}

class UpdateButtonPressed extends UpdateUIEvent {
  final UpdateUserModel updatedUser;

  UpdateButtonPressed(this.updatedUser);
}

class DeleteButtonPressed extends UpdateUIEvent {}
