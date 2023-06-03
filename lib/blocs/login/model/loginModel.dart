class LoginModel {
  int? id;
  String? email;
  String? password;

  LoginModel({this.id, this.email, this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
  }
}
