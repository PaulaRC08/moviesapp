import 'package:isar/isar.dart';
import 'package:movies_app/features/movies/data/models/favoritemovie.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();
  Isar? _isar;

  IsarService._internal();
  
  static IsarService get instance => _instance;
  
  Future<void> init() async {
    if (_isar == null) {
      final directory = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [FavoriteMovieSchema],
        directory: directory.path,
      );
    }
  }

  Isar get isarInstance {
    if (_isar == null) {
      throw 'Isar not initialized.';
    }
    return _isar!;
  }

  Future<void> addFavoriteMovie(FavoriteMovie movie) async {
    final isar = await _isar;
    await isar?.writeTxn(() async {
      await isar.favoriteMovies.put(movie);
    });
  }

  Future<List<FavoriteMovie>> getFavoriteMovies() async {
    final isar = await _isar;
    return isar!.favoriteMovies.where().findAll();
  }

  Future<void> removeFavoriteMovie(int id) async {
    final isar = await _isar;
    await isar?.writeTxn(() async {
      await isar.favoriteMovies.delete(id);
    });
  }

  Future<FavoriteMovie?> isFavorite(String movieId) async {
    final isar = await _isar; 
    final favoriteMovie = await isar?.favoriteMovies
        .filter()
        .movieIdEqualTo(movieId)
        .findFirst();
    return favoriteMovie; 
  }
}