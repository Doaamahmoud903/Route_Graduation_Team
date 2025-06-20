import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/core/cach_helper/cach_helper.dart';
import 'package:movie_app/features/movie_details/domain/entities/all_favourites_response_entity.dart';
import 'core/di/di.dart';
import 'core/state_management/bloc_observer.dart';
import 'features/movie_details/domain/entities/favourite_response_entity.dart';
import 'movie_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FavouriteResponseEntityAdapter());
  Hive.registerAdapter(FavouriteMovieEntityAdapter());
  await CacheHelper().initPrefs();
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  runApp(const MovieApp());

}
