import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../models/movie_details_response.dart';

// todo: Interface => Remote Data Source
abstract class MovieDetailsRemoteDataSource {
  Future<Either<Failure, MovieDetailsResponse>> getMovieDetails(int movieId);

}

// todo: Interface => Offline Data Source
abstract class MovieDetailsOfflineDataSource{

}