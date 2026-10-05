class GalleryItemModel {
  final int id;
  final int? farmId;
  final int? animalId;
  final String imagePath;
  final String? imageUrl;
  final String? caption;
  final String? animalTag;
  final String? animalName;

  GalleryItemModel({
    required this.id,
    this.farmId,
    this.animalId,
    required this.imagePath,
    this.imageUrl,
    this.caption,
    this.animalTag,
    this.animalName,
  });

  factory GalleryItemModel.fromJson(Map<String, dynamic> json) {
    return GalleryItemModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      farmId: json['farm_id'] != null ? (json['farm_id'] is int ? json['farm_id'] : int.tryParse(json['farm_id'].toString())) : null,
      animalId: json['animal_id'] != null ? (json['animal_id'] is int ? json['animal_id'] : int.tryParse(json['animal_id'].toString())) : null,
      imagePath: json['image_path']?.toString() ?? '',
      imageUrl: json['image_url']?.toString(),
      caption: json['caption']?.toString(),
      animalTag: json['animal'] != null && json['animal']['tag_number'] != null ? json['animal']['tag_number'].toString() : null,
      animalName: json['animal'] != null && json['animal']['name'] != null ? json['animal']['name'].toString() : null,
    );
  }
}
