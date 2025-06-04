import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/core/cach_helper/cach_helper.dart';
import 'core/state_management/bloc_observer.dart';
import 'movie_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await CacheHelper().initPrefs();
  Bloc.observer = MyBlocObserver();
  runApp(const MovieApp());
}
