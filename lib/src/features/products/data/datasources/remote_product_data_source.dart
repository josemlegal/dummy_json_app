import 'package:dummy_json_app/core/network_client/netwok_client.dart';
import 'package:dummy_json_app/src/features/products/data/models/product_list_model.dart';
import 'package:dummy_json_app/src/features/products/domain/datasources/product_data_source.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:fpdart/fpdart.dart';

class RemoteProductDatasource extends ProductDataSource {
  RemoteProductDatasource({
    required NetworkClient client,
  }) : _client = client;

  final NetworkClient _client;

  @override
  Future<Result<List<ProductEntity>?>> getAllProducts() async {
    final response = await _client.get(
      '/products',
      fromJsonFunction: ProductListModel.fromJson,
      queryParameters: {
        'skip': 0,
        'limit': 0,
      },
    );

    return response.flatMap(
      (data) => right(data.products.map((e) => e.toEntity()).toList()),
    );
  }

  @override
  Future<Result<ProductEntity>> getProduct(String productId) async {
    final response = await _client.get(
      '/products/$productId',
      fromJsonFunction: ProductListModel.fromJson,
    );

    return response.flatMap(
      (data) => right(data.products.first.toEntity()),
    );
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    final response = await _client.get(
      '/products/search?q=$query',
      fromJsonFunction: ProductListModel.fromJson,
    );

    return response.fold(
      (error) {
        throw error; // Puedes lanzar la excepción o manejarla de otra manera
      },
      (productListModel) {
        // Convertimos el ProductListModel en List<ProductEntity> y lo retornamos
        return productListModel.products
            .map((product) => product.toEntity())
            .toList();
      },
    );
  }
}
