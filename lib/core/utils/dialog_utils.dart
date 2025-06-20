import 'package:flutter/material.dart';
import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/core/theming/styles_manager.dart';

class DialogUtils {
  static bool _isDialogOpen = false; // ADD THIS FLAG

  static void showLoading({
    required BuildContext context,
    required String message,
  }) {
    if (_isDialogOpen) return; // prevent opening multiple dialogs
    _isDialogOpen = true;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorManager.grey,  // optional: to match your app theme
          content: Row(
            children: [
              CircularProgressIndicator(color: ColorManager.orangeColor),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(message, style: Styles.textStyle20w4White),
              ),
            ],
          ),
        );
      },
    ).then((_) {
      _isDialogOpen = false;  // reset flag after dialog closed
    });
  }

  static void hideLoading(BuildContext context) {
    if (_isDialogOpen) {
      Navigator.pop(context);
      _isDialogOpen = false;
    }
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
            negAction?.call();
          },
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorManager.grey,  // optional: same as theme
          content: Text(message, style: Styles.textStyle20w4White),
          title: Text(title ?? '', style: Styles.textStyle20w4White),
          actions: actions,
        );
      },
    );
  }
}
