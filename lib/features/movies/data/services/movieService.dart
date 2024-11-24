import 'package:dio/dio.dart';
import 'package:movies_app/features/movies/data/models/Credit.dart';
import 'package:movies_app/features/movies/data/models/Movie.dart';
import 'package:movies_app/features/movies/data/models/MovieList.dart';

class MoviesApiService {
  final Dio _dio;

  MoviesApiService(this._dio);

  static dynamic optionsApi = {
    'language': 'es',
    'page': 1,
  };

  Future<List<MovieListModel>> getMoviesAccordingUrl(String apiurl) async {
    try {
      final response = await _dio.get(apiurl, queryParameters: optionsApi);

      final movies = (response.data['results'] as List)
          .map((movie) => MovieListModel.fromJson(movie))
          .toList();

      return movies;
    } catch (e) {
      throw Exception('Error al obtener películas: $e');
    }
  }

  Future<Movie> getMovieDetail(String idMovie) async {
    try {
      final response = await _dio.get('/movie/$idMovie', queryParameters: optionsApi);
      final movie = Movie.fromJson(response.data);

      return movie;
    } catch (e) {
      throw Exception('Error al obtener la pelicula: $e');
    }
  }

    Future<List<Credit>> getCreditsMovieDetail(String idMovie) async {
    try {
      final response = await _dio.get('/movie/$idMovie/credits', queryParameters: optionsApi);
      final credits = (response.data['cast'] as List)
          .map((credit) => Credit.fromJson(credit))
          .toList();

      return credits;
    } catch (e) {
      throw Exception('Error al obtener los creditos: $e');
    }
  }

}