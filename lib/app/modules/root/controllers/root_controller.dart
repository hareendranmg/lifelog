import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../../../services/account_services.dart';
import '../../../services/user_services.dart';

class RootController extends GetxController {
  final box = GetStorage();

  @override
  void onReady() {
    initApp();
    super.onReady();
  }

  Future<void> initApp() async {
    await Get.putAsync(() async => AccountService().init());

    if (Get.find<UserService>().appUser != null) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => Get.offNamed(Routes.HOME),
      );
    } else {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => Get.offNamed(Routes.LOGIN),
      );
    }
  }
}
