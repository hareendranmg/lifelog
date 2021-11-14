import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/custom_bottom_sheet.dart';
import '../../../global_widgets/custom_scaffold.dart';
import '../../../services/account_services.dart';
import '../controllers/home_controller.dart';
import 'widgets/expense_cat/add_expense_cat_bottom_sheet.dart';
import 'widgets/expense_cat/edit_expense_cat_bottom_sheet.dart';

class EditExpenseCatView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: 'Edit Expense Categories',
        actions: [
          IconButton(
            onPressed: () => showCustomBottomSheet(
              context,
              const AddExpenseCatBottomSheet(),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Get.find<AccountService>().expenseCategories.isNotEmpty
          ? GetBuilder<HomeController>(
              builder: (_) {
                return ListView.separated(
                  itemCount:
                      Get.find<AccountService>().expenseCategories.length,
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
                            Get.find<AccountService>()
                                .expenseCategories[i]
                                .name,
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => showCustomBottomSheet(
                                context,
                                EditExpenseCatBottomSheet(
                                  expenseCategory: Get.find<AccountService>()
                                      .expenseCategories[i],
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
                'You are not added any expense categories yet. \nAdd a new one by clicking the + button.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.5,
                ),
              ),
            ),
    );
  }
}
