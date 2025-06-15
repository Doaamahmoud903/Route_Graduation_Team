import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/features/auth/presentation/manager/login/login_states.dart';
import 'package:movie_app/features/auth/presentation/manager/login/login_view_model.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import '../../../../../core/theming/color_manager.dart';
import '../../../../../core/utils/toast_utils.dart';

void showLogoutDialog(BuildContext context) {
    LoginViewModel logoutViewModel = getIt<LoginViewModel>();

  showDialog(
    context: context,
    builder: (context) => BlocProvider.value(
      value: logoutViewModel,
      child: BlocConsumer<LoginViewModel, LoginStates>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pop(context);
            Navigator.of(context).pushReplacementNamed(AppRoutes.loginRoute);
          } else if (state is LogoutFailure) {
            ToastUtils.showErrorToast(state.error);
          }
        },
        builder: (context, state) {
          return AlertDialog(
            backgroundColor: ColorManager.grey,
            title: Text(AppLocalizations.of(context)!.logout),
            content: Text(AppLocalizations.of(context)!.logout_ques),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              TextButton(
                onPressed: () {
                  logoutViewModel.logout();
                },
                child: Text(
                  AppLocalizations.of(context)!.logout,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
