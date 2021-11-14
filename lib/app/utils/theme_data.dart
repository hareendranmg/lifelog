import 'package:flutter/material.dart';

const primaryColor = Colors.teal;

final themeData = ThemeData(primarySwatch: primaryColor);

const Color bodyBackgroundColor = Colors.white;
const Color textColor = Color(0xFF121212);
const Color textColorMedGrey = Color(0xFF202020);
const Color textColorGrey = Color(0xFF616161);

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
