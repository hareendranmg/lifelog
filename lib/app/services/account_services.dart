import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/account.dart';
import '../utils/constants.dart';

class AccountService extends GetxService {
  final box = GetStorage();
  int currentMonthIncome = 0;
  int currentMonthExpense = 0;
  int currentMonthBalance = 0;
  int currentMonthRemainingPercent = 0;

  int totalIncome = 0;
  int totalExpense = 0;
  int totalBalance = 0;
  int totalRemainingPercent = 0;

  Future<AccountService> init() async {
    await getCurrentMonthAccountDet();
    await getTotalAccountDet();
    return this;
  }

  Future<void> getCurrentMonthAccountDet() async {
    try {
      final incomeDbRes =
          await supabase.from('income').select('amount').execute();
      currentMonthIncome = incomeDbRes.data as int? ?? 0;
      final expenseDbRes =
          await supabase.from('expense').select('amount').execute();
      currentMonthExpense = expenseDbRes.data as int? ?? 0;

      currentMonthBalance = currentMonthIncome - currentMonthExpense;
      currentMonthRemainingPercent =
          100 - ((currentMonthBalance / currentMonthIncome) * 100).round();
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
      final incomeDbRes =
          await supabase.from('income').select('amount').execute();
      totalIncome = incomeDbRes.data as int? ?? 0;
      final expenseDbRes =
          await supabase.from('expense').select('amount').execute();
      totalExpense = expenseDbRes.data as int? ?? 0;

      totalBalance = totalIncome - totalExpense;
      totalRemainingPercent =
          100 - ((totalBalance / totalIncome) * 100).round();
    } catch (e) {
      totalIncome = 0;
      totalExpense = 0;
      totalBalance = 0;
      totalRemainingPercent = 0;
      debugPrint(e.toString());
    }
  }

  Future<void> getIncomeCategoriess() async {
    try {
      final incomeCategoriesDbRes =
          await supabase.from('accounts').select().execute();
      print(Account.fromJson(
              incomeCategoriesDbRes.data[0] as Map<String, dynamic>)
          .toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
