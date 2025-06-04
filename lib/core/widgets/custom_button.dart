import 'package:flutter/material.dart';
import '../theming/color_manager.dart';
import '../theming/styles_manager.dart';

class CustomButton extends StatelessWidget {
   void Function()? onPressed;
   String btnName;
   final Color bgColor;
   final Color fgColor;
   final String? logo;
   final Color textColor;
   CustomButton({super.key , required this.btnName , required this.onPressed, required this.bgColor, required this.fgColor,  this.logo, required this.textColor});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return SizedBox(
      width: double.infinity,
      height: height * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(
                  color: ColorManager.orangeColor
              )
          ),
        ),
        onPressed: onPressed,
        child: logo != null ?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(logo!),
                SizedBox(width: width*0.01,),
                Text(btnName,
                  style: Styles.textStyle20w7.copyWith(
                    color: textColor,
                  ),
                ),
              ],
            )
            :Text(btnName,
          style: Styles.textStyle20w7.copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
