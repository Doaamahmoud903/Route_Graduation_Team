import 'package:fluttertoast/fluttertoast.dart';
import 'show_toast.dart';
import '../theming/color_manager.dart';

class ToastUtils {
  static void showSuccessToast(String msg) {
    CustomToast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorManager.greenColor,
      textColor: ColorManager.whiteColor,
      fontSize: 16.0,
    );
  }

  static void showErrorToast(String msg) {
    CustomToast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorManager.redColor,
      textColor: ColorManager.whiteColor,
      fontSize: 16.0,
    );
  }
}
