import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart'; // For debugPrint
import '../../../../../../../core/cach_helper/cach_helper.dart';
import '../../../../../../../core/errors/failure.dart';
import '../../../../../../movie_details/domain/entities/favourite_response_entity.dart';
import '../history_local_data_source.dart';


@Injectable(as: HistoryLocalDataSource)
class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  final CacheHelper cacheHelper;
  static const String historyKey = 'historyList';

  HistoryLocalDataSourceImpl(this.cacheHelper);

  @override
  Future<Either<ServerFailure, void>> addMovieToHistory(FavouriteMovieEntity movie) async {
    debugPrint('HistoryLocalDataSourceImpl: addMovieToHistory for movie ID: ${movie.movieId}');
    try {
      final currentHistoryEither = await getHistoryMovies();
      final List<FavouriteMovieEntity> currentHistory = currentHistoryEither.fold(
            (_) => <FavouriteMovieEntity>[],
            (list) => list,
      );
      debugPrint('HistoryLocalDataSourceImpl: Current history movies count: ${currentHistory.length}');

      final updatedHistory = [movie, ...currentHistory.where((m) => m.movieId != movie.movieId)];
      debugPrint('HistoryLocalDataSourceImpl: Updated history movies count before limit: ${updatedHistory.length}');


      if (updatedHistory.length > 50) {
        updatedHistory.removeLast();
        debugPrint('HistoryLocalDataSourceImpl: History truncated to 50 movies.');
      }

      // NEW: Directly save List<FavouriteMovieEntity> using CacheHelper
      debugPrint('HistoryLocalDataSourceImpl: Saving ${updatedHistory.length} movies to history directly as List<FavouriteMovieEntity>.');
      final success = await cacheHelper.saveData(historyKey, updatedHistory);
      if (success) {
        debugPrint('HistoryLocalDataSourceImpl: Successfully saved movie to history locally.');
        return const Right(null);
      } else {
        debugPrint('HistoryLocalDataSourceImpl: Failed to save movie to history locally.');
        return Left(ServerFailure('Failed to save movie to history locally.'));
      }
    } catch (e) {
      debugPrint('HistoryLocalDataSourceImpl: Error adding movie to history: ${e.toString()}');
      return Left(ServerFailure('Error adding movie to history: ${e.toString()}'));
    }
  }

  @override
  Future<Either<ServerFailure, List<FavouriteMovieEntity>>> getHistoryMovies() async {
    debugPrint('HistoryLocalDataSourceImpl: Attempting to get history for key: $historyKey');
    try {
      dynamic rawData = await cacheHelper.getData(historyKey);
      debugPrint('HistoryLocalDataSourceImpl: Initial raw data for $historyKey: $rawData (Type: ${rawData.runtimeType})');

      if (rawData == null) {
        debugPrint('HistoryLocalDataSourceImpl: History data is null. Returning empty list.');
        return const Right([]);
      }

      if (rawData is List<FavouriteMovieEntity>) {
        debugPrint('HistoryLocalDataSourceImpl: Successfully retrieved List<FavouriteMovieEntity> from Hive.');
        return Right(rawData);
      } else {
        debugPrint('HistoryLocalDataSourceImpl: WARNING! History data retrieved is NOT List<FavouriteMovieEntity> (Type: ${rawData.runtimeType}). Clearing old corrupted history and returning empty list.');
        await cacheHelper.removeData(historyKey); // Clear corrupted data
        return const Right([]);
      }
    } catch (e) {
      debugPrint('HistoryLocalDataSourceImpl: CRITICAL ERROR retrieving history movies: ${e.toString()}');
      await cacheHelper.removeData(historyKey); // Clear data on any unhandled retrieval error
      return Left(ServerFailure('Error retrieving history movies: ${e.toString()}'));
    }
  }

  @override
  Future<Either<ServerFailure, void>> clearHistory() async {
    debugPrint('HistoryLocalDataSourceImpl: Attempting to clear history for key: $historyKey');
    try {
      final success = await cacheHelper.removeData(historyKey);
      if (success) {
        debugPrint('HistoryLocalDataSourceImpl: Successfully cleared history locally.');
        return const Right(null);
      } else {
        debugPrint('HistoryLocalDataSourceImpl: Failed to clear history locally.');
        return Left(ServerFailure('Failed to clear history locally.'));
      }
    } catch (e) {
      debugPrint('HistoryLocalDataSourceImpl: Error clearing history: ${e.toString()}');
      return Left(ServerFailure('Error clearing history: ${e.toString()}'));
    }
  }
}

