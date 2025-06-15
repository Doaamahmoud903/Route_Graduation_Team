import 'package:flutter/material.dart';
import 'package:movie_app/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  static const String routeName = "HomeView";
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  HomeViewBody();
  }
}
