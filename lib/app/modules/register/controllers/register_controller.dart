import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';
import '../../../utils/global_widgets.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  bool _isRegistering = false;
  bool _isObsecure = true;

  Future<void> register() async {
    try {
      if (formKey.currentState!.saveAndValidate()) {
        isRegistering = true;
        final registerRes =
            await AuthServices.register(formData: formKey.currentState!.value);
        isRegistering = false;
        if (registerRes['status'] as bool) {
          Get.offAllNamed(Routes.LOGIN);
          showSnackBar(
            type: SnackbarType.success,
            message: 'Registration success. Please login to use the app',
          );
        } else {
          showSnackBar(
            type: registerRes['is_warning'] as bool
                ? SnackbarType.warning
                : SnackbarType.error,
            message: registerRes['message'] as String,
          );
        }
      }
    } catch (e) {
      showSnackBar(
        type: SnackbarType.error,
        message: 'Error occured. Please try again later.',
      );
    }
  }

  bool get isRegistering => _isRegistering;
  set isRegistering(bool v) => {_isRegistering = v, update()};
  bool get isObsecure => _isObsecure;
  set isObsecure(bool v) => {_isObsecure = v, update()};
}
