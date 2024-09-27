import 'package:cached_network_image/cached_network_image.dart';
import 'package:dummy_json_app/core/extensions/localizations_extension.dart';
import 'package:dummy_json_app/src/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:dummy_json_app/src/features/products/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  static const name = 'favorites_screen';
  static const route = 'favorites_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesNotifier = ref.watch(favoritesNotifierProvider);

    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.favorites),
      ),
      body: favoritesNotifier.isEmpty
          ? Center(
              child: Text(l10n.nothingOnFavorites),
            )
          : FavoritesList(favoritesNotifier: favoritesNotifier),
    );
  }
}

class FavoritesList extends StatelessWidget {
  const FavoritesList({
    super.key,
    required this.favoritesNotifier,
  });

  final List<ProductEntity> favoritesNotifier;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoritesNotifier.length,
      itemBuilder: (context, index) {
        final product = favoritesNotifier[index];
        return FavoriteProductTile(product: product);
      },
    );
  }
}

class FavoriteProductTile extends ConsumerWidget {
  const FavoriteProductTile({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).pushNamed(
        ProductDetailsScreen.name,
        extra: <String, dynamic>{
          'product': product,
        },
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        visualDensity: VisualDensity.comfortable,
        leading: ProductImage(imageUrl: product.images.first),
        title: ProductTitle(title: product.title),
        subtitle: ProductPrice(price: product.price.toString()),
        trailing: FavoriteButton(productId: product.id),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
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

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.price,
  });

  final String price;

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$$price',
      style: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(
        Icons.favorite,
        color: Colors.red,
      ),
      onPressed: () {
        ref.read(favoritesNotifierProvider.notifier).removeFavorite(productId);

        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: const Text(
                'El producto ha sido eliminado de la lista de favoritos.',
              ),
              duration: const Duration(
                seconds: 1,
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
      },
    );
  }
}
