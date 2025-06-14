import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/browse/presentation/views/widgets/browse_view_body.dart';
import '../../../../core/di/di.dart';
import '../manager/movie_view_model.dart';

class BrowseView extends StatelessWidget {
  static const String routeName = "MovieView";
   BrowseView({super.key});
  MovieViewModel movieViewModel = getIt<MovieViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => movieViewModel..getMovie(),
      child: const BrowseViewBody(),
    );
  }
}
