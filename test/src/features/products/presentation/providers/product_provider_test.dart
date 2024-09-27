import 'package:dummy_json_app/core/network_client/api_exception.dart';
import 'package:dummy_json_app/core/network_client/netwok_client.dart';
import 'package:dummy_json_app/src/features/products/data/models/product_model.dart';
import 'package:dummy_json_app/src/features/products/data/providers.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:dummy_json_app/src/features/products/domain/repositories/product_repository.dart';
import 'package:dummy_json_app/src/features/products/presentation/providers/products_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

final mockResponse = [
  const ProductModel(
    id: 1,
    title: "iPhone 9",
    description: "An apple mobile which is nothing like apple",
    price: 549,
    discountPercentage: 12.96,
    rating: 4.69,
    stock: 94,
    brand: "Apple",
    category: "smartphones",
    thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
    images: [
      "https://cdn.dummyjson.com/product-images/1/1.jpg",
      "https://cdn.dummyjson.com/product-images/1/2.jpg",
      "https://cdn.dummyjson.com/product-images/1/3.jpg",
      "https://cdn.dummyjson.com/product-images/1/4.jpg",
      "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"
    ],
  ).toEntity(),
];

void main() {
  late MockProductRepository mockProductRepository;

  group('Product Provider Tests', () {
    setUpAll(() {
      mockProductRepository = MockProductRepository();
    });

    Future<void> setupRepository() async {
      when(
        () => mockProductRepository.getAllProducts(),
      ).thenAnswer(
        (_) async => Future.value(
          Right(mockResponse),
        ),
      );
    }

    test('''The provider should have an AsyncLoading state when init
    and a List<ProductEntity> when finish
    ''', () async {
      const mockError = ApiException(message: 'Error');

      await setupRepository();

      final container = ProviderContainer(
        overrides: [
          productRepositoryProvider.overrideWithValue(mockProductRepository),
        ],
      );

      final notifier = container.read(getAllProductsProvider);

      addTearDown(container.dispose);

      expect(
        notifier,
        equals(
          const AsyncLoading<Result<List<ProductEntity>?>>(),
        ),
      );

      notifier.whenData(
        (data) {
          expect(
            data,
            equals(mockResponse),
          );
        },
      );
    });

    test('''The provider should have an AsyncLoading state when init
    and a ApiException when finish
    ''', () async {
      const mockError = ApiException(message: 'Error');

      final container = ProviderContainer(
        overrides: [
          productRepositoryProvider.overrideWithValue(mockProductRepository),
        ],
      );

      final notifier = container.read(getAllProductsProvider);
      addTearDown(container.dispose);

      notifier.when(
        data: (data) {},
        error: (error, stackTrace) {
          expect(
            error,
            equals(mockError),
          );
        },
        loading: () {},
      );
    });
  });
}
