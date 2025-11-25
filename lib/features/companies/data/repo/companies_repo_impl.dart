import 'package:dartz/dartz.dart';
import 'package:link_task/core/errors/exceptions.dart';
import 'package:link_task/core/errors/failure.dart';
import 'package:link_task/features/companies/data/datasource/remote_data_source.dart';
import 'package:link_task/features/companies/domain/entities/city.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/domain/entities/pagination.dart';
import 'package:link_task/features/companies/domain/entities/sub_category.dart';
import 'package:link_task/features/companies/domain/repo/companies_repo.dart';

class CompaniesRepoImpl implements CompaniesRepo {
  final CompaniesRemoteDataSource _remoteDataSource;

  CompaniesRepoImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<City>>> getCities() async {
    try {
      final cities = await _remoteDataSource.getCities();
      return Right(cities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, List<Subcategory>>> getSubcategories() async {
    try {
      final subcategories = await _remoteDataSource.getSubcategories();

      return Right(subcategories);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, (List<Company>, Pagination)>> filterCompanies({
    String? search,
    String? type,
    int? cityId,
    List<int>? subCategoryIds,
    int page = 1,
  }) async {
    try {
      final response = await _remoteDataSource.filterCompanies(
        search: search,
        type: type,
        cityId: cityId,
        subCategoryIds: subCategoryIds,
        page: page,
      );

      final companies = response.data.data;
      final pagination = response.data.pagination;

      return Right((companies, pagination));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('حدث خطأ غير متوقع'));
    }
  }
}
