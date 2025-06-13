import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/core/theming/styles_manager.dart';
import 'package:movie_app/core/utils/assets_manager.dart';
import 'package:movie_app/core/widgets/custom_button.dart';
import 'package:movie_app/core/widgets/custom_text_field.dart';
import 'package:movie_app/features/account/presentation/manager/edit_profile_cubit/edit_profile_states.dart'; // Import singular states
// import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_states.dart'; // Not directly used here, remove if not listening
// import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_view_model.dart'; // Not directly used here, remove if not listening
import 'package:movie_app/features/account/presentation/views/widgets/images_avater.dart';
import 'package:movie_app/features/account/presentation/views/widgets/pick_avatar_widget.dart';
import 'package:movie_app/features/auth/presentation/views/login_view.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/utils/validators.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/ProfileResponse.dart';
import '../manager/edit_profile_cubit/edit_profile_view_model.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = "EditProfileScreen";

  final ProfileResponse currentUserProfileData; // Made final
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
      param1: widget.currentUserProfileData, // Pass the initial data to the ViewModel
    );

    // Initialize local avatar ID state
    selectedAvatarId = widget.currentUserProfileData.data?.avaterId ?? 0;
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
        // Listen to EditProfileViewModel states
        bloc: viewModel, // Specify the bloc instance
        listener: (context, state) {
          if (state is EditProfileLoadingStates || state is ProfileDeleteLoadingStates) { // Use singular states
            DialogUtils.showLoading(context: context, message: 'Loading...');
          } else if (state is EditProfileErrorStates) { // Use singular state
            DialogUtils.hideLoading(context);
            // ToastUtils.showErrorToast is already called in the ViewModel, so no need to repeat here
          } else if (state is EditProfileSuccessStates) { // Use singular state
            DialogUtils.hideLoading(context);
            // ToastUtils.showSuccessToast is already called in the ViewModel
            Navigator.of(context).pop(); // Go back to profile view
          } else if (state is ProfileDeleteSuccessStates) { // Use singular state
            DialogUtils.hideLoading(context);
            // ToastUtils.showSuccessToast is already called in the ViewModel
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginView()), // Ensure LoginView is const
                  (route) => false,
            );
          } else if (state is ProfileDeleteErrorStates) { // Use singular state
            DialogUtils.hideLoading(context);
            // ToastUtils.showErrorToast is already called in the ViewModel
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w), // Corrected to use EdgeInsets.all
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
                /*SizedBox(height: 16.h),

                CustomTextField(
                  controller: viewModel.emailController,
                  keyboardType: TextInputType.emailAddress,
                  typingColor: ColorManager.whiteColor,
                  prefixIcon: AssetManager.user, // Consider a different icon for email
                  prefixColor: ColorManager.whiteColor,
                  fillColor: ColorManager.grey,
                  borderColor: ColorManager.grey,
                  borderRadius: 15,
                  validator: (value) {
                    return Validators.validateEmail(value); // Return validation result
                  },
                ),*/
                SizedBox(height: 16.h),

                CustomTextField(
                  controller: viewModel.phoneController,
                  keyboardType: TextInputType.phone,
                  typingColor: ColorManager.whiteColor,
                  prefixIcon: AssetManager.phone,
                  prefixColor: ColorManager.whiteColor,
                  fillColor: ColorManager.grey,
                  borderColor: ColorManager.grey,
                  borderRadius: 15,
                  validator: (value) {
                    return Validators.validatePhone(value); // Return validation result
                  },
                ),
                SizedBox(height: 10.h),

                Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: Text(
                      AppLocalizations.of(context)!.reset_password,
                      style: Styles.textStyle20w4White,
                    ),
                    onPressed: () {
                      //todo: reset password
                    },
                  ),
                ),

                SizedBox(height: 50.h), // Adjusted spacing

                CustomButton(
                  btnName: AppLocalizations.of(context)!.delete_account,
                  bgColor: ColorManager.redColor,
                  fgColor: ColorManager.redColor,
                  textColor: ColorManager.whiteColor,
                  borderSideColor: ColorManager.redColor,
                  onPressed: () {
                    _confirmDeleteDialog(context); // Call confirmation dialog
                  },
                ),
                SizedBox(height: 15.h),
                CustomButton(
                  btnName: AppLocalizations.of(context)!.update_data,
                  bgColor: ColorManager.orangeColor,
                  fgColor: ColorManager.orangeColor,
                  textColor: ColorManager.blackButtonColor,
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
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
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: ColorManager.redColor)),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss the dialog
                context.read<EditProfileViewModel>().deleteProfile(); // Trigger delete
              },
            ),
          ],
        );
      },
    );
  }
}































