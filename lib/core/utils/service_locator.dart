import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:link_task/core/networking/dio_helper.dart';
import 'package:link_task/core/networking/network_info.dart';
import 'package:link_task/features/companies/data/datasource/remote_data_source.dart';
import 'package:link_task/features/companies/data/repo/companies_repo_impl.dart';
import 'package:link_task/features/companies/domain/repo/companies_repo.dart';
import 'package:link_task/features/companies/domain/usecases/filter_companies_use_case.dart';
import 'package:link_task/features/companies/domain/usecases/get_cities_use_case.dart';
import 'package:link_task/features/companies/domain/usecases/get_subcategories_use_case.dart';
import 'package:link_task/features/companies/presentation/manager/cubit/companies_cubit.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  // External
  sl.registerLazySingleton(() => Connectivity());

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // DioHelper
  sl.registerLazySingleton(() => DioHelper());

  // Data Sources
  sl.registerLazySingleton<CompaniesRemoteDataSource>(
    () => CompaniesRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<CompaniesRepo>(() => CompaniesRepoImpl(sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetCitiesUseCase(sl()));
  sl.registerLazySingleton(() => GetSubcategoriesUseCase(sl()));
  sl.registerLazySingleton(() => FilterCompaniesUseCase(sl()));

  // Cubit
  sl.registerFactory(
    () => CompaniesCubit(
      getCitiesUseCase: sl(),
      filterCompaniesUseCase: sl(),
      getSubcategoriesUseCase: sl(),
      networkInfo: sl(),
    ),
  );
}
