import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/core/theming/styles_manager.dart';
import 'package:movie_app/core/utils/assets_manager.dart';
import 'package:movie_app/core/widgets/custom_button.dart';
import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_states.dart'; // Import singular states
import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_view_model.dart';
import 'package:movie_app/features/account/presentation/views/widgets/tab_item.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import '../../../../../core/di/di.dart'; // For GetIt
import '../../../../../core/utils/toast_utils.dart'; // For toasts
import '../../../../auth/presentation/views/login_view.dart';
import '../../../data/models/ProfileResponse.dart'; // For Data model
import '../../manager/edit_profile_cubit/edit_profile_states.dart'; // Import singular states
import '../../manager/edit_profile_cubit/edit_profile_view_model.dart'; // For EditProfileViewModel
import '../edit_profile.dart'; // For EditProfile screen
import '../watch_history_page.dart'; // For WatchHistoryPage
import 'images_avater.dart'; // For avatar images

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  late final ProfileViewModel viewModel; // Initialized in initState

  @override
  void initState() {
    super.initState();
    viewModel = context.read<ProfileViewModel>(); // Get existing ViewModel from BlocProvider
    viewModel.getProfileData(); // Fetch profile data when the screen loads
  }

  @override
  void dispose() {
    // viewModel.close(); // Do NOT dispose here if provided by a higher-level BlocProvider
    // The BlocProvider managing this BLoC is responsible for its disposal.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Assuming 2 tabs (Watch List, History)
      child: SafeArea(
        child: Container(
          color: ColorManager.blackProfileColor,
          child: BlocConsumer<ProfileViewModel, ProfileStates>(
            bloc: viewModel,
            listener: (context, state) {
              if (state is ProfileErrorStates) {
                ToastUtils.showErrorToast(state.errorMessage);

                if (state.errorMessage.contains('401') ||
                    state.errorMessage.contains('Session expired')) {
                  // Delayed navigation to allow toast to show
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LoginView()),
                          (route) => false,
                    );
                  });
                }

              } else if (state is ProfileDeleteSuccessStates) {
                ToastUtils.showSuccessToast('Profile Deleted Successfully');
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginView()),
                        (route) => false,
                  );
                });
              }
            },
            builder: (context, state) {
              if (state is ProfileSuccessStates) {
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
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => BlocProvider<EditProfileViewModel>(
                                                create: (context) => getIt<EditProfileViewModel>(
                                                  param1: userProfile, // Pass the current ProfileResponse
                                                ),
                                                child: EditProfile(currentUserProfileData: userProfile), // Correctly provide the child
                                              ),
                                            ),
                                          ).then((_) {
                                            // When returning from EditProfile, refresh profile data
                                            viewModel.getProfileData();
                                          });
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
                                      btnName: '', // Empty button name
                                      onPressed: () async{
                                        // todo: logout
                                        await context.read<ProfileViewModel>().logout();
                                        Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(builder: (context) => const LoginView()), // Ensure LoginView is const
                                                (route) => false);
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
                              isSelected: true, // This `isSelected` is static for TabItem, not dynamic
                              selectedTextStyle: Styles.textStyle20w4White,
                              unSelectedTextStyle: Styles.textStyle20w4White,
                            ),
                            TabItem(
                                imgPath: AssetManager.history,
                                text: AppLocalizations.of(context)!.history,
                                isSelected: true, // This `isSelected` is static for TabItem, not dynamic
                                selectedTextStyle: Styles.textStyle20w4White,
                                unSelectedTextStyle: Styles.textStyle20w4White),
                          ]
                      ),
                      Container(
                        height: 300.h, // Fixed height for TabBarView
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: const TabBarView( // Added const
                            children: [
                              WatchHistoryPage(initialTab: 0), // Watch List content
                              WatchHistoryPage(initialTab: 1), // History content
                            ]),
                      )
                    ],
                  ),
                );
              } else if (state is ProfileErrorStates) { // Corrected to singular ProfileErrorState
                return Center(
                  child: Text(
                    'Failed to load profile', // Use localization
                    style: Styles.textStyle20w4White,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              // Fallback for any other unhandled states (e.g., initial state)
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
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
import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_states.dart';
import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_view_model.dart';
import 'package:movie_app/features/account/presentation/views/widgets/tab_item.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import '../../../../../core/di/di.dart'; // For GetIt
import '../../../../../core/utils/toast_utils.dart'; // For toasts
import '../../../../auth/presentation/views/login_view.dart';
import '../../../data/models/ProfileResponse.dart'; // For Data model
import '../../manager/edit_profile_cubit/edit_profile_states.dart';
import '../../manager/edit_profile_cubit/edit_profile_view_model.dart'; // For EditProfileViewModel
import '../edit_profile.dart'; // For EditProfile screen
import '../watch_history_page.dart'; // For WatchHistoryPage
import 'images.dart'; // For avatar images

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
    viewModel = getIt<ProfileViewModel>();
    viewModel.getProfileData(); // Fetch profile data when the screen loads
  }

  @override
  void dispose() {
    viewModel.close(); // Dispose the cubit when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Assuming 2 tabs (Watch List, History)
      child: SafeArea(
        child: Container(
          color: ColorManager.blackProfileColor, // Background color for the whole body
          child: BlocConsumer<ProfileViewModel, ProfileStates>(
            bloc: viewModel,
              listener: (context, state) {
                if (state is ProfileErrorStates) { // Corrected to singular ProfileErrorState
                  ToastUtils.showErrorToast(state.errorMessage);
                } else if (state is ProfileDeleteSuccessStates) { // Corrected to singular ProfileDeleteSuccessState
                  ToastUtils.showSuccessToast('Profile Deleted Successfully'); // Show toast first
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginView()),
                        (route) => false,
                  );
                }
              },
            builder: (context, state) {
              if (state is ProfileLoadingStates) { // Handle loading state
                return const Center(
                  child: CircularProgressIndicator(color: ColorManager.orangeColor),
                );
              }
              else if (state is ProfileSuccessStates) {
                final ProfileResponse userProfile = state.userProfile;
                SingleChildScrollView(
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
                                          style: Theme.of(context).textTheme.bodyLarge),
                                      SizedBox(height: 4.h),
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
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => BlocProvider<EditProfileViewModel>(
                                                create: (context) => getIt<EditProfileViewModel>(
                                                  param1: userProfile, // Pass the current ProfileResponse
                                                ),
                                                ///child: EditProfile(currentUserProfileData: currentUserProfileData),
                                              ),
                                            ),
                                          );
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
                                      btnName: '', // Empty button name
                                      onPressed: () async{
                                        // todo: logout
                                        await context.read<ProfileViewModel>().logout();
                                        Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(builder: (context) => LoginView()),
                                                (route) => false);

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
                              isSelected: true, // This `isSelected` is static for TabItem, not dynamic
                              selectedTextStyle: Styles.textStyle20w4White,
                              unSelectedTextStyle: Styles.textStyle20w4White,
                            ),
                            // PROBLEM: These InkWell blocks are commented out.
                            // TabBar tabs are controlled by DefaultTabController, not individual InkWell taps.
                            /*InkWell(
                              child: TabItem(
                                imgPath: AssetManager.watchList,
                                text: AppLocalizations.of(context)!.watch_list,
                                isSelected: true,
                                selectedTextStyle: Styles.textStyle20w4White,
                                unSelectedTextStyle: Styles.textStyle20w4White,
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const WatchHistoryPage(initialTab: 0), // Pass initial tab for Watch List
                                ),
                                );
                              },
                            ),*/
                            TabItem(
                                imgPath: AssetManager.history,
                                text: AppLocalizations.of(context)!.history,
                                isSelected: true, // This `isSelected` is static for TabItem, not dynamic
                                selectedTextStyle: Styles.textStyle20w4White,
                                unSelectedTextStyle: Styles.textStyle20w4White),
                            /*InkWell(
                              child: TabItem(
                                  imgPath: AssetManager.history,
                                  text: AppLocalizations.of(context)!.history,
                                  isSelected: true,
                                  selectedTextStyle: Styles.textStyle20w4White,
                                  unSelectedTextStyle: Styles.textStyle20w4White),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const WatchHistoryPage(initialTab: 1), // Pass initial tab for History
                                ),
                                );
                              },
                            )*/
                          ]
                      ),
                      Container(
                        height: 300.h, // Fixed height for TabBarView
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: TabBarView(
                            children: [
                              WatchHistoryPage(initialTab: 0), // Watch List content
                              WatchHistoryPage(initialTab: 1), // History content
                              ///Center(child: Image.asset(AssetManager.empty)), // Commented out content
                              ///Center(child: Image.asset(AssetManager.empty)), // Commented out content
                            ]),
                      )
                    ],
                  ),
                );
              }
              else if (state is ProfileErrorStates) { // Handle error state for initial load
                return Center(
                  child: Text(
                    'failed_to_load_profile',
                    style: Styles.textStyle20w4White,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              // Fallback for any other unhandled states
              return const SizedBox.shrink();

            },
          )

        ),
      ),
    );
  }
}*/