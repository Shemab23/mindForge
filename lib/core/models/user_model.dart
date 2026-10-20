class UserModel {
  final int id;
  final String name;
  final String email;
  final String city;
  final String companyName;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
    required this.companyName,
  });

  /// Factory constructor enforces data normalization and strict typing rules
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Anonymous User',
      email: json['email'] as String? ?? 'no-email@domain.com',
      // Safe boundary parsing of deeply nested properties
      city:
          (json['address'] as Map<String, dynamic>?)?['city'] as String? ??
          'Unknown City',
      companyName:
          (json['company'] as Map<String, dynamic>?)?['name'] as String? ??
          'Independent',
    );
  }
}
