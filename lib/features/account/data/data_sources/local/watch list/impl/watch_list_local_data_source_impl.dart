import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../core/cach_helper/cach_helper.dart';
import '../../../../../../../core/errors/failure.dart';
import 'package:flutter/foundation.dart';
import '../../../../../../movie_details/data/models/favourite_response_dto.dart';
import '../../../../../../movie_details/domain/entities/favourite_response_entity.dart';
import '../watch_list_local_data_source.dart';


@Injectable(as: WatchListLocalDataSource)
class WatchListLocalDataSourceImpl implements WatchListLocalDataSource {
  final CacheHelper cacheHelper;
  static const String watchListKey = 'watchList';

  WatchListLocalDataSourceImpl(this.cacheHelper);

  @override
  Future<Either<ServerFailure, void>> addMovieToWatchList(FavouriteMovieEntity movie) async {
    debugPrint('WatchListLocalDataSourceImpl: addMovieToWatchList for movie ID: ${movie.movieId}');
    try {
      final currentWatchListEither = await getWatchListMovies();
      final List<FavouriteMovieEntity> currentWatchList = currentWatchListEither.fold(
            (_) => <FavouriteMovieEntity>[],
            (list) => list,
      );
      debugPrint('WatchListLocalDataSourceImpl: Current watch list movies count: ${currentWatchList.length}');

      final updatedWatchList = [movie, ...currentWatchList.where((m) => m.movieId != movie.movieId)];
      debugPrint('WatchListLocalDataSourceImpl: Updated watch list movies count before limit: ${updatedWatchList.length}');


      if (updatedWatchList.length > 50) {
        updatedWatchList.removeLast();
        debugPrint('WatchListLocalDataSourceImpl: Watch list truncated to 50 movies.');
      }

      // Convert List<FavouriteMovieEntity> to List<Map<String, dynamic>> using DTO's toJson
      final List<Map<String, dynamic>> watchListMaps = updatedWatchList.map((e) {
        if (e is FavouriteMovieDto) {
          return e.toJson();
        }
        throw Exception('Attempted to save a non-FavouriteMovieDto to watch list.');
      }).toList();

      debugPrint('WatchListLocalDataSourceImpl: Saving ${watchListMaps.length} movies to watch list.');
      final success = await cacheHelper.saveData(watchListKey, watchListMaps);
      if (success) {
        debugPrint('WatchListLocalDataSourceImpl: Successfully saved movie to watch list locally.');
        return const Right(null);
      } else {
        debugPrint('WatchListLocalDataSourceImpl: Failed to save movie to watch list locally.');
        return Left(ServerFailure('Failed to save movie to watch list locally.'));
      }
    } catch (e) {
      debugPrint('WatchListLocalDataSourceImpl: Error adding movie to watch list: ${e.toString()}');
      return Left(ServerFailure('Error adding movie to watch list: ${e.toString()}'));
    }
  }

  @override
  Future<Either<ServerFailure, void>> removeMovieFromWatchList(String movieId) async {
    debugPrint('WatchListLocalDataSourceImpl: removeMovieFromWatchList for movie ID: $movieId');
    try {
      final currentWatchListEither = await getWatchListMovies();
      final List<FavouriteMovieEntity> currentWatchList = currentWatchListEither.fold(
            (_) => <FavouriteMovieEntity>[],
            (list) => list,
      );
      debugPrint('WatchListLocalDataSourceImpl: Current watch list movies count before removal: ${currentWatchList.length}');


      final updatedWatchList = currentWatchList.where((m) => m.movieId != movieId).toList();
      debugPrint('WatchListLocalDataSourceImpl: Updated watch list movies count after removal: ${updatedWatchList.length}');


      final List<Map<String, dynamic>> watchListMaps = updatedWatchList.map((e) {
        if (e is FavouriteMovieDto) {
          return e.toJson();
        }
        throw Exception('Attempted to save a non-FavouriteMovieDto to watch list during removal.');
      }).toList();

      debugPrint('WatchListLocalDataSourceImpl: Saving ${watchListMaps.length} movies after removal.');
      final success = await cacheHelper.saveData(watchListKey, watchListMaps);
      if (success) {
        debugPrint('WatchListLocalDataSourceImpl: Successfully removed movie from watch list locally.');
        return const Right(null);
      } else {
        debugPrint('WatchListLocalDataSourceImpl: Failed to remove movie from watch list locally.');
        return Left(ServerFailure('Failed to remove movie from watch list locally.'));
      }
    } catch (e) {
      debugPrint('WatchListLocalDataSourceImpl: Error removing movie from watch list: ${e.toString()}');
      return Left(ServerFailure('Error removing movie from watch list: ${e.toString()}'));
    }
  }

