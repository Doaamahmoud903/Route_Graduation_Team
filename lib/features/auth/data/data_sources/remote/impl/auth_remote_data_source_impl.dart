import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/api/api_constant.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:movie_app/features/auth/data/models/auth_response_dto.dart';
import 'package:movie_app/features/auth/data/models/signup_response_dto.dart';
import '../../../../../../core/api/api_services.dart';
import '../../../../../../core/errors/model/api_error_model.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final ApiService apiService;
  AuthRemoteDataSourceImpl(this.apiService);

  // Login
  @override
  Future<Either<ServerFailure, UserResponseDto>> login(String email, String password) async{
    try{
      final response = await apiService.post(
        baseUrl: ApiConstant.baseUrlPostman,
        endPoint: ApiConstant.login,
        data: {
          "email" : email,
          "password" : password,
        },
      );
      final userResponseDto = UserResponseDto.fromJson(response);
      return right(userResponseDto);
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


  // Reset Password
  @override
  Future<Either<ServerFailure, UserResponseDto>> resetPassword(
      String oldPassword,
      String newPassword,
      String token
      ) async{
    try{
      final response = await apiService.put(
          baseUrl: ApiConstant.baseUrlPostman,
          endPoint: ApiConstant.resetPassword,
          data: {
            "oldPassword" : oldPassword,
            "newPassword" : newPassword
          },
        token: token
      );
      final userResponse = UserResponseDto.fromJson(response);
      return right(userResponse);
    }catch(error){
      if(error is DioException){
        return left(ServerFailure.fromResponse(
            error.response?.statusCode,
            ApiErrorResponse.fromJson(error.response?.data)
        ));

      }else {
        return left(ServerFailure('Something went wrong ${error.toString()}'));
      }
    }
  }


  // Register
  @override
  Future<Either<ServerFailure, SignupSuccessResponseDto>> signUp(
      String name, String email,
      String password, String confirmPassword,
      String phone, int avaterId) async{
   try{
     final response = await apiService.post(
         baseUrl: ApiConstant.baseUrlPostman,
         endPoint: ApiConstant.signup,
         data: {
           "name" : name,
           "email" : email,
           "password" : password,
           "confirmPassword" : confirmPassword,
           "phone" : phone,
           "avaterId" : avaterId
         },
     );
     final userResponseDto = SignupSuccessResponseDto.fromJson(response);
     return right(userResponseDto);


  }catch(error){
     if (error is DioException) {
       final errorData = SignupErrorResponseDto.fromJson(error.response!.data);
        return Left(ServerFailure(errorData.message?.join("\n") ?? "Unknown error"));
     }else {
       return left(ServerFailure('Something went wrong ${error.toString()}'));
     }
   }
  
}
}