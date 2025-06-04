import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/assets_manager.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SizedBox(
      child: Image.asset(
        AssetManager.logo,
        height: height*0.14,
        fit: BoxFit.contain,),
    );
  }
}