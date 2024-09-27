import 'package:cached_network_image/cached_network_image.dart';
import 'package:dummy_json_app/core/extensions/localizations_extension.dart';
import 'package:dummy_json_app/core/theme/app_theme.dart';
import 'package:dummy_json_app/src/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  final ProductEntity? product;

  static const name = 'product_details_screen';
  static const route = '/product_details_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    if (product == null) {
      return Scaffold(
        body: Center(
          child: Text(
            l10n.productNotFound,
            style: Styles.detailValueTextStyle,
          ),
        ),
      );
    }

    final productData = product!;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: ProductImage(imageUrl: productData.images.first),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ProductInfoCard(product: productData),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AddToFavoritesButton(product: productData),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.contain,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        size: 60,
        color: Colors.red,
      ),
    );
  }
}

class ProductInfoCard extends StatelessWidget {
  const ProductInfoCard({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.title,
              style: Styles.titleTextStyle,
            ),
            const SizedBox(height: 10),
            Text(
              product.description,
              style: Styles.bodyTextStyle,
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey[400]),
            ProductDetailRow(
              label: l10n.price,
              value: '\$${product.price}',
            ),
            ProductDetailRow(
              label: l10n.rating,
              value: '${product.rating}',
            ),
            ProductDetailRow(
              label: l10n.stock,
              value: '${product.stock}',
            ),
            ProductDetailRow(
              label: l10n.brand,
              value: product.brand,
            ),
            ProductDetailRow(
              label: l10n.discount,
              value: '${product.discountPercentage}%',
            ),
            ProductDetailRow(
              label: l10n.category,
              value: product.category,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailRow extends StatelessWidget {
  const ProductDetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: Styles.detailLabelTextStyle,
          ),
          Text(
            value,
            style: Styles.detailValueTextStyle,
          ),
        ],
      ),
    );
  }
}

class AddToFavoritesButton extends ConsumerWidget {
  const AddToFavoritesButton({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: () {
        final isFavorite =
            ref.read(favoritesNotifierProvider.notifier).isFavorite(product);

        if (isFavorite) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  'El producto ${product.title} ya está en la lista de favoritos.',
                ),
                duration: const Duration(
                  seconds: 2,
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
        } else {
          ref.read(favoritesNotifierProvider.notifier).addFavorite(product);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  'El producto ${product.title} ha sido añadido a la lista de favoritos.',
                ),
                duration: const Duration(
                  seconds: 2,
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
        }
      },
      label: const Text('Add to favorites'),
      icon: const Icon(Icons.favorite),
    );
  }
}
