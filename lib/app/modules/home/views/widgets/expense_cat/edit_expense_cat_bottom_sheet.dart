import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../../data/expense_category.dart';
import '../../../../../global_widgets/custom_circular_progress_indicator.dart';
import '../../../controllers/home_controller.dart';

class EditExpenseCatBottomSheet extends StatelessWidget {
  const EditExpenseCatBottomSheet({
    Key? key,
    required this.expenseCategory,
  }) : super(key: key);

  final ExpenseCategory expenseCategory;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: Get.find<HomeController>().editExpenseCatFormKey,
      child: Wrap(
        runSpacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Edit Expense Category',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text(
                      'You cannot restore the Expense category after you delete.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Get.find<HomeController>()
                            .deleteExpenseCat(expenseCategory.id),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                ),
                icon: Icon(Icons.delete, color: Get.theme.errorColor),
              ),
            ],
          ),
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(
              labelText: 'Name*',
              border: OutlineInputBorder(),
            ),
            initialValue: expenseCategory.name,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
            maxLength: 30,
          ),
          FormBuilderTextField(
            name: 'remarks',
            decoration: const InputDecoration(
              labelText: 'Remarks',
              border: OutlineInputBorder(),
            ),
            maxLength: 30,
            initialValue: expenseCategory.remarks,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.find<HomeController>()
                        .editExpenseCatFormKey
                        .currentState
                        ?.reset();
                    Get.back();
                  },
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 10),
              GetBuilder<HomeController>(
                builder: (_) => Expanded(
                  child: ElevatedButton(
                    onPressed: _.isDataUploading
                        ? null
                        : () => _.editExpenseCat(expenseCategory.id),
                    child: _.isDataUploading
                        ? const CustomCircularProgressIndicator()
                        : const Text('Edit'),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
