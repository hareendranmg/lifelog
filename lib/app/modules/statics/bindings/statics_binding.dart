import 'package:get/get.dart';

import '../controllers/statics_controller.dart';

class StaticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaticsController>(
      () => StaticsController(),
    );
  }
}
