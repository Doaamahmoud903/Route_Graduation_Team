import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../movie_details/domain/entities/favourite_response_entity.dart';

abstract class WatchListLocalDataSource {
  Future<Either<ServerFailure, void>> addMovieToWatchList(FavouriteMovieEntity movie);
  Future<Either<ServerFailure, void>> removeMovieFromWatchList(String movieId);
  Future<Either<ServerFailure, List<FavouriteMovieEntity>>> getWatchListMovies();
  Future<Either<ServerFailure, bool>> isMovieInWatchList(String movieId);
}