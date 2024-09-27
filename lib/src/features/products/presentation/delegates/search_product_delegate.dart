import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:dummy_json_app/src/features/products/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

typedef SearchProductCallback = Future<List<ProductEntity>> Function(
    String query);

class SearchProductDelegate extends SearchDelegate<ProductEntity?> {
  final SearchProductCallback searchProducts;
  List<ProductEntity> initialProducts;
  StreamController<List<ProductEntity>> debounceProducts =
      StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchProductDelegate({
    required this.initialProducts,
    required this.searchProducts,
  });

  void clearStreams() {
    debounceProducts.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () async {
        if (query.isEmpty) {
          debounceProducts.add([]);
          return;
        }
        final products = await searchProducts(query);
        initialProducts = products;
        debounceProducts.add(products);
        isLoadingStream.add(false);
      },
    );
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialProducts,
      stream: debounceProducts.stream,
      builder: (context, snapshot) {
        final product = snapshot.data ?? [];

        if (product.isEmpty) {
          return const Center(
            child: Text('No products found'),
          );
        }

        return ListView.builder(
          itemCount: product.length,
          itemBuilder: (context, index) => _ProductItem(
            product: product[index],
            onMovieSelected: (context, movie) {
              clearStreams();
              close(context, movie);

              GoRouter.of(context).pushNamed(
                ProductDetailsScreen.name,
                extra: <String, dynamic>{
                  'product': product[index],
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Search products...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(
                  Icons.refresh_rounded,
                ),
              ),
            );
          }
          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: Icon(
                Icons.clear,
                color: colors.primary,
              ),
            ),
          );
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return buildResultsAndSuggestions();
  }
}

class _ProductItem extends StatelessWidget {
  final Function onMovieSelected;
  final ProductEntity product;

  const _ProductItem({required this.product, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onMovieSelected(context, product),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Imagen del producto con borde redondeado y sombra
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: product.images.first,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 16),
              // Información del producto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.price.toString(),
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
