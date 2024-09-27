import 'package:cached_network_image/cached_network_image.dart';
import 'package:dummy_json_app/core/extensions/fp_async_value.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:dummy_json_app/src/features/products/presentation/providers/products_provider.dart';
import 'package:dummy_json_app/src/features/products/presentation/screens/product_details_screen.dart';
import 'package:dummy_json_app/src/features/home/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsListScreen extends ConsumerWidget {
  const ProductsListScreen({super.key});

  static const name = 'products_list_screen';
  static const route = 'products_list_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(
      getAllProductsProvider,
    );

    return products.mapEither(
      data: (data) {
        return CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: EdgeInsets.zero,
                title: CustomAppBar(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = data.value![index];
                    return ProductCard(product: product);
                  },
                  childCount: data.value!.length,
                ),
              ),
            ),
          ],
        );
      },
      error: (error) => Scaffold(
        appBar: AppBar(
          title: const Text('Products List'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Text(
            'Error: $error',
            style: GoogleFonts.lato(fontSize: 16, color: Colors.red),
          ),
        ),
      ),
      loading: (loading) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

// Componente ProductCard que encapsula el GestureDetector y la tarjeta
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(
          ProductDetailsScreen.name,
          extra: <String, dynamic>{
            'product': product,
          },
        );
      },
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
                    const SizedBox(height: 4), // Espacio entre título y precio
                    Text(
                      '\$${product.price}', // Precio del producto
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.green[700], // Color verde para el precio
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        color: Colors.grey[700],
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
