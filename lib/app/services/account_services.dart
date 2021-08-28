import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/constants.dart';

class AccountService extends GetxService {
  final box = GetStorage();
  int income = 0;
  int expense = 0;
  int balance = 0;
  int remainingPercentage = 0;

  Future<AccountService> init() async {
    try {
      final incomeDbRes =
          await supabase.from('income').select('amount').execute();
      income = incomeDbRes.data as int? ?? 0;
      final expenseDbRes =
          await supabase.from('expense').select('amount').execute();
      expense = expenseDbRes.data as int? ?? 0;

      balance = income - expense;
      remainingPercentage = 100 - ((balance / income) * 100).round();
      return this;
    } catch (e) {
      income = 0;
      expense = 0;
      balance = 0;
      remainingPercentage = 0;
      debugPrint(e.toString());
      return this;
    }
  }
}
