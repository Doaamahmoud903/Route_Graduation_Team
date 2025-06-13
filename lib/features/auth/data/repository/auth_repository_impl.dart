import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:movie_app/features/auth/domain/entities/auth_response_entity.dart';
import 'package:movie_app/features/auth/domain/repository/auth_respository.dart';

import '../../domain/entities/signup_response_entity.dart';


@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<ServerFailure, UserResponseEntity>> login(String email, String password) async{
    final response = await authRemoteDataSource.login(email, password);

   return response.fold(
          (failure) => left(failure),
          (user) => right(user),
    );
  }

  @override
  Future<Either<ServerFailure, UserResponseEntity>> resetPassword(String oldPassword, String newPassword ,String token) async{
    final response = await authRemoteDataSource.resetPassword(oldPassword, newPassword, token);
    return response.fold(
          (failure) => left(failure),
          (user) => right(user),
    );
  }

  @override
  Future<Either<ServerFailure, SignupSuccessResponseEntity>> signUp(String name, String email, String password, String confirmPassword, String phone, int avaterId) async{
    final response = await authRemoteDataSource.signUp(name, email, password, confirmPassword, phone, avaterId);
    return response.fold(
          (failure) => left(failure),
          (user) => right(user),
    );
  }
  
}