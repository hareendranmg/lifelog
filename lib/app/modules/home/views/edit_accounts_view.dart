import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/custom_bottom_sheet.dart';
import '../../../global_widgets/custom_scaffold.dart';
import '../../../services/account_services.dart';
import '../controllers/home_controller.dart';
import 'widgets/account/add_account_bottom_sheet.dart';
import 'widgets/account/edit_account_bottom_sheet.dart';

class EditAccountsView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: 'Edit Accounts',
        actions: [
          IconButton(
            onPressed: () => showCustomBottomSheet(
              context,
              const AddAccountBottomSheet(),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Get.find<AccountService>().accounts.isNotEmpty
          ? GetBuilder<HomeController>(
              builder: (_) {
                return ListView.separated(
                  itemCount: Get.find<AccountService>().accounts.length,
                  itemBuilder: (final c, final i) => Container(
                    height: 60,
                    width: Get.width,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.lightBlue[50],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            Get.find<AccountService>().accounts[i].name,
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Bal. ',
                                    style: TextStyle(
                                      color: Get.theme.primaryColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: Get.find<AccountService>()
                                        .accounts[i]
                                        .amount
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Get.theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => showCustomBottomSheet(
                                context,
                                EditAccountBottomSheet(
                                  account:
                                      Get.find<AccountService>().accounts[i],
                                ),
                              ),
                              icon: const Icon(Icons.remove_red_eye),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  separatorBuilder: (final c, final i) =>
                      const SizedBox(height: 10),
                );
              },
            )
          : const Center(
              child: Text(
                'You are not added any accounts yet. \nAdd a new one by clicking the + button.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.5,
                ),
              ),
            ),
    );
  }
}
