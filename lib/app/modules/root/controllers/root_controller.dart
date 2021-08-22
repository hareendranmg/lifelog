import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constants.dart';

class RootController extends GetxController {
  final box = GetStorage();

  @override
  void onReady() {
    if (box.hasData('user_session')) {
      supabase.auth.recoverSession(box.read('user_session') as String);
      supabase.auth.refreshSession();
      if (supabase.auth.currentUser != null) {
        WidgetsBinding.instance!.addPostFrameCallback(
          (_) => Get.offNamed(Routes.HOME),
        );
      } else {
        WidgetsBinding.instance!.addPostFrameCallback(
          (_) => Get.offNamed(Routes.LOGIN),
        );
      }
    } else {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => Get.offNamed(Routes.LOGIN),
      );
    }
    super.onReady();
  }
}
