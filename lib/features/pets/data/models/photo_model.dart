class PhotoModel {
  final String small;
  final String medium;
  final String large;
  final String full;

  const PhotoModel({
    required this.small,
    required this.medium,
    required this.large,
    required this.full,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      small: json['small'] ?? '',
      medium: json['medium'] ?? '',
      large: json['large'] ?? '',
      full: json['full'] ?? '',
    );
  }
}
