class ActivityModel {
  final String id;
  final String categoryId;
  final String title;
  final String description;
  final List<String> imageUrls;
  final int price;
  final int priceDiscount; // Diubah ke camelCase
  final double rating;
  final int totalReviews; // Diubah ke camelCase
  final String facilities;
  final String address;
  final String province;
  final String city;
  final String locationMaps; // Diubah ke camelCase

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
    return ActivityModel(
      id: json['id'] ?? '',
      categoryId: json['categoryId'] ?? '',
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
      // Mapping List String agar aman jika null
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ?? [],
      price: json['price'] ?? 0,
      // Mapping snake_case dari API ke camelCase di Model
      priceDiscount: json['price_discount'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: json['total_reviews'] ?? 0,
      facilities: json['facilities'] ?? '',
      address: json['address'] ?? '',
      province: json['province'] ?? '',
      city: json['city'] ?? '',
      locationMaps: json['location_maps'] ?? '',
    );
  }

  // Tambahkan juga Method toJson (Berguna untuk Local Storage/Bookmark nanti)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'imageUrls': imageUrls,
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