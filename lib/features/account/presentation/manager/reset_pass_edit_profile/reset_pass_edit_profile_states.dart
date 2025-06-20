abstract class ResetPassEditProfileStates {}

class ResetPassInitialState extends ResetPassEditProfileStates {}

class ResetPassLoadingState extends ResetPassEditProfileStates {}

class ResetPassSuccessState extends ResetPassEditProfileStates {
  final String message;

  ResetPassSuccessState({required this.message});
}

class ResetPassErrorState extends ResetPassEditProfileStates {
  final String errorMessage;

  ResetPassErrorState({required this.errorMessage});
}
