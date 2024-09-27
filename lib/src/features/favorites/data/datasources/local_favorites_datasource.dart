import 'dart:convert';

import 'package:dummy_json_app/src/features/favorites/domain/datasources/favorites_datasources.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalFavoriteDatasource extends FavoritesDataSource {
  LocalFavoriteDatasource({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Future<void> addFavoriteProduct(ProductEntity product) async {
    final productToJson = product.toJson();
    final productString = jsonEncode(productToJson);
    final favoritesProducts =
        sharedPreferences.getStringList('favorites') ?? [];

    favoritesProducts.add(productString);
    await sharedPreferences.setStringList('favorites', favoritesProducts);
  }

  @override
  Future<List<ProductEntity>?> getFavoritesProducts() async {
    final favoritesProducts =
        sharedPreferences.getStringList('favorites') ?? [];
    final products = favoritesProducts
        .map((product) => ProductEntity.fromJson(jsonDecode(product)))
        .toList();
    return products;
  }

  @override
  Future<void> removeFavoriteProduct(int index) async {
    final favoritesProducts =
        sharedPreferences.getStringList('favorites') ?? [];

    favoritesProducts.removeWhere((productString) {
      final decodedProduct = jsonDecode(productString);
      return decodedProduct['id'].toString() == index.toString();
    });

    await sharedPreferences.setStringList('favorites', favoritesProducts);
  }
}
