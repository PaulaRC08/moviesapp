import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/features/movies/presentation/pages/FavoritePage.dart';
import 'package:movies_app/features/movies/presentation/pages/PopularPages.dart';
import 'package:movies_app/features/movies/presentation/pages/RecentPage.dart';

final navItems = [
  {"icon": Icons.movie, "label": "Recientes"},
  {"icon": Icons.star, "label": "Populares"},
  {"icon": Icons.favorite, "label": "Favoritas"},
];

class MainPage extends StatelessWidget {
  final Widget child;
  const MainPage({
    super.key, 
    required this.child
  });

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();
    if (location.startsWith('/recents')) return 0;
    if (location.startsWith('/popular')) return 1;
    if (location.startsWith('/favorites')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.cyan.shade800,
        selectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(size: 30),
        currentIndex: _getSelectedIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              context.replace('/recents');
              break;
            case 1:
              context.replace('/popular');
              break;
            case 2:
              context.replace('/favorites');
              break;
          }
        },
        items: navItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item['icon'] as IconData),
            label: item['label'] as String,
          );
        }).toList(),
      )
      
    );
  }
}