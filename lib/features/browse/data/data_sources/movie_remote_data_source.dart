import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/movie_response.dart';

// todo: Interface => Remote Data Source
abstract class MovieRemoteDataSource {
  Future<Either<Failure, MovieResponse?>> getMovie({Map<String, dynamic>? queryParameters});
}

// todo: Interface => Offline Data Source
abstract class MovieOfflineDataSource{

}