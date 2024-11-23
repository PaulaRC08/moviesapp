import 'package:flutter/material.dart';
import 'package:movies_app/features/movies/presentation/widgets/GetListMovies/GetListMovies.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListMovies(
      titleComponent: 'Peliculas Recientes',
      urlApi: '/movie/now_playing',
    );
  }
}