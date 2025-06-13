

import 'package:movie_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:movie_app/features/home/data/models/home_response.dart';
import 'package:movie_app/features/home/data/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
 @override
Future<List<Movie>> getAllMovies() async {
  List<Movie> allMovies = [];
  int page = 1;
  bool hasMore = true;

  while (hasMore) {
    final movies = await remoteDataSource.getMovies(page: page);
    if (movies.isEmpty) {
      hasMore = false;
    } else {
      allMovies.addAll(movies);
      page++;
      if (page > 50) break;
    }
  }

  return allMovies;
}
@override
Future<List<Movie>> getMovies({int page = 1}) {
  return remoteDataSource.getMovies(page: page);
}

}
