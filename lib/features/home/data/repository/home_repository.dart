import '../models/home_response.dart';

abstract class HomeRepository {
Future<List<Movie>> getMovies({int page = 1});
 Future<List<Movie>> getAllMovies();
}
