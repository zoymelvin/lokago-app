import 'activity_model.dart';

class CartItemModel {
  final String id;
  final ActivityModel activity;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.activity,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id']?.toString() ?? '',
      quantity: json['quantity'] ?? 1,
      activity: (json['activity'] != null && json['activity'] is Map<String, dynamic>)
          ? ActivityModel.fromJson(json['activity'] as Map<String, dynamic>)
          : ActivityModel(
              id: '',
              categoryId: '',
              title: 'Data Corrupted',
              description: '',
              imageUrls: [],
              price: 0,
              priceDiscount: 0,
              rating: 0,
              totalReviews: 0,
              facilities: '',
              address: '',
              province: '',
              city: '',
              locationMaps: '',
            ),
    );
  }
}