import 'package:dartz/dartz.dart';
import 'package:movie_app/features/browse/data/models/movie_response.dart';
import '../../../../core/errors/failure.dart';

abstract class MovieRepository {
 Future<Either<Failure, MovieResponse?>> getMovies({Map<String, dynamic>? queryParameters});
}