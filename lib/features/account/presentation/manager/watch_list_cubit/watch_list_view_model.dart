import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/account/presentation/manager/watch_list_cubit/watch_list_states.dart';
import 'package:movie_app/core/cach_helper/cach_helper.dart';
import 'package:movie_app/features/movie_details/domain/entities/favourite_response_entity.dart'; // Keep for FavouriteMovieEntity list type
import 'package:movie_app/features/movie_details/domain/usecases/favourite/get_all_fav_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/features/movie_details/domain/entities/all_favourites_response_entity.dart'; // NEW Import for AllFavouritesResponseEntity

@injectable
class WatchListViewModel extends Cubit<WatchListStates> {
  final GetAllFavUseCase getAllFavUseCase;
  final CacheHelper cacheHelper;

  WatchListViewModel({required this.getAllFavUseCase, required this.cacheHelper}) : super(WatchListInitial());

  Future<void> fetchWatchList() async {
    emit(WatchListLoading());

    final dynamic tokenData = await cacheHelper.getData("token");
    final String? token = tokenData is String ? tokenData : null;

    if (token == null || token.isEmpty) {
      debugPrint('WatchListViewModel Error: Authentication token not found or empty.');
      emit(WatchListError(message: "Authentication token not found. Please log in again."));
      return;
    }

    // Call the UseCase, which now returns AllFavouritesResponseEntity
    final result = await getAllFavUseCase.call(token);

    result.fold(
          (failure) {
        debugPrint('WatchListViewModel Error: ${failure.errMessage}');
        emit(WatchListError(message: failure.errMessage));
      },
          (allFavouritesResponseEntity) { // EDITED: Expect AllFavouritesResponseEntity here
        if (allFavouritesResponseEntity != null && allFavouritesResponseEntity.data != null) {
          final List<FavouriteMovieEntity> watchListMovies = allFavouritesResponseEntity.data!; // Access the 'data' field
          debugPrint('WatchListViewModel Success: Loaded ${watchListMovies.length} movies.');
          emit(WatchListSuccess(watchListMovies: watchListMovies));
        } else {
          debugPrint('WatchListViewModel Success: No movies found in watch list data.');
          emit(WatchListSuccess(watchListMovies: []));
        }
      },
    );
  }
}