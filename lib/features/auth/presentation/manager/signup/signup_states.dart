import 'package:movie_app/features/auth/data/models/auth_response_dto.dart';
import 'package:movie_app/features/auth/domain/entities/auth_response_entity.dart';

abstract class SignupStates{}
class SignupIntState extends SignupStates{}
class SignupLoadingState extends SignupStates{}

class SignupSuccessState extends SignupStates{
  final UserResponseEntity userResponseEntity;
  SignupSuccessState(this.userResponseEntity);
}

class SignupFailureState extends SignupStates{
  final List<String> errorMsg;
  SignupFailureState(this.errorMsg);
}

class SignupAvatarChangedState extends SignupStates{
  final int avatarId;
  SignupAvatarChangedState(this.avatarId);

}