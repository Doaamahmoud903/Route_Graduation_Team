import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/account/presentation/manager/reset_pass_edit_profile/reset_pass_edit_profile_states.dart';

import '../../../../../core/cach_helper/cach_helper.dart';
import '../../../../../core/utils/toast_utils.dart';
import '../../../../auth/domain/repository/auth_respository.dart';

@injectable
class ResetPasswordEditProfileViewModel
    extends Cubit<ResetPassEditProfileStates> {
  final AuthRepository authRepository;
  final CacheHelper cacheHelper;

  ResetPasswordEditProfileViewModel({
    required this.authRepository,
    required this.cacheHelper,
  }) : super(ResetPassInitialState());

  Future<void> resetPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(ResetPassLoadingState());
    try {
      final token = await cacheHelper.getData("token"); // Fetch token
      if (token == null) {
        emit(
          ResetPassErrorState(
            errorMessage:
                'Authentication token not found. Please log in again.',
          ),
        );
        ToastUtils.showErrorToast(
          'Authentication token not found. Please log in again.',
        );
        return;
      }

      final result = await authRepository.resetPassword(
        oldPassword,
        newPassword,
        token,
      );

      result.fold(
        (failure) {
          emit(ResetPassErrorState(errorMessage: failure.errMessage));
          ToastUtils.showErrorToast(failure.errMessage);
        },
        (userResponseEntity) {
          emit(
            ResetPassSuccessState(
              message:
                  userResponseEntity.message ?? 'Password reset successfully!',
            ),
          );
          ToastUtils.showSuccessToast(
            userResponseEntity.message ?? 'Password reset successfully!',
          );
        },
      );
    } catch (e) {
      e.toString();
    }
  }
}
