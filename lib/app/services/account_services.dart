import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart' as p;

import '../data/account.dart';
import '../data/expense.dart';
import '../data/expense_category.dart';
import '../data/income.dart';
import '../data/income_category.dart';
import '../utils/constants.dart';
import 'user_services.dart';

class AccountService extends GetxService {
  final box = GetStorage();

  final startDate =
      DateTime(DateTime.now().year, DateTime.now().month).toIso8601String();
  final endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
      .toIso8601String();

  List<Account> accounts = [];

  List<IncomeCategory> incomeCategories = [];
  List<ExpenseCategory> expenseCategories = [];

  List<Income> currentIncomeList = [];
  List<Expense> currentExpenseList = [];
  List<Income> totalIncomeList = [];
  List<Expense> totalExpenseList = [];

  double currentMonthIncome = 0;
  double currentMonthExpense = 0;
  double currentMonthBalance = 0;
  double currentMonthRemainingPercent = 0;

  double totalIncome = 0;
  double totalExpense = 0;
  double totalBalance = 0;
  double totalRemainingPercent = 0;

  Future<AccountService> init() async {
    await getAccounts();
    await getCurrentMonthAccountDet();
    await getTotalAccountDet();
    return this;
  }

  Future<void> getCurrentMonthAccountDet() async {
    try {
      currentIncomeList.clear();
      currentExpenseList.clear();
      await getIncomeCategories();

      for (final incomeCategory in incomeCategories) {
        final incomeList = await getIncomeCategoryWiseAmount(
          incomeCategory.id,
          startDate: startDate,
          endDate: endDate,
        );
        currentIncomeList.addAll(incomeList);
      }

      await getExpenseCategories();
      for (final expenseCategory in expenseCategories) {
        final expenseList = await getExpenseCategoryWiseAmount(
          expenseCategory.id,
          startDate: startDate,
          endDate: endDate,
        );
        currentExpenseList.addAll(expenseList);
      }

      currentMonthIncome = currentIncomeList.fold(0, (a, b) => a + b.amount);
      currentMonthExpense = currentExpenseList.fold(0, (a, b) => a + b.amount);
      currentMonthBalance = currentMonthIncome - currentMonthExpense;
      currentMonthRemainingPercent = currentMonthIncome == 0
          ? 0
          : ((currentMonthBalance / currentMonthIncome) * 100).toPrecision(2);
    } catch (e) {
      //print('getCurrentMonthAccountDet');
      currentMonthIncome = 0;
      currentMonthExpense = 0;
      currentMonthBalance = 0;
      currentMonthRemainingPercent = 0;
      debugPrint(e.toString());
    }
  }

  Future<void> getTotalAccountDet() async {
    try {
      totalIncomeList.clear();
      totalExpenseList.clear();
      await getIncomeCategories();
      for (final incomeCategory in incomeCategories) {
        final incomeList = await getIncomeCategoryWiseAmount(incomeCategory.id);
        totalIncomeList.addAll(incomeList);
      }

      await getExpenseCategories();
      for (final expenseCategory in expenseCategories) {
        final expenseList =
            await getExpenseCategoryWiseAmount(expenseCategory.id);
        totalExpenseList.addAll(expenseList);
      }

      totalIncome = totalIncomeList.fold(0, (a, b) => a + b.amount);
      totalExpense = totalExpenseList.fold(0, (a, b) => a + b.amount);
      totalBalance = totalIncome - totalExpense;
      totalRemainingPercent = totalIncome == 0
          ? 0
          : ((totalBalance / totalIncome) * 100).toPrecision(2);
    } catch (e) {
      //print('getTotalAccountDet');
      totalIncome = 0;
      totalExpense = 0;
      totalBalance = 0;
      totalRemainingPercent = 0;
      debugPrint(e.toString());
    }
  }

  Future<List<Account>> getAccounts() async {
    try {
      accounts.clear();
      return accounts = await supabase.from('accounts').select().execute().then(
            (value) => List<Account>.from(
              (value.data as List)
                  .map((e) => Account.fromJson(e as Map<String, dynamic>))
                  .toList(),
            ),
          );
    } catch (e) {
      //print('getAccounts');
      debugPrint(e.toString());
      return accounts;
    }
  }

