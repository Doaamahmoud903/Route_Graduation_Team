
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/assets_manager.dart';
import 'package:movie_app/features/account/presentation/views/account_view.dart';
import 'package:movie_app/features/browse/presentation/views/browse_view.dart';
import 'package:movie_app/features/home/data/models/home_response.dart';
import 'package:movie_app/features/home/presentation/views/home_view.dart';
import 'package:movie_app/features/search/presentation/views/search_view.dart';
import '../../manager/home_cubit.dart';
import '../../manager/home_states.dart';
import 'movie_card.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  final List<Widget> _screens = [
   const HomeViewBody(),
   const  SearchView(), 
   const  BrowseView(),
   const  AccountView(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeSuccess) {
                  final movies = state.movies;
                  final allGenres = movies.expand((m) => m.genres).toSet().toList();

                  return Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          movies[_currentPage].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(color: Colors.black.withOpacity(0.5)),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Center(
                                child: Image.asset(AssetManager.availableNow, width: 200),
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: movies.length,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentPage = index;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      left: index == 0 ? 16 : 8,
                                      right: 8,
                                    ),
                                    child: MovieCard(movie: movies[index]),
                                  );
                                },
                              ),
                            ),
                            Center(
                              child: Image.asset(AssetManager.watchNow, width: 200),
                            ),
                            ...allGenres.map((genre) {
                              final genreMovies = movies.where((movie) => movie.genres.contains(genre)).toList();
                              if (genreMovies.isEmpty) return const SizedBox.shrink();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildSectionTitle(genre),
                                  buildHorizontalList(genreMovies),
                                ],
                              );
                            }).toList(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state is HomeFailure) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          : _screens[_currentIndex], 

      bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.black,
  selectedFontSize: 0, 
  unselectedFontSize: 0,
  showSelectedLabels: false,
  showUnselectedLabels: false,
  type: BottomNavigationBarType.fixed,
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
  items: [
    BottomNavigationBarItem(
      icon: Image.asset(
        _currentIndex == 0
            ? AssetManager.home_select
            : AssetManager.home,
        width: 30,
        height: 30,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        _currentIndex == 1
            ? AssetManager.search_select
            : AssetManager.search,
        width: 30,
        height: 30,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        _currentIndex == 2
            ? AssetManager.explore_select
            : AssetManager.explore_unselect,
        width: 30,
        height: 30,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        _currentIndex == 3
            ? AssetManager.Profiel_select
            : AssetManager.account,
        width: 30,
        height: 30,
      ),
      label: '',
    ),
  ],
),

    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildHorizontalList(List<Movie> moviesList) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: moviesList.length,
        itemBuilder: (context, index) {
          final movie = moviesList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: 120,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      movie.image,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.title,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

  }
}
