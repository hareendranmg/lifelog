import 'package:get/get.dart';

import '../../../services/user_services.dart';

class HomeController extends GetxController {
  final appUser = Get.find<UserService>().appUser!;
}
