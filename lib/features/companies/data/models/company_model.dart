import 'package:link_task/features/companies/data/models/pagination_model.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';

class CompanyModel extends Company {
  const CompanyModel({
    required super.id,
    required super.name,
    required super.type,
    required super.img,
    required super.desc,
    required super.avgRates,
    required super.fav,
    required super.location,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      img: json['img'] as String,
      desc: json['desc'] as String,
      avgRates: json['avg_rates'] as String,
      fav: json['fav'] as bool,
      location: json['location'] as String,
    );
  }
}

class CompaniesData {
  final List<CompanyModel> data;
  final PaginationModel pagination;

  CompaniesData({required this.data, required this.pagination});

  factory CompaniesData.fromJson(Map<String, dynamic> json) {
    return CompaniesData(
      data: (json['data'] as List)
          .map((item) => CompanyModel.fromJson(item))
          .toList(),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }
}

class CompaniesResponse {
  final CompaniesData data;
  final String message;
  final bool status;

  CompaniesResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory CompaniesResponse.fromJson(Map<String, dynamic> json) {
    return CompaniesResponse(
      data: CompaniesData.fromJson(json['data']),
      message: json['message'] as String,
      status: json['status'] as bool,
    );
  }
}
