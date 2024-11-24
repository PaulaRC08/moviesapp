import 'dart:ui';

import 'package:go_router/go_router.dart';
import 'package:movies_app/features/movies/presentation/pages/DetailPage.dart';
import 'package:movies_app/features/movies/presentation/pages/FavoritePage.dart';
import 'package:movies_app/features/movies/presentation/pages/MainPage.dart';
import 'package:movies_app/features/movies/presentation/pages/PopularPages.dart';
import 'package:movies_app/features/movies/presentation/pages/RecentPage.dart';

final router = GoRouter(
  initialLocation: '/recents',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainPage(child: child);
      },
      routes: [
          GoRoute(
            path: '/recents',
            builder: (context, state) => const RecentPage()
          ),
          GoRoute(
            path: '/popular',
            builder: (context, state) => const PopularPage(),
          ),
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavoritePage(),
          ),
          GoRoute(
            path: '/detail/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              final onClose = state.extra as VoidCallback?;
              return DetailPage(movieId: id!, onBack: onClose!);
            },
          ),
      ],
    )
  ]
);