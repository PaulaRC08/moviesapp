import 'package:flutter/material.dart';
import 'package:movies_app/features/movies/presentation/widgets/GetListMovies/GetListMovies.dart';

class PopularPage extends StatelessWidget {
  const PopularPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListMovies(
      titleComponent: 'Peliculas Populares',
      urlApi: '/movie/popular',
    );
  }
}