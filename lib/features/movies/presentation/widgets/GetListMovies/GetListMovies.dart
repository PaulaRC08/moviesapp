import 'package:flutter/material.dart';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/core/network/clientApi.dart';
import 'package:movies_app/features/movies/data/models/MovieList.dart';
import 'package:movies_app/features/movies/data/services/movieService.dart';
import 'package:movies_app/features/movies/presentation/widgets/CardMovie/CardMovie.dart';

class ListMovies extends StatefulWidget {

  final String titleComponent;
  final String urlApi;

  const ListMovies({super.key, required this.titleComponent, required this.urlApi});

  @override
  State<ListMovies> createState() => _ListMoviesState();
}

class _ListMoviesState extends State<ListMovies> {

  late final MoviesApiService _moviesApiService;
  List<MovieListModel> _movies = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    final dioClient = DioClient();
    _moviesApiService = MoviesApiService(dioClient.dio);
    _fetchNowPlayingMovies();
  }

    Future<void> _fetchNowPlayingMovies() async {
    try {
      final List<MovieListModel> movies  = await _moviesApiService.getMoviesAccordingUrl(widget.urlApi);
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load movies: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Text(
              widget.titleComponent,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24.0
              ),
            ),
          ),
          _isLoading ?
          const Center(child: CircularProgressIndicator()) :
          _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          :
          Expanded(
            child: ListView.builder(
              itemCount: _movies.length,
              
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return CardMovie(
                  title: movie.title, 
                  image: '${Constants.ImageAPIUrl}${movie.image}', 
                  description: movie.description
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