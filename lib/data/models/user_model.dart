class UserModel {
  final String? id;
  final String? email;
  final String? name;
  final String? role;
  final String? profilePictureUrl;
  final String? phoneNumber;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.role,
    this.profilePictureUrl,
    this.phoneNumber,
  });

  // Untuk mengubah data dari API (JSON) menjadi objek Flutter
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      profilePictureUrl: json['profilePictureUrl'],
      phoneNumber: json['phoneNumber'],
    );
  }

  // TAMBAHKAN INI: Untuk mengubah objek Flutter menjadi JSON 
  // (Sangat berguna untuk fitur Update Profil nanti)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'profilePictureUrl': profilePictureUrl,
      'phoneNumber': phoneNumber,
    };
  }
}