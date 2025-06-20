import '../models/home_response.dart';

abstract class HomeRepository {
  Future<List<Movie>> searchMovies(String query);
}

