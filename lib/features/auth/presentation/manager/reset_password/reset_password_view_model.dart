import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:movie_app/features/auth/presentation/manager/reset_password/reset_password_states.dart';

@injectable
class ResetPasswordViewModel extends Cubit<ResetPasswordStates>{
  final emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  ResetPasswordUseCase resetPasswordUseCase;
  ResetPasswordViewModel({required this.resetPasswordUseCase}):super(ResetPasswordIntState());
  Future<void>resetPassword( String oldPassword , String newPassword , String token) async{
    emit(ResetPasswordIntState());
    emit(ResetPasswordLoadingState());

    final response =await resetPasswordUseCase.invoke(oldPassword, newPassword, token);

    response.fold(
        (failure) => emit(ResetPasswordFailureState(failure.errorMessage)),
          (user) => emit(ResetPasswordSuccessState(user))
    );
  }
}