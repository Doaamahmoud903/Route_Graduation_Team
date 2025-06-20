import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie_details/domain/repository/favourite/favourite_respository.dart';

import '../../../../../core/errors/failure.dart';
import '../../entities/all_favourites_response_entity.dart';

@injectable
class GetAllFavUseCase{
  final FavouriteRespository favouriteRespository;
  GetAllFavUseCase(this.favouriteRespository);

  Future<Either<Failure, AllFavouritesResponseEntity>> call(String token) async {
    return favouriteRespository.getAllFav(token);
  }

}
