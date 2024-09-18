import 'package:flutter/widgets.dart';
import 'package:toastification/toastification.dart';

class ToastUtil {
  static void showToast(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 3),
      type: ToastificationType.success,
      showProgressBar: false,
    );
  }
}
