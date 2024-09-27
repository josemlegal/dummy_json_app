import 'app_localization.dart';

/// The translations for English (`en`).
class AppLocalizationEn extends AppLocalization {
  AppLocalizationEn([String locale = 'en']) : super(locale);

  @override
  String get productNotFound => 'Product not found';

  @override
  String get price => 'Price';

  @override
  String get rating => 'Rating';

  @override
  String get stock => 'Stock';

  @override
  String get brand => 'Brand';

  @override
  String get discount => 'Discount';

  @override
  String get category => 'Category';

  @override
  String get profile => 'Profile';

  @override
  String get years => 'years';

  @override
  String get contactInfo => 'Contact information';

  @override
  String get email => 'Email';

  @override
  String get phone => 'Phone';

  @override
  String get personalInfo => 'Personal information';

  @override
  String get birthdate => 'Birthdate';

  @override
  String get id => 'ID';

  @override
  String get gender => 'Gender';

  @override
  String get nothingOnFavorites => 'You don\'t have any products on favorites';

  @override
  String get favorites => 'Wishlist';

  @override
  String productInFavorites(String productTitle) {
    return 'The product $productTitle is already in your favorites list.';
  }

  @override
  String get addToFavorites => 'Añadir a favoritos';

  @override
  String get marketplace => 'Marketplace';

  @override
  String get noProductsFound => 'No se encontraron productos';

  @override
  String get productsList => 'Lista de productos';
}
