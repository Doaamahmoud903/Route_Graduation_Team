import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/browse/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/features/browse/data/repository/movie_repository.dart';
import '../../../../core/errors/failure.dart';
import '../models/movie_response.dart';


@Injectable(as: MovieRepository)
class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource movieRemote;
  MovieRepositoryImpl({required this.movieRemote});

  @override
  Future<Either<Failure, MovieResponse?>> getMovies({Map<String, dynamic>? queryParameters}) {
    return movieRemote.getMovie(queryParameters: queryParameters);
  }
}