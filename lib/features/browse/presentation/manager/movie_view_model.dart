import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/browse/data/repository/movie_repository.dart';
import 'package:movie_app/features/browse/presentation/manager/movie_states.dart';

@injectable
class MovieViewModel extends Cubit<MovieState> {
  MovieRepository movieRepo;

  MovieViewModel({required this.movieRepo}) : super(MovieIntialState());
  Future<void> getMovie({String? genre, String? searchTerm , String? sort_by}) async {
    emit(MovieLoading());
    final response = await movieRepo.getMovies(queryParameters: {
      if (genre != null) "genre": genre,
      if (searchTerm != null && searchTerm.isNotEmpty) "query_term": searchTerm,
      if (sort_by != null) "sort_by": sort_by,
    });
    response.fold(
          (failure) => emit(MovieFaluire(failure.errMessage)),
          (movie) => emit(MovieSuccess(movie!)),
    );
  }

}
