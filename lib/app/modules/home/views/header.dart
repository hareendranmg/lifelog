import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: TextStyle(fontSize: 16.sp),
            ),
            Text(
              controller.user.email!,
              style: TextStyle(fontSize: 24.sp),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () => Get.toNamed(Routes.PROFILE),
          icon: Icon(Icons.person, size: 26.sp),
        )
      ],
    );
  }
}
