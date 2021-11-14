import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../../global_widgets/custom_bottom_sheet.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../services/account_services.dart';
import '../../../controllers/home_controller.dart';
import 'add_account_bottom_sheet.dart';

class AccountsBottomSheet extends StatelessWidget {
  const AccountsBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: Wrap(
        spacing: 12,
        children: [
          Row(
            children: [
              const Text(
                'Accounts',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Get.toNamed(Routes.EDIT_ACCOUNTS),
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => showCustomBottomSheet(
                  context,
                  const AddAccountBottomSheet(),
                ),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          GetBuilder<HomeController>(
            builder: (_) => Get.find<AccountService>().accounts.isNotEmpty
                ? FormBuilderChoiceChip(
                    name: 'choice_chip',
                    spacing: 12,
                    options: Get.find<AccountService>()
                        .accounts
                        .map(
                          (final e) => FormBuilderFieldOption(
                            value: e.id,
                            child: Text('${e.name} (Bal. ${e.amount})'),
                          ),
                        )
                        .toList(),
                    decoration: const InputDecoration(border: InputBorder.none),
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
          ),
        ],
      ),
    );
  }
}
