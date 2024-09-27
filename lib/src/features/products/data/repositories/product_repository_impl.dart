import 'package:dummy_json_app/core/network_client/netwok_client.dart';
import 'package:dummy_json_app/src/features/products/domain/datasources/product_data_source.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:dummy_json_app/src/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl({
    required this.datasource,
  });

  final ProductDataSource datasource;

  @override
  Future<Result<ProductEntity?>> getProduct(String productId) {
    return datasource.getProduct(productId);
  }

  @override
  Future<Result<List<ProductEntity>?>> getAllProducts() {
    return datasource.getAllProducts();
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) {
    return datasource.searchProducts(query);
  }
}