/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/core/theming/styles_manager.dart';
import 'package:movie_app/core/utils/assets_manager.dart';
import 'package:movie_app/core/widgets/custom_button.dart';
import 'package:movie_app/core/widgets/custom_text_field.dart';
import 'package:movie_app/features/account/presentation/manager/edit_profile_cubit/edit_profile_states.dart';
import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_states.dart';
import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_view_model.dart';
import 'package:movie_app/features/account/presentation/views/widgets/images.dart';
import 'package:movie_app/features/account/presentation/views/widgets/pick_avatar_widget.dart';
import 'package:movie_app/features/auth/presentation/views/login_view.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_loding_indicator.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/ProfileResponse.dart';
import '../manager/edit_profile_cubit/edit_profile_view_model.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = "EditProfileScreen";

  ProfileResponse currentUserProfileData;
   EditProfile({super.key, required this.currentUserProfileData});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final EditProfileViewModel viewModel; ///EditProfileViewModel viewModel = getIt<EditProfileViewModel>();
  late int selectedAvatarId;
  final formKey = GlobalKey<FormState>();

  //String currentAvatarAsset = AssetManager.profile1;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<EditProfileViewModel>(
      param1: widget.currentUserProfileData, // Pass the initial data to the ViewModel
    );

    // Initialize local avatar ID state
    selectedAvatarId = widget.currentUserProfileData.data?.avaterId ?? 0;
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
              listener: (context, state){
                if(state is EditProfileLoadingStates || state is ProfileDeleteLoadingStates){
                  Center(
                      child: CircularProgressIndicator(color: ColorManager.orangeColor));
                }
                else if (state is EditProfileErrorStates) {
                  Navigator.pop(context);
                  ToastUtils.showErrorToast(state.errorMessage);
                }
                else if (state is EditProfileSuccessStates) {
                  Navigator.pop(context);
                  ToastUtils.showSuccessToast('Profile Updated Successfully');
                  Navigator.of(context).pop();
                }
                else if(state is ProfileDeleteSuccessStates){
                  Navigator.pop(context);
                  ToastUtils.showSuccessToast('Profile Deleted Successfully');
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginView()),
                      (route) => false);
                }
                else if(state is ProfileDeleteErrorStates){
                  Navigator.pop(context);
                  ToastUtils.showSuccessToast(state.errorMessage);
                }
              },

              child: SingleChildScrollView(
                padding:  EdgeInsetsGeometry.all(16.w),
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
                          final int? selectedAvatar = await showModalBottomSheet<int>(
                            backgroundColor: ColorManager.transparentColor,
                            elevation: 0,
                            context: context,
                            builder: (context) {
                              return PickAvatarWidget(currentSelectedAvatarId: selectedAvatarId);
                            },
                          );
                          // If an avatar was selected and returned, update the state
                          if (selectedAvatar != null) {
                            setState(() {
                              selectedAvatarId = selectedAvatar;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 30.h),

                      //Name
                      CustomTextField(
                        controller: viewModel.nameController,
                        typingColor: ColorManager.whiteColor,
                        prefixIcon: AssetManager.user,
                        prefixColor: ColorManager.whiteColor,
                        fillColor: ColorManager.grey,
                        borderColor: ColorManager.grey,
                        borderRadius: 15,
                        validator: (value) {
                          Validators.validateName(viewModel.nameController.text);
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      //Phone
                      CustomTextField(
                        controller: viewModel.phoneController,
                        keyboardType: TextInputType.phone,
                        typingColor: ColorManager.whiteColor,
                        prefixIcon: AssetManager.phone,
                        prefixColor: ColorManager.whiteColor,
                        fillColor: ColorManager.grey,
                        borderColor: ColorManager.grey,
                        borderRadius: 15,
                        validator: (value) {
                          Validators.validateName(viewModel.phoneController.text);
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          child: Text(
                            AppLocalizations.of(context)!.reset_password,
                            style: Styles.textStyle20w4White,
                          ),
                          onPressed: () {
                            //todo: reset password
                          },
                        ),
                      ),

                      SizedBox(height: 150.h),
                      CustomButton(
                        btnName: AppLocalizations.of(context)!.delete_account,
                        bgColor: ColorManager.redColor,
                        fgColor: ColorManager.redColor,
                        textColor: ColorManager.whiteColor,
                        borderSideColor: ColorManager.redColor,
                        onPressed: () {
                          //todo: delete account
                          context.read<EditProfileViewModel>().deleteProfile();
                        },
                      ),
                      SizedBox(height: 15.h),
                      CustomButton(
                        btnName: AppLocalizations.of(context)!.update_data,
                        bgColor: ColorManager.orangeColor,
                        fgColor: ColorManager.orangeColor,
                        textColor: ColorManager.blackButtonColor,
                        onPressed: () {
    if(formKey.currentState?.validate() == true){
    context.read<EditProfileViewModel>().updateProfile(
    name: viewModel.nameController.text,
    phone: viewModel.phoneController.text,
    avaterId: selectedAvatarId,
        email:viewModel.emailController.text
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
}
*/