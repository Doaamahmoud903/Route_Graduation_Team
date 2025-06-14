import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie_details/domain/repository/favourite/favourite_respository.dart';

@injectable
class IsFavUseCase{
  final FavouriteRespository favouriteRespository;
  IsFavUseCase(this.favouriteRespository);

  call(String token ,String movieId){
    return favouriteRespository.isFav(token ,movieId);
  }

}