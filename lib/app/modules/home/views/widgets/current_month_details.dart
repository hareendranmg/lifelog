import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../services/account_services.dart';
import 'account_details.dart';

class CurrentMonthDetails extends StatelessWidget {
  const CurrentMonthDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${Get.find<AccountService>().currentMonthBalance}',
                style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w500),
              ),
              Text(
                DateFormat.yMMMM().format(DateTime.now()),
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.only(left: 20),
          alignment: Alignment.topLeft,
          child: Text(
            'You have ${Get.find<AccountService>().currentMonthRemainingPercent}% income remaining',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        const SizedBox(height: 15),
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