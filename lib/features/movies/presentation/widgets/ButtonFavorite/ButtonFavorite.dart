import 'package:flutter/material.dart';
import 'package:movies_app/features/movies/data/models/Movie.dart';
import 'package:movies_app/features/movies/data/models/favoritemovie.dart';
import 'package:movies_app/features/movies/data/services/isarService.dart';

class ButtonFavorite extends StatefulWidget {
  final Movie movie; 
  const ButtonFavorite({super.key, required this.movie});

  @override
  State<ButtonFavorite> createState() => _ButtonFavoriteState();
}

class _ButtonFavoriteState extends State<ButtonFavorite> {
  bool _isFavorite = false;
  late int? _idIsar;

  @override
  void initState() {
    super.initState();
    _initializeIsar();
  }

  Future<void> _initializeIsar() async {
    await IsarService.instance.init();
    _isFavoriteMovie();
  }


  Future<void> _isFavoriteMovie() async {
    final FavoriteMovie? favoriteMovie = await IsarService.instance.isFavorite(widget.movie.id);
    setState(() {
      _idIsar = favoriteMovie?.id;
      _isFavorite = favoriteMovie != null ? true : false;
    });
  }

  void _toggleFavorite(String movieId) async {
    if (_isFavorite) {
      await IsarService.instance.removeFavoriteMovie(_idIsar!);
      setState(() {
        _isFavorite = false;
      });
    }else{
      final movie = FavoriteMovie(
        movieId: widget.movie.id,
        title: widget.movie.title,
        image: widget.movie.posterImage,
        description: widget.movie.description,
        isFavorite: true,
      );
      await IsarService.instance.addFavoriteMovie(movie);
      setState(() {
        _isFavorite = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: _isFavorite ? WidgetStateProperty.all( const Color(0xFFB71C1C)) : WidgetStateProperty.all(Colors.white),
        side: WidgetStateProperty.all(const BorderSide(
          width: 1.0,
          color: Color(0xFFB71C1C),
        )),
      ),
      onPressed: (){
        _toggleFavorite(widget.movie.id);
      }, 
      child: Row(
        children: [
          Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_outline ,
            color: _isFavorite ? Colors.white : const Color(0xFFB71C1C)
          ),
          Text(
            _isFavorite ? 'Favorita' : 'No favorito',
            style: TextStyle(color: _isFavorite ? Colors.white : const Color(0xFFB71C1C))
          )
        ],
      )
    );
  }
}