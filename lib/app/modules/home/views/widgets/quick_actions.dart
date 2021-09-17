import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: () => Get.toNamed(Routes.ACCOUNTS),
          icon: const Icon(Icons.account_balance_sharp),
          label: const Text('Accounts'),
        ),
        ElevatedButton.icon(
          onPressed: () => Get.toNamed(Routes.STATICS),
          icon: const Icon(Icons.bar_chart),
          label: const Text('Statics'),
        ),
        ElevatedButton.icon(
          onPressed: () => Get.toNamed(Routes.SETTINGS),
          icon: const Icon(Icons.settings_suggest),
          label: const Text('Settings'),
        ),
      ],
    );
  }
}
