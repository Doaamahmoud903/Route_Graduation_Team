import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TabItem extends StatelessWidget {
  String imgPath;
  String text;
  bool isSelected;
  TextStyle selectedTextStyle;
  TextStyle unSelectedTextStyle;
  TabItem({super.key,
    required this.imgPath,
    required this.text,
    required this.isSelected,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(imgPath),
          SizedBox(height: 5.h),
          Text(text,
            style: isSelected
                ? selectedTextStyle
                : unSelectedTextStyle,
          )
        ]),
    );
  }
}
