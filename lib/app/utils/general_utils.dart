import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifelog/app/modules/home/controllers/home_controller.dart';
import 'package:lifelog/app/routes/app_pages.dart';

void removeCurrentFocus(BuildContext context) {
  final currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

String getGreeting() {
  final hour = TimeOfDay.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}

void routingCallback(Routing routing) {
  if (routing.current == Routes.HOME && routing.isBack!) {
    Get.find<HomeController>().update(['header_name']);
  }
}
