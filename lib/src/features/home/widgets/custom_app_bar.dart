import 'package:dummy_json_app/core/extensions/localizations_extension.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:dummy_json_app/src/features/products/presentation/delegates/search_product_delegate.dart';
import 'package:dummy_json_app/src/features/products/presentation/providers/search_products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    final l10n = context.l10n;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              color: colors.primary,
            ),
            const SizedBox(width: 8.0),
            Text(l10n.marketplace, style: titleStyle),
            const Spacer(),
            IconButton(
              icon: Icon(
                Icons.search,
                color: colors.primary,
              ),
              onPressed: () {
                final searchedProducts = ref.read(searchedProductsProvider);
                final searchQuery = ref.read(searchQueryProvider);

                showSearch<ProductEntity?>(
                  query: searchQuery,
                  context: context,
                  delegate: SearchProductDelegate(
                    initialProducts: searchedProducts,
                    searchProducts: ref
                        .read(searchedProductsProvider.notifier)
                        .searchProductByQuery,
                  ),
                ).then((product) {
                  if (product == null) return;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
