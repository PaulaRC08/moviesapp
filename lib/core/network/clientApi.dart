import 'package:dio/dio.dart';
import 'package:movies_app/core/constants.dart';

class DioClient {
  final Dio _dio;

  DioClient(): _dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.themoviedb.org/3',
            headers: {
              'Authorization': 'Bearer ${Constants.TokenAPI}', // Agrega el token al header
              'Content-Type': 'application/json',
            },
          ),
        ) {
  //   _dio.interceptors.add(LogInterceptor(
  //     request: true,
  //     requestBody: true,
  //     responseBody: true,
  //   )); 
  }
  Dio get dio => _dio;
}