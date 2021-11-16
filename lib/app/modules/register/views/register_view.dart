import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../global_widgets/custom_scaffold.dart';
import '../../../utils/theme_data.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: FormBuilder(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(height: Get.height * 0.1),
            const Text(
              'LifeLog',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, letterSpacing: 1),
            ),
            SizedBox(height: Get.height * 0.1),
            FormBuilderTextField(
              name: 'fullname',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  context,
                  errorText: 'Please enter your name',
                ),
              ]),
            ),
            const SizedBox(height: 20),
            FormBuilderTextField(
              name: 'email',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  context,
                  errorText: 'Please enter your email address',
                ),
                FormBuilderValidators.email(context),
              ]),
            ),
            // id,fullname,mobile_number,username,avatar_url,updated_at
            const SizedBox(height: 20),
            // FormBuilderTextField(
            //   name: 'mobile_number',
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     hintText: 'Mobile',
            //   ),
            //   keyboardType: TextInputType.phone,
            //   maxLength: 10,
            //   validator: FormBuilderValidators.compose([
            //     FormBuilderValidators.required(
            //       context,
            //       errorText: 'Please enter your password',
            //     ),
            //     FormBuilderValidators.minLength(
            //       context,
            //       10,
            //       errorText: 'Please enter a valid mobile number',
            //     ),
            //   ]),
            // ),
            // const SizedBox(height: 20),
            GetBuilder<RegisterController>(
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
                  FormBuilderValidators.minLength(
                    context,
                    6,
                    errorText: 'Password should have minimum 6 characters',
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 26),
            GetBuilder<RegisterController>(
              builder: (_) => SizedBox(
                height: 42.h,
                child: ElevatedButton(
                  onPressed:
                      _.isRegistering ? null : () => controller.register(),
                  style: primaryButtonStyle,
                  child: _.isRegistering
                      ? const SizedBox(
                          height: 26,
                          width: 26,
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Register'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already Registered?'),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Login'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
