import 'package:dartz/dartz.dart';
import 'package:link_task/core/errors/failure.dart';
import 'package:link_task/core/usecases/use_cases.dart';
import 'package:link_task/features/companies/domain/entities/sub_category.dart';
import 'package:link_task/features/companies/domain/repo/companies_repo.dart';

class GetSubcategoriesUseCase {
  final CompaniesRepo _repository;

  const GetSubcategoriesUseCase(this._repository);

  Future<Either<Failure, List<Subcategory>>> call(NoParams params) async {
    return await _repository.getSubcategories();
  }
}
