class ActivityModel {
  final String id;
  final String title;
  final String city;
  final double rating;
  final int price;
  final int price_discount;
  final int total_reviews;
  final List<String> imageUrls;

  ActivityModel({
    required this.id,
    required this.title,
    required this.city,
    required this.rating,
    required this.price,
    required this.price_discount,
    required this.total_reviews,
    required this.imageUrls,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'] ?? '',
      title: json['title'] ?? 'No Title',
      city: json['city'] ?? 'Unknown',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      price: json['price'] ?? 0,
      price_discount: json['price_discount'] ?? 0,
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      total_reviews: json['total_reviews'] ?? 0,
    );
  }
}