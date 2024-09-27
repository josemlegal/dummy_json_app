import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';

abstract class FavoritesRepository {
  Future<void> addFavoriteProduct(ProductEntity product);
  Future<void> removeFavoriteProduct(int index);
  Future<List<ProductEntity>?> getFavoritesProducts();
}
