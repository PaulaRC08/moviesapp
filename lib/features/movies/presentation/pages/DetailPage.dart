import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/network/clientApi.dart';
import 'package:movies_app/core/providers/provider.dart';
import 'package:movies_app/features/movies/data/models/Credit.dart';
import 'package:movies_app/features/movies/data/models/Movie.dart';
import 'package:movies_app/features/movies/data/services/movieService.dart';
import 'package:movies_app/features/movies/presentation/widgets/ButtonFavorite/ButtonFavorite.dart';
import 'package:movies_app/features/movies/presentation/widgets/NamePerson/namePerson.dart';

class DetailPage extends ConsumerStatefulWidget {

  final String movieId;
  final VoidCallback onBack;

  const DetailPage({super.key, required this.movieId, required this.onBack});

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {


  late final MoviesApiService _moviesApiService;
  Movie _movie = Movie();
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    final dioClient = DioClient();
    _moviesApiService = MoviesApiService(dioClient.dio);
    _fetchMovie();
    _fetchCredits();
  }

  Future<void> _fetchMovie() async {
    try {
      final Movie movies  = await _moviesApiService.getMovieDetail(widget.movieId);
      setState(() {
        _movie = movies;
        _fetchCredits();
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load movies: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchCredits() async {
    try {
      final List<Credit> credits  = await _moviesApiService.getCreditsMovieDetail(widget.movieId);
      setState(() {
        _movie = _movie.copyWith(credits: credits);
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
    final namePerson = ref.watch(nameProvider);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Detalle',
              style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.normal
              ),
            ),
            NamePerson(
              name: namePerson
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
      ),
      body: SafeArea(
        child: Container(
          child: _isLoading ? 
            const Center(child: CircularProgressIndicator()) : 
            _errorMessage.isNotEmpty ? 
            Center(child: Text(_errorMessage)) : 
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 230,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(_movie.image ?? 'https://avatar.iran.liara.run/public'),
                        fit: BoxFit.cover
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.4],
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                _movie.vote
                              ),
                            ],
                          ),
                        ),
                        ButtonFavorite(
                          movie: _movie
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      _movie.description,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Creditos:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    child: _movie.credits == null ? 
                    const Text('No contiene creditos') :
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _movie.credits!.length > 10 ? 10 : _movie.credits!.length,
                        itemBuilder: (context, index) {
                          final credit = _movie.credits![index];
                          return Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(credit.profile ?? 'https://avatar.iran.liara.run/public'),
                                      fit: BoxFit.cover
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        credit.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        credit.rol,
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider()
                      ),
                    )
                  )
                ],
              ),
            ),
        )
        ,
      ),
    );
  }
}