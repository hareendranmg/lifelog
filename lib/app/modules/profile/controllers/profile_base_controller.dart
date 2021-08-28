import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/user_services.dart';

enum EditingNameState { editing, saving, saved }

class ProfileBaseController extends GetxController {
  final userService = Get.find<UserService>();
  final nameEditFormKey = GlobalKey<FormBuilderState>();
  final nameFocusNode = FocusNode();

  final imagePicker = ImagePicker();
  XFile? image;

  bool _isUpdatingProPic = false;
  EditingNameState _editingNameState = EditingNameState.saved;

  // ***************** GETTERS AND SETTERS ****************************** //
  bool get isUpdatingProPic => _isUpdatingProPic;
  set isUpdatingProPic(final bool v) => {_isUpdatingProPic = v, update()};
  EditingNameState get editingNameState => _editingNameState;
  set editingNameState(final EditingNameState v) =>
      {_editingNameState = v, update()};
}
