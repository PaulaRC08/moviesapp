class MovieListModel {
  final String id;
  final String title;
  final String image;
  final String description;

  MovieListModel({
    required this.id,
    required this.title,
    required this.image, 
    required this.description,
  });

  factory MovieListModel.fromJson(Map<String, dynamic> json) {
    return MovieListModel(
      id: json['id'].toString(),
      title: json['original_title'] ?? '',
      image: json['poster_path'],
      description: json['overview'] == '' || json['overview'] == null ? 'Sin descripcion latina' : json['overview'],
    );
  }
}
