import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/utils/assets_manager.dart';
import 'package:movie_app/core/widgets/custom_loding_indicator.dart';
import 'package:movie_app/features/account/presentation/manager/history_cubit/history_states.dart';
import 'package:movie_app/features/account/presentation/manager/history_cubit/history_view_model.dart';
import 'package:movie_app/features/account/presentation/manager/watch_list_cubit/watch_list_states.dart';
import 'package:movie_app/core/utils/toast_utils.dart';
import 'package:movie_app/features/movie_details/presentation/views/movie_details_view.dart';
import '../../../../movie_details/domain/entities/favourite_response_entity.dart';
import '../../manager/watch_list_cubit/watch_list_view_model.dart';

class WatchHistoryPage extends StatefulWidget {
  final int initialTab;
  const WatchHistoryPage({super.key, this.initialTab = 0});

  @override
  State<WatchHistoryPage> createState() => _WatchHistoryPageState();
}

class _WatchHistoryPageState extends State<WatchHistoryPage> with AutomaticKeepAliveClientMixin {
  late final WatchListViewModel watchListViewModel;
  late final HistoryViewModel historyViewModel;

  @override
  void initState() {
    super.initState();
    watchListViewModel = getIt<WatchListViewModel>();
    historyViewModel = getIt<HistoryViewModel>();

    // Fetch data when the page initializes
    watchListViewModel.fetchWatchList();
    historyViewModel.fetchHistory();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: TabBarView(
        children: [
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
                  return Center(child: Image.asset(AssetManager.empty,

                  ));
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
                  return Center(child: Image.asset(AssetManager.empty,
                  )); // Adjust size
                }
                return _buildMovieList(state.historyMovies);
              } else if (state is HistoryError) {
                return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)));
              }
              return const SizedBox.shrink();
            },
          ),
        ],
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
