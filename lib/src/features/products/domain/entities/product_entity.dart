import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  final int id;
  final String title;
  final String description;
  final num price;
  final num discountPercentage;
  final num rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  ProductEntity copyWith({
    int? id,
    String? title,
    String? description,
    num? price,
    num? discountPercentage,
    num? rating,
    int? stock,
    String? brand,
    String? category,
    String? thumbnail,
    List<String>? images,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'category': category,
      'thumbnail': thumbnail,
      'images': images,
    };
  }

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as num,
      discountPercentage: json['discountPercentage'] as num,
      rating: json['rating'] as num,
      stock: json['stock'] as int,
      brand: json['brand'] as String,
      category: json['category'] as String,
      thumbnail: json['thumbnail'] as String,
      images: List<String>.from(json['images'] as List),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        discountPercentage,
        rating,
        stock,
        brand,
        category,
        thumbnail,
        images,
      ];
}
