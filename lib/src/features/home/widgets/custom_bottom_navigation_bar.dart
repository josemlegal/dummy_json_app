import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return NavigationBar(
      indicatorColor: colors.inversePrimary,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      selectedIndex: currentIndex,
      animationDuration: const Duration(milliseconds: 1000),
      onDestinationSelected: (value) => onItemTapped(context, value),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite_border),
          label: 'Favorites',
        ),
      ],
    );
  }
}
