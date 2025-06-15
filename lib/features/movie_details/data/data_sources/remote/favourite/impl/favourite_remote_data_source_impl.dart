import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/api/api_constant.dart';
import 'package:movie_app/core/api/api_services.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/movie_details/data/data_sources/remote/favourite/favourite_remote_data_source.dart';
import 'package:movie_app/features/movie_details/data/models/favourite_response_dto.dart';
import '../../../../../../../core/cach_helper/cach_helper.dart';
import '../../../../../../../core/errors/model/api_error_model.dart';

@Injectable(as: FavouriteRemoteDataSource )
class FavouriteRemoteDataSourceImpl extends FavouriteRemoteDataSource{
final ApiService apiService;
  FavouriteRemoteDataSourceImpl(this.apiService);

  @override
  Future<Either<Failure, FavouriteResponseDto>> addToFav(String token, String movieId, String name, double rating, String imageURL, String year) async{
    try {
      final token = await CacheHelper().getData("token");
      final response = await apiService.post(
        baseUrl: ApiConstant.baseUrlPostman,
          endPoint: ApiConstant.addToFav,
          data:{
            "movieId": movieId,
            "name": name,
            "rating": rating,
            "imageURL": imageURL,
            "year": year
          },token: token
      );
      print(response);
      return right(FavouriteResponseDto.fromJson(response));

    }catch(error){
      if (error is DioException) {
        return Left(
            ServerFailure.fromResponse(
                error.response?.statusCode,
                ApiErrorResponse.fromJson(error.response?.data)
            )
        );
      } else {
        return left(ServerFailure('Something went wrong ${error.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, DelFavouriteResponseDto>> delMovieFromFav(String token,String movieId) async{
    try {
        final response = await apiService.delete(
            baseUrl: ApiConstant.baseUrlPostman,
            endPoint: ApiConstant.removeFromFav(movieId),
          token: token
        );
        print(response);
        return right(DelFavouriteResponseDto.fromJson(response));

    }catch(error){
      if (error is DioException) {
        return Left(
            ServerFailure.fromResponse(
                error.response?.statusCode,
                ApiErrorResponse.fromJson(error.response?.data)
            )
        );
      } else {
        return left(ServerFailure('Something went wrong ${error.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, FavouriteResponseDto>> getAllFav(String token) async{
    try {
      //if (await networkInfo.isConnected()) {
        final response = await apiService.get(
          baseUrl: ApiConstant.baseUrlPostman,
          endPoint: ApiConstant.getAllFav,
          token: token
        );
        print(response);
        return right(FavouriteResponseDto.fromJson(response));
      // } else{
      //   // NO Internet Connection
      //   return left(NetworkFailure("No Internet Connection"));
      // }
    }catch(error){
      if (error is DioException) {
        return Left(
            ServerFailure.fromResponse(
                error.response?.statusCode,
                ApiErrorResponse.fromJson(error.response?.data)
            )
        );
      } else {
        return left(ServerFailure('Something went wrong ${error.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, DelFavouriteResponseDto>> isFav(String token,String movieId) async{
    try {

        final response = await apiService.get(
          baseUrl: ApiConstant.baseUrlPostman,
          endPoint: ApiConstant.getIsFav(movieId),
          token: token
        );
        print(response);
        return right(DelFavouriteResponseDto.fromJson(response));

    }catch(error){
      if (error is DioException) {
        return Left(
            ServerFailure.fromResponse(
                error.response?.statusCode,
                ApiErrorResponse.fromJson(error.response?.data)
            )
        );
      } else {
        return left(ServerFailure('Something went wrong ${error.toString()}'));
      }
    }
  }
}