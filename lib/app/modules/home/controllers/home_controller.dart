import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/account_services.dart';
import '../../../services/other_services.dart';
import '../../../utils/general_utils.dart';
import 'home_base_controller.dart';

class HomeController extends HomeBaseController {
  void pickFile() {
    OtherServices.pickFile().then((fileRes) {
      if (fileRes != null) {
        file = fileRes['file'] as File;
        fileName = fileRes['fileName'] as String;
      }
    });
  }

  void removeFile() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Remove file'),
        content: const Text('Are you sure you want to remove the file?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          ElevatedButton(
            child: const Text('Remove'),
            onPressed: () {
              file = null;
              fileName = null;
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Future<void> addIncome() async {
    if (addIncomeFormKey.currentState?.saveAndValidate() ?? false) {
      isDataUploading = true;
      final formData = {
        'user_id': appUser.id,
        'account': addIncomeFormKey.currentState?.value['account'],
        'income_category':
            addIncomeFormKey.currentState?.value['income_category'],
        'amount': addIncomeFormKey.currentState?.value['amount'],
        'remarks': addIncomeFormKey.currentState?.value['remarks'],
        'date': (addIncomeFormKey.currentState?.value['date'] as DateTime)
            .toIso8601String(),
      };

      final addIncomeRes =
          await Get.find<AccountService>().addIncome(formData, file: file);
      if (addIncomeRes['status'] as bool) {
        showSnackBar(
          type: SnackbarType.success,
          message: 'Income added successfully',
        );
      } else {
        showSnackBar(
          type: SnackbarType.error,
          message: addIncomeRes['message'] as String,
        );
      }
      isDataUploading = false;
    }
  }

  Future<void> addExpense() async {
    if (addExpenseFormKey.currentState?.saveAndValidate() ?? false) {
      isDataUploading = true;
      final formData = {
        'user_id': appUser.id,
        'account': addExpenseFormKey.currentState?.value['account'],
        'expense_category':
            addExpenseFormKey.currentState?.value['expense_category'],
        'amount': addExpenseFormKey.currentState?.value['amount'],
        'remarks': addExpenseFormKey.currentState?.value['remarks'],
        'date': (addExpenseFormKey.currentState?.value['date'] as DateTime)
            .toIso8601String(),
      };

      final addExpenseRes =
          await Get.find<AccountService>().addExpense(formData, file: file);
      if (addExpenseRes['status'] as bool) {
        showSnackBar(
          type: SnackbarType.success,
          message: 'Expense added successfully',
        );
      } else {
        showSnackBar(
          type: SnackbarType.error,
          message: addExpenseRes['message'] as String,
        );
      }
      isDataUploading = false;
    }
  }
}
