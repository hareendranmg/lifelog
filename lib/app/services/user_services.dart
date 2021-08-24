import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// ignore: implementation_imports
import 'package:storage_client/src/types.dart';

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

  Future<Map<String, dynamic>> updateProfilePicture(File imageFile) async {
    // TODO: Check whether the image is already present or not,
    // TODO: one method is checking avatar_url in profile page is empty or not
    await supabase.storage
        .from('avatars')
        .move('${appUser!.id}.jpg', '${appUser!.id}-copy.jpg');
    await supabase.storage.from('avatars').remove(['${appUser!.id}.jpg']);
    final storageResponse = await supabase.storage.from('avatars').upload(
          '${appUser!.id}.jpg',
          imageFile,
          fileOptions: const FileOptions(upsert: true),
        );
    if (storageResponse.data != null) {
      final publicUrl = supabase.storage
          .from('avatars')
          .getPublicUrl('${appUser!.id}-copy.jpg');
      await supabase.storage
          .from('avatars')
          .remove(['${appUser!.id}-copy.jpg']);
      await supabase
          .from('profiles')
          .update({'avatar_url': publicUrl.data}).execute();
      return {'status': true, 'url': storageResponse.data};
    } else {
      await supabase.storage
          .from('avatars')
          .move('${appUser!.id}-copy.jpg', '${appUser!.id}.jpg');
      return {
        'status': false,
        'error': storageResponse.error?.message ?? 'Error occured.'
      };
    }
  }

  Future<void> removeAppUser() async {
    await box.remove('user_session');
    await box.remove('app_user');
    appUser = null;
  }
}
