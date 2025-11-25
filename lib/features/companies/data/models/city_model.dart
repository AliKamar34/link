import 'package:link_task/features/companies/domain/entities/city.dart';

class CityModel extends City {
  const CityModel({required super.id, required super.name});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(id: json['id'], name: json['name']);
  }
}

class CitiesResponse {
  final List<CityModel> data;
  final String message;
  final bool status;

  CitiesResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory CitiesResponse.fromJson(Map<String, dynamic> json) {
    return CitiesResponse(
      data: (json['data'] as List)
          .map((item) => CityModel.fromJson(item))
          .toList(),
      message: json['message'] as String,
      status: json['status'] as bool,
    );
  }
}
