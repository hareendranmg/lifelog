// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../routes/app_pages.dart';
import '../utils/constants.dart';
import 'user_services.dart';

class AuthServices {
  static final box = GetStorage();

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginRes =
          await supabase.auth.signIn(email: email, password: password);

      final Map<String, dynamic> result;

      if (loginRes.data != null) {
        await Get.find<UserService>().saveAppUser();
        await box.write('user_session', loginRes.data!.persistSessionString);
        result = {'status': true};
      } else {
        result = {'status': false, 'message': loginRes.error?.message};
      }
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return {
        'status': false,
        'message': 'Error occured. Please try again',
      };
    }
  }

  static Future<Map<String, dynamic>> register({
    required Map<String, dynamic> formData,
  }) async {
    try {
      final Map<String, dynamic> result;

      final emailExist = await supabase
          .from('profiles')
          .select()
          .eq('email', formData['email'])
          .execute();

      if (emailExist.error == null && (emailExist.data as List).isEmpty) {
        final signupRes = await supabase.auth.signUp(
          formData['email']! as String,
          formData['password']! as String,
        );

        if (signupRes.data != null) {
          await supabase.from('profiles').insert({
            'id': signupRes.data!.user!.id,
            'name': formData['fullname'],
            // 'mobile_number': formData['mobile_number'],
            'email': formData['email'],
          }).execute();
          result = {'status': true, 'message': 'Successful'};
        } else {
          result = {
            'status': false,
            'is_warning': true,
            'message':
                signupRes.error?.message ?? 'Error occured. Please try again',
          };
        }
      } else {
        result = {
          'status': false,
          'is_warning': true,
          'message':
              'An user with the same email already registered. Please use another email',
        };
      }
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return {
        'status': false,
        'message': 'Error occured. Please try again',
      };
    }
  }

  static Future<void> logout() async {
    await UserService().removeAppUser();
    Get.offAllNamed(Routes.LOGIN);
    await supabase.auth.signOut();
  }
}
