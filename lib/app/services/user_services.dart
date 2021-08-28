import 'dart:io';

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

  Future<bool> updateProfilePicture(File imageFile) async {
    // ignore: prefer_typing_uninitialized_variables
    var storageResponse;
    if (appUser?.avatarUrl != null) {
      storageResponse = await supabase.storage
          .from('avatars')
          .update('${appUser!.id}.jpg', imageFile);
    } else {
      storageResponse = await supabase.storage
          .from('avatars')
          .upload('${appUser!.id}.jpg', imageFile);
    }

    if (storageResponse.data != null) {
      final publicUrl =
          supabase.storage.from('avatars').getPublicUrl('${appUser!.id}.jpg');
      await supabase
          .from('profiles')
          .update({'avatar_url': publicUrl.data}).execute();
      await saveAppUser();
      return true;
    }

    return false;
  }

  Future<bool> updateProfile(
      {required final Map<String, dynamic> formData}) async {
    final res = await supabase.from('profiles').update(formData).execute();
    await saveAppUser();
    return res.data != null;
  }

  Future<void> removeProfilePicture() async {
    await supabase.storage.from('avatars').remove(['${appUser!.id}.jpg']);
    await supabase.from('profiles').update({'avatar_url': null}).execute();
    await saveAppUser();
  }

  Future<void> removeAppUser() async {
    await box.remove('user_session');
    await box.remove('app_user');
    appUser = null;
  }
}
