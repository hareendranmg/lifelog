import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../modules/home/controllers/home_controller.dart';
import '../routes/app_pages.dart';
import '../services/account_services.dart';
import '../services/user_services.dart';
import 'constants.dart';
import 'theme_data.dart';

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

void showCustomLoadingIndicator() {
  showDialog(
    context: Get.context!,
    builder: (context) => Center(
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: const SpinKitPulse(color: primaryColor),
      ),
    ),
  );
}

void routingCallback(Routing routing) {
  if (routing.current == Routes.HOME && routing.isBack!) {
    Get.find<HomeController>().update(['header_name', 'header_profile_pic']);
  }
}

enum SnackbarType {
  success,
  warning,
  error,
}

void showSnackBar({
  required SnackbarType type,
  required String message,
  String? title,
  Duration? duration,
}) {
  final Color fontColor =
      type == SnackbarType.warning ? Colors.black : Colors.white;

  final Color bgColor = type == SnackbarType.success
      ? const Color(0xff28a745)
      : type == SnackbarType.warning
          ? const Color(0xffffc107)
          : const Color(0xffdc3545);
  Get.showSnackbar(
    GetBar(
      message: message,
      messageText: Text(message, style: TextStyle(color: fontColor)),
      backgroundColor: bgColor,
      icon: type == SnackbarType.success
          ? Icon(Icons.check, color: fontColor)
          : Icon(Icons.error_outline, color: fontColor),
      duration: duration ?? 3.seconds,
      snackStyle: SnackStyle.FLOATING,
      shouldIconPulse: false,
    ),
  );
}
