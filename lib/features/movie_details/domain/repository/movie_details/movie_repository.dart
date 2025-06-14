import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../data/models/movie_details_response.dart';

abstract class MovieDetailsRepository {
 Future<Either<Failure, MovieDetailsResponse>> getMovieDetails(int movieId);

}