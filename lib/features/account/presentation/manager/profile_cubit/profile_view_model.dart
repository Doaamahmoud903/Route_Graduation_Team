import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_states.dart';

import '../../../../../core/cach_helper/cach_helper.dart';
import '../../../../../core/utils/toast_utils.dart';
import '../../../data/repository/profile_repository.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileStates>{
  final ProfileRepository profileRepository;
  final CacheHelper cacheHelper;

  ProfileViewModel({required this.profileRepository, required this.cacheHelper})
    : super(ProfileInitialStates());

  Future<void> getProfileData() async {
    emit(ProfileLoadingStates());

    try {
      final userProfile = await profileRepository.getProfile();
      emit(ProfileSuccessStates(profileResponse: userProfile));
    } catch (e) {
      debugPrint('Error in ProfileViewModel.getProfileData: $e');
      final errorMessage = e.toString().contains('Exception:')
          ? e.toString().replaceFirst('Exception: ', '')
          : 'Failed to fetch profile: ${e.toString()}';

      if (e.toString().contains('401') ||
          e.toString().contains('token not found') ||
          e.toString().contains('unauthorized')) {
        await cacheHelper.removeData("token");
        ToastUtils.showErrorToast('Session expired. Please log in again.');
      }
      emit(ProfileErrorStates(errorMessage: errorMessage));
    }
  }

  Future<void> logout() async {
    try {
      await cacheHelper.removeData("token");
      ToastUtils.showSuccessToast('Logged out successfully!');
    } catch (e) {
      debugPrint('Error in ProfileViewModel.logout: $e');
      ToastUtils.showErrorToast('Logout failed: ${e.toString()}');
    }
  }
}
