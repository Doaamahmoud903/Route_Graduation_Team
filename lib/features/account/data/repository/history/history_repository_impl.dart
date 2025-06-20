import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/account/data/data_sources/local/history/history_local_data_source.dart';
import 'package:movie_app/features/account/domain/repository/history_repository.dart';

import '../../../../movie_details/domain/entities/favourite_response_entity.dart';
@Injectable(as: HistoryRepository)
class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryLocalDataSource historyLocalDataSource;

  HistoryRepositoryImpl(this.historyLocalDataSource);

  @override
  Future<Either<ServerFailure, void>> addMovieToHistory(FavouriteMovieEntity movie) {
    return historyLocalDataSource.addMovieToHistory(movie);
  }

  @override
  Future<Either<ServerFailure, void>> clearHistory() {
    return historyLocalDataSource.clearHistory();
  }

  @override
  Future<Either<ServerFailure, List<FavouriteMovieEntity>>> getHistory() {
    return historyLocalDataSource.getHistoryMovies();
  }
}