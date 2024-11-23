import 'package:go_router/go_router.dart';
import 'package:movies_app/features/movies/presentation/pages/FavoritePage.dart';
import 'package:movies_app/features/movies/presentation/pages/MainPage.dart';
import 'package:movies_app/features/movies/presentation/pages/PopularPages.dart';
import 'package:movies_app/features/movies/presentation/pages/RecentPage.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainPage(),
      routes: [
        GoRoute(
          path: 'recientes',
          builder: (context, state) => const RecentPage(),
        ),
        GoRoute(
          path: 'populares',
          builder: (context, state) => const PopularPage(),
        ),
        GoRoute(
          path: 'favoritos',
          builder: (context, state) => const FavoritePage(),
        ),
      ],
    ),
  ],
);