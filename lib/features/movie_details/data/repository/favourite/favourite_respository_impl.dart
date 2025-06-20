import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/account/data/data_sources/local/history/history_local_data_source.dart';
import 'package:movie_app/features/movie_details/data/data_sources/remote/favourite/favourite_remote_data_source.dart';
import 'package:movie_app/features/movie_details/domain/entities/favourite_response_entity.dart';
import 'package:movie_app/features/movie_details/domain/repository/favourite/favourite_respository.dart';
import 'package:movie_app/features/movie_details/domain/entities/all_favourites_response_entity.dart'; // NEW Import for new entity
import '../../../../account/data/data_sources/local/watch list/watch_list_local_data_source.dart'; // For LocalFavoriteListDto (for local storage)

@Injectable(as: FavouriteRespository)
class FavouriteRepositoryImpl implements FavouriteRespository {
  final FavouriteRemoteDataSource favouriteRemoteDataSource;
  final WatchListLocalDataSource watchListLocalDataSource;
  final HistoryLocalDataSource historyLocalDataSource;

  FavouriteRepositoryImpl(this.favouriteRemoteDataSource, this.watchListLocalDataSource, this .historyLocalDataSource);

  @override
  Future<Either<Failure, FavouriteResponseEntity>> addToFav(String token, String movieId, String name, double rating, String imageURL, String year) async {
    final result = await favouriteRemoteDataSource.addToFav(token, movieId, name, rating, imageURL, year);
    return result.fold(
          (failure) => Left(failure),
          (responseDto) async {
        final favouriteMovieEntity = FavouriteMovieEntity(
          movieId: movieId,
          name: name,
          rating: rating,
          imageURL: imageURL,
          year: year,
        );
        await watchListLocalDataSource.addMovieToWatchList(favouriteMovieEntity); // Save to local cache
        await historyLocalDataSource.addMovieToHistory(favouriteMovieEntity); // Save to local cache
        return Right(responseDto);
      },
    );
  }

  @override
  Future<Either<Failure, DelFavouriteResponseEntity>> delMovieFromFav(String token, String movieId) async {
    final result = await favouriteRemoteDataSource.delMovieFromFav(token, movieId);
    return result.fold(
          (failure) => Left(failure),
          (responseDto) async {

        await watchListLocalDataSource.removeMovieFromWatchList(movieId); // Remove from local cache
        return Right(responseDto);
      },
    );
  }

  @override
  Future<Either<Failure, AllFavouritesResponseEntity>> getAllFav(String token) async {
    final localResult = await watchListLocalDataSource.getWatchListMovies();

    // If local data exists and is valid (not empty), return it
    if (localResult.isRight()) {
      final localWatchList = localResult.getOrElse(() => []);
      if (localWatchList.isNotEmpty) {
        return Right(AllFavouritesResponseEntity(data: localWatchList));
      }
    }

    // If local data is empty or failed, try remote
    final remoteResult = await favouriteRemoteDataSource.getAllFav(token); // This now returns AllFavouritesResponseDto
    return remoteResult.fold(
          (remoteFailure) => Left(remoteFailure),
          (remoteDto) async {
        // On successful remote fetch, update the local cache
        if (remoteDto.data != null && remoteDto.data!.isNotEmpty) {
        }
        // remoteDto already extends AllFavouritesResponseEntity, so can return directly
        return Right(remoteDto);
      },
    );
  }

  @override
  Future<Either<Failure, DelFavouriteResponseEntity>> isFav(String token,String movieId) async{
    return favouriteRemoteDataSource.isFav(token ,movieId);
  }
}