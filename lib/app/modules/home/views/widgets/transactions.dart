import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class Transactions extends StatelessWidget {
  const Transactions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
