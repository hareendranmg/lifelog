import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../services/account_services.dart';

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
                          ? '₹${Get.find<AccountService>().currentMonthIncome}'
                          : '₹${Get.find<AccountService>().currentMonthExpense}',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: accountType == 'income'
                            ? Colors.green
                            : Colors.red[600],
                      ),
                    ),
                    const Spacer(),
                    Transform.rotate(
                      angle: 1,
                      child: Icon(
                        accountType == 'income'
                            ? Icons.arrow_downward_rounded
                            : Icons.arrow_upward_rounded,
                        color: accountType == 'income'
                            ? Colors.green
                            : Colors.red[600],
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
