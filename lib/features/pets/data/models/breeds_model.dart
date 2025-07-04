class BreedsModel {
  final String? primary;
  final String? secondary;
  final bool mixed;
  final bool unknown;

  const BreedsModel({
    this.primary,
    this.secondary,
    required this.mixed,
    required this.unknown,
  });

  factory BreedsModel.fromJson(Map<String, dynamic> json) {
    return BreedsModel(
      primary: json['primary'],
      secondary: json['secondary'],
      mixed: json['mixed'] ?? false,
      unknown: json['unknown'] ?? false,
    );
  }
}
