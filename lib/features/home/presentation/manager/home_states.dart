import 'package:movie_app/features/home/data/models/home_response.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeSuccess extends HomeStates {
  final List<Movie> movies;
  HomeSuccess(this.movies);
}

class HomeFailure extends HomeStates {
  final String errorMessage;
  HomeFailure(this.errorMessage);
}
