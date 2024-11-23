import 'package:flutter/material.dart';
import 'package:movies_app/features/movies/presentation/pages/FavoritePage.dart';
import 'package:movies_app/features/movies/presentation/pages/PopularPages.dart';
import 'package:movies_app/features/movies/presentation/pages/RecentPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _tabIndex = 0;

  final List<Widget> _pages = [
    const RecentPage(),
    const PopularPage(),
    const FavoritePage(),
  ];

  final navItems = [
    {"icon": Icons.movie, "label": "Recientes"},
    {"icon": Icons.star, "label": "Populares"},
    {"icon": Icons.favorite, "label": "Favoritas"},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.cyan.shade800,
        selectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(size: 30),
        currentIndex: _tabIndex,
        onTap: _onItemTapped,
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