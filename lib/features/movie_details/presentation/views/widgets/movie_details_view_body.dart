import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/core/theming/styles_manager.dart';
import 'package:movie_app/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/toast_utils.dart';
import 'package:movie_app/core/widgets/custom_loding_indicator.dart';
import 'package:movie_app/features/browse/data/models/movie_response.dart';
import 'package:movie_app/features/movie_details/data/models/movie_details_response.dart';
import 'package:movie_app/features/movie_details/presentation/manager/favourite/favourite_states.dart';
import 'package:movie_app/features/movie_details/presentation/manager/favourite/favourite_view_model.dart';
import 'package:movie_app/features/movie_details/presentation/manager/movie_details/movie_details_states.dart';
import 'package:movie_app/features/movie_details/presentation/manager/movie_details/movie_details_view_model.dart';
import 'package:movie_app/features/movie_details/presentation/views/widgets/movie_card.dart';

import '../../../../../core/di/di.dart';


class MovieDetailsViewBody extends StatefulWidget {
  final int movieId;
  MovieDetailsViewBody({super.key, required this.movieId});

  @override
  State<MovieDetailsViewBody> createState() => _MovieDetailsViewBodyState();
}

class _MovieDetailsViewBodyState extends State<MovieDetailsViewBody> {
  final MovieDetailsViewModel movieDetailsViewModel = getIt<MovieDetailsViewModel>();
  final FavouriteViewModel favouriteViewModel = getIt<FavouriteViewModel>();

  @override
  void initState() {
    super.initState();

    movieDetailsViewModel.getMovieDetails(widget.movieId);
    favouriteViewModel.isFav(widget.movieId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MovieDetailsViewModel, MovieDetailsState>(
          bloc: movieDetailsViewModel,
          listener: (context, state) {
            if (state is MovieDetailsFaluire) {
              ToastUtils.showErrorToast(state.errorMessage);
            }
          },
        ),
        BlocListener<FavouriteViewModel, FavouriteStates>(
          bloc: favouriteViewModel,
          listener: (context, state) {
            if (state is FavouriteFaliure) {
              ToastUtils.showErrorToast(state.errorMsg);
              print(state.errorMsg);
            } else if (state is FavouriteSuccessSub || state is FavouriteSuccessGeneral) {
              ToastUtils.showSuccessToast("Success");
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<MovieDetailsViewModel, MovieDetailsState>(
          bloc: movieDetailsViewModel,
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return const Center(child: CustomLoadingIndicator());
            } else if (state is MovieDetailsSuccess) {
              final movieItem = state.movieList?.data?.movie;
              final similar = state.similarMovies;

              debugPrint("MovieItem: $movieItem");
              debugPrint("SimilarMovies: $similar");

              if (movieItem == null) {
                return const Center(child: Text("No browse data available"));
              }
              return buildMovieDetailsBody(context, movieItem, similar);
            }

            return const Center(child: Text("Unexpected error occurred"));
          },
        ),
      ),
    );
  }

