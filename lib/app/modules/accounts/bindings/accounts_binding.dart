import 'package:get/get.dart';

import '../controllers/accounts_controller.dart';

class AccountsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountsController>(
      () => AccountsController(),
    );
  }
}
