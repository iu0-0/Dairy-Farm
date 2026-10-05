class Farm {
  final int id;
  final String name;
  final String ownerName;
  final String? phone;
  final String? email;
  final String? city;
  final String? state;
  final String? address;
  final String? pincode;
  final bool status;
  final String? description;

  Farm({
    required this.id,
    required this.name,
    required this.ownerName,
    this.phone,
    this.email,
    this.city,
    this.state,
    this.address,
    this.pincode,
    this.status = true,
    this.description,
  });

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      ownerName: json['owner_name']?.toString() ?? '',
      phone: json['phone']?.toString(),
      email: json['email']?.toString(),
      city: json['city']?.toString(),
      state: json['state']?.toString(),
      address: json['address']?.toString(),
      pincode: json['pincode']?.toString(),
      status: json['status'] == 1 || json['status'] == true || json['status'] == '1',
      description: json['description']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'owner_name': ownerName,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (address != null) 'address': address,
      if (pincode != null) 'pincode': pincode,
      'status': status ? 1 : 0,
      if (description != null) 'description': description,
    };
  }
}
