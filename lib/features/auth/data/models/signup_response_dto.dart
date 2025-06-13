import '../../domain/entities/signup_response_entity.dart';

class SignupSuccessResponseDto extends SignupSuccessResponseEntity {
  SignupSuccessResponseDto({
    super.message,
    super.data,
  });

  factory SignupSuccessResponseDto.fromJson(Map<String, dynamic> json) {
    return SignupSuccessResponseDto(
      message: json['message'] ?? "" ?? "",
    );
  }
}

class SignupErrorResponseDto extends SignupErrorResponseEntity {
  SignupErrorResponseDto({
    super.error,
    super.statusCode,
    super.message,
  });

  factory SignupErrorResponseDto.fromJson(Map<String, dynamic> json) {
    return SignupErrorResponseDto(
      error: json['error'] ?? "",
      statusCode: json['statusCode'] ?? "",
      message: json['message'] ?? "",
    );
  }
}


class UserDataDto extends UserDataEntity {
  UserDataDto({
    super.email,
    super.password,
    super.name,
    super.phone,
    super.avaterId,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.v,
  });

  factory UserDataDto.fromJson(Map<String, dynamic> json) {
    return UserDataDto(
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      name: json['name'] ?? "",
      phone: json['phone'] ?? "",
      avaterId: json['avaterId'] ?? "",
      id: json['_id'] ?? "",
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      v: json['__v'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'avaterId': avaterId,
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}
