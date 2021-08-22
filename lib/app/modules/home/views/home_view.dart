import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'header.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Header(controller: controller),
            const SizedBox(height: 20),
            Row(
              children: const [Card()],
            )
          ],
        ),
      ),
    );
  }
}
