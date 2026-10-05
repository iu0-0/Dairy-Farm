class HealthRecordModel {
  final int id;
  final int farmId;
  final int animalId;
  final String checkupDate;
  final String healthStatus;
  final String? diagnosis;
  final String? symptoms;
  final String? treatment;
  final String? medicine;
  final String? veterinarianName;
  final String? nextCheckupDate;
  final String? animalTag;

  HealthRecordModel({
    required this.id,
    required this.farmId,
    required this.animalId,
    required this.checkupDate,
    required this.healthStatus,
    this.diagnosis,
    this.symptoms,
    this.treatment,
    this.medicine,
    this.veterinarianName,
    this.nextCheckupDate,
    this.animalTag,
  });

  factory HealthRecordModel.fromJson(Map<String, dynamic> json) {
    return HealthRecordModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      farmId: json['farm_id'] is int ? json['farm_id'] : int.tryParse(json['farm_id']?.toString() ?? '0') ?? 0,
      animalId: json['animal_id'] is int ? json['animal_id'] : int.tryParse(json['animal_id']?.toString() ?? '0') ?? 0,
      checkupDate: json['checkup_date']?.toString() ?? '',
      healthStatus: json['health_status']?.toString() ?? 'healthy',
      diagnosis: json['diagnosis']?.toString(),
      symptoms: json['symptoms']?.toString(),
      treatment: json['treatment']?.toString(),
      medicine: json['medicine']?.toString(),
      veterinarianName: json['veterinarian_name']?.toString(),
      nextCheckupDate: json['next_checkup_date']?.toString(),
      animalTag: json['animal'] != null && json['animal']['tag_number'] != null ? json['animal']['tag_number'].toString() : null,
    );
  }
}

class VaccinationModel {
  final int id;
  final int farmId;
  final int animalId;
  final String vaccineName;
  final String vaccinationDate;
  final String? nextDueDate;
  final String? dose;
  final String? batchNumber;
  final String? veterinarianName;
  final double? cost;
  final String? animalTag;

  VaccinationModel({
    required this.id,
    required this.farmId,
    required this.animalId,
    required this.vaccineName,
    required this.vaccinationDate,
    this.nextDueDate,
    this.dose,
    this.batchNumber,
    this.veterinarianName,
    this.cost,
    this.animalTag,
  });

  factory VaccinationModel.fromJson(Map<String, dynamic> json) {
    return VaccinationModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      farmId: json['farm_id'] is int ? json['farm_id'] : int.tryParse(json['farm_id']?.toString() ?? '0') ?? 0,
      animalId: json['animal_id'] is int ? json['animal_id'] : int.tryParse(json['animal_id']?.toString() ?? '0') ?? 0,
      vaccineName: json['vaccine_name']?.toString() ?? '',
      vaccinationDate: json['vaccination_date']?.toString() ?? '',
      nextDueDate: json['next_due_date']?.toString(),
      dose: json['dose']?.toString(),
      batchNumber: json['batch_number']?.toString(),
      veterinarianName: json['veterinarian_name']?.toString(),
      cost: json['cost'] != null ? double.tryParse(json['cost'].toString()) : null,
      animalTag: json['animal'] != null && json['animal']['tag_number'] != null ? json['animal']['tag_number'].toString() : null,
    );
  }
}
