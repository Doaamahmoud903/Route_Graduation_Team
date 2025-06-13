import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/account/presentation/views/profile_view.dart';
import 'package:movie_app/features/browse/presentation/views/browse_view.dart';
import 'package:movie_app/features/search/presentation/views/search_view.dart';
import '../../../home/presentation/views/home_view.dart';
import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  final List<Widget> bottomScreens = [
    const HomeView(),
    const SearchView(),
    const BrowseView(),
    const ProfileView(),
  ];

  int currentIndex = 0;
  void changeBottom(int index) {
    currentIndex = index;
    emit((LayoutChangeBottomNavState()));
  }

  void goToMoviesView() {
    currentIndex = 2;
    emit(LayoutChangeBottomNavState());
  }
}
