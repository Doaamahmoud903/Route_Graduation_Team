import 'package:injectable/injectable.dart';
import 'package:movie_app/features/auth/domain/repository/auth_respository.dart';

@injectable
class SignupUseCase {
  final AuthRepository authRepository;
  SignupUseCase(this.authRepository);

  invoke(
      String name,
      String email,
      String password,
      String confirmPassword,
      String phone,
      int avaterId,
      ){
    return authRepository.signUp(name, email, password, confirmPassword, phone, avaterId);
  }

}