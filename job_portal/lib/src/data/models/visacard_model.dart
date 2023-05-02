import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentMethod {
  String cardNumber;
  String cardHolderName;
  String expirationDate;
  String cvv;

  PaymentMethod({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expirationDate,
    required this.cvv,
  });

  factory PaymentMethod.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return PaymentMethod(
      cardNumber: data['cardNumber'] ?? '',
      cardHolderName: data['cardHolderName'] ?? '',
      expirationDate: data['expirationDate'] ?? '',
      cvv: data['cvv'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cardNumber': this.cardNumber,
      'cardHolderName': this.cardHolderName,
      'expirationDate': this.expirationDate,
      'cvv': this.cvv,
    };
  }
}
