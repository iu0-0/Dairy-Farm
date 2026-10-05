// ─────────────────────────────────────────────────────────────────────────────
// UserModel — matches GET /api/profile and PUT /api/profile response
// ─────────────────────────────────────────────────────────────────────────────
class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? role;
  final String? farmName;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.role,
    this.farmName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString(),
      role: json['role']?.toString(),
      farmName: json['farm_name']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      if (phone != null && phone!.isNotEmpty) 'phone': phone,
      if (farmName != null && farmName!.isNotEmpty) 'farm_name': farmName,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? role,
    String? farmName,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      farmName: farmName ?? this.farmName,
    );
  }
}
