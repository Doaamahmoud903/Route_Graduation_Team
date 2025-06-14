import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie_details/domain/repository/favourite/favourite_respository.dart';

@injectable
class DelFromFavUseCase{
  final FavouriteRespository favouriteRespository;
  DelFromFavUseCase(this.favouriteRespository);

  call(String token ,String movieId){
    return favouriteRespository.delMovieFromFav(token ,movieId);
  }

}