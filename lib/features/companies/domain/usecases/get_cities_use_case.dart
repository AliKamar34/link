import 'package:dartz/dartz.dart';
import 'package:link_task/core/errors/failure.dart';
import 'package:link_task/core/usecases/use_cases.dart';
import 'package:link_task/features/companies/domain/entities/city.dart';
import 'package:link_task/features/companies/domain/repo/companies_repo.dart';

class GetCitiesUseCase {
  final CompaniesRepo _repository;

  const GetCitiesUseCase(this._repository);

  Future<Either<Failure, List<City>>> call(NoParams params) async {
    return await _repository.getCities();
  }
}
