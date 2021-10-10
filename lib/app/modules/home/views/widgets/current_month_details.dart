import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../routes/app_pages.dart';
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
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
              Text(
                DateFormat.yMMMM().format(DateTime.now()),
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
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
          children: [
            AccountWidget(
              accountLabel: 'Income',
              amount: Get.find<AccountService>().currentMonthIncome,
              textColor: Colors.green[600]!,
              icon: Icons.arrow_downward,
              route: Routes.ADD_INCOME,
            ),
            AccountWidget(
              accountLabel: 'Expense',
              amount: Get.find<AccountService>().currentMonthExpense,
              textColor: Colors.red,
              icon: Icons.arrow_upward,
              route: Routes.ADD_EXPENSE,
            ),
          ],
        )
      ],
    );
  }
}
