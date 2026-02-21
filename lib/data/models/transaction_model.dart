class TransactionModel {
  final String id;
  final String invoiceId;
  final String status;
  final int totalAmount;
  final String paymentInstruction;

  TransactionModel({
    required this.id,
    required this.invoiceId,
    required this.status,
    required this.totalAmount,
    required this.paymentInstruction,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? '',
      invoiceId: json['invoiceId'] ?? '',
      status: json['status'] ?? '',
      totalAmount: json['totalAmount'] ?? 0,
      paymentInstruction: json['paymentInstruction'] ?? '',
    );
  }
}