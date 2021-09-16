import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/asset_urls.dart';
import '../../controllers/profile_controller.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 40.w,
      child: GetBuilder<ProfileController>(
        builder: (_) => CachedNetworkImage(
          imageUrl: _.userService.appUser!.avatarUrl ?? AssetUrls.SERVER_USER,
          placeholder: (context, url) => const CircularProgressIndicator(),
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
                              top: Radius.circular(10),
                            ),
                          ),
                          builder: (context) => Container(
                            height: 120.h,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.w),
                                  child: Material(
                                    color:
                                        Get.theme.errorColor.withOpacity(0.1),
                                    child: InkWell(
                                      onTap: () => _.removeProfilePicture(),
                                      child: SizedBox(
                                        height: 120.h,
                                        width: Get.width * 0.27,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              size: 40.h,
                                              color: Get.theme.errorColor,
                                            ),
                                            SizedBox(height: 6.w),
                                            Text(
                                              'Remove Photo',
                                              style: TextStyle(
                                                color: Get.theme.errorColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.w),
                                  child: Material(
                                    color:
                                        Get.theme.primaryColor.withOpacity(0.1),
                                    child: InkWell(
                                      onTap: () => _.updateProfilePicture(
                                        isCamera: true,
                                      ),
                                      child: SizedBox(
                                        height: 120.h,
                                        width: Get.width * 0.27,
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
                                            Text(
                                              'Open Camera',
                                              style: TextStyle(
                                                color: Get.theme.primaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.w),
                                  child: Material(
                                    color: Colors.blue.withOpacity(0.1),
                                    child: InkWell(
                                      onTap: () => _.updateProfilePicture(
                                        isCamera: false,
                                      ),
                                      child: SizedBox(
                                        height: 120.h,
                                        width: Get.width * 0.27,
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
                                            Text(
                                              'Open Galley',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                              ),
                                            )
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
          errorWidget: (context, url, error) => Image.asset(AssetUrls.USER),
        ),
      ),
    );
  }
}
