import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:link_task/core/networking/network_info.dart';
import 'package:link_task/core/usecases/use_cases.dart';
import 'package:link_task/features/companies/domain/entities/city.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/domain/entities/pagination.dart';
import 'package:link_task/features/companies/domain/entities/sub_category.dart';
import 'package:link_task/features/companies/domain/usecases/filter_companies_use_case.dart';
import 'package:link_task/features/companies/domain/usecases/get_cities_use_case.dart';
import 'package:link_task/features/companies/domain/usecases/get_subcategories_use_case.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  CompaniesCubit({
    required this.getCitiesUseCase,
    required this.filterCompaniesUseCase,
    required this.getSubcategoriesUseCase,
    required this.networkInfo,
  }) : super(CompaniesInitial());

  final GetCitiesUseCase getCitiesUseCase;
  final FilterCompaniesUseCase filterCompaniesUseCase;
  final GetSubcategoriesUseCase getSubcategoriesUseCase;
  final NetworkInfo networkInfo;

  List<City> citiesList = [];
  List<Subcategory> subCategoriesList = [];

  String? _currentSearch;
  String? _currentType;
  int? _currentCityId;
  List<int>? _currentSubCategoryIds;

  Future<void> loadFiltersData() async {
    if (!await networkInfo.isConnected) {
      emit(CompaniesError('لا يوجد اتصال بالإنترنت'));
      return;
    }

    final citiesResult = await getCitiesUseCase(NoParams());
    citiesResult.fold((failure) => null, (cities) => citiesList = cities);

    final subcategoriesResult = await getSubcategoriesUseCase(NoParams());
    subcategoriesResult.fold(
      (failure) => null,
      (subcategories) => subCategoriesList = subcategories,
    );
  }

  Future<void> initialize() async {
    emit(CompaniesLoading());
    await loadFiltersData();
    await loadCompanies();
  }

  Future<void> loadCompanies({
    String? search,
    String? type,
    int? cityId,
    List<int>? subCategoryIds,
    int page = 1,
  }) async {
    if (!await networkInfo.isConnected) {
      emit(CompaniesError('لا يوجد اتصال بالإنترنت'));
      return;
    }

    if (page == 1) {
      emit(CompaniesLoading());
      _currentSearch = search;
      _currentType = type;
      _currentCityId = cityId;
      _currentSubCategoryIds = subCategoryIds;
    }

    final params = FilterCompaniesParams(
      search: search,
      type: type,
      cityId: cityId,
      subCategoryIds: subCategoryIds,
      page: page,
    );

    final result = await filterCompaniesUseCase(params);

    result.fold((failure) => emit(CompaniesError(failure.message)), (data) {
      final companies = data.$1;
      final pagination = data.$2;

      if (companies.isEmpty) {
        emit(
          CompaniesEmpty(cities: citiesList, subcategories: subCategoriesList),
        );
      } else {
        emit(
          CompaniesLoaded(
            companies: companies,
            pagination: pagination,
            cities: citiesList,
            subcategories: subCategoriesList,
            currentSearch: search,
            currentType: type,
            currentCityId: cityId,
            currentSubCategoryIds: subCategoryIds,
          ),
        );
      }
    });
  }

  Future<void> goToPage(int page) async {
    try {
      final currentState = state;
      if (currentState is! CompaniesLoaded) return;
      if (!await networkInfo.isConnected) {
        emit(CompaniesError('لا يوجد اتصال بالإنترنت'));
        return;
      }
      emit(CompaniesPageLoading(currentState));
      final params = FilterCompaniesParams(
        search: currentState.currentSearch,
        type: currentState.currentType,
        cityId: currentState.currentCityId,
        subCategoryIds: currentState.currentSubCategoryIds,
        page: page,
      );
      final result = await filterCompaniesUseCase(params);
      result.fold(
        (failure) {
          emit(currentState);
          emit(CompaniesError(failure.message));
        },
        (data) {
          final companies = data.$1;
          final pagination = data.$2;
          if (companies.isEmpty && page > 1) {
            emit(currentState);
            emit(CompaniesError('لا توجد بيانات في هذه الصفحة'));
            return;
          }
          emit(
            currentState.copyWith(companies: companies, pagination: pagination),
          );
        },
      );
    } catch (e) {
      final currentState = state;
      if (currentState is CompaniesLoaded) {
        emit(currentState);
      }
      emit(CompaniesError('حدث خطأ: ${e.toString()}'));
    }
  }

  Future<void> applyFilters({
    String? search,
    String? type,
    int? cityId,
    List<int>? subCategoryIds,
  }) async {
    await loadCompanies(
      search: search ?? _currentSearch,
      type: type,
      cityId: cityId,
      subCategoryIds: subCategoryIds,
      page: 1,
    );
  }

  Future<void> search(String query) async {
    await loadCompanies(
      search: query.isEmpty ? null : query,
      type: _currentType,
      cityId: _currentCityId,
      subCategoryIds: _currentSubCategoryIds,
      page: 1,
    );
  }

  Future<void> clearFilters() async {
    _currentSearch = null;
    _currentType = null;
    _currentCityId = null;
    _currentSubCategoryIds = null;
    await loadCompanies(page: 1);
  }
}
