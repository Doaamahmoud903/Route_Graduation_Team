import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/account/presentation/manager/profile_cubit/profile_view_model.dart';
import 'package:movie_app/features/account/presentation/views/widgets/profile_view_body.dart';

import '../../../../core/di/di.dart';

class ProfileView extends StatelessWidget {
  static const String routeName = "ProfileView";
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<ProfileViewModel>(
        create: (context) => getIt<ProfileViewModel>(),
        child: const Scaffold(body: ProfileViewBody())); // Added const
  }
}