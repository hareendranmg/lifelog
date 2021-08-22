import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constants.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final box = GetStorage();

  bool _isLogging = false;

  Future<void> login() async {
    if (formKey.currentState!.saveAndValidate()) {
      final result = await supabase.auth.signIn(
        email: formKey.currentState!.value['email']! as String,
        password: formKey.currentState!.value['password']! as String,
      );

      if (result.data != null) {
        await box.write('user_session', result.data!.persistSessionString);
        Get.offAllNamed(Routes.HOME);
      } else if (result.error?.message != null) {
        Get.showSnackbar(GetBar(
          title: 'Error',
          message: result.error?.message,
        ));
      }
    }
  }

  bool get isLogging => _isLogging;
  set isLogging(bool v) => {_isLogging = v, update()};
}
