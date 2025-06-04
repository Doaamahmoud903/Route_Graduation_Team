import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/core/theming/color_manager.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(color: ColorManager.orangeColor, size: size ?? 80);
  }
}
