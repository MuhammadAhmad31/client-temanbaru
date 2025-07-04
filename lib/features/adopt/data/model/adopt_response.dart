import 'package:client/features/adopt/data/model/adopt_model.dart';

class AdoptResponse {
  final bool success;
  final List<AdoptModel> data;

  const AdoptResponse({required this.success, required this.data});

  factory AdoptResponse.fromJson(Map<String, dynamic> json) {
    return AdoptResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List)
          .map((item) => AdoptModel.fromJson(item))
          .toList(),
    );
  }
}
