import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_states.dart';
import 'package:flutter/foundation.dart'; // Import for debugPrint
import '../../../../../core/services/secure_storage.dart';
import '../../../../../core/utils/toast_utils.dart';
import '../../../data/models/ProfileResponse.dart';
import '../../../data/repository/profile_repository.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileStates>{
  final ProfileRepository profileRepository; // Made final
  final SecureStorage secureStorage; // Made final
  ProfileViewModel({required this.profileRepository, required this.secureStorage}): super(ProfileInitialStates()); // Corrected to singular state

  Future<void> getProfileData() async {
    emit(ProfileLoadingStates()); // Corrected to singular state

    try {
      final userProfile = await profileRepository.getProfile();
      emit(ProfileSuccessStates(profileResponse: userProfile));
    } catch (e) {
      debugPrint('Error in ProfileViewModel.getProfileData: $e');
      final errorMessage = e.toString().contains('Exception:')
          ? e.toString().replaceFirst('Exception: ', '')
          : 'Failed to fetch profile: ${e.toString()}';

      // Specific handling for 401 or token-related errors
      if (e.toString().contains('401') || e.toString().contains('token not found')) {
        // If a 401 happens, it means the user's token is invalid or missing.
        // You should log them out and redirect to login screen.
        await secureStorage.deleteToken(); // Clear invalid token
        ToastUtils.showErrorToast('Session expired. Please log in again.');
        // Optionally, emit a state like ProfileUnauthorizedState to trigger navigation
        // For now, let the error state handle it, and the UI will then navigate
        // (or you can add a listener for a new specific state if you prefer).
      }
      emit(ProfileErrorStates(errorMessage: errorMessage));
      // ToastUtils.showErrorToast(errorMessage); // Already handled in listener or if you want it duplicated
    }
  }

  Future<void> logout() async {
    try {
      await secureStorage.deleteToken();
      ToastUtils.showSuccessToast('Logged out successfully!');
      // Consider emitting a state here, e.g., emit(ProfileLoggedOutState());
      // if you want to drive navigation purely from the ViewModel's state.
    } catch (e) {
      debugPrint('Error in ProfileViewModel.logout: $e'); // Added debugPrint
      ToastUtils.showErrorToast('Logout failed: ${e.toString()}');
    }
  }
}