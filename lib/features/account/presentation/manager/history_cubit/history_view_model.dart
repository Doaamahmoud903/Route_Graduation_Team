import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../movie_details/domain/entities/favourite_response_entity.dart';
import '../../../domain/usecases/history/add_to_history_use_case.dart';
import '../../../domain/usecases/history/get_history_use_case.dart';
import 'history_states.dart';

@injectable
class HistoryViewModel extends Cubit<HistoryStates> {
  final AddToHistoryUseCase addToHistoryUseCase; // <--- USE CASE
  final GetHistoryUseCase getHistoryUseCase; // <--- USE CASE

  HistoryViewModel(this.addToHistoryUseCase, this.getHistoryUseCase) : super(HistoryInitial());

  Future<void> fetchHistory() async {
    emit(HistoryLoading());
    final result = await getHistoryUseCase.call();
    result.fold(
          (failure) => emit(HistoryError(message: failure.errMessage)),
          (movies) => emit(HistorySuccess(historyMovies: movies)),
    );
  }

  Future<void> addMovieToHistory(FavouriteMovieEntity movie) async { // <--- ENTITY
    final result = await addToHistoryUseCase.call(movie);
    result.fold(
          (failure) {
        // debugPrint('Failed to add movie to history: ${failure.errMessage}');
      },
          (_) {
        fetchHistory(); // Refresh the list after adding
      },
    );
  }
}
