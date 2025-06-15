import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/widgets/custom_button.dart';
import 'package:movie_app/features/browse/presentation/manager/movie_states.dart';
import 'package:movie_app/features/browse/presentation/manager/movie_view_model.dart';
import 'package:movie_app/features/browse/presentation/views/widgets/custom_tab_item.dart';
import 'package:movie_app/features/movie_details/presentation/views/movie_details_view.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/types.dart';
import '../../../../../core/widgets/custom_loding_indicator.dart';
import '../../../../account/presentation/views/widgets/logout_dialog.dart';

class BrowseViewBody extends StatefulWidget {
  const BrowseViewBody({super.key});
  @override
  State<BrowseViewBody> createState() => _BrowseViewBodyState();
}

class _BrowseViewBodyState extends State<BrowseViewBody> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: genres.length, vsync: this);

    context.read<MovieViewModel>().getMovie(
      genre: genres[0].toLowerCase(),
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
        Future.microtask(() {
          context.read<MovieViewModel>().getMovie(
            genre: genres[_tabController.index].toLowerCase(),
          );
        });
      }
    });
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return BlocListener<MovieViewModel, MovieState>(
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
            return const Center(child: CustomLoadingIndicator());
          } else if (state is MovieFaluire) {
            return Center(child: Text(state.errorMessage));
          } else if (state is MovieSuccess) {
            final movieList = state.movieList?.data?.movies ?? [];

            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                toolbarHeight: 100,
                title: TabBar(
                  tabAlignment: TabAlignment.start,
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: Colors.black,
                  dividerColor: Colors.transparent,
                  labelPadding: EdgeInsets.symmetric(horizontal: width * 0.01),
                  tabs: genres.asMap().entries.map((entry) {
                    final index = entry.key;
                    final genre = entry.value;
                    return Tab(
                      child: CustomTabItem(
                        type: genre,
                        isSelected: _tabController.index == index,
                      ),
                    );
                  }).toList(),
                ),
              ),
              body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: const EdgeInsets.all(12),
                itemCount: movieList.length,
                itemBuilder: (context, index) {
                  final movie = movieList[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetailsView(movieId: movie.id!),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            decoration: BoxDecoration(
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
          return const Center(child: Text("Something went wrong..."));
        },
      ),
    );
  }
}
