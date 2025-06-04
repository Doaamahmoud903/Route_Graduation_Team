import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../layout/presentation/views/widgets/bottom_navigate_bar.dart';
import '../../manager/layout_cubit.dart';
import '../../manager/layout_states.dart';

class LayoutViewBody extends StatefulWidget {
  static const String routeName = "/layout";
  const LayoutViewBody({super.key});

  @override
  State<LayoutViewBody> createState() => _LayoutViewBodyState();
}

class _LayoutViewBodyState extends State<LayoutViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
        builder: (context, state)
    {
      final cubit = LayoutCubit.get(context);
      return Scaffold(
        body: cubit.bottomScreens[cubit.currentIndex],
        bottomNavigationBar: const BottomNavigateBar(),

      );
    });
  }
}

