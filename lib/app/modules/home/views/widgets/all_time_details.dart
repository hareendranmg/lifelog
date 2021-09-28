import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../services/account_services.dart';
import 'account_details.dart';

class AllTimeDetails extends StatelessWidget {
  const AllTimeDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '₹${Get.find<AccountService>().balance}',
          style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5.h),
        Text(
          'You have ${Get.find<AccountService>().remainingPercentage}% income remaining',
          style: TextStyle(color: Colors.grey[600]),
        ),
        SizedBox(height: 25.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            AccountWidget(accountType: 'income'),
            AccountWidget(accountType: 'expense'),
          ],
        )
      ],
    );
  }
}
