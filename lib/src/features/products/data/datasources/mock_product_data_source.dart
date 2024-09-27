import 'package:dummy_json_app/core/network_client/netwok_client.dart';
import 'package:dummy_json_app/src/features/products/data/models/product_list_model.dart';
import 'package:dummy_json_app/src/features/products/data/models/product_model.dart';
import 'package:dummy_json_app/src/features/products/domain/datasources/product_data_source.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:fpdart/fpdart.dart';

class MockProductDatasource extends ProductDataSource {
  @override
  Future<Result<List<ProductEntity>?>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 1));

    final response = ProductListModel(
      products: [
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
        ),
      ],
    ).toEntity();

    return right(response.products);
  }

  @override
  Future<Result<ProductEntity?>> getProduct(String productId) async {
    await Future.delayed(const Duration(seconds: 1));

    const response = ProductModel(
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
    );

    return right(response.toEntity());
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) {
    // TODO: implement searchProducts
    throw UnimplementedError();
  }
}
