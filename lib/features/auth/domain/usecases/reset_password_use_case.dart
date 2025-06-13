import 'package:injectable/injectable.dart';
import '../repository/auth_respository.dart';

@injectable
class ResetPasswordUseCase{
  final AuthRepository authRepository;

  ResetPasswordUseCase(this.authRepository);
  invoke( String oldPassword, String newPassword,String token){
    return authRepository.resetPassword(oldPassword, newPassword , token);
  }

}