import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie_details/domain/repository/movie_details/movie_repository.dart';
import 'package:movie_app/features/movie_details/presentation/manager/movie_details/movie_details_states.dart';

import '../../../../account/domain/usecases/history/add_to_history_use_case.dart';
import '../../../../browse/data/models/movie_response.dart';
import '../../../../browse/data/repository/movie_repository.dart';
import '../../../data/models/favourite_response_dto.dart';



@injectable
class MovieDetailsViewModel extends Cubit<MovieDetailsState> {
  final MovieDetailsRepository movieDetailsRepo;
  final MovieRepository movieRepo;
  final AddToHistoryUseCase addToHistoryUseCase;

  MovieDetailsViewModel({
    required this.movieDetailsRepo,
    required this.movieRepo,
    required this.addToHistoryUseCase,
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

            if (movieDetails?.data?.movie != null) {
              final movieData = movieDetails!.data!.movie!;

              // Map the Movie object to a FavouriteMovieEntity (or FavouriteMovieDto)
              // Adjust this mapping based on the exact fields you have in your Movie model
              final FavouriteMovieDto movieForHistory = FavouriteMovieDto(
                movieId: movieData.id?.toString(), // Convert int ID to String if needed
                name: movieData.title,
                rating: movieData.rating,
                imageURL: movieData.mediumCoverImage, // Assuming this is the correct image URL field
                year: movieData.year?.toString(), // Convert int year to String if needed
              );

              // Call the AddToHistoryUseCase
              final historyResult = await addToHistoryUseCase.call(movieForHistory);

              historyResult.fold(
                    (_) => debugPrint('Failed to add movie to history.'), // Handle failure if needed
                    (_) => debugPrint('Movie "${movieData.title}" added to history.'), // Success confirmation
              );
            }


          },
    );
  }
}
