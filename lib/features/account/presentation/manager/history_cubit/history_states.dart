import '../../../../movie_details/domain/entities/favourite_response_entity.dart';

abstract class HistoryStates {}

class HistoryInitial extends HistoryStates {}
class HistoryLoading extends HistoryStates {}

class HistorySuccess extends HistoryStates {
  final List<FavouriteMovieEntity> historyMovies; // <--- ENTITY
   HistorySuccess({required this.historyMovies});
}

class HistoryError extends HistoryStates {
  final String message;
   HistoryError({required this.message});
}
