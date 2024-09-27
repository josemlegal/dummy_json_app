import 'package:dummy_json_app/src/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:dummy_json_app/src/features/home/widgets/custom_bottom_navigation_bar.dart';
import 'package:dummy_json_app/src/features/products/presentation/screens/screens.dart';
import 'package:dummy_json_app/src/features/user/presentation/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

class HomeScreen extends ConsumerWidget {
  static const String name = 'home';
  static const String route = '/home';

  const HomeScreen({
    required this.pageIndex,
    super.key,
  });

  final int pageIndex;

  final screenRoutes = const <Widget>[
    ProductsListScreen(),
    UserProfileScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: screenRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: pageIndex,
      ),
    );
  }
}
