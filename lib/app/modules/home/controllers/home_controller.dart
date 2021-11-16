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

  Future<void> addAccount() async {
    try {
      if (addAccountFormKey.currentState?.saveAndValidate() ?? false) {
        isDataUploading = true;
        final res = await Get.find<AccountService>().addAccount(
          accountName: addAccountFormKey.currentState!.value['name'] as String,
          initialAmount: double.parse(
            addAccountFormKey.currentState!.value['amount'] as String,
          ),
          remarks:
              addAccountFormKey.currentState?.value['remarks'] as String? ?? '',
        );
        isDataUploading = false;

        if (res['status'] as bool) {
          update();
          Get.back();
          showSnackBar(
            type: SnackbarType.success,
            message: 'Successfully added new account.',
          );
        } else {
          showSnackBar(
            type: SnackbarType.error,
            message: res['message'] as String,
          );
        }
      }
    } catch (e) {
      isDataUploading = false;
      showSnackBar(type: SnackbarType.error, message: e.toString());
    }
  }

  Future<void> editAccount(final int id) async {
    try {
      if (editAccountFormKey.currentState?.saveAndValidate() ?? false) {
        isDataUploading = true;
        final res = await Get.find<AccountService>().editAccount(
          id: id,
          accountName: editAccountFormKey.currentState!.value['name'] as String,
          initialAmount: double.parse(
            editAccountFormKey.currentState!.value['amount'] as String,
          ),
          remarks:
              editAccountFormKey.currentState?.value['remarks'] as String? ??
                  '',
        );
        isDataUploading = false;

        if (res['status'] as bool) {
          update();
          Get.back();
          showSnackBar(
            type: SnackbarType.success,
            message: 'Successfully edited the account.',
          );
        } else {
          showSnackBar(
            type: SnackbarType.error,
            message: res['message'] as String,
          );
        }
      }
    } catch (e) {
      isDataUploading = false;
      showSnackBar(type: SnackbarType.error, message: e.toString());
    }
  }

  Future<void> deleteAccount(final int id) async {
    try {
      showCustomLoadingIndicator();

      final res = await Get.find<AccountService>().deleteAccount(id: id);

      Get.back();
      if (res['status'] as bool) {
        if (selectedAccount?.id == id) {
          selectedAccount = null;
        }
        update();
        Get.back();
        Get.back();
        showSnackBar(
          type: SnackbarType.success,
          message: 'Successfully deleted the account.',
        );
      } else {
        showSnackBar(
          type: SnackbarType.error,
          message: res['message'] as String,
        );
      }
    } catch (e) {
      Get.back();
      isDataUploading = false;
      showSnackBar(type: SnackbarType.error, message: e.toString());
    }
  }

  Future<void> addIncomeCat() async {
    try {
      if (addIncomeCatFormKey.currentState?.saveAndValidate() ?? false) {
        isDataUploading = true;
        final res = await Get.find<AccountService>().addIncomeCat(
          categoryName:
              addIncomeCatFormKey.currentState!.value['name'] as String,
          remarks:
              addIncomeCatFormKey.currentState?.value['remarks'] as String? ??
                  '',
        );
        isDataUploading = false;

        if (res['status'] as bool) {
          update();
          Get.back();
          showSnackBar(
            type: SnackbarType.success,
            message: 'Successfully added new income category.',
          );
        } else {
          showSnackBar(
            type: SnackbarType.error,
            message: res['message'] as String,
          );
        }
      }
    } catch (e) {
      isDataUploading = false;
      showSnackBar(type: SnackbarType.error, message: e.toString());
    }
  }

  Future<void> editIncomeCat(final int id) async {
    try {
      if (editIncomeCatFormKey.currentState?.saveAndValidate() ?? false) {
        isDataUploading = true;
        final res = await Get.find<AccountService>().editIncomeCat(
          id: id,
          categoryName:
              editIncomeCatFormKey.currentState!.value['name'] as String,
          remarks:
              editIncomeCatFormKey.currentState?.value['remarks'] as String? ??
                  '',
        );
        isDataUploading = false;

        if (res['status'] as bool) {
          update();
          Get.back();
          showSnackBar(
            type: SnackbarType.success,
            message: 'Successfully edited the income category.',
          );
        } else {
          showSnackBar(
            type: SnackbarType.error,
            message: res['message'] as String,
          );
        }
      }
    } catch (e) {
      isDataUploading = false;
      showSnackBar(type: SnackbarType.error, message: e.toString());
    }
  }

  Future<void> deleteIncomeCat(final int id) async {
    try {
      showCustomLoadingIndicator();

      final res = await Get.find<AccountService>().deleteIncomeCat(id: id);

      Get.back();
      if (res['status'] as bool) {
        if (selectedIncCat?.id == id) {
          selectedIncCat = null;
        }
        update();
        Get.back();
        Get.back();
        showSnackBar(
          type: SnackbarType.success,
          message: 'Successfully deleted the income category.',
        );
      } else {
        showSnackBar(
          type: SnackbarType.error,
          message: res['message'] as String,
        );
      }
    } catch (e) {
      Get.back();
      isDataUploading = false;
      showSnackBar(type: SnackbarType.error, message: e.toString());
    }
  }

  Future<void> addExpenseCat() async {
    try {
      if (addExpenseCatFormKey.currentState?.saveAndValidate() ?? false) {
        isDataUploading = true;
        final res = await Get.find<AccountService>().addExpenseCat(
          categoryName:
              addExpenseCatFormKey.currentState!.value['name'] as String,
          remarks:
              addExpenseCatFormKey.currentState?.value['remarks'] as String? ??
                  '',
        );
        isDataUploading = false;

        if (res['status'] as bool) {
          update();
          Get.back();
          showSnackBar(
            type: SnackbarType.success,
            message: 'Successfully added new expense category.',
          );
        } else {
          showSnackBar(
            type: SnackbarType.error,
            message: res['message'] as String,
          );
        }
      }
    } catch (e) {
      isDataUploading = false;
      showSnackBar(type: SnackbarType.error, message: e.toString());
    }
  }

  Future<void> editExpenseCat(final int id) async {
    try {
      if (editExpenseCatFormKey.currentState?.saveAndValidate() ?? false) {
        isDataUploading = true;
        final res = await Get.find<AccountService>().editExpenseCat(
          id: id,
          categoryName:
              editExpenseCatFormKey.currentState!.value['name'] as String,
          remarks:
              editExpenseCatFormKey.currentState?.value['remarks'] as String? ??
                  '',
        );
        isDataUploading = false;

        if (res['status'] as bool) {
          update();
          Get.back();
          showSnackBar(
            type: SnackbarType.success,
            message: 'Successfully edited the expense category.',
          );
        } else {
          showSnackBar(
            type: SnackbarType.error,
            message: res['message'] as String,
          );
        }
      }
    } catch (e) {
      isDataUploading = false;
      showSnackBar(type: SnackbarType.error, message: e.toString());
    }
  }

  Future<void> deleteExpenseCat(final int id) async {
    try {
      showCustomLoadingIndicator();

      final res = await Get.find<AccountService>().deleteExpenseCat(id: id);

      Get.back();
      if (res['status'] as bool) {
        if (selectedExpCat?.id == id) {
          selectedExpCat = null;
        }
        update();
        Get.back();
        Get.back();
        showSnackBar(
          type: SnackbarType.success,
          message: 'Successfully deleted the expense category.',
        );
      } else {
        showSnackBar(
          type: SnackbarType.error,
          message: res['message'] as String,
        );
      }
    } catch (e) {
      Get.back();
      isDataUploading = false;
      showSnackBar(type: SnackbarType.error, message: e.toString());
    }
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
    try {
      if (addIncomeFormKey.currentState?.saveAndValidate() ?? false) {
        if (selectedAccount == null) {
          showSnackBar(
            type: SnackbarType.warning,
            message: 'Please select an account.',
          );
          return;
        }
        if (selectedIncCat == null) {
          showSnackBar(
            type: SnackbarType.warning,
            message: 'Please select an income category.',
          );
          return;
        }

        isDataUploading = true;
        final formData = {
          'user_id': appUser.id,
          'account': selectedAccount!.id,
          'income_category': selectedIncCat!.id,
          'amount': addIncomeFormKey.currentState?.value['amount'],
          'remarks': addIncomeFormKey.currentState?.value['remarks'] ?? '',
          'date': (addIncomeFormKey.currentState?.value['date'] as DateTime)
              .toIso8601String(),
        };

        final addIncomeRes =
            await Get.find<AccountService>().addIncome(formData, file: file);
        if (addIncomeRes['status'] as bool) {
          addIncomeFormKey.currentState?.reset();
          file = null;
          fileName = null;
          selectedAccount = null;
          selectedIncCat = null;
          update();
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
    } catch (e) {
      showSnackBar(
        type: SnackbarType.error,
        message: e.toString(),
      );
    }
  }

  Future<void> addExpense() async {
    try {
      if (addExpenseFormKey.currentState?.saveAndValidate() ?? false) {
        if (selectedAccount == null) {
          showSnackBar(
            type: SnackbarType.warning,
            message: 'Please select an account.',
          );
          return;
        }
        if (selectedExpCat == null) {
          showSnackBar(
            type: SnackbarType.warning,
            message: 'Please select an expense category.',
          );
          return;
        }
        isDataUploading = true;
        final formData = {
          'user_id': appUser.id,
          'account': selectedAccount!.id,
          'expense_category': selectedExpCat!.id,
          'amount': addExpenseFormKey.currentState?.value['amount'],
          'remarks': addExpenseFormKey.currentState?.value['remarks'] ?? '',
          'date': (addExpenseFormKey.currentState?.value['date'] as DateTime)
              .toIso8601String(),
        };

        final addExpenseRes =
            await Get.find<AccountService>().addExpense(formData, file: file);
        if (addExpenseRes['status'] as bool) {
          addExpenseFormKey.currentState?.reset();
          file = null;
          fileName = null;
          selectedAccount = null;
          selectedIncCat = null;
          update();
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
    } catch (e) {
      showSnackBar(
        type: SnackbarType.error,
        message: e.toString(),
      );
    }
  }
}
