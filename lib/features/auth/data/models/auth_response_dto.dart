import '../../domain/entities/auth_response_entity.dart';

class UserResponseDto extends UserResponseEntity {
  UserResponseDto({
    super.message,
    super.data,
    super.statusCode,
    super.error
  });

  factory UserResponseDto.fromJson(Map<String, dynamic> json) {

    return UserResponseDto(
      message:  json['message'],
      data: json['data'],
      statusCode: json['statusCode'],
      error: json['error'],
    );
  }
}

