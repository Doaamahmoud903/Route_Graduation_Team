class SignupSuccessResponseEntity  {
  final String? message;
  final UserDataEntity? data;


  SignupSuccessResponseEntity ({ this.message, this.data});
}

class SignupErrorResponseEntity {
  final String? error;
  final int? statusCode;
  final List<String>? message;

  SignupErrorResponseEntity({this.error, this.statusCode, this.message});

}

class UserDataEntity {
  final String? email;
  final String? password;
  final String? name;
  final String? phone;
  final int? avaterId;
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  UserDataEntity({
    this.email,
    this.password,
    this.name,
    this.phone,
    this.avaterId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
}
