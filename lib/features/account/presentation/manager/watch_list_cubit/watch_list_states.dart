import '../../../../movie_details/domain/entities/favourite_response_entity.dart';

abstract class WatchListStates  {}

class WatchListInitial extends WatchListStates {}
class WatchListLoading extends WatchListStates {}

class WatchListSuccess extends WatchListStates {
  final List<FavouriteMovieEntity> watchListMovies; // <--- ENTITY
   WatchListSuccess({required this.watchListMovies});
}

class WatchListError extends WatchListStates {
  final String message;
   WatchListError({required this.message});
}
