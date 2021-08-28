import 'package:flutter/material.dart';

final themeData = ThemeData(primarySwatch: Colors.teal);

final primaryButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.resolveWith(
    (states) => states.contains(MaterialState.disabled)
        ? Colors.grey[800]!
        : Colors.white,
  ),
  backgroundColor: MaterialStateProperty.resolveWith(
    (states) => states.contains(MaterialState.disabled)
        ? Colors.grey
        : themeData.primaryColor,
  ),
);