  Future<Map<String, dynamic>> addAccount({
    required final String accountName,
    required final double initialAmount,
    required final String remarks,
  }) async {
    try {
      final formData = {
        'user_id': Get.find<UserService>().appUser!.id,
        'name': accountName,
        'amount': initialAmount,
        'remarks': remarks,
      };

      final response =
          await supabase.from('accounts').insert(formData).execute();
      if (response.error == null) {
        await getAccounts();
        return {'status': true};
      } else {
        return {'status': false, 'message': response.error.toString()};
      }
    } catch (e) {
      //print('addAccount');
      return {'status': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> editAccount({
    required final int id,
    required final String accountName,
    required final double initialAmount,
    required final String remarks,
  }) async {
    try {
      final formData = {
        'name': accountName,
        'amount': initialAmount,
        'remarks': remarks,
      };

      final response = await supabase
          .from('accounts')
          .update(formData)
          .eq('id', id)
          .execute();
      if (response.error == null) {
        await getAccounts();
        return {'status': true};
      } else {
        return {'status': false, 'message': response.error.toString()};
      }
    } catch (e) {
      //print('editAccount');
      return {'status': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteAccount({
    required final int id,
  }) async {
    try {
      final response =
          await supabase.from('accounts').delete().eq('id', id).execute();
      if (response.error == null) {
        await getAccounts();
        return {'status': true};
      } else {
        return {'status': false, 'message': response.error.toString()};
      }
    } catch (e) {
      //print('deleteAccount');
      return {'status': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> addIncomeCat({
    required final String categoryName,
    required final String remarks,
  }) async {
    try {
      final formData = {
        'user_id': Get.find<UserService>().appUser!.id,
        'name': categoryName,
        'remarks': remarks,
      };

      final response =
          await supabase.from('income_categories').insert(formData).execute();
      if (response.error == null) {
        await getIncomeCategories();
        return {'status': true};
      } else {
        return {'status': false, 'message': response.error.toString()};
      }
    } catch (e) {
      //print('addIncomeCat');
      return {'status': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> editIncomeCat({
    required final int id,
    required final String categoryName,
    required final String remarks,
  }) async {
    try {
      final formData = {
        'name': categoryName,
        'remarks': remarks,
      };

      final response = await supabase
          .from('income_categories')
          .update(formData)
          .eq('id', id)
          .execute();
      if (response.error == null) {
        await getIncomeCategories();
        return {'status': true};
      } else {
        return {'status': false, 'message': response.error.toString()};
      }
    } catch (e) {
      //print('editIncomeCat');
      return {'status': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteIncomeCat({
    required final int id,
  }) async {
    try {
      final response = await supabase
          .from('income_categories')
          .delete()
          .eq('id', id)
          .execute();
      if (response.error == null) {
        await getIncomeCategories();
        return {'status': true};
      } else {
        return {'status': false, 'message': response.error.toString()};
      }
    } catch (e) {
      //print('deleteIncomeCat');
      return {'status': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> addExpenseCat({
    required final String categoryName,
    required final String remarks,
  }) async {
    try {
      final formData = {
        'user_id': Get.find<UserService>().appUser!.id,
        'name': categoryName,
        'remarks': remarks,
      };

      final response =
          await supabase.from('expense_categories').insert(formData).execute();
      if (response.error == null) {
        await getExpenseCategories();
        return {'status': true};
      } else {
        return {'status': false, 'message': response.error.toString()};
      }
    } catch (e) {
      //print('addExpenseCat');
      return {'status': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> editExpenseCat({
    required final int id,
    required final String categoryName,
    required final String remarks,
  }) async {
    try {
      final formData = {
        'name': categoryName,
        'remarks': remarks,
      };

      final response = await supabase
          .from('expense_categories')
          .update(formData)
          .eq('id', id)
          .execute();
      if (response.error == null) {
        await getExpenseCategories();
        return {'status': true};
      } else {
        return {'status': false, 'message': response.error.toString()};
      }
    } catch (e) {
      //print('editExpenseCat');
      return {'status': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteExpenseCat({
    required final int id,
  }) async {
    try {
      final response = await supabase
          .from('expense_categories')
          .delete()
          .eq('id', id)
          .execute();
      if (response.error == null) {
        await getExpenseCategories();
        return {'status': true};
      } else {
        return {'status': false, 'message': response.error.toString()};
      }
    } catch (e) {
      //print('deleteExpenseCat');
      return {'status': false, 'message': e.toString()};
    }
  }

  Future<List<IncomeCategory>> getIncomeCategories() async {
    try {
      final incomeCategoriesList = await supabase
          .from('income_categories')
          .select()
          .execute()
          .then((value) => value.data as List);

      return incomeCategories = List<IncomeCategory>.from(
        incomeCategoriesList
            .map((e) => IncomeCategory.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      //print('getIncomeCategories');
      debugPrint(e.toString());
      return incomeCategories;
    }
  }

  Future<List<ExpenseCategory>> getExpenseCategories() async {
    try {
      final expenseCategoriesList = await supabase
          .from('expense_categories')
          .select()
          .execute()
          .then((value) => value.data as List);

      return expenseCategories = List<ExpenseCategory>.from(
        expenseCategoriesList
            .map((e) => ExpenseCategory.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      //print('getExpenseCategories');
      debugPrint(e.toString());
      return expenseCategories;
    }
  }

  Future<List<Income>> getIncomeCategoryWiseAmount(
    int category, {
    final String? startDate,
    final String? endDate,
  }) async {
    try {
      if (startDate != null && endDate != null) {
        return await supabase
            .from('income')
            .select()
            .lte('created_at', endDate)
            .gte('created_at', startDate)
            .eq('income_category', category)
            .execute()
            .then(
              (value) => List<Income>.from(
                (value.data as List)
                    .map((e) => Income.fromJson(e as Map<String, dynamic>))
                    .toList(),
              ),
            );
      } else {
        final incomeList = await supabase
            .from('income')
            .select()
            .eq('income_category', category)
            .execute()
            .then(
              (value) => List<Income>.from(
                (value.data as List)
                    .map((e) => Income.fromJson(e as Map<String, dynamic>))
                    .toList(),
              ),
            );
        return incomeList;
      }
    } catch (e) {
      //print('getIncomeCategoryWiseAmount');
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Expense>> getExpenseCategoryWiseAmount(
    int category, {
    final String? startDate,
    final String? endDate,
  }) async {
    try {
      if (startDate != null && endDate != null) {
        return await supabase
            .from('expense')
            .select()
            .lte('created_at', endDate)
            .gte('created_at', startDate)
            .eq('expense_category', category)
            .execute()
            .then(
              (value) => List<Expense>.from(
                (value.data as List)
                    .map((e) => Expense.fromJson(e as Map<String, dynamic>))
                    .toList(),
              ),
            );
      } else {
        return await supabase
            .from('expense')
            .select()
            .eq('expense_category', category)
            .execute()
            .then(
              (value) => List<Expense>.from(
                (value.data as List)
                    .map((e) => Expense.fromJson(e as Map<String, dynamic>))
                    .toList(),
              ),
            );
      }
    } catch (e) {
      //print('getExpenseCategoryWiseAmount');
      debugPrint(e.toString());
      return [];
    }
  }

  Future<Map<String, dynamic>> addIncome(
    final Map<String, dynamic> formData, {
    final File? file,
  }) async {
    try {
      final response = await supabase.from('income').insert(formData).execute();
      if (response.error == null) {
        if (file != null) {
          final incomeId = response.data[0]['id'] as int;
          await supabase.storage
              .from('income-docs')
              .upload('$incomeId${p.extension(file.path)}', file);

          final publicUrl = supabase.storage
              .from('income-docs')
              .getPublicUrl('$incomeId${p.extension(file.path)}');

          await supabase
              .from('income')
              .update({'file_url': publicUrl.data})
              .eq('id', incomeId)
              .execute();
        }
        getCurrentMonthAccountDet();
        getTotalAccountDet();
        return {'status': true, 'message': 'Income added successfully'};
      } else {
        return {'status': false, 'message': response.error.toString()};
      }
    } catch (e) {
      //print('addIncome');
      debugPrint(e.toString());
      return {'status': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> addExpense(
    final Map<String, dynamic> formData, {
    final File? file,
  }) async {
    try {
      final response =
          await supabase.from('expense').insert(formData).execute();
      if (response.error == null) {
        if (file != null) {
          final expenseId = response.data[0]['id'] as int;
          await supabase.storage
              .from('expense-docs')
              .upload('$expenseId${p.extension(file.path)}', file);

          final publicUrl = supabase.storage
              .from('expense-docs')
              .getPublicUrl('$expenseId${p.extension(file.path)}');

          await supabase
              .from('expense')
              .update({'file_url': publicUrl.data})
              .eq('id', expenseId)
              .execute();
        }
        getCurrentMonthAccountDet();
        getTotalAccountDet();
        return {'status': true, 'message': 'Expense added successfully'};
      } else {
        return {'status': false, 'message': response.error.toString()};
      }
    } catch (e) {
      //print('addExpense');
      debugPrint(e.toString());
      return {'status': false, 'message': e.toString()};
    }
  }
}
