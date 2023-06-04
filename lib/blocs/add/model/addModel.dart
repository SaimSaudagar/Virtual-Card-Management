class AddModel {
  String? userUid;
  String? selectedItem;
  String? selectedCard;
  DateTime date = DateTime.now();
  String explanation = '';
  String amountTransacted = '';

  AddModel({
    this.selectedItem,
    this.selectedCard,
    required this.date,
    this.explanation = '',
    this.amountTransacted = '',
  });

  AddModel.fromJson(Map<String, dynamic> json) {
    userUid = json['userUid'];
    selectedItem = json['selectedItem'];
    selectedCard = json['selectedCard'];
    date = DateTime.parse(json['date']);
    explanation = json['explanation'];
    amountTransacted = json['amountTransacted'];
  }

  Map<String, dynamic> toJson() => {
        'userUid': userUid,
        'selectedItem': selectedItem,
        'selectedCard': selectedCard,
        'date': date.toIso8601String(),
        'explanation': explanation,
        'amountTransacted': amountTransacted,
      };
}
