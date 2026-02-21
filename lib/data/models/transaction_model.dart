class TransactionModel {
  final String id;
  final String invoiceId;
  final String status;
  final int totalAmount;
  final String paymentInstruction;
  final List<TransactionItem> transactionItems;
  final PaymentMethodDetail? paymentMethod;

  TransactionModel({
    required this.id,
    required this.invoiceId,
    required this.status,
    required this.totalAmount,
    required this.paymentInstruction,
    required this.transactionItems,
    this.paymentMethod,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? '',
      invoiceId: json['invoiceId'] ?? '',
      status: json['status'] ?? '',
      totalAmount: json['totalAmount'] ?? 0,
      paymentInstruction: json['paymentInstruction'] ?? '',
      transactionItems: (json['transaction_items'] as List?)
              ?.map((item) => TransactionItem.fromJson(item))
              .toList() ??
          [],
      paymentMethod: json['payment_method'] != null
          ? PaymentMethodDetail.fromJson(json['payment_method'])
          : null,
    );
  }

  TransactionModel copyWith({
    String? id,
    String? invoiceId,
    String? status,
    int? totalAmount,
    String? paymentInstruction,
    List<TransactionItem>? transactionItems,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentInstruction: paymentInstruction ?? this.paymentInstruction,
      transactionItems: transactionItems ?? this.transactionItems,
      paymentMethod: paymentMethod,
    );
  }
}

class TransactionItem {
  final String id;
  final String title;
  final int price;
  final int quantity;
  final List<String> imageUrls;

  TransactionItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imageUrls,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      price: json['price'] ?? 0,
      quantity: json['quantity'] ?? 0,
      imageUrls: (json['imageUrls'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}

class PaymentMethodDetail {
  final String name;
  final String virtualAccountNumber;
  final String imageUrl;

  PaymentMethodDetail({
    required this.name,
    required this.virtualAccountNumber,
    required this.imageUrl,
  });

  factory PaymentMethodDetail.fromJson(Map<String, dynamic> json) {
    return PaymentMethodDetail(
      name: json['name'] ?? '',
      virtualAccountNumber: json['virtual_account_number'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}