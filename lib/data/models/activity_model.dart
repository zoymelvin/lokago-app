class ActivityModel {
  final String id;
  final String categoryId;
  final String title;
  final String description;
  final List<String> imageUrls;
  final int price;
  final int priceDiscount;
  final double rating;
  final int totalReviews;
  final String facilities;
  final String address;
  final String province;
  final String city;
  final String locationMaps;

  ActivityModel({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.price,
    required this.priceDiscount,
    required this.rating,
    required this.totalReviews,
    required this.facilities,
    required this.address,
    required this.province,
    required this.city,
    required this.locationMaps,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    int toInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    double toDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    List<String> toStringList(dynamic value) {
      if (value != null && value is List) {
        return value.map((e) => e.toString()).toList();
      }
      return [];
    }

    return ActivityModel(
      id: json['id']?.toString() ?? '',
      categoryId: (json['categoryId'] ?? json['category_id'])?.toString() ?? '',
      title: json['title']?.toString() ?? 'No Title',
      description: json['description']?.toString() ?? '',
      imageUrls: toStringList(json['image_urls'] ?? json['imageUrls']),
      price: toInt(json['price']),
      priceDiscount: toInt(json['price_discount'] ?? json['priceDiscount']),
      rating: toDouble(json['rating']),
      totalReviews: toInt(json['total_reviews'] ?? json['totalReviews']),
      facilities: json['facilities']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      province: json['province']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      locationMaps: (json['location_maps'] ?? json['locationMaps'])?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'image_urls': imageUrls,
      'price': price,
      'price_discount': priceDiscount,
      'rating': rating,
      'total_reviews': totalReviews,
      'facilities': facilities,
      'address': address,
      'province': province,
      'city': city,
      'location_maps': locationMaps,
    };
  }
}