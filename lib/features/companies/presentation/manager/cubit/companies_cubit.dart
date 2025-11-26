// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:link_task/core/usecases/use_cases.dart';
// import 'package:link_task/features/companies/domain/entities/city.dart';
// import 'package:link_task/features/companies/domain/entities/company.dart';
// import 'package:link_task/features/companies/domain/entities/pagination.dart';
// import 'package:link_task/features/companies/domain/entities/sub_category.dart';
// import 'package:link_task/features/companies/domain/usecases/filter_companies_use_case.dart';
// import 'package:link_task/features/companies/domain/usecases/get_cities_use_case.dart';
// import 'package:link_task/features/companies/domain/usecases/get_subcategories_use_case.dart';

// part 'companies_state.dart';

// class CompaniesCubit extends Cubit<CompaniesState> {
//   CompaniesCubit({
//     required this.getCitiesUseCase,
//     required this.filterCompaniesUseCase,
//     required this.getSubcategoriesUseCase,
//   }) : super(CompaniesInitial());

//   final GetCitiesUseCase getCitiesUseCase;
//   final FilterCompaniesUseCase filterCompaniesUseCase;
//   final GetSubcategoriesUseCase getSubcategoriesUseCase;

//   List<City> citiesList = [];
//   List<Subcategory> subCategoriesList = [];
//   final Set<int> favIds = {};

//   Future<void> loadFiltersData() async {
//     final citiesResult = await getCitiesUseCase(NoParams());
//     citiesResult.fold((failure) => null, (cities) => citiesList = cities);

//     final subcategoriesResult = await getSubcategoriesUseCase(NoParams());
//     subcategoriesResult.fold(
//       (failure) => null,
//       (subcategories) => subCategoriesList = subcategories,
//     );
//   }

//   Future<void> initialize() async {
//     emit(CompaniesLoading());
//     await loadFiltersData();
//     await loadCompanies();
//   }

//   Future<void> loadCompanies({
//     String? search,
//     String? type,
//     int? cityId,
//     List<int>? subCategoryIds,
//     int page = 1,
//   }) async {
//     if (page == 1) {
//       emit(CompaniesLoading());
//     }

//     final params = FilterCompaniesParams(
//       search: search,
//       type: type,
//       cityId: cityId,
//       subCategoryIds: subCategoryIds,
//       page: page,
//     );

//     final result = await filterCompaniesUseCase(params);

//     result.fold((failure) => emit(CompaniesError(failure.message)), (data) {
//       final companies = data.$1;
//       final pagination = data.$2;

//       final updatedCompanies = companies.map((company) {
//         return company.copyWith(fav: favIds.contains(company.id));
//       }).toList();

//       if (updatedCompanies.isEmpty) {
//         emit(
//           CompaniesEmpty(cities: citiesList, subcategories: subCategoriesList),
//         );
//       } else {
//         emit(
//           CompaniesLoaded(
//             companies: updatedCompanies,
//             pagination: pagination,
//             cities: citiesList,
//             subcategories: subCategoriesList,
//             currentSearch: search,
//             currentType: type,
//             currentCityId: cityId,
//             currentSubCategoryIds: subCategoryIds,
//           ),
//         );
//       }
//     });
//   }

//   Future<void> loadMore() async {
//     final currentState = state;
//     if (currentState is! CompaniesLoaded) return;
//     if (!currentState.pagination.hasNextPage) return;

//     emit(CompaniesLoadingMore(currentState.companies));

//     final params = FilterCompaniesParams(
//       search: currentState.currentSearch,
//       type: currentState.currentType,
//       cityId: currentState.currentCityId,
//       subCategoryIds: currentState.currentSubCategoryIds,
//       page: currentState.pagination.currentPage + 1,
//     );

//     final result = await filterCompaniesUseCase(params);

//     result.fold((failure) => emit(CompaniesError(failure.message)), (data) {
//       final newCompanies = data.$1;
//       final pagination = data.$2;

//       final updatedNewCompanies = newCompanies.map((company) {
//         return company.copyWith(fav: favIds.contains(company.id));
//       }).toList();

//       final allCompanies = [...currentState.companies, ...updatedNewCompanies];

