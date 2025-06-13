import 'package:movie_app/features/auth/domain/entities/auth_response_entity.dart';

abstract class ResetPasswordStates{}
class ResetPasswordIntState extends ResetPasswordStates{}
class ResetPasswordLoadingState extends ResetPasswordStates{}

class ResetPasswordSuccessState extends ResetPasswordStates{
  final UserResponseEntity userResponseEntity;
  ResetPasswordSuccessState(this.userResponseEntity);
}

class ResetPasswordFailureState extends ResetPasswordStates{
  final String errorMsg;
  ResetPasswordFailureState(this.errorMsg);
}
