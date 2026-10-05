import 'breed_model.dart';

class AnimalModel {
  final int id;
  final int farmId;
  final int animalTypeId;
  final int? breedId;
  final String tagNumber;
  final String? name;
  final String gender;
  final String? dateOfBirth;
  final String? purchaseDate;
  final double? purchasePrice;
  final String? color;
  final double? weight;
  final String status;
  final String? notes;
  final String? animalTypeName;
  final String? breedName;
  final Breed? breed;

  AnimalModel({
    required this.id,
    required this.farmId,
    required this.animalTypeId,
    this.breedId,
    required this.tagNumber,
    this.name,
    required this.gender,
    this.dateOfBirth,
    this.purchaseDate,
    this.purchasePrice,
    this.color,
    this.weight,
    this.status = 'active',
    this.notes,
    this.animalTypeName,
    this.breedName,
    this.breed,
  });

  String get displayName => (name != null && name!.trim().isNotEmpty) ? name! : tagNumber;
  String get speciesName => animalTypeName ?? (gender.toLowerCase() == 'female' ? 'Cow' : 'Bull');
  String get breedDisplay => breedName ?? breed?.name ?? 'Standard';

  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    return AnimalModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      farmId: json['farm_id'] is int ? json['farm_id'] : int.tryParse(json['farm_id']?.toString() ?? '0') ?? 0,
      animalTypeId: json['animal_type_id'] is int ? json['animal_type_id'] : int.tryParse(json['animal_type_id']?.toString() ?? '0') ?? 0,
      breedId: json['breed_id'] != null ? (json['breed_id'] is int ? json['breed_id'] : int.tryParse(json['breed_id'].toString())) : null,
      tagNumber: json['tag_number']?.toString() ?? 'TAG-${json['id']}',
      name: json['name']?.toString(),
      gender: json['gender']?.toString() ?? 'female',
      dateOfBirth: json['date_of_birth']?.toString(),
      purchaseDate: json['purchase_date']?.toString(),
      purchasePrice: json['purchase_price'] != null ? double.tryParse(json['purchase_price'].toString()) : null,
      color: json['color']?.toString(),
      weight: json['weight'] != null ? double.tryParse(json['weight'].toString()) : null,
      status: json['status']?.toString() ?? 'active',
      notes: json['notes']?.toString(),
      animalTypeName: json['animal_type'] != null && json['animal_type']['name'] != null
          ? json['animal_type']['name'].toString()
          : (json['animalType'] != null ? json['animalType']['name']?.toString() : null),
      breedName: json['breed'] != null && json['breed']['name'] != null
          ? json['breed']['name'].toString()
          : null,
      breed: json['breed'] != null && json['breed'] is Map<String, dynamic> ? Breed.fromJson(json['breed']) : null,
    );
  }
}
