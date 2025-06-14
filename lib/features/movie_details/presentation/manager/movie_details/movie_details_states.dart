import 'package:movie_app/features/movie_details/data/models/movie_details_response.dart';
import '../../../../browse/data/models/movie_response.dart';

abstract class MovieDetailsState{}

class MovieDetailsIntialState extends MovieDetailsState{}

class MovieDetailsLoading extends MovieDetailsState{}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsResponse movieList;
  final List<Movie> similarMovies;
  MovieDetailsSuccess(this.movieList, this.similarMovies);
}

class MovieDetailsFaluire extends MovieDetailsState{
  final String errorMessage;
  MovieDetailsFaluire(this.errorMessage);
}