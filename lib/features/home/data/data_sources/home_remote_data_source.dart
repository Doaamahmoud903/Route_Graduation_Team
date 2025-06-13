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
}
