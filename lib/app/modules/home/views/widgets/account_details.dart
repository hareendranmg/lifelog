import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../services/account_services.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    Key? key,
    required this.accountLabel,
    required this.amount,
    required this.textColor,
    required this.icon,
  }) : super(key: key);

  final String accountLabel;
  final double amount;
  final Color textColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.find<AccountService>().getIncomeCategoryWiseAmount(3),
      child: Container(
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
                    accountLabel,
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Text(
                        '$amount',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                      const Spacer(),
                      Transform.rotate(
                        angle: 1,
                        child: Icon(
                          icon,
                          // ? Icons.arrow_drop_up
                          // : Icons.arrow_drop_down,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
