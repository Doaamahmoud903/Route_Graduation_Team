import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/data/repository/home_repository.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeRepository _repository;

  HomeCubit(this._repository) : super(HomeInitial());

  void fetchMovies() async {
  emit(HomeLoading());
  try {
    final movies = await _repository.getAllMovies(); 
    emit(HomeSuccess(movies));
  } catch (e) {
    emit(HomeFailure(e.toString()));
  }
}
}
