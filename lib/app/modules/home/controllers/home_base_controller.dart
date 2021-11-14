import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../data/account.dart';
import '../../../data/expense_category.dart';
import '../../../data/income_category.dart';
import '../../../services/user_services.dart';

class HomeBaseController extends GetxController {
  final appUser = Get.find<UserService>().appUser!;
  final pageController = PageController();

  final addIncomeFormKey = GlobalKey<FormBuilderState>();
  final addExpenseFormKey = GlobalKey<FormBuilderState>();

  final addAccountFormKey = GlobalKey<FormBuilderState>();
  final editAccountFormKey = GlobalKey<FormBuilderState>();

  final addIncomeCatFormKey = GlobalKey<FormBuilderState>();
  final editIncomeCatFormKey = GlobalKey<FormBuilderState>();

  final addExpenseCatFormKey = GlobalKey<FormBuilderState>();
  final editExpenseCatFormKey = GlobalKey<FormBuilderState>();

  Account? _selectedAccount;
  IncomeCategory? _selectedIncCat;
  ExpenseCategory? _selectedExpCat;

  bool _isDataUploading = false;
  File? _file;
  String? _fileName;

  bool get isDataUploading => _isDataUploading;
  set isDataUploading(final bool v) => {_isDataUploading = v, update()};
  File? get file => _file;
  set file(final File? file) => {_file = file, update()};
  String? get fileName => _fileName;
  set fileName(final String? fileName) => {_fileName = fileName, update()};
  Account? get selectedAccount => _selectedAccount;
  set selectedAccount(final Account? v) => {_selectedAccount = v, update()};
  IncomeCategory? get selectedIncCat => _selectedIncCat;
  set selectedIncCat(final IncomeCategory? v) =>
      {_selectedIncCat = v, update()};
  ExpenseCategory? get selectedExpCat => _selectedExpCat;
  set selectedExpCat(final ExpenseCategory? v) =>
      {_selectedExpCat = v, update()};
}
