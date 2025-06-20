import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:movie_app/core/widgets/custom_button.dart';
import 'package:movie_app/core/widgets/custom_loding_indicator.dart';
import 'package:movie_app/features/account/presentation/views/widgets/logout_dialog.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/theming/color_manager.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../browse/presentation/manager/movie_states.dart';
import '../../../../browse/presentation/manager/movie_view_model.dart';
import '../../../../layout/presentation/manager/layout_cubit.dart';


class HomeViewBody extends StatefulWidget {
   const HomeViewBody({super.key});
  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  MovieViewModel movieViewModel = getIt<MovieViewModel>();
  int currentIndex=0;
  @override

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) =>movieViewModel..getMovie(sort_by: "date_added"),
      child: BlocListener<MovieViewModel, MovieState>(
        listener: (context, state) {
          if (state is MovieFaluire) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: BlocBuilder<MovieViewModel, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return  const Center(child: CustomLoadingIndicator());
            } else if (state is MovieFaluire) {
              return  Center(child: Text(state.errorMessage));
            } else if (state is MovieSuccess) {
              final movieList = state.movieList?.data?.movies ?? [];
              final enlargedMovie = movieList.isNotEmpty ? movieList[currentIndex].largeCoverImage : null;
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image:NetworkImage(enlargedMovie!) ,fit: BoxFit.cover,)
                    ),
                  ),
                  Container(
                    color: Colors.black.withValues(alpha: 0.9),
                  ),
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AssetManager.availableNow),
                        ],
                      ),
                      toolbarHeight: 100,
                    ),
                    body: Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 400.0,
                            enlargeCenterPage: true,
                            viewportFraction: 0.6,
                            enableInfiniteScroll: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ),
                          items: movieList.map((movie) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(movie.largeCoverImage ?? ''),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(height: height*0.01,),
                        Image.asset(AssetManager.watchNow ,height: height*0.15,),
                        TextButton(
                          onPressed: (){},
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Action",style: TextStyle(
                                color: ColorManager.whiteColor,
                              ),
                              ),
                              InkWell(
                                onTap: (){
                                  LayoutCubit.get(context).goToMoviesView();
                                },
                                child: Row(
                                  children: [
                                     Text(AppLocalizations.of(context)!.see_more,
                                      style: const TextStyle(
                                        color: ColorManager.orangeColor,
                                      ),),
                                    SizedBox(width: width*0.02,),
                                    const Icon(Bootstrap.arrow_right,color: ColorManager.orangeColor,),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                            itemCount: movieList.length,
                            separatorBuilder: (context, index) => SizedBox(width: width * 0.03),
                            itemBuilder: (context, index) {
                              final movie = movieList[index];
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      width: width * 0.35,
                                      height: height * 0.25,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        image: DecorationImage(
                                          image: NetworkImage(movie.largeCoverImage ?? ''),
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
                                          Image.asset(
                                            AssetManager.star,
                                            width: 16,
                                            height: 16,
                                            color: Colors.amber,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            movie.rating.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );

                            },
                          ),
                        ),
                        // CustomButton(
                        //     btnName: "Logout",
                        //     onPressed: ()=>showLogoutDialog(context),
                        //     bgColor: ColorManager.redColor,
                        //     fgColor: Colors.white,
                        //     textColor: Colors.white)

                      ],
                    ),

                  ),

                ],
              );
            }
            return  Center(child: Text(AppLocalizations.of(context)!.error));
          },
        ),
      ),
    );
  }
}
