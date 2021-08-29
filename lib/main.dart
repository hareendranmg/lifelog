import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/general_utils.dart';
import 'app/utils/theme_data.dart';

Future<void> main() async {
  await initServices();

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
