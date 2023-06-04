class SignupModel {
  String? uid;
  late String firstName;
  late String lastName;
  late String gender;
  late String phonenumber;
  late double balance;
  late double expense;

  SignupModel(
      {this.uid,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.phonenumber});

  SignupModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    phonenumber = json['phoneNumber'];
    balance = json['balance'];
    expense = json['expense'];
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'phonenumber': phonenumber,
        'balance': balance,
        'expense': expense,
      };
}
