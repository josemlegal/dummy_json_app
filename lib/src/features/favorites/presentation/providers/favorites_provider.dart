import 'package:dummy_json_app/src/features/favorites/data/providers.dart';
import 'package:dummy_json_app/src/features/favorites/domain/repository/favorites_repository.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<List<ProductEntity>> {
  final FavoritesRepository repository;

  FavoritesNotifier(this.repository) : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await repository.getFavoritesProducts();
    if (favorites != null) {
      state = favorites;
    }
  }

  Future<void> addFavorite(ProductEntity product) async {
    final currentFavorites = await repository.getFavoritesProducts();

    final productExists = currentFavorites?.any((existingProduct) {
          return existingProduct.id == product.id;
        }) ??
        false;

    if (!productExists) {
      await repository.addFavoriteProduct(product);
      state = [...state, product];
    }
  }

  Future<void> removeFavorite(int productId) async {
    await repository.removeFavoriteProduct(productId);
    state = state.where((product) => product.id != productId).toList();
  }

  bool isFavorite(ProductEntity product) {
    return state.any((favoriteProduct) => favoriteProduct.id == product.id);
  }
}

final favoritesNotifierProvider =
    AutoDisposeStateNotifierProvider<FavoritesNotifier, List<ProductEntity>>(
        (ref) {
  final repository = ref.watch(favoritesRepositoryProvider);
  return FavoritesNotifier(repository);
});
