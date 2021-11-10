import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/general_utils.dart';
import '../utils/theme_data.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.backgroundColor,
  }) : super(key: key);

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? bodyBackgroundColor,
      appBar: appBar,
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => removeCurrentFocus(context),
            child: body,
          ),
        ),
      ),
    );
  }
}

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    Key? key,
    required this.title,
    this.actions,
  }) : super(key: key);

  final String title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: Text(title),
      actions: actions,
      foregroundColor: textColorMedGrey,
      titleTextStyle: const TextStyle(
        color: textColorMedGrey,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
