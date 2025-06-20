import 'package:movie_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:movie_app/features/home/data/models/home_response.dart';
import 'package:movie_app/features/home/data/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  HomeRepositoryImpl(this.remoteDataSource);

@override
Future<List<Movie>> searchMovies(String query) async {
  return await remoteDataSource.searchMovies(query); 
}


}
