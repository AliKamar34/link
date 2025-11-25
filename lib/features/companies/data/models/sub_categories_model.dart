import 'package:link_task/features/companies/domain/entities/sub_category.dart';

class SubCategoriesModel extends Subcategory {
  const SubCategoriesModel({
    required super.id,
    required super.name,
    required super.img,
  });

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) {
    return SubCategoriesModel(
      id: json['id'],
      name: json['name'],
      img: json['img'],
    );
  }
}

class SubcategoriesResponse {
  final List<SubCategoriesModel> data;
  final String message;
  final bool status;

  SubcategoriesResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory SubcategoriesResponse.fromJson(Map<String, dynamic> json) {
    return SubcategoriesResponse(
      data: (json['data'] as List)
          .map((item) => SubCategoriesModel.fromJson(item))
          .toList(),
      message: json['message'] as String,
      status: json['status'] as bool,
    );
  }
}
