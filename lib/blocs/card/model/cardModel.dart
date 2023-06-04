class CardModel {
  String? userUid;
  late String cardNumber;
  late DateTime expiryDate;
  late String cardHolder;
  late String cardType;
  late String cvv;
  late String virtualNumber;
  late String status;

  CardModel({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolder,
    required this.cardType,
    required this.cvv,
    required this.virtualNumber,
  });

  CardModel.fromJson(Map<String, dynamic> json) {
    userUid = json['userUid'];
    cardNumber = json['cardNumber'];
    expiryDate = DateTime.parse(json['expiryDate']);
    cardHolder = json['cardHolder'];
    cardType = json['cardType'];
    cvv = json['cvv'];
    virtualNumber = json['virtualNumber'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() => {
        'userUid': userUid,
        'cardNumber': cardNumber,
        'expiryDate': expiryDate.toIso8601String(),
        'cardHolder': cardHolder,
        'cardType': cardType,
        'cvv': cvv,
        'virtualNumber': virtualNumber,
        'status': status,
      };
}
