import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../modules/home/controllers/home_controller.dart';
import '../routes/app_pages.dart';
import '../services/account_services.dart';
import '../services/user_services.dart';
import 'constants.dart';

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_ANON_KEY);
  await Get.putAsync(() async => UserService().init());
  await Get.putAsync(() async => AccountService().init());
}

void removeCurrentFocus(BuildContext context) {
  final currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

String getGreeting() {
  final hour = TimeOfDay.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}

void routingCallback(Routing routing) {
  if (routing.current == Routes.HOME && routing.isBack!) {
    Get.find<HomeController>().update(['header_name', 'header_profile_pic']);
  }
}
