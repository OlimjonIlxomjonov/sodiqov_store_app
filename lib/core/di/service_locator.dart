import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_template/features/cart/data/repo/cart_repo_impl.dart';
import 'package:my_template/features/cart/data/source/impl_remote_data_source/cart_remote_data_source_impl.dart';
import 'package:my_template/features/cart/data/source/remote_data_source/cart_remote_data_source.dart';
import 'package:my_template/features/cart/domain/repository/cart_repository.dart';
import 'package:my_template/features/cart/domain/usecase/order/order_use_case.dart';
import 'package:my_template/features/cart/presentation/bloc/order/order_bloc.dart';
import 'package:my_template/features/home/data/repo/home_repo_impl.dart';
import 'package:my_template/features/home/data/source/impl_remote_data_source/home_remote_data_source_impl.dart';
import 'package:my_template/features/home/data/source/remote_data_source/home_remote_data_source.dart';
import 'package:my_template/features/home/domain/repository/home_repository.dart';
import 'package:my_template/features/home/domain/usecase/category/category_use_case.dart';
import 'package:my_template/features/home/domain/usecase/products/products_use_case.dart';
import 'package:my_template/features/home/domain/usecase/products_by_slug/products_by_slug_use_case.dart';
import 'package:my_template/features/home/presentation/bloc/category/category_bloc.dart';
import 'package:my_template/features/home/presentation/bloc/products/products_bloc.dart';
import 'package:my_template/features/home/presentation/bloc/products_by_slug/products_by_slug_bloc.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  sl.registerLazySingleton(() => Dio());

  /// REMOTE DATA SOURCE
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(),
  );

  /// REPOSITORY
  sl.registerLazySingleton<HomeRepository>(() => HomeRepoImpl(sl()));
  sl.registerLazySingleton<CartRepository>(() => CartRepoImpl(sl()));

  /// USE CASE
  sl.registerLazySingleton(() => CategoryUseCase(sl()));
  sl.registerLazySingleton(() => ProductsUseCase(sl()));
  sl.registerLazySingleton(() => ProductsBySlugUseCase(sl()));
  sl.registerLazySingleton(() => OrderUseCase(sl()));

  /// BLOC
  sl.registerLazySingleton(() => CategoryBloc(sl()));
  sl.registerLazySingleton(() => ProductsBloc(sl()));
  sl.registerLazySingleton(() => ProductsBySlugBloc(sl()));
  sl.registerLazySingleton(() => OrderBloc(sl()));
}
