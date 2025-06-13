import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/utils/toast_utils.dart';
import 'package:movie_app/core/utils/validators.dart';
import 'package:movie_app/features/auth/domain/usecases/signup_use_case.dart';
import 'package:movie_app/features/auth/presentation/manager/signup/signup_states.dart';

@injectable
class SignupViewModel extends Cubit<SignupStates>{
  SignupUseCase signupUseCase;
  SignupViewModel({required this.signupUseCase}):super(SignupIntState());
  final emailController = TextEditingController(text: "dodoo@gmail.com");
  final passwordController = TextEditingController(text: "Dodo0123@");
  final rePasswordController = TextEditingController(text: "Dodo0123@");
  final nameController = TextEditingController(text: "Dodo");
  final phoneController = TextEditingController(text: "+201141209334");
  var formKey = GlobalKey<FormState>();
  int avatarId = 1;

  void updateAvatarId(int? id) {
    avatarId = id ?? 1;
    emit(SignupAvatarChangedState(avatarId));
  }

  Future<void> signUp() async{
    if(formKey.currentState?.validate() == true){
       emit(SignupLoadingState());
      final nameError = Validators.validateName(nameController.text);
      final emailError = Validators.validateEmail(emailController.text);
      final passwordError = Validators.validatePassword(passwordController.text);
      final rePasswordError = Validators.validateConfirmPassword(rePasswordController.text,
          passwordController.text);
      final phoneError = Validators.validatePhone(phoneController.text);
      if (nameError != null) {
        ToastUtils.showErrorToast(nameError);
      } else if (emailError != null) {
        ToastUtils.showErrorToast(emailError);
      } else if (passwordError != null) {
        ToastUtils.showErrorToast(passwordError);
      } else if (rePasswordError != null) {
        ToastUtils.showErrorToast(rePasswordError);
       }
        // else if (phoneError != null) {
      //   ToastUtils.showErrorToast(phoneError);
      // }
       else {
        final response = await signupUseCase.invoke(
            nameController.text,
            emailController.text,
            passwordController.text,
            rePasswordController.text,
            phoneController.text,
            avatarId);
        print(response);
        response.fold(
              (failure) => emit(SignupFailureState(failure.errMessage)),
              (user) => emit(SignupSuccessState(user)),
        );

      }
    
    
    }}
}