import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(height: Get.height * 0.3),
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
                FormBuilderValidators.required(context),
                FormBuilderValidators.email(context),
              ]),
            ),
            const SizedBox(height: 20),
            FormBuilderTextField(
              name: 'password',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
              ]),
            ),
            const SizedBox(height: 26),
            GetBuilder<RegisterController>(
              builder: (_) => ElevatedButton(
                onPressed: _.isRegistering ? null : () => controller.register(),
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
