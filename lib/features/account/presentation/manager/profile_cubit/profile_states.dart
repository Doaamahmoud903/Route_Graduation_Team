import 'package:movie_app/features/account/data/models/ProfileResponse.dart';

abstract class ProfileStates{}
class ProfileInitialStates extends ProfileStates {}

class ProfileLoadingStates extends ProfileStates {}
class ProfileSuccessStates extends ProfileStates {
  ProfileResponse profileResponse;
  ProfileSuccessStates({required this.profileResponse});
}
class ProfileErrorStates extends ProfileStates {
  String errorMessage;
  ProfileErrorStates({required this.errorMessage});
}

