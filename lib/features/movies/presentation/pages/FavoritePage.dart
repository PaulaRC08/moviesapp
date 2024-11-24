import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/core/providers/provider.dart';
import 'package:movies_app/features/movies/data/models/favoritemovie.dart';
import 'package:movies_app/features/movies/data/services/isarService.dart';
import 'package:movies_app/features/movies/presentation/widgets/CardMovie/CardMovie.dart';
import 'package:movies_app/features/movies/presentation/widgets/NamePerson/namePerson.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  
  List<FavoriteMovie> _movies = [];
  bool _isLoading = true;
  String _errorMessage = '';
  
  @override
  void initState() {
    super.initState();
    _initializeIsar();
  }

  Future<void> _initializeIsar() async {
    await IsarService.instance.init();
    _favoriteMovies();
  }


  Future<void> _favoriteMovies() async {
    final List<FavoriteMovie> favoriteMovie = await IsarService.instance.getFavoriteMovies();
    _isLoading = false;
    setState(() {
      _movies = favoriteMovie;
    });
  }

  @override
  Widget build(BuildContext context) {
    final namePerson = ref.watch(nameProvider);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NamePerson(
            name: namePerson
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: const Text(
              'Tus favoritas',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24.0
              ),
            ),
          ),
          _isLoading ?
          const Center(child: CircularProgressIndicator()) :
          _movies.isEmpty ? 
          const Center(
            child: Column(
              children: [
                Icon(Icons.heart_broken, size: 50, color: Colors.red,),
                Text('No tienes favoritos agregados'),
              ],
            ),
          ) :
          Expanded(
            child: ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return CardMovie(
                  id: movie.movieId!,
                  title: movie.title!, 
                  image: '${Constants.ImageAPIUrl}${movie.image}', 
                  description: movie.description!, 
                  goDetail: () { 
                    GoRouter.of(context).push(
                      '/detail/${movie.movieId}',
                      extra: () {
                        _favoriteMovies();
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              }
            ),
          )
          ,
        ],
      ),
    );
  }
}