import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/account.dart';
import '../data/expense.dart';
import '../data/expense_category.dart';
import '../data/income.dart';
import '../data/income_category.dart';
import '../utils/constants.dart';

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
      currentMonthRemainingPercent =
          ((currentMonthBalance / currentMonthIncome) * 100).toPrecision(2);
    } catch (e) {
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
      totalRemainingPercent =
          ((totalBalance / totalIncome) * 100).toPrecision(2);
    } catch (e) {
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
      debugPrint(e.toString());
      return accounts;
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
      debugPrint(e.toString());
      return [];
    }
  }

  Future<Map<String, dynamic>?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg'],
      withData: true,
      withReadStream: true,
    );

    if (result != null) {
      final fileName = result.files[0].name;
      final file = File(result.files[0].path!);
      return {
        'fileName': fileName,
        'file': file,
      };
    }
    return null;
  }
}
