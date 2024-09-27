import 'app_localization.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationEs extends AppLocalization {
  AppLocalizationEs([String locale = 'es']) : super(locale);

  @override
  String get productNotFound => 'Producto no encontrado';

  @override
  String get price => 'Precio';

  @override
  String get rating => 'Valoración';

  @override
  String get stock => 'Stock';

  @override
  String get brand => 'Marca';

  @override
  String get discount => 'Descuento';

  @override
  String get category => 'Categoría';

  @override
  String get profile => 'Perfil';

  @override
  String get years => 'años';

  @override
  String get contactInfo => 'Información de contacto';

  @override
  String get email => 'Email';

  @override
  String get phone => 'Tel';

  @override
  String get personalInfo => 'Información personal';

  @override
  String get birthdate => 'Fecha de nacimiento';

  @override
  String get id => 'ID';

  @override
  String get gender => 'Género';

  @override
  String get nothingOnFavorites => 'No tienes productos en favoritos';

  @override
  String get favorites => 'Favoritos';

  @override
  String productInFavorites(String productTitle) {
    return 'El producto $productTitle ya está en tu lista de favoritos.';
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
