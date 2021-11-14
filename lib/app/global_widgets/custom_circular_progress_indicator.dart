import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    Key? key,
    this.height = 20,
    this.width = 20,
    this.strokeWidth = 3,
  }) : super(key: key);

  final double height;
  final double width;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CircularProgressIndicator(strokeWidth: strokeWidth),
    );
  }
}
