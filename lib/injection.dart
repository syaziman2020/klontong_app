import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'features/product/domain/usecases/add_product.dart';
import 'features/product/domain/usecases/delete_product.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/data/datasources/product_remote_datasource.dart';
import 'features/product/data/repositories/product_repository_implementation.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/get_all_product.dart';
import 'features/product/domain/usecases/get_product.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

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
  injection.registerLazySingleton(
    () => AddProduct(
      injection(),
    ),
  );
  injection.registerLazySingleton(
    () => UpdateProduct(
      injection(),
    ),
  );
  injection.registerLazySingleton(
    () => DeleteProduct(
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
