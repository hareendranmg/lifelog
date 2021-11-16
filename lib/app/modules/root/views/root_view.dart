import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: GetBuilder<RootController>(
        builder: (_) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'LifeLog',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(height: 180),
                CircularProgressIndicator(strokeWidth: 3),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
