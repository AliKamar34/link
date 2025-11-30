import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:link_task/core/errors/exceptions.dart';
import 'package:link_task/core/networking/api_end_points.dart';
import 'package:link_task/core/networking/dio_helper.dart';
import 'package:link_task/features/companies/data/models/city_model.dart';
import 'package:link_task/features/companies/data/models/company_model.dart';
import 'package:link_task/features/companies/data/models/sub_categories_model.dart';

abstract class CompaniesRemoteDataSource {
  Future<List<CityModel>> getCities();
  Future<List<SubCategoriesModel>> getSubcategories();
  Future<CompaniesResponse> filterCompanies({
    String? search,
    String? type,
    int? cityId,
    List<int>? subCategoryIds,
    int page = 1,
  });
}

class CompaniesRemoteDataSourceImpl implements CompaniesRemoteDataSource {
  final DioHelper _dioHelper;

  CompaniesRemoteDataSourceImpl(this._dioHelper);

  @override
  Future<List<CityModel>> getCities() async {
    try {
      final response = await _dioHelper.getRequest(
        endPoint: ApiEndPoints.cities,
      );

      final citiesResponse = CitiesResponse.fromJson(response.data);
      if (citiesResponse.status) {
        return citiesResponse.data;
      } else {
        throw ServerException(citiesResponse.message);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع');
    }
  }

  @override
  Future<List<SubCategoriesModel>> getSubcategories() async {
    try {
      final response = await _dioHelper.getRequest(
        endPoint: ApiEndPoints.subCategoreis,
      );

      final subcategoriesResponse = SubcategoriesResponse.fromJson(
        response.data,
      );
      if (subcategoriesResponse.status) {
        return subcategoriesResponse.data;
      } else {
        throw ServerException(subcategoriesResponse.message);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع');
    }
  }

  @override
  Future<CompaniesResponse> filterCompanies({
    String? search,
    String? type,
    int? cityId,
    List<int>? subCategoryIds,
    int page = 1,
  }) async {
    try {
      final formData = FormData();

      if (search != null && search.isNotEmpty) {
        formData.fields.add(MapEntry('search', search));
      }

      if (type != null) {
        formData.fields.add(MapEntry('type', type));
      }

      if (cityId != null) {
        formData.fields.add(MapEntry('city_id', cityId.toString()));
      }

      if (subCategoryIds != null && subCategoryIds.isNotEmpty) {
        final subCategoriesJson = subCategoryIds
            .map((id) => '{ "id": $id}')
            .toList()
            .toString();
        formData.fields.add(MapEntry('sub_categories', subCategoriesJson));
      }

      formData.fields.add(MapEntry('page', page.toString()));

      log('Requesting page: $page');

      final response = await _dioHelper.postRequest(
        endPoint: ApiEndPoints.filterCompanies,
        data: formData,
      );

      log('Response data: ${response.data}');
      if (response.data == null) {
        throw ServerException('لا توجد بيانات في الاستجابة');
      }
      if (response.data is! Map<String, dynamic>) {
        throw ServerException('تنسيق البيانات غير صحيح');
      }

      final companiesResponse = CompaniesResponse.fromJson(response.data);

      log('Companies count: ${companiesResponse.data.data.length}');
      log('Current page: ${companiesResponse.data.pagination.currentPage}');
      log('Last page: ${companiesResponse.data.pagination.lastPage}');

      if (companiesResponse.status) {
        return companiesResponse;
      } else {
        throw ServerException(companiesResponse.message);
      }
    } on ServerException {
      rethrow;
    } catch (e, stackTrace) {
      log('Error in filterCompanies: $e', error: e, stackTrace: stackTrace);
      throw ServerException('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }
}
