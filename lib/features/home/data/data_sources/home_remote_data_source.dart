import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/core/api/api_constant.dart';
import 'package:movie_app/core/api/api_services.dart';
import '../models/home_response.dart';

class HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSource({required this.apiService});

  Future<List<Movie>> getMovies({int page = 1}) async {
    final response = await apiService.get(
      endPoint: "${ApiConstant.movieList}?page=$page",
    );

    final List data = response['data']['movies'];
    
    
    if (data == null) return [];

    return data.map((e) => Movie.fromJson(e)).toList();
  }
  Future<List<Movie>> searchMovies(String query) async {
  final response = await http.get(Uri.parse('https://yts.mx/api/v2/list_movies.json?query_term=$query'));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final List moviesJson = json['data']['movies'];
    return moviesJson.map((e) => Movie.fromJson(e)).toList();
  } else {
    return [];
  }
}

}