  Widget buildMovieDetailsBody(BuildContext context, MovieDetails movieItem, List<Movie> similar) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<FavouriteViewModel, FavouriteStates>(
              bloc: favouriteViewModel,
              builder: (context, favState) {
                // bool isFav = false;
                // if (favState is FavouriteSuccessGeneral) {
                //   isFav = favState.isFav;
                // } else if (favState is FavouriteSuccessSub) {
                //   isFav = favState.isFav;
                // }

                return MovieCard(
                  coverImg: movieItem.largeCoverImage ?? '',
                  starImg: AssetManager.star,
                  loveImg: AssetManager.love,
                  clockImg: AssetManager.clock,
                  ratingNum: (movieItem.rating ?? 0).toStringAsFixed(1),
                  loveNum: (movieItem.likeCount ?? 0).toString(),
                  clockNum: formatRuntime(movieItem.runtime ?? 0),
                  title: movieItem.titleEnglish ?? 'No title available',
                  year: (movieItem.year ?? 0).toString(),
                  isFav: favouriteViewModel.isMovieFav,
                  onPressedSaved: () {
                    favouriteViewModel.addToFav(
                      movieItem.id.toString(),
                      movieItem.titleEnglish ?? '',
                      movieItem.rating ?? 0.0,
                      movieItem.largeCoverImage ?? '',
                      (movieItem.year ?? 0).toString(),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 20),
            buildScreenshots(movieItem),
            buildSimilarMovies(similar ?? []),
            buildSummary(movieItem),
            buildCast(movieItem, width, height),
            buildGenres(movieItem),
          ],
        ),
      ),
    );
  }

  Widget buildScreenshots(MovieDetails movieItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("ScreenShots", style: Styles.textStyle24w5.copyWith(color: Colors.white)),
        const SizedBox(height: 5),
        if (movieItem.screenshot1 != null && movieItem.screenshot1!.isNotEmpty)
          _buildCircleScreenshot(movieItem.screenshot1!),
        if (movieItem.screenshot2 != null && movieItem.screenshot2!.isNotEmpty)
          _buildCircleScreenshot(movieItem.screenshot2!),
        if (movieItem.screenshot3 != null && movieItem.screenshot3!.isNotEmpty)
          _buildCircleScreenshot(movieItem.screenshot3!),
      ],
    );
  }

  Widget buildSimilarMovies(List<Movie> similar) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text("Similar", style: Styles.textStyle24w5.copyWith(color: Colors.white)),
        const SizedBox(height: 10),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          itemCount: min(similar.length, 4),
          itemBuilder: (context, index) {
            final movie = similar[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.network(movie.largeCoverImage ?? '', fit: BoxFit.cover),
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
                          Text("${movie.rating ?? 0}", style: const TextStyle(color: Colors.white, fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildSummary(MovieDetails movieItem) {
    if (movieItem.descriptionIntro == null || movieItem.descriptionIntro!.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text("Summary", style: Styles.textStyle24w5.copyWith(color: Colors.white)),
        const SizedBox(height: 8),
        Text(movieItem.descriptionIntro ?? "", style: Styles.textStyle24w5.copyWith(color: Colors.white)),
      ],
    );
  }

  Widget buildCast(MovieDetails movieItem, double width, double height) {
    if (movieItem.cast == null || movieItem.cast!.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text("Cast", style: Styles.textStyle24w5.copyWith(color: Colors.white)),
        const SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: movieItem.cast!.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final castMember = movieItem.cast![index];
              return Container(
                padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.01),
                decoration: BoxDecoration(color: ColorManager.grey, borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(castMember.urlSmallImage ?? "", width: 70, height: 70, fit: BoxFit.contain),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(castMember.name ?? "", style: const TextStyle(color: Colors.white, fontSize: 20)),
                          Text(castMember.characterName ?? "", style: const TextStyle(color: Colors.white, fontSize: 20)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildGenres(MovieDetails movieItem) {
    if (movieItem.genres == null || movieItem.genres!.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text("Genres", style: Styles.textStyle24w5.copyWith(color: Colors.white)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: movieItem.genres!.map((genre) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(12)),
              child: Text(genre, style: Styles.textStyle16w5.copyWith(color: Colors.white)),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCircleScreenshot(String url) {
    if (url == null || url.isEmpty) return SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          url,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300], child: const Icon(Icons.broken_image, color: Colors.grey)),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const SizedBox(width: 70, height: 70, child: Center(child: CustomLoadingIndicator()));
          },
        ),
      ),
    );
  }
}

String formatRuntime(int runtime) {
  if (runtime <= 0) return '0 min';
  final hours = runtime ~/ 60;
  final minutes = runtime % 60;
  return hours > 0 ? '${hours}h ${minutes}min' : '${minutes}min';
}
