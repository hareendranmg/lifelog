import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/app_user.dart';
import '../utils/constants.dart';

class UserService extends GetxService {
  final box = GetStorage();
  AppUser? appUser;

  Future<UserService> init() async {
    if (box.hasData('user_session')) {
      await supabase.auth.recoverSession(box.read('user_session') as String);
      await supabase.auth.refreshSession();
      if (supabase.auth.currentUser != null) {
        final jsonUser = await box.read('app_user');
        appUser = jsonUser != null
            ? AppUser.fromJson(jsonUser as Map<String, dynamic>)
            : null;
      } else {
        appUser = null;
      }
    }
    return this;
  }

  Future<void> saveAppUser() async {
    final jsonUser = await supabase
        .from('profiles')
        .select()
        .eq('id', supabase.auth.currentUser!.id)
        .execute();
    final savableUser =
        AppUser.fromJson(jsonUser.data[0] as Map<String, dynamic>);
    await box.write('app_user', savableUser.toJson());
    appUser = savableUser;
  }

  Future<void> removeAppUser() async {
    await box.remove('user_session');
    await box.remove('app_user');
    appUser = null;
  }
}
