import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'widgets/account_area.dart';
import 'widgets/header.dart';
import 'widgets/quick_actions.dart';
import 'widgets/transactions.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: const [
            Header(),
            SizedBox(height: 5),
            AccountArea(),
            SizedBox(height: 20),
            QuickActions(),
            Transactions(),
          ],
        ),
      ),
    );
  }
}
