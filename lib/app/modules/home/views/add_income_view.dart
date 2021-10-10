import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../services/account_services.dart';
import '../../../utils/global_widgets.dart';
import '../controllers/home_controller.dart';

class AddIncomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: FormBuilder(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back),
                ),
                Text('Income', style: Get.textTheme.headline5),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                SizedBox(
                  width: Get.width * 0.2,
                  child: Text(
                    'Amount',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                  ),
                ),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'income',
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)],
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      isDense: true,
                      prefixText: '₹',
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                SizedBox(
                  width: Get.width * 0.2,
                  child: Text(
                    'Account',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                  ),
                ),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'account',
                    keyboardType: TextInputType.text,
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)],
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      isDense: true,
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FormBuilderDropdown(
              name: 'account',
              items: Get.find<AccountService>()
                  .accounts
                  .map(
                    (account) => DropdownMenuItem(
                      value: account.id,
                      child: Text(account.name),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Account',
                border: OutlineInputBorder(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
