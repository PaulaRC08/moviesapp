import 'package:isar/isar.dart';
part 'favoritemovie.g.dart';

@collection
class FavoriteMovie {
  Id id = Isar.autoIncrement;
  String? movieId; 
  String? title; 
  String? image; 
  String? description; 

  @Index() 
  late bool isFavorite;

  FavoriteMovie({
    this.movieId = '',
    this.title = '',
    this.image = '',
    this.description = '',
    this.isFavorite = true,
  });

}