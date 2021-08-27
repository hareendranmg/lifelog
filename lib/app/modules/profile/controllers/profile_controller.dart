import 'package:cached_network_image/cached_network_image.dart';
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
      isUpdatingProPic = true;
      await userService.removeProfilePicture();
      await CachedNetworkImage.evictFromCache(userService.appUser!.avatarUrl!);
      isUpdatingProPic = false;

      Get.back();

      showSnackBar(
        type: SnackbarType.success,
        message: 'Profile photo updated successfully',
      );
    } catch (e) {
      showSnackBar(
        type: SnackbarType.error,
        message: 'Failed to remove profile picture.',
      );
    }
  }
}
