import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie_details/data/data_sources/remote/movie_details/movie_details_remote_data_source.dart';
import 'package:movie_app/features/movie_details/data/models/movie_details_response.dart';
import 'package:movie_app/features/movie_details/domain/repository/movie_details/movie_repository.dart';
import '../../../../../core/errors/failure.dart';


@Injectable(as: MovieDetailsRepository)
class MovieDetailsRepositoryImpl extends MovieDetailsRepository {
    final MovieDetailsRemoteDataSource movieDetailsRemote;
    MovieDetailsRepositoryImpl({required this.movieDetailsRemote});

    @override
    Future<Either<Failure, MovieDetailsResponse>> getMovieDetails(int movieId){
      return movieDetailsRemote.getMovieDetails(movieId);
    }
}