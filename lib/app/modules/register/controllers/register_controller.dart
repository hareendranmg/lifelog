import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constants.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  bool _isRegistering = false;

  Future<void> register() async {
    try {
      if (formKey.currentState!.saveAndValidate()) {
        isRegistering = true;
        final result = await supabase.auth.signUp(
          formKey.currentState!.value['email']! as String,
          formKey.currentState!.value['password']! as String,
        );
        isRegistering = false;
        if (result.data != null) {
          Get.offAllNamed(Routes.LOGIN);
          Get.showSnackbar(GetBar(
            title: 'Success',
            message: 'Registration success. Please login to use the app',
          ));
        } else if (result.error?.message != null) {
          Get.showSnackbar(GetBar(
            title: 'Error',
            message: result.error?.message,
            backgroundColor: Colors.red[400]!,
          ));
        }
      }
    } catch (e) {
      Get.showSnackbar(GetBar(
        title: 'Error',
        message: 'Error occured. Please try again later',
        backgroundColor: Colors.red[400]!,
      ));
    }
  }

  bool get isRegistering => _isRegistering;
  set isRegistering(bool v) => {_isRegistering = v, update()};
}
