import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/cach_helper/cach_helper.dart';
import '../../../../../core/utils/toast_utils.dart';
import '../../../data/models/ProfileResponse.dart';
import '../../../data/repository/profile_repository.dart';
import 'edit_profile_states.dart';

@injectable
class EditProfileViewModel extends Cubit<EditProfileStates> {
  final ProfileRepository profileRepository;
  final ProfileResponse? initialProfileData;
  final CacheHelper cacheHelper;

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;

  EditProfileViewModel({
    required this.profileRepository,
    @factoryParam this.initialProfileData,
    required this.cacheHelper,
  }) : super(EditProfileInitialStates()) {
    nameController = TextEditingController(
      text: initialProfileData?.data?.name ?? '',
    );
    phoneController = TextEditingController(
      text: initialProfileData?.data?.phone ?? '',
    );
    emailController = TextEditingController(
      text: initialProfileData?.data?.email ?? '',
    );
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String email,
    required int avaterId,
  }) async {
    emit(EditProfileLoadingStates());
    try {
      String formattedPhone = phone;
      String digitsOnly = phone.replaceAll(RegExp(r'[^\d+]'), '');
      if (digitsOnly.startsWith('01') && digitsOnly.length == 11) {
        formattedPhone = '+20${digitsOnly.substring(1)}';
      } else if (digitsOnly.startsWith('+2001') && digitsOnly.length == 14) {
        formattedPhone = '+20${digitsOnly.substring(4)}';
      } else if (!digitsOnly.startsWith('+')) {
        if (digitsOnly.startsWith('0')) {
          formattedPhone = '+20${digitsOnly.substring(1)}';
        } else {
          formattedPhone = '+20$digitsOnly';
        }
      } else {
        formattedPhone = digitsOnly;
      }

      final updatedProfile = await profileRepository.updateProfile(
        name: name,
        phone: formattedPhone,
        email: email,
        avaterId: avaterId,
      );
      emit(EditProfileSuccessStates(message: 'Profile updated successfully!',
          updatedProfile: updatedProfile));
      ToastUtils.showSuccessToast('Profile updated successfully!');
    } catch (e) {
      debugPrint('Error in EditProfileViewModel.updateProfile: $e');
      final errorMessage = e.toString().contains('Exception:')
          ? e.toString().replaceFirst('Exception: ', '')
          : 'Failed to update profile: ${e.toString()}';
      emit(EditProfileErrorStates(errorMessage: errorMessage));
      ToastUtils.showErrorToast(errorMessage);
    }
  }

  Future<void> deleteProfile() async {
    emit(ProfileDeleteLoadingStates());
    try {
      final response = await profileRepository.deleteProfile();
      if (response['status'] == true) {
        await cacheHelper.removeData("token");
        emit(ProfileDeleteSuccessStates(
            message: response['message'] ?? 'Profile deleted successfully!'));
        ToastUtils.showSuccessToast(
            response['message'] ?? 'Profile deleted successfully!');
      } else {
        throw Exception(response['message'] ?? 'Failed to delete profile.');
      }
    } catch (e) {
      debugPrint('Error in EditProfileViewModel.deleteProfile: $e');
      final errorMessage = e.toString().contains('Exception:')
          ? e.toString().replaceFirst('Exception: ', '')
          : 'Failed to delete profile: ${e.toString()}';
      emit(ProfileDeleteErrorStates(errorMessage: errorMessage));
      ToastUtils.showErrorToast(errorMessage);
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    return super.close();
  }
}