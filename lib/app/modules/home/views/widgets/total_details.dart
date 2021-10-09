import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../services/account_services.dart';
import 'account_details.dart';

class TotalDetails extends StatelessWidget {
  const TotalDetails({
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
                'Total',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w300),
              ),
              Text(
                '₹${Get.find<AccountService>().totalBalance}',
                style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.only(left: 20),
          alignment: Alignment.topLeft,
          child: Text(
            'You have ${Get.find<AccountService>().totalRemainingPercent}% income remaining',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        SizedBox(height: 25.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AccountWidget(
              accountLabel: 'Income',
              amount: Get.find<AccountService>().totalIncome,
              textColor: Colors.green[600]!,
              icon: Icons.arrow_upward,
            ),
            AccountWidget(
              accountLabel: 'Expense',
              amount: Get.find<AccountService>().totalExpense,
              textColor: Colors.red,
              icon: Icons.arrow_downward,
            ),
          ],
        )
      ],
    );
  }
}
