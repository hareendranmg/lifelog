import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../utils/asset_urls.dart';
import '../../controllers/profile_base_controller.dart';
import '../../controllers/profile_controller.dart';
import 'profile_picture.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            AssetUrls.PROFILE_BG,
            fit: BoxFit.cover,
            width: Get.width,
          ),
        ),
        Column(
          children: [
            const ProfilePicture(),
            SizedBox(height: 10.h),
            GetBuilder<ProfileController>(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_.editingNameState != EditingNameState.saved)
                    FormBuilder(
                      key: _.nameEditFormKey,
                      child: IntrinsicWidth(
                        child: FormBuilderTextField(
                          name: 'name',
                          initialValue: _.userService.appUser!.name,
                          focusNode: _.nameFocusNode,
                          decoration: const InputDecoration(
                            hintText: 'Your Name',
                            counterText: '',
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 18.sp),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          maxLength: 25,
                          onSubmitted: (final v) => _.updateName(),
                        ),
                      ),
                    )
                  else
                    Text(
                      _.userService.appUser!.name,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  const SizedBox(width: 6),
                  if (_.editingNameState == EditingNameState.saving)
                    const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(),
                    )
                  else
                    GestureDetector(
                      onTap: _.editingNameState == EditingNameState.editing
                          ? () => _.updateName()
                          : () => {
                                _.editingNameState = EditingNameState.editing,
                                _.nameFocusNode.requestFocus(),
                              },
                      child: Icon(
                        _.editingNameState == EditingNameState.editing
                            ? Icons.check
                            : Icons.edit,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              controller.userService.appUser!.email!,
              style: TextStyle(fontSize: 14.sp),
            ),
          ],
        ),
      ],
    );
  }
}
