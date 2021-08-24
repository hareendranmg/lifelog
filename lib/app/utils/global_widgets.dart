import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'general_utils.dart';

enum SnackbarType {
  success,
  warning,
  error,
}

void showSnackBar({
  required SnackbarType type,
  required String message,
  String? title,
  Duration? duration,
}) {
  final Color fontColor =
      type == SnackbarType.warning ? Colors.black : Colors.white;

  final Color bgColor = type == SnackbarType.success
      ? const Color(0xff28a745)
      : type == SnackbarType.warning
          ? const Color(0xffffc107)
          : const Color(0xffdc3545);
  Get.showSnackbar(
    GetBar(
      message: message,
      messageText: Text(message, style: TextStyle(color: fontColor)),
      backgroundColor: bgColor,
      icon: type == SnackbarType.success
          ? Icon(Icons.check, color: fontColor)
          : Icon(Icons.error_outline, color: fontColor),
      duration: duration ?? 3.seconds,
      snackStyle: SnackStyle.FLOATING,
      shouldIconPulse: false,
    ),
  );
}

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key? key,
    required this.body,
  }) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => removeCurrentFocus(context),
          child: body,
        ),
      ),
    );
  }
}
