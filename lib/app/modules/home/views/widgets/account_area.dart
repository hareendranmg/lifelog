import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../services/account_services.dart';

class AccountArea extends StatelessWidget {
  const AccountArea({
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

class AccountWidget extends StatelessWidget {
  const AccountWidget({Key? key, required this.accountType}) : super(key: key);

  final String accountType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: Get.width * 0.4,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 20,
            spreadRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  accountType == 'income' ? 'Income' : 'Expense',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Text(
                      accountType == 'income'
                          ? '₹${Get.find<AccountService>().income}'
                          : '₹${Get.find<AccountService>().expense}',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Transform.rotate(
                      angle: 1,
                      child: Icon(
                        accountType == 'income'
                            ? Icons.arrow_downward_rounded
                            : Icons.arrow_upward_rounded,
                        color:
                            accountType == 'income' ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
