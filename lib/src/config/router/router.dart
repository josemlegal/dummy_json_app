import 'package:dummy_json_app/src/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:dummy_json_app/src/features/home/presentation/home_screen.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:dummy_json_app/src/features/products/presentation/screens/screens.dart';
import 'package:dummy_json_app/src/features/user/presentation/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  initialLocation: '/home/0',
  debugLogDiagnostics: true,
  navigatorKey: globalNavigatorKey,
  routes: [
    GoRoute(
      name: HomeScreen.name,
      path: '/home/:page',
      parentNavigatorKey: globalNavigatorKey,
      builder: (context, state) {
        final pageIndex = state.pathParameters['page'] ?? '0';
        return HomeScreen(pageIndex: int.parse(pageIndex));
      },
      routes: [
        GoRoute(
          name: ProductsListScreen.name,
          path: ProductsListScreen.route,
          parentNavigatorKey: globalNavigatorKey,
          builder: (context, state) => const ProductsListScreen(),
        ),
        GoRoute(
          name: FavoritesScreen.name,
          path: FavoritesScreen.route,
          parentNavigatorKey: globalNavigatorKey,
          builder: (context, state) => const FavoritesScreen(),
        ),
        GoRoute(
          name: UserProfileScreen.name,
          path: UserProfileScreen.route,
          parentNavigatorKey: globalNavigatorKey,
          builder: (context, state) => const UserProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      name: ProductDetailsScreen.name,
      path: ProductDetailsScreen.route,
      builder: (context, state) {
        if (state.extra != null) {
          final args = state.extra! as Map<String, dynamic>;

          return ProductDetailsScreen(
            product: args['product'] as ProductEntity?,
          );
        }

        return const ProductDetailsScreen(product: null);
      },
    ),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0',
    )
  ],
);
