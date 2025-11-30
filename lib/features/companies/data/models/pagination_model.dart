import 'package:link_task/features/companies/domain/entities/pagination.dart';

class PaginationModel extends Pagination {
  const PaginationModel({
    required super.currentPage,
    required super.lastPage,
    required super.total,
    required super.hasNextPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    final currentPage = json['current_page'] as int? ?? 1;
    final lastPage = json['last_page'] as int? ?? 1;
    final total = json['total'] as int? ?? 0;
    final nextPageUrl = json['next_page_url'];

    return PaginationModel(
      currentPage: currentPage,
      lastPage: lastPage,
      total: total,
      hasNextPage: nextPageUrl != null && currentPage < lastPage,
    );
  }
}
