import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:klontong_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:klontong_app/features/product/data/repositories/product_repository_implementation.dart';
import 'package:klontong_app/features/product/domain/repositories/product_repository.dart';
import 'package:klontong_app/features/product/domain/usecases/get_all_product.dart';
import 'package:klontong_app/features/product/domain/usecases/get_product.dart';
import 'package:klontong_app/features/product/presentation/bloc/product_bloc.dart';

var injection = GetIt.instance;

// Inject all dependencies
Future<void> init() async {
  /// GENERAL DEPENDENCIES

  // dio
  injection.registerLazySingleton(
    () => Dio(),
  );

  /// FEATURE - PRODUCT
  // BLOC
  injection.registerFactory(
    () => ProductBloc(
      getAllProduct: injection(),
      getProduct: injection(),
      addProduct: injection(),
      updateProduct: injection(),
      deleteProduct: injection(),
    ),
  );

  // USECASE
  injection.registerLazySingleton(
    () => GetAllProduct(
      injection(),
    ),
  );
  injection.registerLazySingleton(
    () => GetProduct(
      injection(),
    ),
  );

  // REPOSITORY
  injection.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImplementation(
      productRemoteDataSource: injection(),
    ),
  );

  // DATASOURCE
  injection.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDataSourceImplements(
      dio: injection(),
    ),
  );
}
