import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies_app/core/network/clientApi.dart';
import 'package:movies_app/features/movies/data/models/MovieList.dart';
import 'package:movies_app/features/movies/data/services/movieService.dart';
import 'package:movies_app/features/movies/presentation/widgets/Recent/CardMovie.dart';

class RecentPage extends StatefulWidget {
  const RecentPage({super.key});

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recient Movies')),
    );
  }
}