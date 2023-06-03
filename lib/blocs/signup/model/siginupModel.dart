class SignupModel {
  String? uid;
  late String email;
  late String firstName;
  late String lastName;
  late String password;
  late String gender;
  late String phonenumber;
  late double balance;
  late double expense;

  SignupModel(
      {this.uid,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.password,
      required this.gender,
      required this.phonenumber});

  SignupModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    password = json['password'];
    gender = json['gender'];
    phonenumber = json['phoneNumber'];
    balance = json['balance'];
    expense = json['expense'];
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'password': password,
        'gender': gender,
        'phonenumber': phonenumber,
        'balance': balance,
        'expense': expense,
      };
}
