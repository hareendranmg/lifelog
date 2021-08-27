import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/global_widgets.dart';
import 'profile_base_controller.dart';

class ProfileController extends ProfileBaseController {
  Future<void> updateProfilePicture({required final bool isCamera}) async {
    final pickedImage = await imagePicker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (pickedImage != null) {
      final croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );

      if (croppedFile != null) {
        isUpdatingProPic = true;
        final res = await userService.updateProfilePicture(croppedFile);
        await CachedNetworkImage.evictFromCache(
            userService.appUser!.avatarUrl!);
        isUpdatingProPic = false;

        Get.back();
        if (res) {
          showSnackBar(
            type: SnackbarType.success,
            message: 'Profile photo updated successfully',
          );
        } else {
          showSnackBar(
            type: SnackbarType.error,
            message: 'Failed to update profile picture.',
          );
        }
      }
    }
  }

  Future<void> removeProfilePicture() async {
    try {
      if (userService.appUser?.avatarUrl == null) return;
      showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          content: const Text('Are you sure to remove profile picture?'),
          actions: [
            TextButton(
                onPressed: () => Get.back(), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                Get.back();
                Get.back();
                isUpdatingProPic = true;
                await CachedNetworkImage.evictFromCache(
                    userService.appUser!.avatarUrl!);
                await userService.removeProfilePicture();
                isUpdatingProPic = false;

                showSnackBar(
                  type: SnackbarType.success,
                  message: 'Profile photo removed successfully',
                );
              },
              child: const Text('Remove'),
            ),
          ],
        ),
      );
    } catch (e) {
      showSnackBar(
        type: SnackbarType.error,
        message: 'Failed to remove profile picture.',
      );
    }
  }
}
