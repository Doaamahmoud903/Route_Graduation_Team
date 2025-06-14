import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie_details/domain/repository/favourite/favourite_respository.dart';

@injectable
class GetAllFavUseCase{
  final FavouriteRespository favouriteRespository;
  GetAllFavUseCase(this.favouriteRespository);

  call(String token){
    return favouriteRespository.getAllFav(token);
  }

}