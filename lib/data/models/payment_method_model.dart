class PaymentMethodModel {
  final String id;
  final String name;
  final String imageUrl;

  PaymentMethodModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}