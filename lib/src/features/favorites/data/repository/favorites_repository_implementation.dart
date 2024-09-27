import 'package:dummy_json_app/src/features/favorites/domain/datasources/favorites_datasources.dart';
import 'package:dummy_json_app/src/features/favorites/domain/repository/favorites_repository.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  const FavoritesRepositoryImpl({
    required this.datasource,
  });

  final FavoritesDataSource datasource;

  @override
  Future<void> addFavoriteProduct(ProductEntity product) async {
    datasource.addFavoriteProduct(product);
  }

  @override
  Future<List<ProductEntity>?> getFavoritesProducts() async {
    return datasource.getFavoritesProducts();
  }

  @override
  Future<void> removeFavoriteProduct(int index) async {
    datasource.removeFavoriteProduct(index);
  }
}
