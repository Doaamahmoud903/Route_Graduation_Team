import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/api/api_constant.dart';
import 'package:movie_app/core/api/api_services.dart';
import 'package:dartz/dartz.dart';
import '../../../../../../../core/errors/failure.dart';
import '../../../../../../../core/errors/model/api_error_model.dart';
import '../../../../models/movie_details_response.dart';
import '../movie_details_remote_data_source.dart';


@Injectable(as: MovieDetailsRemoteDataSource)
class MovieDetailsRemoteDataSourceImpl extends MovieDetailsRemoteDataSource {
  final ApiService apiService;
  MovieDetailsRemoteDataSourceImpl(this.apiService);

  @override
  Future<Either<Failure, MovieDetailsResponse>> getMovieDetails(int movieId) async{
    try{
        final response = await apiService.get(
            endPoint: ApiConstant.movieDetails,
            queryParameters:{
              "movie_id" : movieId,
              "with_images" : true,
              "with_cast" : true
            },
        );
        final movieDetailsResponse = MovieDetailsResponse.fromJson(response);
        return right(movieDetailsResponse);
    }catch(error){
      if (error is DioException) {
        return left(
            ServerFailure.fromResponse(
                error.response?.statusCode,
                ApiErrorResponse.fromJson(error.response?.data)
            )
        );
      }else {
        return left(ServerFailure('Something went wrong ${error.toString()}'));
      }
    }
  }

}


class MovieOfflineDataSourceImpl extends MovieDetailsOfflineDataSource{
}