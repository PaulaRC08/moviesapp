import 'package:movies_app/core/constants.dart';
import 'package:movies_app/features/movies/data/models/Credit.dart';

class Movie {
  final String id;
  final String title;
  final String description;
  final String image;
  final String vote;
  final List<Credit>? credits;

  Movie({
    this.id = '',
    this.title = '',
    this.description = '',
    this.image = '', 
    this.vote = '', 
    this.credits,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'].toString(),
      title: json['original_title'] ?? '',
      description: json['overview'] ?? '',
      vote: json['vote_average'].toString(),
      image: '${Constants.ImageAPIUrl}${json['backdrop_path']}',
      credits: null,
    );
  }
  
  Movie copyWith({
    List<Credit>? credits,
  }) {
    return Movie(
      id: this.id,
      title: this.title,
      description: this.description,
      image: this.image,
      vote: this.vote,
      credits: credits ?? this.credits,
    );
  }

}