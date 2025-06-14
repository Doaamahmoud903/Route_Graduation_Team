import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/movie_details/data/data_sources/remote/favourite/favourite_remote_data_source.dart';
import 'package:movie_app/features/movie_details/data/data_sources/remote/favourite/impl/favourite_remote_data_source_impl.dart';
import 'package:movie_app/features/movie_details/domain/entities/favourite_response_entity.dart';
import 'package:movie_app/features/movie_details/domain/repository/favourite/favourite_respository.dart';

@Injectable(as: FavouriteRespository)
class FavouriteRespositoryImpl extends FavouriteRespository {
  final FavouriteRemoteDataSource favouriteRemoteDataSource;
  FavouriteRespositoryImpl(this.favouriteRemoteDataSource);

  @override
  Future<Either<Failure, FavouriteResponseEntity>> addToFav(String token, String movieId, String name, double rating, String imageURL, String year) async{
    return favouriteRemoteDataSource.addToFav(token ,movieId, name, rating, imageURL, year);
  }

  @override
  Future<Either<Failure, DelFavouriteResponseEntity>> delMovieFromFav(String token ,String movieId) async{
    return favouriteRemoteDataSource.delMovieFromFav(token ,movieId);
  }

  @override
  Future<Either<Failure, FavouriteResponseEntity>> getAllFav(String token) async{
    return favouriteRemoteDataSource.getAllFav(token);
  }

  @override
  Future<Either<Failure, DelFavouriteResponseEntity>> isFav(String token,String movieId) async{
   return favouriteRemoteDataSource.isFav(token ,movieId);
  }

}