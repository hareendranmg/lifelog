import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/custom_scaffold.dart';
import '../controllers/profile_controller.dart';
import 'widgets/profile_appbar.dart';
import 'widgets/profile_card.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const ProfileAppBar(),
          ProfileCard(controller: controller),
        ],
      ),
    );
  }
}
