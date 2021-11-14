import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/custom_scaffold.dart';
import '../controllers/home_controller.dart';

class EditExpenseCatView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppbar(title: 'Edit Expense Categories'),
      body: Container(),
    );
  }
}