//       emit(
//         currentState.copyWith(companies: allCompanies, pagination: pagination),
//       );
//     });
//   }

//   Future<void> applyFilters({
//     String? search,
//     String? type,
//     int? cityId,
//     List<int>? subCategoryIds,
//   }) async {
//     await loadCompanies(
//       search: search,
//       type: type,
//       cityId: cityId,
//       subCategoryIds: subCategoryIds,
//       page: 1,
//     );
//   }

//   Future<void> search(String query) async {
//     final currentState = state;
//     if (currentState is CompaniesLoaded) {
//       await loadCompanies(
//         search: query.isEmpty ? null : query,
//         type: currentState.currentType,
//         cityId: currentState.currentCityId,
//         subCategoryIds: currentState.currentSubCategoryIds,
//         page: 1,
//       );
//     } else {
//       await loadCompanies(search: query.isEmpty ? null : query);
//     }
//   }

//   void toggleFavorite(int companyId) {
//     if (favIds.contains(companyId)) {
//       favIds.remove(companyId);
//     } else {
//       favIds.add(companyId);
//     }

//     final currentState = state;
//     if (currentState is CompaniesLoaded) {
//       final updatedCompanies = currentState.companies.map((company) {
//         if (company.id == companyId) {
//           return company.copyWith(fav: !company.fav);
//         }
//         return company;
//       }).toList();

//       emit(currentState.copyWith(companies: updatedCompanies));
//     }
//   }

//   Future<void> clearFilters() async {
//     await loadCompanies(page: 1);
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
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
  }) : super(CompaniesInitial());

  final GetCitiesUseCase getCitiesUseCase;
  final FilterCompaniesUseCase filterCompaniesUseCase;
  final GetSubcategoriesUseCase getSubcategoriesUseCase;

  List<City> citiesList = [];
  List<Subcategory> subCategoriesList = [];
  final Set<int> favIds = {};

  String? _currentSearch;
  String? _currentType;
  int? _currentCityId;
  List<int>? _currentSubCategoryIds;

  Future<void> loadFiltersData() async {
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

      final updatedCompanies = companies.map((company) {
        return company.copyWith(fav: favIds.contains(company.id));
      }).toList();

      if (updatedCompanies.isEmpty) {
        emit(
          CompaniesEmpty(cities: citiesList, subcategories: subCategoriesList),
        );
      } else {
        emit(
          CompaniesLoaded(
            companies: updatedCompanies,
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

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! CompaniesLoaded) return;
    if (!currentState.pagination.hasNextPage) return;

    emit(CompaniesLoadingMore(currentState.companies));

    final params = FilterCompaniesParams(
      search: currentState.currentSearch,
      type: currentState.currentType,
      cityId: currentState.currentCityId,
      subCategoryIds: currentState.currentSubCategoryIds,
      page: currentState.pagination.currentPage + 1,
    );

    final result = await filterCompaniesUseCase(params);

    result.fold(
      (failure) {
        // Return to loaded state with current companies on error
        emit(currentState);
      },
      (data) {
        final newCompanies = data.$1;
        final pagination = data.$2;

        final updatedNewCompanies = newCompanies.map((company) {
          return company.copyWith(fav: favIds.contains(company.id));
        }).toList();

        final allCompanies = [
          ...currentState.companies,
          ...updatedNewCompanies,
        ];

        emit(
          currentState.copyWith(
            companies: allCompanies,
            pagination: pagination,
          ),
        );
      },
    );
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

  void toggleFavorite(int companyId) {
    if (favIds.contains(companyId)) {
      favIds.remove(companyId);
    } else {
      favIds.add(companyId);
    }

    final currentState = state;
    if (currentState is CompaniesLoaded) {
      final updatedCompanies = currentState.companies.map((company) {
        if (company.id == companyId) {
          return company.copyWith(fav: !company.fav);
        }
        return company;
      }).toList();

      emit(currentState.copyWith(companies: updatedCompanies));
    }
  }

  Future<void> clearFilters() async {
    _currentSearch = null;
    _currentType = null;
    _currentCityId = null;
    _currentSubCategoryIds = null;
    await loadCompanies(page: 1);
  }
}
