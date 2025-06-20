import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/core/theming/styles_manager.dart';
import 'package:movie_app/core/utils/assets_manager.dart';
import 'package:movie_app/core/widgets/custom_button.dart';
import 'package:movie_app/features/account/presentation/manager/history_cubit/history_states.dart';
import 'package:movie_app/features/account/presentation/manager/history_cubit/history_view_model.dart';
import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_states.dart';
import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_view_model.dart';
import 'package:movie_app/features/account/presentation/views/widgets/tab_item.dart';
import 'package:movie_app/l10n/app_localizations.dart';

import '../../../../../core/cach_helper/cach_helper.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/utils/toast_utils.dart';
import '../../../../../core/widgets/custom_loding_indicator.dart';
import '../../../../auth/presentation/views/login_view.dart';
import '../../../../movie_details/domain/entities/favourite_response_entity.dart';
import '../../../../movie_details/presentation/views/movie_details_view.dart';
import '../../../data/models/ProfileResponse.dart';
import '../../manager/edit_profile_cubit/edit_profile_states.dart';
import '../../manager/edit_profile_cubit/edit_profile_view_model.dart';
import '../../manager/watch_list_cubit/watch_list_states.dart';
import '../../manager/watch_list_cubit/watch_list_view_model.dart';
import 'edit_profile.dart';
import 'logout_dialog.dart';
import 'watch_history_page.dart';
import 'images.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> with SingleTickerProviderStateMixin{
  late final ProfileViewModel profileViewModel;
  late final WatchListViewModel watchListViewModel;
  late final HistoryViewModel historyViewModel;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    profileViewModel = getIt<ProfileViewModel>();
    watchListViewModel = getIt<WatchListViewModel>();
    historyViewModel = getIt<HistoryViewModel>();

    // Initialize TabController
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging || !tabController.indexIsChanging) {
        setState(() {});
      }
    });

    // Fetch data when the page initializes
    profileViewModel.getProfileData();
    watchListViewModel.fetchWatchList();
    historyViewModel.fetchHistory();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Container(
          color: ColorManager.blackProfileColor,
          child: BlocConsumer<ProfileViewModel, ProfileStates>(
            bloc: profileViewModel,
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
                return const Center(child: CustomLoadingIndicator());
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

                                  BlocBuilder<WatchListViewModel, WatchListStates>(
                                    bloc: watchListViewModel,
                                    builder: (context, watchListState) {
                                      int watchListCount = 0;
                                      if (watchListState is WatchListSuccess) {
                                        watchListCount = watchListState.watchListMovies.length;
                                      } else if (watchListState is WatchListError) {
                                        return Column(
                                          children: [
                                            Text('0', style: Theme.of(context).textTheme.bodyLarge), // Or a small error icon
                                            SizedBox(height: 4.h),
                                            Text(AppLocalizations.of(context)!.watch_list, style: Theme.of(context).textTheme.bodyLarge)
                                          ],
                                        );
                                      }
                                      return Column(
                                        children: [
                                          Text(watchListCount.toString(),
                                              style: Theme.of(context).textTheme.bodyLarge),
                                          SizedBox(height: 4.h),
                                          Text(AppLocalizations.of(context)!.watch_list,
                                              style: Theme.of(context).textTheme.bodyLarge)
                                        ],
                                      );
                                    },
                                  ),




                                  SizedBox(width: 24.w),
                                  BlocBuilder<HistoryViewModel, HistoryStates>(
                                    bloc: historyViewModel,
                                    builder: (context, historyState) {
                                      int historyCount = 0;
                                      if (historyState is HistorySuccess) {
                                        historyCount = historyState.historyMovies.length;
                                      } else if (historyState is HistoryError) {
                                        return Column(
                                          children: [
                                            Text('0', style: Theme.of(context).textTheme.bodyLarge), // Or a small error icon
                                            SizedBox(height: 4.h),
                                            Text(AppLocalizations.of(context)!.history, style: Theme.of(context).textTheme.bodyLarge)
                                          ],
                                        );
                                      }
                                      return Column(
                                        children: [
                                          Text(historyCount.toString(),
                                              style: Theme.of(context).textTheme.bodyLarge),
                                          SizedBox(height: 4.h),
                                          Text(AppLocalizations.of(context)!.history,
                                              style: Theme.of(context).textTheme.bodyLarge)
                                        ],
                                      );
                                    },
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
                                                      create: (context) => getIt<EditProfileViewModel>(
                                                        param1: userProfile),
                                                      child: EditProfile(
                                                          currentUserProfileData: userProfile),
                                                    ),
                                              ),
                                            ).then((_) {
                                              profileViewModel.getProfileData();
                                              watchListViewModel.fetchWatchList();
                                              historyViewModel.fetchHistory();
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
                                      onPressed: () => showLogoutDialog(context),
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
                        controller: tabController,
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
                              isSelected: tabController.index == 0,
                              selectedTextStyle: Styles.textStyle20w4White,
                              unSelectedTextStyle: Styles.textStyle20w4White,
                            ),
                            TabItem(
                                imgPath: AssetManager.history,
                                text: AppLocalizations.of(context)!.history,
                                isSelected: tabController.index == 1,
                                selectedTextStyle: Styles.textStyle20w4White,
                                unSelectedTextStyle: Styles.textStyle20w4White),
                          ]
                      ),
                      Container(
                        height: 932.h,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: TabBarView(
                          controller: tabController,
                            children:  [
                              BlocConsumer<WatchListViewModel, WatchListStates>(
                                bloc: watchListViewModel,
                                listener: (context, state) {
                                  if (state is WatchListError) {
                                    ToastUtils.showErrorToast(state.message);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is WatchListLoading) {
                                    return const Center(child: CustomLoadingIndicator());
                                  } else if (state is WatchListSuccess) {
                                    if (state.watchListMovies.isEmpty) {
                                      return Center(child: Image.asset(AssetManager.empty, width: 200.w, height: 200.h));
                                    }
                                    return _buildMovieList(state.watchListMovies);
                                  } else if (state is WatchListError) {
                                    return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)));
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),

                              BlocConsumer<HistoryViewModel, HistoryStates>(
                                bloc: historyViewModel,
                                listener: (context, state) {
                                  if (state is HistoryError) {
                                    ToastUtils.showErrorToast(state.message);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is HistoryLoading) {
                                    return const Center(child: CustomLoadingIndicator());
                                  } else if (state is HistorySuccess) {
                                    if (state.historyMovies.isEmpty) {
                                      return Center(child: Image.asset(AssetManager.empty, width: 200.w, height: 200.h));
                                    }
                                    return _buildMovieList(state.historyMovies);
                                  } else if (state is HistoryError) {
                                    return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)));
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                              ///WatchHistoryPage(initialTab: 0),
                              ///WatchHistoryPage(initialTab: 1),
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

  Widget _buildMovieList(List<FavouriteMovieEntity> movies) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child:
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              if (movie.movieId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsView(movieId: int.parse(movie.movieId!)),
                  ),
                );
              } else {
                ToastUtils.showErrorToast("Movie ID not available for details.");
              }
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(movie.imageURL ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Image.asset(AssetManager.star, width: 16, height: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          movie.rating.toString(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

          );
        },
      ),
    );
  }
}
