import 'package:get/get.dart';

import '../controllers/transactions_controller.dart';

class TransactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionsController>(
      () => TransactionsController(),
    );
  }
}
