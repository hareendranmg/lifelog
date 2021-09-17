import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/statics_controller.dart';

class StaticsView extends GetView<StaticsController> {
  final pageController = PageController(
    viewportFraction: 0.8,
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
      3,
      (index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade300,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: SizedBox(
          height: 280,
          child: Center(
            child: Text(
              'Page $index',
              style: const TextStyle(color: Colors.indigo),
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          SizedBox(
            height: 240,
            child: PageView.builder(
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) => pages[index % pages.length],
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: pages.length,
          ),
        ],
      ),
    );
  }
}

const colors = [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
