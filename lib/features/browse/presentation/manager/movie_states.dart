import 'package:movie_app/features/browse/data/models/movie_response.dart';

abstract class MovieState{}

class MovieIntialState extends MovieState{}

class MovieLoading extends MovieState{}

class MovieSuccess extends MovieState{
  final MovieResponse movieList;
  MovieSuccess(this.movieList);
}
class MovieFaluire extends MovieState{
  final String errorMessage;
  MovieFaluire(this.errorMessage);
}