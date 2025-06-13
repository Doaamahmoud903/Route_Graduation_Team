import '../../../data/models/ProfileResponse.dart';

abstract class EditProfileStates {}

class EditProfileInitialStates extends EditProfileStates {}

class EditProfileLoadingStates extends EditProfileStates {}

class EditProfileSuccessStates extends EditProfileStates {
  String message;
  ProfileResponse updatedProfile;
  EditProfileSuccessStates({required this.message, required this.updatedProfile});
}

class EditProfileErrorStates extends EditProfileStates {
  String errorMessage;
  EditProfileErrorStates({required this.errorMessage});
}

// Delete States
class ProfileDeleteLoadingStates extends EditProfileStates {}
class ProfileDeleteSuccessStates extends EditProfileStates {
  String message;
  ProfileDeleteSuccessStates({required this.message});
}
class ProfileDeleteErrorStates extends EditProfileStates {
  String errorMessage;
  ProfileDeleteErrorStates({required this.errorMessage});
}