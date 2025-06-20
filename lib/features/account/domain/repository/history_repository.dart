import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../movie_details/domain/entities/favourite_response_entity.dart';

abstract class HistoryRepository {
  Future<Either<ServerFailure, void>> addMovieToHistory(FavouriteMovieEntity movie);
  Future<Either<ServerFailure, List<FavouriteMovieEntity>>> getHistory();
  Future<Either<ServerFailure, void>> clearHistory();
}