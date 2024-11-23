import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailPage extends StatefulWidget {

  final String movieId;

  const DetailPage({super.key, required this.movieId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Película'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            context.pushReplacement('/recents');
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Text(widget.movieId),
        ),
      ),
    );
  }
}