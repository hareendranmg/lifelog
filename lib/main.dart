import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';
import 'app/services/account_services.dart';
import 'app/services/user_services.dart';
import 'app/utils/constants.dart';
import 'app/utils/general_utils.dart';
import 'app/utils/theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_ANON_KEY);
  await Get.putAsync(() async => UserService().init());
  await Get.putAsync(() async => AccountService().init());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) => runApp(
      ScreenUtilInit(
        builder: () => GetMaterialApp(
          title: 'LifeLog',
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          theme: themeData,
          routingCallback: (routing) => routingCallback(routing!),
        ),
      ),
    ),
  );
}
