import 'package:dummy_json_app/core/network_client/netwok_client.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';

abstract class ProductDataSource {
  Future<Result<List<ProductEntity>?>> getAllProducts();
  Future<Result<ProductEntity?>> getProduct(String productId);
  Future<List<ProductEntity>> searchProducts(String query);
}
