import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_template/features/home/data/repo/home_repo_impl.dart';
import 'package:my_template/features/home/data/source/impl_remote_data_source/home_remote_data_source_impl.dart';
import 'package:my_template/features/home/data/source/remote_data_source/home_remote_data_source.dart';
import 'package:my_template/features/home/domain/repository/home_repository.dart';
import 'package:my_template/features/home/domain/usecase/category/category_use_case.dart';
import 'package:my_template/features/home/domain/usecase/products/products_use_case.dart';
import 'package:my_template/features/home/presentation/bloc/category/category_bloc.dart';
import 'package:my_template/features/home/presentation/bloc/products/products_bloc.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  sl.registerLazySingleton(() => Dio());

  /// REMOTE DATA SOURCE
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );

  /// REPOSITORY
  sl.registerLazySingleton<HomeRepository>(() => HomeRepoImpl(sl()));

  /// USE CASE
  sl.registerLazySingleton(() => CategoryUseCase(sl()));
  sl.registerLazySingleton(() => ProductsUseCase(sl()));

  /// BLOC
  sl.registerLazySingleton(() => CategoryBloc(sl()));
  sl.registerLazySingleton(() => ProductsBloc(sl()));
}
