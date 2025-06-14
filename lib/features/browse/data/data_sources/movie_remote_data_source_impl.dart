import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/api/api_constant.dart';
import 'package:movie_app/core/api/api_services.dart';
import 'package:movie_app/features/browse/data/models/movie_response.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/model/api_error_model.dart';
import 'movie_remote_data_source.dart';
import 'package:dartz/dartz.dart';


@Injectable(as: MovieRemoteDataSource)
class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiService apiService;

  MovieRemoteDataSourceImpl(this.apiService);

  @override
  Future<Either<Failure, MovieResponse?>> getMovie({Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await apiService.get(
        endPoint: ApiConstant.movieList,
        queryParameters: queryParameters,
      );
      final movieResponse = MovieResponse.fromJson(response);
      return right(movieResponse);
    } catch (error) {
      if (error is DioException) {
        return left(
          ServerFailure.fromResponse(
            error.response?.statusCode,
            ApiErrorResponse.fromJson(error.response?.data),
          ),
        );
      } else {
        return left(ServerFailure('Something went wrong ${error.toString()}'));
      }
    }
  }
}


class MovieOfflineDataSourceImpl extends MovieOfflineDataSource{
}