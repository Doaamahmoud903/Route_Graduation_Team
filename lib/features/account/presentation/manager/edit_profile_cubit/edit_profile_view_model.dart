import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';
import '../../../../../core/services/secure_storage.dart';
import '../../../../../core/utils/toast_utils.dart';
import '../../../data/models/ProfileResponse.dart';
import '../../../data/repository/profile_repository.dart';
import 'edit_profile_states.dart';

@injectable
class EditProfileViewModel extends Cubit<EditProfileStates> {
  final ProfileRepository profileRepository;
  final ProfileResponse? initialProfileData;
  final SecureStorage secureStorage;

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;

  EditProfileViewModel({
    required this.profileRepository,
    @factoryParam this.initialProfileData,
    required this.secureStorage,
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
    emit(EditProfileLoadingStates()); // Corrected to singular state
    try {
      final updatedProfile = await profileRepository.updateProfile(
        name: name,
        phone: phone,
        email: email,
        avaterId: avaterId,
      );
      emit(EditProfileSuccessStates(message: 'Profile updated successfully!', updatedProfile: updatedProfile)); // Corrected to singular state
      // ToastUtils.showSuccessToast is often better triggered from the UI listener
      // but if you want it here as well, it's fine.
    } catch (e) {
      debugPrint('Error in EditProfileViewModel.updateProfile: $e');
      final errorMessage = e.toString().contains('Exception:')
          ? e.toString().replaceFirst('Exception: ', '')
          : 'Failed to update profile: ${e.toString()}';
      emit(EditProfileErrorStates(errorMessage: errorMessage)); // Corrected to singular state
      ToastUtils.showErrorToast(errorMessage);
    }
  }

  Future<void> deleteProfile() async {
    emit(ProfileDeleteLoadingStates()); // Corrected to singular state
    try {
      final response = await profileRepository.deleteProfile();
      if (response['status'] == true) { // Assuming 'status' is a boolean
        await secureStorage.deleteToken();
        emit(ProfileDeleteSuccessStates(message: response['message'] ?? 'Profile deleted successfully!')); // Corrected to singular state
      } else {
        throw Exception(response['message'] ?? 'Failed to delete profile.');
      }
    } catch (e) {
      debugPrint('Error in EditProfileViewModel.deleteProfile: $e');
      final errorMessage = e.toString().contains('Exception:')
          ? e.toString().replaceFirst('Exception: ', '')
          : 'Failed to delete profile: ${e.toString()}';
      emit(ProfileDeleteErrorStates(errorMessage: errorMessage)); // Corrected to singular state
      ToastUtils.showErrorToast(errorMessage);
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose(); // Dispose email controller
    return super.close();
  }
}