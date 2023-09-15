abstract class ISendMoneyBridge {
  Future<Payment> makePayment(
    double amount,
    String receiverMsisdn,
    String orderId,
  );
}

class Payment {
  String transactionId;
  String transactionDate;

  Payment({
    required this.transactionId,
    required this.transactionDate,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        transactionId: json["transactionId"],
        transactionDate: json["transactionDate"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "transactionDate": transactionDate,
      };
}
