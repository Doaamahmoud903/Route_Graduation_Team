import 'package:dartz/dartz.dart';
import 'package:movie_app/features/auth/domain/entities/signup_response_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/auth_response_entity.dart';

abstract class AuthRemoteDataSource{
  Future<Either<ServerFailure , SignupSuccessResponseEntity>> signUp(
      String name,
      String email,
      String password,
      String confirmPassword,
      String phone,
      int avaterId,
      );
  Future<Either<ServerFailure , UserResponseEntity>> login(
      String email,
      String password,
      );
  Future<Either<ServerFailure , UserResponseEntity>> resetPassword(
      String oldPassword,
      String newPassword,
      String token
      );
}