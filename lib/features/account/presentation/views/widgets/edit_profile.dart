import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/core/theming/styles_manager.dart';
import 'package:movie_app/core/utils/assets_manager.dart';
import 'package:movie_app/core/widgets/custom_button.dart';
import 'package:movie_app/core/widgets/custom_text_field.dart';
import 'package:movie_app/features/account/presentation/manager/edit_profile_cubit/edit_profile_states.dart';
import 'package:movie_app/features/account/presentation/views/widgets/images.dart';
import 'package:movie_app/features/account/presentation/views/widgets/pick_avatar_widget.dart';
import 'package:movie_app/features/account/presentation/views/widgets/reset_password.dart';
import 'package:movie_app/features/auth/presentation/views/login_view.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../data/models/ProfileResponse.dart';
import '../../manager/edit_profile_cubit/edit_profile_view_model.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = "EditProfileScreen";

  final ProfileResponse currentUserProfileData;
  const EditProfile({super.key, required this.currentUserProfileData});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final EditProfileViewModel viewModel;
  late int selectedAvatarId;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    viewModel = getIt<EditProfileViewModel>(
      param1: widget.currentUserProfileData,
    );

    selectedAvatarId = widget.currentUserProfileData.data?.avaterId ?? 1;
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.edit_profile,
          style: Styles.textStyle16w4Orange,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorManager.orangeColor),
      ),
      body: BlocListener<EditProfileViewModel, EditProfileStates>(
        bloc: viewModel,
        listener: (context, state) {
          if (state is EditProfileLoadingStates ||
              state is ProfileDeleteLoadingStates) {
            DialogUtils.showLoading(context: context,
                message: AppLocalizations.of(context)!.loading);
          } else if (state is EditProfileErrorStates) {
            DialogUtils.hideLoading(context);
          } else if (state is EditProfileSuccessStates) {
            DialogUtils.hideLoading(context);
            Navigator.of(context).pop();
          } else if (state is ProfileDeleteSuccessStates) {
            DialogUtils.hideLoading(context);
            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginView()),
                    (route) => false,
              );
            });
          } else if (state is ProfileDeleteErrorStates) {
            DialogUtils.hideLoading(context);
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    radius: 70.r,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(Images.getAvatarPath(selectedAvatarId)),
                  ),
                  onTap: () async {
                    final int? selected = await showModalBottomSheet<int>(
                      backgroundColor: ColorManager.transparentColor,
                      elevation: 0,
                      context: context,
                      builder: (context) {
                        return PickAvatarWidget(currentSelectedAvatarId: selectedAvatarId);
                      },
                    );
                    if (selected != null) {
                      setState(() {
                        selectedAvatarId = selected;
                      });
                    }
                  },
                ),
                SizedBox(height: 30.h),

                CustomTextField(
                  controller: viewModel.nameController,
                  hintText: AppLocalizations.of(context)!.name,
                  typingColor: ColorManager.whiteColor,
                  prefixIcon: AssetManager.user,
                  prefixColor: ColorManager.whiteColor,
                  fillColor: ColorManager.grey,
                  borderColor: ColorManager.grey,
                  borderRadius: 15,
                  validator: (value) {
                    return Validators.validateName(value);
                  },
                ),
                SizedBox(height: 16.h),

                CustomTextField(
                  controller: viewModel.phoneController,
                  hintText: AppLocalizations.of(context)!.phone,
                  keyboardType: TextInputType.phone,
                  typingColor: ColorManager.whiteColor,
                  prefixIcon: AssetManager.phone,
                  prefixColor: ColorManager.whiteColor,
                  fillColor: ColorManager.grey,
                  borderColor: ColorManager.grey,
                  borderRadius: 15,
                  validator: (value) {
                    return Validators.validatePhone(value);
                  },
                ),
                SizedBox(height: 10.h),

                Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          ResetPasswordScreen.resetPasswordRoute);

                    },
                    child: Text(AppLocalizations.of(context)!.reset_password,
                        style: Styles.textStyle20w4White),
                  ),
                ),

                SizedBox(height: 240.h),

                CustomButton(
                  btnName: AppLocalizations.of(context)!.delete_account,
                  bgColor: ColorManager.redColor,
                  fgColor: ColorManager.redColor,
                  textColor: ColorManager.whiteColor,
                  borderSideColor: ColorManager.redColor,
                  onPressed: () {
                    _confirmDeleteDialog(context);

                  },
                ),
                SizedBox(height: 15.h),
                CustomButton(
                  btnName: AppLocalizations.of(context)!.update_data,
                  bgColor: ColorManager.orangeColor,
                  fgColor: ColorManager.orangeColor,
                  textColor: ColorManager.blackButtonColor,
                  onPressed: () {
                    if (formKey.currentState?.validate() == true &&
                        context.mounted) {
                      context.read<EditProfileViewModel>().updateProfile(
                        name: viewModel.nameController.text,
                        phone: viewModel.phoneController.text,
                        avaterId: selectedAvatarId,
                        email: viewModel.emailController.text,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDeleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: ColorManager.grey,
          title: Text('Confirm deletion', style: Styles.textStyle20w4White,),
          actions: <Widget>[
            TextButton(
              child: Text('cancel', style: Styles.textStyle20w4White,),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.delete,
                  style: const TextStyle(
                      color: ColorManager.redColor, fontSize: 20)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (context.mounted) {
                  context.read<EditProfileViewModel>().deleteProfile();
                  Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => LoginView(),), (
                        route) => false,);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
