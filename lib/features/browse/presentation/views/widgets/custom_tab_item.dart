import 'package:flutter/material.dart';
import 'package:movie_app/core/theming/color_manager.dart';

class CustomTabItem extends StatelessWidget {
  final String type;
  final bool isSelected;
  const CustomTabItem({super.key, required this.type, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  Container(
      padding: EdgeInsets.symmetric(
        vertical: height*0.01,
        horizontal: width*0.025
      ) ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorManager.orangeColor,

        ),
        color: isSelected ? ColorManager.orangeColor : ColorManager.blackColor
      ),
      child: Text(type,
       style:  TextStyle(
        fontSize: 20,
        color: isSelected ? ColorManager.blackColor : ColorManager.orangeColor,
        fontWeight: FontWeight.bold
      ),),
    );
  }
}
