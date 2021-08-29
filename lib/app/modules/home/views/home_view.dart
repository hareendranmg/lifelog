import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import 'widgets/account_area.dart';
import 'widgets/header.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            const Header(),
            const SizedBox(height: 30),
            const AccountArea(),
            const SizedBox(height: 30),
            Column(
              children: [
                Row(
                  children: [
                    Text('Transactions', style: TextStyle(fontSize: 18.sp)),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Get.toNamed(Routes.TRANSACTIONS),
                      child: Row(
                        children: const [
                          Text('See all'),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward_ios, size: 16)
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
