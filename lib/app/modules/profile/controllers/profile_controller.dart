import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/user_services.dart';

class ProfileController extends GetxController {
  final appUser = Get.find<UserService>().appUser!;

  final imagePicker = ImagePicker();
  XFile? image;
  //   // Pick an image
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   // Capture a photo
  //   final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
}
