import 'package:link_task/features/companies/domain/entities/pagination.dart';

class PaginationModel extends Pagination {
  const PaginationModel({
    required super.currentPage,
    required super.lastPage,
    required super.total,
    required super.hasNextPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'] as int,
      lastPage: json['last_page'] as int,
      total: json['total'] as int,
      hasNextPage: json['next_page_url'] != null,
    );
  }
}
