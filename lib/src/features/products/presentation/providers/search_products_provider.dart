import 'package:dummy_json_app/src/features/products/data/providers.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedProductsProvider =
    StateNotifierProvider<SearchedProductsNotifier, List<ProductEntity>>((ref) {
  final productRepository = ref.read(productRepositoryProvider);
  return SearchedProductsNotifier(
    ref: ref,
    searchProducts: productRepository.searchProducts,
  );
});

typedef SearchProductsCallback = Future<List<ProductEntity>> Function(
    String query);

class SearchedProductsNotifier extends StateNotifier<List<ProductEntity>> {
  final SearchProductsCallback searchProducts;
  final Ref ref;

  SearchedProductsNotifier({
    required this.ref,
    required this.searchProducts,
  }) : super([]);

  Future<List<ProductEntity>> searchProductByQuery(String query) async {
    final List<ProductEntity> products = await searchProducts(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = products;
    return products;
  }
}
