import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../services/user_services.dart';

class HomeBaseController extends GetxController {
  final appUser = Get.find<UserService>().appUser!;
  final pageController = PageController();
  final addIncomeFormKey = GlobalKey<FormBuilderState>();
  final addExpenseFormKey = GlobalKey<FormBuilderState>();

  bool _isDataUploading = false;
  File? _file;
  String? _fileName;

  bool get isDataUploading => _isDataUploading;
  set isDataUploading(final bool v) => {_isDataUploading = v, update()};
  File? get file => _file;
  set file(final File? file) => {_file = file, update()};
  String? get fileName => _fileName;
  set fileName(final String? fileName) => {_fileName = fileName, update()};
}
