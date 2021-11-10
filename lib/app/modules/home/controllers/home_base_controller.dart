import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../services/user_services.dart';

class HomeBaseController extends GetxController {
  final appUser = Get.find<UserService>().appUser!;
  final pageController = PageController();
  final addIncomeFormKey = GlobalKey<FormBuilderState>();
  final addExpenseFormKey = GlobalKey<FormBuilderState>();
}
