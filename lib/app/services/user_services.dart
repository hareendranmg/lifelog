import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/user.dart';

class UserServices extends GetxService {
  final box = GetStorage();

  User? _user;

  @override
  void onInit() {
    user = getUser();
    super.onInit();
  }

  User? getUser() {
    // final jsonUser = box.read('user');
    // if (jsonUser != null) {
    //   user = User.fromJson(jsonUser as Map<String, dynamic>);
    // } else {
    //   user = null;
    // }
    return user;
  }

  // Future<void> getUserFromServer() async {
  //   final apiResponse = await apiHelper.getData(ApiUrls.getEmployeeUrl);
  //   if (apiResponse['success'] as bool) {
  //     final User updatedEmployee =
  //         User.fromJson(apiResponse['data'] as Map<String, dynamic>);
  //     updatedEmployee.token = user!.token;
  //     await box.write('user', updatedEmployee.toJson());
  //     _user = updatedEmployee;
  //   }
  // }

  Future<void> saveUser(User usr) async {
    // await box.write('user', usr.toJson());
    user = usr;
  }

  Future<void> removeUser() async {
    await box.remove('user');
    user = null;
  }

  User? get user => _user;
  set user(User? user) => {_user = user};
}
