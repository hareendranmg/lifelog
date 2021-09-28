import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/home_controller.dart';
import 'all_time_details.dart';
import 'current_month_details.dart';

class AccountArea extends StatelessWidget {
  const AccountArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.25,
          child: PageView.builder(
            controller: Get.find<HomeController>().pageController,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (final context, final i) => const [
              CurrentMonthDetails(),
              AllTimeDetails(),
            ][i % 2],
          ),
        ),
        SmoothPageIndicator(
          controller: Get.find<HomeController>().pageController,
          count: 2,
          effect: ExpandingDotsEffect(
            activeDotColor: Get.theme.primaryColor,
            dotHeight: 12,
            dotWidth: 12,
          ),
        ),
      ],
    );
  }
}
