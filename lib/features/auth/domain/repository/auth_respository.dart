import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failure.dart';

import '../entities/auth_response_entity.dart';
import '../entities/signup_response_entity.dart';

abstract class AuthRepository{
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
    String token,
  );
}