import 'package:flutter_test/flutter_test.dart';
import 'package:dummy_json_app/src/features/products/data/models/product_model.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';

void main() {
  group('ProductModel', () {
    const productModel = ProductModel(
      id: 1,
      title: 'Test Product',
      description: 'This is a test product',
      price: 100,
      discountPercentage: 10,
      rating: 4.5,
      stock: 50,
      brand: 'Test Brand',
      category: 'Test Category',
      thumbnail: 'https://example.com/thumbnail.jpg',
      images: [
        'https://example.com/image1.jpg',
        'https://example.com/image2.jpg'
      ],
    );

    test('fromMap creates a valid ProductModel', () {
      final json = {
        'id': 1,
        'title': 'Test Product',
        'description': 'This is a test product',
        'price': 100,
        'discountPercentage': 10,
        'rating': 4.5,
        'stock': 50,
        'brand': 'Test Brand',
        'category': 'Test Category',
        'thumbnail': 'https://example.com/thumbnail.jpg',
        'images': [
          'https://example.com/image1.jpg',
          'https://example.com/image2.jpg'
        ],
      };

      final product = ProductModel.fromMap(json);

      expect(product.id, 1);
      expect(product.title, 'Test Product');
      expect(product.description, 'This is a test product');
      expect(product.price, 100);
      expect(product.discountPercentage, 10);
      expect(product.rating, 4.5);
      expect(product.stock, 50);
      expect(product.brand, 'Test Brand');
      expect(product.category, 'Test Category');
      expect(product.thumbnail, 'https://example.com/thumbnail.jpg');
      expect(
        product.images,
        [
          'https://example.com/image1.jpg',
          'https://example.com/image2.jpg',
        ],
      );
    });

    test('toEntity converts ProductModel to ProductEntity', () {
      const productEntity = ProductEntity(
        id: 1,
        title: 'Test Product',
        description: 'This is a test product',
        price: 100,
        discountPercentage: 10,
        rating: 4.5,
        stock: 50,
        brand: 'Test Brand',
        category: 'Test Category',
        thumbnail: 'https://example.com/thumbnail.jpg',
        images: [
          'https://example.com/image1.jpg',
          'https://example.com/image2.jpg'
        ],
      );

      final result = productModel.toEntity();

      expect(result, productEntity);
    });
  });
}
