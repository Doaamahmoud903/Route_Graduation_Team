import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie_details/domain/usecases/favourite/add_to_fav_use_case.dart';
import 'package:movie_app/features/movie_details/domain/usecases/favourite/del_from_fav_use_case.dart';
import 'package:movie_app/features/movie_details/domain/usecases/favourite/is_fav_use_case.dart';
import 'package:movie_app/features/movie_details/presentation/manager/favourite/favourite_states.dart';
import '../../../../../core/cach_helper/cach_helper.dart';

@injectable
class FavouriteViewModel extends Cubit<FavouriteStates> {
  final AddToFavUseCase addToFavUseCase;
  final DelFromFavUseCase delFromFavUseCase;
  final IsFavUseCase isFavUseCase;

  bool isMovieFav = false;

  FavouriteViewModel(
      this.addToFavUseCase,
      this.delFromFavUseCase,
      this.isFavUseCase,
      ) : super(FavouriteInit());

  Future<void> addToFav(String movieId, String name, double rating, String imageURL, String year) async {
    emit(FavouriteLoading());
    final token = await CacheHelper().getData("token");
    print(isMovieFav);
    if (isMovieFav == true) {
      await delFromFav(movieId);
    } else {
      final response = await addToFavUseCase.call(token, movieId, name, rating, imageURL, year);
      response.fold(
            (failure) => emit(FavouriteFaliure(failure.errMessage)),
            (data) {
          isMovieFav = true;
          emit(FavouriteSuccessGeneral(data, isMovieFav));
        },
      );
    }
  }

  Future<void> delFromFav(String movieId) async {
    emit(FavouriteLoading());
    final token = await CacheHelper().getData("token");
    final response = await delFromFavUseCase.call(token, movieId);
    response.fold(
          (failure) {
        isMovieFav = true;
        emit(FavouriteFaliure(failure.errMessage));
      },
          (data) {
        isMovieFav = false;
        emit(FavouriteSuccessSub(data, isMovieFav));
      },
    );
  }

  Future<void> isFav(String movieId) async {
    emit(FavouriteLoading());
    final token = await CacheHelper().getData("token");
    final response = await isFavUseCase.call(token, movieId);
    response.fold(
          (failure) => emit(FavouriteFaliure(failure.errMessage)),
          (data) {
        isMovieFav = data.data;
        emit(FavouriteSuccessSub(data, isMovieFav));
      },
    );
  }

}
