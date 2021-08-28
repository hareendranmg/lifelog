import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../services/user_services.dart';
import '../../../utils/asset_urls.dart';
import '../../../utils/general_utils.dart';
import '../controllers/home_controller.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GestureDetector(
            onTap: () => Get.toNamed(Routes.PROFILE),
            child: SizedBox(
              height: 52.h,
              width: 52.h,
              child: GetBuilder<HomeController>(
                id: 'header_profile_pic',
                builder: (_) => CachedNetworkImage(
                  imageUrl: Get.find<UserService>().appUser!.avatarUrl ??
                      AssetUrls.SERVER_USER,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getGreeting(),
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
            ),
            GetBuilder<HomeController>(
              id: 'header_name',
              builder: (_) => Text(
                Get.find<UserService>().appUser!.name!,
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
