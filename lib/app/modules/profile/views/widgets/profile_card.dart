import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
              child: GetBuilder<ProfileController>(
                  builder: (_) => CachedNetworkImage(
                        imageUrl: controller.userService.appUser!.avatarUrl ??
                            AssetUrls.SERVER_USER,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 40.w,
                          backgroundImage: imageProvider,
                          child: _.isUpdatingProPic
                              ? const Align(child: CircularProgressIndicator())
                              : Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    radius: 16.w,
                                    child: IconButton(
                                      onPressed: () => showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10)),
                                        ),
                                        builder: (context) => Container(
                                          height: 120.h,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.w),
                                                child: Material(
                                                  color: Get.theme.errorColor
                                                      .withOpacity(0.2),
                                                  child: InkWell(
                                                    onTap: () => controller
                                                        .removeProfilePicture(),
                                                    child: SizedBox(
                                                      height: 120.h,
                                                      width: Get.width * 0.27,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.delete,
                                                            size: 40.h,
                                                            color: Get.theme
                                                                .errorColor,
                                                          ),
                                                          SizedBox(height: 6.w),
                                                          const Text(
                                                              'Remove Photo')
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.w),
                                                child: Material(
                                                  color: Get.theme.primaryColor
                                                      .withOpacity(0.2),
                                                  child: InkWell(
                                                    onTap: () => controller
                                                        .updateProfilePicture(
                                                            isCamera: true),
                                                    child: SizedBox(
                                                      height: 120.h,
                                                      width: Get.width * 0.27,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.camera_alt,
                                                            size: 40.h,
                                                            color: Get.theme
                                                                .primaryColor,
                                                          ),
                                                          SizedBox(height: 6.w),
                                                          const Text(
                                                              'Open Camera')
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.w),
                                                child: Material(
                                                  color: Colors.blue
                                                      .withOpacity(0.2),
                                                  child: InkWell(
                                                    onTap: () => controller
                                                        .updateProfilePicture(
                                                            isCamera: false),
                                                    child: SizedBox(
                                                      height: 120.h,
                                                      width: Get.width * 0.27,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.photo,
                                                            size: 40.h,
                                                            color: Colors
                                                                .blue.shade800,
                                                          ),
                                                          SizedBox(height: 6.w),
                                                          const Text(
                                                              'Open Galley')
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
                        errorWidget: (context, url, error) =>
                            Image.asset(AssetUrls.USER),
                      )),
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
            onPressed: () async {},
            icon: const Icon(Icons.edit),
            label: const Text('Edit'),
            style: OutlinedButton.styleFrom(shape: const StadiumBorder()),
          ),
        ),
      ],
    );
  }
}
