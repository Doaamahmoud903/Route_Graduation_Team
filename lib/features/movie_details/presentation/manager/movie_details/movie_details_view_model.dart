import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie_details/domain/repository/movie_details/movie_repository.dart';
import 'package:movie_app/features/movie_details/presentation/manager/movie_details/movie_details_states.dart';

import '../../../../browse/data/models/movie_response.dart';
import '../../../../browse/data/repository/movie_repository.dart';



@injectable
class MovieDetailsViewModel extends Cubit<MovieDetailsState> {
  final MovieDetailsRepository movieDetailsRepo;
  final MovieRepository movieRepo;

  MovieDetailsViewModel({
    required this.movieDetailsRepo,
    required this.movieRepo,
  }) : super(MovieDetailsIntialState());

  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());

    final response = await movieDetailsRepo.getMovieDetails(movieId);

    response.fold(
          (failure) => emit(MovieDetailsFaluire(failure.errMessage)),
          (movieDetails) async {
            final genre = movieDetails?.data?.movie?.genres?.isNotEmpty == true
                ? movieDetails!.data!.movie!.genres!.first
                : null;

            List<Movie> similarMovies = [];

            if (genre != null) {
              final similarResponse = await movieRepo.getMovies(queryParameters: {
                "genre": genre,
              });

              similarResponse.fold(
                    (failure) {},
                    (moviesData) {
                  similarMovies = moviesData?.data?.movies ?? [];
                },
              );
            }

            emit(MovieDetailsSuccess(movieDetails!, similarMovies));

          },
    );
  }
}
