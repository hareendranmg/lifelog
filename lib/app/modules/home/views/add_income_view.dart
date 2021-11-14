import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../global_widgets/custom_bottom_sheet.dart';
import '../../../global_widgets/custom_scaffold.dart';
import '../../../services/account_services.dart';
import '../controllers/home_controller.dart';
import 'widgets/account/accounts_bottom_sheet.dart';

class AddIncomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppbar(title: 'Income'),
      body: FormBuilder(
        key: controller.addIncomeFormKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            FormBuilderTextField(
              name: 'amount',
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required(context)],
              ),
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            FormBuilderTextField(
              onTap: () =>
                  showCustomBottomSheet(context, const AccountsBottomSheet()),
              name: 'account',
              keyboardType: TextInputType.none,
              decoration: const InputDecoration(
                labelText: 'Account',
                border: OutlineInputBorder(),
              ),
              validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required(context)],
              ),
            ),
            const SizedBox(height: 12),
            FormBuilderDropdown(
              name: 'income_category',
              items: Get.find<AccountService>()
                  .incomeCategories
                  .map(
                    (final incomeCat) => DropdownMenuItem(
                      value: incomeCat.id,
                      child: Text(incomeCat.name),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Income Category',
                border: OutlineInputBorder(),
              ),
              validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required(context)],
              ),
            ),
            const SizedBox(height: 12),
            FormBuilderDateTimePicker(
              name: 'date',
              initialValue: DateTime.now(),
              decoration: const InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
              ),
              validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required(context)],
              ),
            ),
            const SizedBox(height: 12),
            FormBuilderTextField(
              name: 'remarks',
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Remarks',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            GetBuilder<HomeController>(
              builder: (_) => Row(
                children: [
                  const Text('Related File'),
                  if (_.fileName != null)
                    Expanded(
                      child: Text(
                        ' - ${_.fileName}',
                        style: TextStyle(color: Get.theme.primaryColor),
                      ),
                    )
                  else
                    const Spacer(),
                  OutlinedButton.icon(
                    onPressed: _.file != null ? _.removeFile : _.pickFile,
                    icon: _.file != null
                        ? const Icon(Icons.remove_circle_outline)
                        : const Icon(Icons.file_upload_outlined),
                    label: _.file != null
                        ? const Text('Remove File')
                        : const Text('Upload File'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            GetBuilder<HomeController>(
              builder: (_) => ElevatedButton(
                onPressed: _.isDataUploading ? null : _.addIncome,
                child: _.isDataUploading
                    ? const Text('Adding...')
                    : const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
