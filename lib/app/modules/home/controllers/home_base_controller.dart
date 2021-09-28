import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/user_services.dart';

class HomeBaseController extends GetxController {
  final appUser = Get.find<UserService>().appUser!;
  final pageController = PageController();
}
