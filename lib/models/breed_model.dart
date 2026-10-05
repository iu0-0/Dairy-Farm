class Breed {
  final int id;
  final int animalTypeId;
  final String name;
  final String? description;
  final bool status;
  final String? animalTypeName;

  Breed({
    required this.id,
    required this.animalTypeId,
    required this.name,
    this.description,
    this.status = true,
    this.animalTypeName,
  });

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      animalTypeId: json['animal_type_id'] is int ? json['animal_type_id'] : int.tryParse(json['animal_type_id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString(),
      status: json['status'] == 1 || json['status'] == true || json['status'] == '1',
      animalTypeName: json['animal_type'] != null && json['animal_type']['name'] != null
          ? json['animal_type']['name'].toString()
          : null,
    );
  }
}
