abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}
