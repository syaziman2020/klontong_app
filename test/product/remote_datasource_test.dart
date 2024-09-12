import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong_app/core/constants/main_url.dart';
import 'package:klontong_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:klontong_app/features/product/data/models/product_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProductRemoteDatasource>(), MockSpec<Dio>()])
void main() {
  final remoteDataSource = MockProductRemoteDatasource();
  MockDio mockDio = MockDio();
  final remoteDataSourceImplementation =
      ProductRemoteDataSourceImplements(dio: mockDio);

  Map<String, dynamic> fakeDataJson = {
    "_id": "66e19adbfe837603e816ba05",
    "id": 1,
    "categoryName": "Cemilan",
    "sku": "MHZVTK",
    "name": "Ciki ciki",
    "description": "Ciki ciki yang super enak, hanya di toko klontong kami",
    "weight": 500,
    "width": 5,
    "length": 5,
    "height": 5,
    "image": "https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b",
    "harga": 30000
  };

  String urlListProduct = '${MainUrl.url}/products';
  String idPrimary = "66e19adbfe837603e816ba05";

  ProductModel fakeProductModel = ProductModel.fromJson(fakeDataJson);

  group("Product Remote Datasource", () {
    group("Abstract", () {
      group("addProduct", () {
        test("Success", () async {
          when(remoteDataSource.addProduct(fakeProductModel))
              .thenAnswer((_) async => true);

          try {
            final response =
                await remoteDataSource.addProduct(fakeProductModel);

            expect(response, true);
          } catch (e) {
            fail("An error occurred: $e");
          }
        });
        test("Failed", () async {
          when(remoteDataSource.addProduct(fakeProductModel))
              .thenThrow(Exception());

          try {
            await remoteDataSource.addProduct(fakeProductModel);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
      });
      group("updateProduct", () {
        test("Success", () async {
          when(remoteDataSource.updateProduct(fakeProductModel))
              .thenAnswer((_) async => true);

          try {
            final response =
                await remoteDataSource.updateProduct(fakeProductModel);

            expect(response, true);
          } catch (e) {
            fail("An error occurred: $e");
          }
        });
        test("Failed", () async {
          when(remoteDataSource.updateProduct(fakeProductModel))
              .thenThrow(Exception());

          try {
            await remoteDataSource.updateProduct(fakeProductModel);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
      });
      group("deleteProduct", () {
        test("Success", () async {
          when(remoteDataSource.deleteProduct(idPrimary))
              .thenAnswer((_) async => true);

          try {
            final response = await remoteDataSource.deleteProduct(idPrimary);

            expect(response, true);
          } catch (e) {
            fail("An error occurred: $e");
          }
        });
        test("Failed", () async {
          when(remoteDataSource.deleteProduct(idPrimary))
              .thenThrow(Exception());
        });
      });
      group("getAllProducts", () {
        test("Success", () async {
          when(remoteDataSource.getAllProducts())
              .thenAnswer((_) async => [fakeProductModel]);

          try {
            final response = await remoteDataSource.getAllProducts();

            expect(response, [fakeProductModel]);
          } catch (e) {
            fail("An error occurred: $e");
          }
        });
        test("Failed", () async {
          when(remoteDataSource.getAllProducts()).thenThrow(Exception());

          try {
            await remoteDataSource.getAllProducts();

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
      });
      group("getProduct", () {
        test("Success", () async {
          when(remoteDataSource.getProduct(idPrimary))
              .thenAnswer((_) async => fakeProductModel);

          try {
            final response = await remoteDataSource.getProduct(idPrimary);

            expect(response, fakeProductModel);
          } catch (e) {
            fail("An error occurred: $e");
          }
        });
        test("Failed", () async {
          when(remoteDataSource.getProduct(idPrimary)).thenThrow(Exception());

          try {
            await remoteDataSource.getProduct(idPrimary);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
      });
    });
    group("Implementation", () {
      group("getAllProducts", () {
        test("Success", () async {
          when(mockDio.get(urlListProduct)).thenAnswer(
            (_) async => Response(
                data: [fakeDataJson],
                statusCode: 200,
                requestOptions: RequestOptions(path: urlListProduct)),
          );
          try {
            final response =
                await remoteDataSourceImplementation.getAllProducts();

            expect(response, [fakeProductModel]);
          } catch (e) {
            fail("An error occurred: $e");
          }
        });
        test("Failed - 400", () async {
          when(mockDio.get(urlListProduct)).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 400,
              requestOptions: RequestOptions(path: urlListProduct),
            ),
          );

          try {
            await remoteDataSourceImplementation.getAllProducts();

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 404", () async {
          when(mockDio.get(urlListProduct)).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 404,
              requestOptions: RequestOptions(path: urlListProduct),
            ),
          );
          try {
            await remoteDataSourceImplementation.getAllProducts();

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 500", () async {
          when(mockDio.get(urlListProduct)).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 500,
              requestOptions: RequestOptions(path: urlListProduct),
            ),
          );
          try {
            await remoteDataSourceImplementation.getAllProducts();

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 418", () async {
          when(mockDio.get(urlListProduct)).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 418,
              requestOptions: RequestOptions(path: urlListProduct),
            ),
          );
          try {
            await remoteDataSourceImplementation.getAllProducts();

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
      });
      group("getProduct", () {
        test("Success", () async {
          when(mockDio.get('$urlListProduct/$idPrimary')).thenAnswer(
            (_) async => Response(
                data: fakeDataJson,
                statusCode: 200,
                requestOptions:
                    RequestOptions(path: '$urlListProduct/$idPrimary')),
          );
          try {
            final response =
                await remoteDataSourceImplementation.getProduct(idPrimary);

            expect(response, fakeProductModel);
          } catch (e) {
            fail("An error occurred: $e");
          }
        });
        test("Failed - 400", () async {
          when(mockDio.get('$urlListProduct/$idPrimary')).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 400,
              requestOptions:
                  RequestOptions(path: '$urlListProduct/$idPrimary'),
            ),
          );

          try {
            await remoteDataSourceImplementation.getProduct(idPrimary);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 404", () async {
          when(mockDio.get('$urlListProduct/$idPrimary')).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 404,
              requestOptions:
                  RequestOptions(path: '$urlListProduct/$idPrimary'),
            ),
          );

          try {
            await remoteDataSourceImplementation.getProduct(idPrimary);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 500", () async {
          when(mockDio.get('$urlListProduct/$idPrimary')).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 500,
              requestOptions:
                  RequestOptions(path: '$urlListProduct/$idPrimary'),
            ),
          );

          try {
            await remoteDataSourceImplementation.getProduct(idPrimary);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 418", () async {
          when(mockDio.get('$urlListProduct/$idPrimary')).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 418,
              requestOptions:
                  RequestOptions(path: '$urlListProduct/$idPrimary'),
            ),
          );

          try {
            await remoteDataSourceImplementation.getProduct(idPrimary);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
      });
      group("addProduct", () {
        test("Success", () async {
          when(
            mockDio.post(
              urlListProduct,
              data: anyNamed('data'),
            ),
          ).thenAnswer(
            (_) async => Response(
              data: fakeDataJson,
              statusCode: 201,
              requestOptions: RequestOptions(path: ''),
            ),
          );
          try {
            final response = await remoteDataSourceImplementation
                .addProduct(fakeProductModel);

            expect(response, true);
          } catch (e) {
            fail("An error occurred: $e");
          }
        });
        test("Failed - 400", () async {
          when(mockDio.post(urlListProduct, data: fakeProductModel.toJson()))
              .thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 400,
              requestOptions: RequestOptions(path: ''),
            ),
          );

          try {
            await remoteDataSourceImplementation.addProduct(fakeProductModel);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 404", () async {
          when(mockDio.post(urlListProduct, data: fakeProductModel.toJson()))
              .thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 404,
              requestOptions: RequestOptions(path: ''),
            ),
          );

          try {
            await remoteDataSourceImplementation.addProduct(fakeProductModel);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 500", () async {
          when(mockDio.post(urlListProduct, data: fakeProductModel.toJson()))
              .thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 500,
              requestOptions: RequestOptions(path: ''),
            ),
          );

          try {
            await remoteDataSourceImplementation.addProduct(fakeProductModel);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 418", () async {
          when(mockDio.post(urlListProduct, data: fakeProductModel.toJson()))
              .thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 418,
              requestOptions: RequestOptions(path: ''),
            ),
          );

          try {
            await remoteDataSourceImplementation.addProduct(fakeProductModel);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
      });
      group("deleteProduct", () {
        test("Success", () async {
          when(
            mockDio.delete(
              '$urlListProduct/$idPrimary',
              data: anyNamed('data'),
            ),
          ).thenAnswer(
            (_) async => Response(
              data: null,
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
            ),
          );
          try {
            final response =
                await remoteDataSourceImplementation.deleteProduct(idPrimary);

            expect(response, true);
          } catch (e) {
            fail("An error occurred: $e");
          }
        });
        test("Failed - 400", () async {
          when(mockDio.delete('$urlListProduct/$idPrimary')).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 400,
              requestOptions: RequestOptions(path: ''),
            ),
          );

          try {
            await remoteDataSourceImplementation.deleteProduct(idPrimary);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 404", () async {
          when(mockDio.delete('$urlListProduct/$idPrimary')).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 404,
              requestOptions: RequestOptions(path: ''),
            ),
          );
          try {
            await remoteDataSourceImplementation.deleteProduct(idPrimary);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 500", () async {
          when(mockDio.delete('$urlListProduct/$idPrimary')).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 500,
              requestOptions: RequestOptions(path: ''),
            ),
          );
          try {
            await remoteDataSourceImplementation.deleteProduct(idPrimary);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 418", () async {
          when(mockDio.delete('$urlListProduct/$idPrimary')).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 418,
              requestOptions: RequestOptions(path: ''),
            ),
          );
          try {
            await remoteDataSourceImplementation.deleteProduct(idPrimary);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
      });
      group("updateProduct", () {
        test("Success", () async {
          when(
            mockDio.put(
              '$urlListProduct/$idPrimary',
              data: anyNamed('data'),
            ),
          ).thenAnswer(
            (_) async => Response(
              data: null,
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
            ),
          );
          try {
            final response = await remoteDataSourceImplementation
                .updateProduct(fakeProductModel);

            expect(response, true);
          } catch (e) {
            fail("An error occurred: $e");
          }
        });
        test("Failed - 400", () async {
          when(mockDio.put('$urlListProduct/$idPrimary')).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 400,
              requestOptions: RequestOptions(path: ''),
            ),
          );

          try {
            await remoteDataSourceImplementation
                .updateProduct(fakeProductModel);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 404", () async {
          when(mockDio.put('$urlListProduct/$idPrimary')).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 404,
              requestOptions: RequestOptions(path: ''),
            ),
          );
          try {
            await remoteDataSourceImplementation
                .updateProduct(fakeProductModel);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 500", () async {
          when(mockDio.put('$urlListProduct/$idPrimary')).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 500,
              requestOptions: RequestOptions(path: ''),
            ),
          );
          try {
            await remoteDataSourceImplementation
                .updateProduct(fakeProductModel);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
        test("Failed - 418", () async {
          when(mockDio.put('$urlListProduct/$idPrimary')).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 418,
              requestOptions: RequestOptions(path: ''),
            ),
          );
          try {
            await remoteDataSourceImplementation
                .updateProduct(fakeProductModel);

            fail("An error occurred, it cannot happen");
          } catch (e) {
            expect(e, isException);
          }
        });
      });
    });
  });
}
