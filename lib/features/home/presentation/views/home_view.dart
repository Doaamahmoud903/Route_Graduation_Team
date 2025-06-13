import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/api/api_services.dart';
import 'package:movie_app/core/api/dio_factory.dart';
import 'package:movie_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:movie_app/features/home/data/repository/home_repository_impl.dart';
import 'package:movie_app/features/home/presentation/manager/home_cubit.dart';
import 'package:movie_app/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  static const String routeName = '/home-view';

  const HomeView({super.key});

  @override
 @override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (context) => HomeCubit(
      HomeRepositoryImpl(
        HomeRemoteDataSource(apiService: ApiService(DioFactory.getDio())),
      ),
    )..fetchMovies(),
    child: const Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: HomeViewBody()),
    ),
  );
}

}
