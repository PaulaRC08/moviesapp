import 'package:dio/dio.dart';
import 'package:movies_app/features/movies/data/models/MovieList.dart';

class MoviesApiService {
  final Dio _dio;

  MoviesApiService(this._dio);

  static dynamic optionsApi = {
    'language': 'es',
    'page': 1,
  };

  Future<List<MovieListModel>> getNowPlayingMovies() async {
    try {
      final response = await _dio.get('/movie/now_playing', queryParameters: optionsApi);

      final movies = (response.data['results'] as List)
          .map((movie) => MovieListModel.fromJson(movie))
          .toList();

      return movies;
    } catch (e) {
      throw Exception('Error al obtener películas recientes: $e');
    }
  }


}