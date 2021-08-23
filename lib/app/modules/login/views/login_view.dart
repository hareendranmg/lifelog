import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/theme_data.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(height: Get.height * 0.4),
            const Text(
              'LifeLog',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, letterSpacing: 1),
            ),
            SizedBox(height: Get.height * 0.1),
            FormBuilderTextField(
              name: 'email',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  context,
                  errorText: 'Please enter your registered email',
                ),
                FormBuilderValidators.email(
                  context,
                  errorText: 'Please enter your registered email',
                ),
              ]),
            ),
            const SizedBox(height: 20),
            GetBuilder<LoginController>(
              builder: (_) => FormBuilderTextField(
                name: 'password',
                obscureText: _.isObsecure,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () => _.isObsecure = !_.isObsecure,
                    icon: Icon(
                      _.isObsecure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    context,
                    errorText: 'Please enter your password',
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 26),
            GetBuilder<LoginController>(
              builder: (_) => ElevatedButton(
                onPressed: _.isLogging ? null : () => controller.login(),
                style: primaryButtonStyle,
                child: _.isLogging
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Login'),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Not Registered?'),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.REGISTER),
                  child: const Text('Register Here.'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
