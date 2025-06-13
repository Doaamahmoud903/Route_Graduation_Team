import 'package:flutter/material.dart';
import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/core/theming/styles_manager.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(color: ColorManager.orangeColor),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(message, style: Styles.textStyle20w4White),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          child: Text(posActionName, style: Styles.textStyle20w4White),
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();

            /// =
            /// if(posAction != null){
            /// posAction.call();
            /// }
          },
        ),
      );
    }

    if (negActionName != null) {
      actions.add(
        TextButton(
          child: Text(negActionName, style: Styles.textStyle20w4White),
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message, style: Styles.textStyle20w4White),
          title: Text(title ?? '', style: Styles.textStyle20w4White),
          actions: actions,
        );
      },
    );
  }
}
