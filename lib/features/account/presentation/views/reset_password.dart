import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/widgets/custom_button.dart';
import 'package:movie_app/l10n/app_localizations.dart';

import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/styles_manager.dart';
import '../manager/reset_pass_edit_profile/reset_pass_edit_profile_states.dart';
import '../manager/reset_pass_edit_profile/reset_pass_edit_profile_view_model.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String resetPasswordRoute = 'resetPasswordScreen';

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ResetPasswordEditProfileViewModel>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Reset Password')),
        body: BlocConsumer<
          ResetPasswordEditProfileViewModel,
          ResetPassEditProfileStates
        >(
          listener: (context, state) {
            if (state is ResetPassSuccessState) {
              Navigator.pop(context);
            } else if (state is ResetPassErrorState) {}
          },
          builder: (context, state) {
            final viewModel =
                BlocProvider.of<ResetPasswordEditProfileViewModel>(context);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Old Password Field
                    TextFormField(
                      controller: _oldPasswordController,
                      cursorColor: ColorManager.orangeColor,
                      obscureText: true,
                      // Hide text
                      decoration: InputDecoration(
                        hintText: 'Current Password',
                        hintStyle: Styles.textStyle20w4White,
                        prefixIcon: const Icon(Icons.lock),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: ColorManager.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: ColorManager.grey),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: ColorManager.grey),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: ColorManager.redColor),
                        ),
                        fillColor: ColorManager.grey,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your current password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // New Password Field
                    TextFormField(
                      controller: _newPasswordController,
                      cursorColor: ColorManager.orangeColor,
                      obscureText: true,
                      // Hide text
                      decoration: InputDecoration(
                        hintText: 'New Password',
                        hintStyle: Styles.textStyle20w4White,
                        prefixIcon: const Icon(Icons.lock_open),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: ColorManager.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: ColorManager.grey),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: ColorManager.grey),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: ColorManager.redColor),
                        ),
                        fillColor: ColorManager.grey,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a new password.';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long.';
                        }
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Password must contain at least one uppercase letter.';
                        }
                        if (!value.contains(RegExp(r'[a-z]'))) {
                          return 'Password must contain at least one lowercase letter.';
                        }
                        if (!value.contains(RegExp(r'[0-9]'))) {
                          return 'Password must contain at least one digit.';
                        }
                        if (!value.contains(
                          RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
                        )) {
                          return 'Password must contain at least one special character.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Confirm New Password Field
                    TextFormField(
                      controller: _confirmNewPasswordController,
                      cursorColor: ColorManager.orangeColor,
                      obscureText: true,
                      // Hide text
                      decoration: InputDecoration(
                        hintText: 'Confirm New Password',
                        hintStyle: Styles.textStyle20w4White,
                        prefixIcon: const Icon(Icons.lock_reset),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: ColorManager.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: ColorManager.grey),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: ColorManager.grey),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: ColorManager.redColor),
                        ),
                        fillColor: ColorManager.grey,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your new password';
                        }
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // Reset Password Button
                    CustomButton(
                      btnName: AppLocalizations.of(context)!.reset_password,
                      bgColor: ColorManager.orangeColor,
                      fgColor: ColorManager.orangeColor,
                      textColor: ColorManager.blackButtonColor,
                      onPressed:
                          state is ResetPassLoadingState
                              ? null // Disable button while loading
                              : () {
                                if (_formKey.currentState!.validate()) {
                                  viewModel.resetPassword(
                                    oldPassword: _oldPasswordController.text,
                                    newPassword: _newPasswordController.text,
                                  );
                                }
                              },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
