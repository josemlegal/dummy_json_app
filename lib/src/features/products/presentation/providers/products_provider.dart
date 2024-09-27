import 'package:dummy_json_app/core/network_client/netwok_client.dart';
import 'package:dummy_json_app/src/features/products/data/providers.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_provider.g.dart';

@riverpod
Future<Result<List<ProductEntity>?>> getAllProducts(
    GetAllProductsRef ref) async {
  final repository = ref.read(productRepositoryProvider);

  return repository.getAllProducts();
}
