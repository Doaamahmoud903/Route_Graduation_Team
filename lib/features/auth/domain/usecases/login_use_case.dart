import 'package:injectable/injectable.dart';

import '../repository/auth_respository.dart';


@injectable
class LoginUseCase{
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);
  invoke(String email, String password,){
    return authRepository.login(email, password);
  }
}