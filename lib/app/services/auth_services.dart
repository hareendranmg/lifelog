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
      // final mobileExist = await supabase
      //     .from('profiles')
      //     .select()
      //     .eq('mobile_number', formData['mobile_number'])
      //     .execute(count: CountOption.exact);
      // if (mobileExist.count == 0) {
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
          'message':
              signupRes.error?.message ?? 'Error occured. Please try again',
        };
      }
      // } else {
      //   result = {
      //     'status': false,
      //     'message':
      //         'Mobile number already taken. Please use another mobile number',
      //   };
      // }
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
