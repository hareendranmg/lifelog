import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';
import '../../../utils/global_widgets.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final box = GetStorage();

  bool _isLogging = false;
  bool _isObsecure = true;

  Future<void> login() async {
    if (formKey.currentState!.saveAndValidate()) {
      isLogging = true;
      final loginRes = await AuthServices.login(
        email: formKey.currentState!.value['email'] as String,
        password: formKey.currentState!.value['password'] as String,
      );
      isLogging = false;
      if (loginRes['status'] as bool) {
        Get.offAllNamed(Routes.HOME);
        showSnackBar(
          type: SnackbarType.success,
          message: 'Successfully logged in.',
        );
      } else {
        showSnackBar(
          type: SnackbarType.error,
          message: loginRes['message'] as String,
        );
      }
    }
  }

  bool get isLogging => _isLogging;
  set isLogging(bool v) => {_isLogging = v, update()};
  bool get isObsecure => _isObsecure;
  set isObsecure(bool v) => {_isObsecure = v, update()};
}
