import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/user_services.dart';

class ProfileBaseController extends GetxController {
  final userService = Get.find<UserService>();

  final imagePicker = ImagePicker();
  XFile? image;

  bool _isUpdatingProPic = false;

  bool get isUpdatingProPic => _isUpdatingProPic;
  set isUpdatingProPic(final bool v) => {_isUpdatingProPic = v, update()};
}
