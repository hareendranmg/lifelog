import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_pages.dart';

class RootController extends GetxController {
  final box = GetStorage();

  @override
  void onReady() {
    if (box.hasData('user')) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => Get.offNamed(Routes.HOME),
      );
    } else {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => Get.offNamed(Routes.LOGIN),
      );
    }
    super.onReady();
  }
}
