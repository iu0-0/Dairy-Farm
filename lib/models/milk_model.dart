class MilkRecordModel {
  final int id;
  final int farmId;
  final int? animalId;
  final String recordDate;
  final double morningQuantity;
  final double eveningQuantity;
  final double totalQuantity;
  final double? fatPercentage;
  final double? snfPercentage;
  final String? notes;
  final String? animalTag;
  final String? animalName;

  MilkRecordModel({
    required this.id,
    required this.farmId,
    this.animalId,
    required this.recordDate,
    required this.morningQuantity,
    required this.eveningQuantity,
    required this.totalQuantity,
    this.fatPercentage,
    this.snfPercentage,
    this.notes,
    this.animalTag,
    this.animalName,
  });

  factory MilkRecordModel.fromJson(Map<String, dynamic> json) {
    final morning = double.tryParse(json['morning_quantity']?.toString() ?? '0') ?? 0.0;
    final evening = double.tryParse(json['evening_quantity']?.toString() ?? '0') ?? 0.0;
    final total = double.tryParse(json['total_quantity']?.toString() ?? '${morning + evening}') ?? (morning + evening);

    return MilkRecordModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      farmId: json['farm_id'] is int ? json['farm_id'] : int.tryParse(json['farm_id']?.toString() ?? '0') ?? 0,
      animalId: json['animal_id'] != null ? (json['animal_id'] is int ? json['animal_id'] : int.tryParse(json['animal_id'].toString())) : null,
      recordDate: json['record_date']?.toString() ?? '',
      morningQuantity: morning,
      eveningQuantity: evening,
      totalQuantity: total,
      fatPercentage: json['fat_percentage'] != null ? double.tryParse(json['fat_percentage'].toString()) : null,
      snfPercentage: json['snf_percentage'] != null ? double.tryParse(json['snf_percentage'].toString()) : null,
      notes: json['notes']?.toString(),
      animalTag: json['animal'] != null && json['animal']['tag_number'] != null ? json['animal']['tag_number'].toString() : null,
      animalName: json['animal'] != null && json['animal']['name'] != null ? json['animal']['name'].toString() : null,
    );
  }
}
