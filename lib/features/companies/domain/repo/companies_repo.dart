import 'package:dartz/dartz.dart';
import 'package:link_task/core/errors/failure.dart';
import 'package:link_task/features/companies/domain/entities/city.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/domain/entities/pagination.dart';
import 'package:link_task/features/companies/domain/entities/sub_category.dart';

abstract class CompaniesRepo {
  Future<Either<Failure, List<City>>> getCities();
  Future<Either<Failure, List<Subcategory>>> getSubcategories();
  Future<Either<Failure, (List<Company>, Pagination)>> filterCompanies({
    String? search,
    String? type,
    int? cityId,
    List<int>? subCategoryIds,
    int page = 1,
  });
}
