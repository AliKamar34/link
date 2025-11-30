part of 'companies_cubit.dart';

sealed class CompaniesState extends Equatable {
  const CompaniesState();

  @override
  List<Object?> get props => [];
}

final class CompaniesInitial extends CompaniesState {}

class CompaniesLoading extends CompaniesState {}

class CompaniesPageLoading extends CompaniesState {
  final CompaniesLoaded previousState;

  const CompaniesPageLoading(this.previousState);

  @override
  List<Object?> get props => [previousState];
}

class CompaniesLoaded extends CompaniesState {
  final List<Company> companies;
  final Pagination pagination;
  final List<City> cities;
  final List<Subcategory> subcategories;

  final String? currentSearch;
  final String? currentType;
  final int? currentCityId;
  final List<int>? currentSubCategoryIds;

  const CompaniesLoaded({
    required this.companies,
    required this.pagination,
    required this.cities,
    required this.subcategories,
    this.currentSearch,
    this.currentType,
    this.currentCityId,
    this.currentSubCategoryIds,
  });

  CompaniesLoaded copyWith({
    List<Company>? companies,
    Pagination? pagination,
    List<City>? cities,
    List<Subcategory>? subcategories,
    String? currentSearch,
    String? currentType,
    int? currentCityId,
    List<int>? currentSubCategoryIds,
  }) {
    return CompaniesLoaded(
      companies: companies ?? this.companies,
      pagination: pagination ?? this.pagination,
      cities: cities ?? this.cities,
      subcategories: subcategories ?? this.subcategories,
      currentSearch: currentSearch ?? this.currentSearch,
      currentType: currentType ?? this.currentType,
      currentCityId: currentCityId ?? this.currentCityId,
      currentSubCategoryIds:
          currentSubCategoryIds ?? this.currentSubCategoryIds,
    );
  }

  @override
  List<Object?> get props => [
    companies,
    pagination,
    cities,
    subcategories,
    currentSearch,
    currentType,
    currentCityId,
    currentSubCategoryIds,
  ];
}

class CompaniesError extends CompaniesState {
  final String message;

  const CompaniesError(this.message);

  @override
  List<Object?> get props => [message];
}

class CompaniesEmpty extends CompaniesState {
  final List<City> cities;
  final List<Subcategory> subcategories;

  const CompaniesEmpty({required this.cities, required this.subcategories});

  @override
  List<Object?> get props => [cities, subcategories];
}
