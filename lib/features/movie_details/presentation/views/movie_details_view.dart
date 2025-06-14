import 'package:flutter/material.dart';
import 'package:movie_app/features/movie_details/presentation/views/widgets/movie_details_view_body.dart';


class MovieDetailsView extends StatelessWidget {
  final int movieId;
  static const String routeName = "MovieDetailsView";
  MovieDetailsView({super.key, required this.movieId});


  @override
  Widget build(BuildContext context) {
    return  MovieDetailsViewBody(movieId: movieId);

  }
}
