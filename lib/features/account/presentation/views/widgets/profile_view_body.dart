import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/core/theming/styles_manager.dart';
import 'package:movie_app/core/utils/assets_manager.dart';
import 'package:movie_app/core/widgets/custom_button.dart';
import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_states.dart';
import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_view_model.dart';
import 'package:movie_app/features/account/presentation/views/widgets/tab_item.dart';
import 'package:movie_app/l10n/app_localizations.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/utils/toast_utils.dart';
import '../../../../auth/presentation/views/login_view.dart';
import '../../../data/models/ProfileResponse.dart';
import '../../manager/edit_profile_cubit/edit_profile_states.dart';
import '../../manager/edit_profile_cubit/edit_profile_view_model.dart';
import '../edit_profile.dart';
import '../watch_history_page.dart';
import 'images.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  late final ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<ProfileViewModel>();
    viewModel.getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Container(
          color: ColorManager.blackProfileColor,
          child: BlocConsumer<ProfileViewModel, ProfileStates>(
            bloc: viewModel,
            listener: (context, state) {
              if (state is ProfileErrorStates) {
                ToastUtils.showErrorToast(state.errorMessage);
                if (state.errorMessage.contains('401') ||
                    state.errorMessage.contains('Session expired') ||
                    state.errorMessage.contains('token not found') ||
                    state.errorMessage.contains('unauthorized')) {
                  Future.delayed(const Duration(seconds: 2), () {
                    if (context.mounted) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (
                            context) => const LoginView()),
                            (route) => false,
                      );
                    }
                  });
                }
              } else if (state is ProfileDeleteSuccessStates) {
                ToastUtils.showSuccessToast('Profile Deleted Successfully');
                Future.delayed(const Duration(seconds: 2), () {
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (
                          context) => const LoginView()),
                          (route) => false,
                    );
                  }
                });
              }
            },
            builder: (context, state) {
              if (state is ProfileLoadingStates) {
                return const Center(
                  child: CircularProgressIndicator(
                      color: ColorManager.orangeColor),
                );
              } else if (state is ProfileSuccessStates) {
                final ProfileResponse userProfile = state.profileResponse;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 16.h,
                            bottom: 0.h,
                            right: 16.w,
                            left: 16.w
                        ),
                        child: Column(
                          children: [
                            FittedBox(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 50.r,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: AssetImage(Images.getAvatarPath(userProfile.data?.avaterId ?? 0)),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(userProfile.data?.name ?? '',
                                          style: Theme.of(context).textTheme.headlineLarge)
                                    ],
                                  ),
                                  SizedBox(width: 24.w),
                                  Column(
                                    children: [
                                      Text((userProfile.data?.watchListCount ?? 0).toString(),
                                          style: Theme.of(context).textTheme.bodyLarge)
                                      ,SizedBox(height: 4.h),
                                      Text(AppLocalizations.of(context)!.watch_list,
                                          style: Theme.of(context).textTheme.bodyLarge)
                                    ],
                                  ),
                                  SizedBox(width: 24.w),
                                  Column(
                                    children: [
                                      Text((userProfile.data?.historyCount ?? 0).toString(),
                                          style: Theme.of(context).textTheme.bodyLarge),
                                      SizedBox(height: 4.h),
                                      Text(AppLocalizations.of(context)!.history,
                                          style: Theme.of(context).textTheme.bodyLarge)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),

                            FittedBox(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 253.w,
                                    height: 56.h,
                                    child: CustomButton(
                                        btnName: AppLocalizations.of(context)!.edit_profile,
                                        onPressed: () {
                                          if (context.mounted) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider<
                                                        EditProfileViewModel>(
                                                      create: (context) =>
                                                          getIt<
                                                              EditProfileViewModel>(
                                                            param1: userProfile,
                                                          ),
                                                      child: EditProfile(
                                                          currentUserProfileData: userProfile),
                                                    ),
                                              ),
                                            ).then((_) {
                                              viewModel.getProfileData();
                                            });
                                          }
                                        },
                                        bgColor: ColorManager.orangeColor,
                                        fgColor: ColorManager.orangeColor,
                                        textColor: ColorManager.blackButtonColor),
                                  ),
                                  SizedBox(width: 10.w),
                                  SizedBox(
                                    width: 135.w,
                                    height: 56.h,
                                    child: CustomButton(
                                      btnName: '',
                                      onPressed: () async {
                                        if (context.mounted) {
                                          await context.read<ProfileViewModel>()
                                              .logout();
                                          if (context.mounted) {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(builder: (
                                                  context) => const LoginView()),
                                                  (route) => false,
                                            );
                                          }
                                        }
                                      },
                                      bgColor: ColorManager.redColor,
                                      fgColor: ColorManager.redColor,
                                      textColor: ColorManager.whiteColor,
                                      logo: AssetManager.exitLogo,
                                      borderSideColor: ColorManager.redColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 32.h),
                          ],
                        ),
                      ),

                      TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: ColorManager.orangeColor,
                          indicatorWeight: 3,
                          dividerColor: ColorManager.transparentColor,
                          labelColor: ColorManager.whiteColor,
                          labelStyle: Styles.textStyle20w4White,
                          tabs: [
                            TabItem(
                              imgPath: AssetManager.watchList,
                              text: AppLocalizations.of(context)!.watch_list,
                              isSelected: true,
                              selectedTextStyle: Styles.textStyle20w4White,
                              unSelectedTextStyle: Styles.textStyle20w4White,
                            ),
                            TabItem(
                                imgPath: AssetManager.history,
                                text: AppLocalizations.of(context)!.history,
                                isSelected: true,
                                selectedTextStyle: Styles.textStyle20w4White,
                                unSelectedTextStyle: Styles.textStyle20w4White),
                          ]
                      ),
                      Container(
                        height: 300.h,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: const TabBarView(
                            children: [
                              WatchHistoryPage(initialTab: 0),
                              WatchHistoryPage(initialTab: 1),
                            ]),
                      )
                    ],
                  ),
                );
              } else {
                ToastUtils.showErrorToast('Failed to load profile');
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