  @override
  Future<Either<ServerFailure, List<FavouriteMovieEntity>>> getWatchListMovies() async {
    debugPrint('WatchListLocalDataSourceImpl: Attempting to get watch list for key: $watchListKey');
    try {
      dynamic rawData = await cacheHelper.getData(watchListKey);
      debugPrint('WatchListLocalDataSourceImpl: Initial raw data for $watchListKey: $rawData (Type: ${rawData.runtimeType})');

      // Handle the case where the stored data is a single Map instead of a List
      if (rawData is Map<String, dynamic>) {
        debugPrint('WatchListLocalDataSourceImpl: WARNING! WatchList data retrieved as a single Map. Clearing old corrupted watch list.');
        final bool removed = await cacheHelper.removeData(watchListKey); // Clear corrupted data
        debugPrint('WatchListLocalDataSourceImpl: Corrupted watch list data removed: $removed');

        rawData = await cacheHelper.getData(watchListKey);
        debugPrint('WatchListLocalDataSourceImpl: Re-fetched raw data after clearing for $watchListKey: $rawData (Type: ${rawData.runtimeType})');

        if (rawData is Map<String, dynamic>) {
          debugPrint('WatchListLocalDataSourceImpl: CRITICAL! Data is still a Map after clearing. Manual intervention may be needed.');
          return Left(ServerFailure('Persistent corrupted watch list data detected.'));
        }
        if (rawData == null || rawData is! List) {
          debugPrint('WatchListLocalDataSourceImpl: Data is now null or not a list after clearing. Returning empty list.');
          return const Right([]);
        }
      }

      if (rawData is List) {
        debugPrint('WatchListLocalDataSourceImpl: Raw data is a List. Proceeding to deserialize.');
        final List<FavouriteMovieEntity> watchList = [];
        for (final item in rawData) {
          if (item is Map<String, dynamic>) {
            try {
              // Use FavouriteMovieDto.fromJson to convert map back to DTO
              watchList.add(FavouriteMovieDto.fromJson(item));
            } catch (e) {
              debugPrint('WatchListLocalDataSourceImpl: Error deserializing map to FavouriteMovieDto in WatchList: $e. Item: $item');
            }
          } else {
            debugPrint('WatchListLocalDataSourceImpl: Warning: Item in watch list is not a Map<String, dynamic>: $item (Type: ${item.runtimeType})');
          }
        }
        debugPrint('WatchListLocalDataSourceImpl: Successfully deserialized ${watchList.length} movies for watch list.');
        return Right(watchList);
      } else {
        debugPrint('WatchListLocalDataSourceImpl: ERROR! WatchList data retrieved is of unexpected final type: ${rawData.runtimeType}. Returning empty list.');
        return const Right([]); // Return empty list
      }
    } catch (e) {
      debugPrint('WatchListLocalDataSourceImpl: CRITICAL ERROR retrieving watch list movies: ${e.toString()}');

      return Left(ServerFailure('Error retrieving watch list movies: ${e.toString()}'));
    }
  }

  @override
  Future<Either<ServerFailure, bool>> isMovieInWatchList(String movieId) async {
    debugPrint('WatchListLocalDataSourceImpl: Checking if movie $movieId is in watch list.');
    try {
      final result = await getWatchListMovies();
      return result.fold(
            (failure) {
          debugPrint('WatchListLocalDataSourceImpl: isMovieInWatchList failed to get watch list: ${failure.errMessage}');
          return Left(failure);
        },
            (watchList) {
          final isInList = watchList.any((m) => m.movieId == movieId);
          debugPrint('WatchListLocalDataSourceImpl: Movie $movieId is in watch list: $isInList');
          return Right(isInList);
        },
      );
    } catch (e) {
      debugPrint('WatchListLocalDataSourceImpl: Error checking watch list status for $movieId: ${e.toString()}');
      return Left(ServerFailure('Error checking watch list status: ${e.toString()}'));
    }
  }
}
