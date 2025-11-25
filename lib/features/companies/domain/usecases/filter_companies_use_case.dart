import 'package:dartz/dartz.dart';
import 'package:link_task/core/errors/failure.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/domain/entities/pagination.dart';
import 'package:link_task/features/companies/domain/repo/companies_repo.dart';

class FilterCompaniesParams {
  final String? search;
  final String? type;
  final int? cityId;
  final List<int>? subCategoryIds;
  final int page;

  FilterCompaniesParams({
    this.search,
    this.type,
    this.cityId,
    this.subCategoryIds,
    this.page = 1,
  });
}

class FilterCompaniesUseCase {
  final CompaniesRepo _repository;

  const FilterCompaniesUseCase(this._repository);

  Future<Either<Failure, (List<Company>, Pagination)>> call(
    FilterCompaniesParams params,
  ) async {
    return await _repository.filterCompanies(
      search: params.search,
      type: params.type,
      cityId: params.cityId,
      subCategoryIds: params.subCategoryIds,
      page: params.page,
    );
  }
}
