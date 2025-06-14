import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/movie_details/domain/entities/favourite_response_entity.dart';

abstract class FavouriteRespository{
  Future<Either<Failure , FavouriteResponseEntity>> addToFav(String token ,String movieId,String name,double rating,String imageURL,String year);
  Future<Either<Failure , FavouriteResponseEntity>> getAllFav(String token);
  Future<Either<Failure , DelFavouriteResponseEntity>> delMovieFromFav(String token ,String movieId);
  Future<Either<Failure , DelFavouriteResponseEntity>> isFav(String token ,String movieId);
}