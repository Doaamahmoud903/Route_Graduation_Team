import 'package:flutter/material.dart';
import 'package:movie_app/features/search/presentation/views/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  static const String routeName = "HomeView";
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchViewBody();
  }
}
