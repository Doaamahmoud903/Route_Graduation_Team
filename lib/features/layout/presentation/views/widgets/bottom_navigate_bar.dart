import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/assets_manager.dart';

import '../../manager/layout_cubit.dart';
import '../../manager/layout_states.dart';


class BottomNavigateBar extends StatelessWidget {
  const BottomNavigateBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        final cubit = LayoutCubit.get(context);

        return BottomNavigationBar(
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          currentIndex: cubit.currentIndex,
          onTap: (index) => cubit.changeBottom(index),
          items: [
            buildBottomNavigateBar(context, iconName: AssetManager.home, label: "", index: 0, currentIndex: cubit.currentIndex),
            buildBottomNavigateBar(context, iconName: AssetManager.search, label: "", index: 1, currentIndex: cubit.currentIndex),
            buildBottomNavigateBar(context, iconName: AssetManager.explore, label: "", index: 2, currentIndex: cubit.currentIndex),
            buildBottomNavigateBar(context, iconName: AssetManager.account, label: "", index: 3, currentIndex: cubit.currentIndex),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem buildBottomNavigateBar(
      BuildContext context, {
        required String iconName,
        required String label,
        required int index,
        required int currentIndex,
      }) {
    final isSelected = index == currentIndex;
    final selectedColor = Theme.of(context).bottomNavigationBarTheme.selectedItemColor ?? Colors.orange;
    final unselectedColor = Theme.of(context).bottomNavigationBarTheme.unselectedItemColor ?? Colors.grey;

    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(iconName),
        color: isSelected ? selectedColor : unselectedColor,
      ),
      label: label,
    );
  }
}
