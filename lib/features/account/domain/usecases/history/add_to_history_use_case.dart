import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/account/domain/repository/history_repository.dart';

import '../../../../movie_details/domain/entities/favourite_response_entity.dart';

@injectable
class AddToHistoryUseCase {
  final HistoryRepository historyRepository;
  AddToHistoryUseCase(this.historyRepository);
  Future<Either<ServerFailure, void>> call(FavouriteMovieEntity movie) {
    return historyRepository.addMovieToHistory(movie);
  }
}