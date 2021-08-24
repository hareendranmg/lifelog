import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifelog/app/utils/constants.dart';
import 'package:lifelog/app/utils/global_widgets.dart';

import '../../../../utils/asset_urls.dart';
import '../../controllers/profile_controller.dart';

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
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 40.w,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 40.w,
                backgroundImage: controller.userService.appUser!.avatarUrl ==
                        null
                    ? const AssetImage(AssetUrls.USER)
                    : NetworkImage(controller.userService.appUser!.avatarUrl!)
                        as ImageProvider,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 16.w,
                    child: IconButton(
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                        ),
                        builder: (context) => Container(
                          height: 120.h,
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.w),
                                child: Material(
                                  color:
                                      Get.theme.primaryColor.withOpacity(0.3),
                                  child: InkWell(
                                    onTap: () async {
                                      final pickedImage = await controller
                                          .imagePicker
                                          .pickImage(
                                        source: ImageSource.camera,
                                      );

                                      if (pickedImage != null) {
                                        final croppedFile =
                                            await ImageCropper.cropImage(
                                          sourcePath: pickedImage.path,
                                          aspectRatioPresets: [
                                            CropAspectRatioPreset.square
                                          ],
                                        );

                                        if (croppedFile != null) {
                                          final res = await controller
                                              .userService
                                              .updateProfilePicture(
                                                  croppedFile);

                                          Get.back();
                                          if (res['status'] as bool) {
                                            showSnackBar(
                                              type: SnackbarType.success,
                                              message:
                                                  'Profile photo updated successfully',
                                            );
                                          } else {
                                            showSnackBar(
                                              type: SnackbarType.error,
                                              message: res['error'] as String,
                                            );
                                          }
                                        }
                                      }
                                    },
                                    child: SizedBox(
                                      height: 120.h,
                                      width: 100.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.camera_alt,
                                            size: 40.h,
                                            color: Get.theme.primaryColor,
                                          ),
                                          SizedBox(height: 6.w),
                                          const Text('Open Camera')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.w),
                                child: Material(
                                  color: Colors.blue.withOpacity(0.3),
                                  child: InkWell(
                                    onTap: () {},
                                    child: SizedBox(
                                      height: 120.h,
                                      width: 100.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.photo,
                                            size: 40.h,
                                            color: Colors.blue.shade800,
                                          ),
                                          SizedBox(height: 6.w),
                                          const Text('Open Galley')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      icon: Icon(Icons.camera_alt, size: 18.w),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              controller.userService.appUser!.name!,
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone_android, size: 16.sp),
                    SizedBox(width: 5.w),
                    Text(
                      '${controller.userService.appUser!.mobileNumber!}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.mail_outline_rounded, size: 16.sp),
                    SizedBox(width: 5.w),
                    Text(
                      controller.userService.appUser!.email!,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        Positioned(
          right: 10,
          top: 10,
          child: OutlinedButton.icon(
            onPressed: () async {
              final alreadyExist = await supabase.storage
                  .from('avatars')
                  .remove(['96c91284-dd5d-4d55-902e-2a543ad5dfdc.jpg']);
              print(alreadyExist.error?.error);
              print(alreadyExist.error?.message);
            },
            icon: const Icon(Icons.edit),
            label: const Text('Edit'),
            style: OutlinedButton.styleFrom(shape: const StadiumBorder()),
          ),
        ),
      ],
    );
  }
}
