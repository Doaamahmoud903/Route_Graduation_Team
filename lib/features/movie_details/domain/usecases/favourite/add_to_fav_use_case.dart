import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie_details/domain/repository/favourite/favourite_respository.dart';

@injectable
class AddToFavUseCase{
  final FavouriteRespository favouriteRespository;
  AddToFavUseCase(this.favouriteRespository);

  call(String token ,String movieId,String name,double rating,String imageURL,String year){
    return favouriteRespository.addToFav(token ,movieId, name, rating, imageURL, year);
  }

}