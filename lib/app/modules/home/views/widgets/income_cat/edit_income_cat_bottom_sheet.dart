import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../../data/income_category.dart';
import '../../../../../global_widgets/custom_circular_progress_indicator.dart';
import '../../../controllers/home_controller.dart';

class EditIncomeCatBottomSheet extends StatelessWidget {
  const EditIncomeCatBottomSheet({
    Key? key,
    required this.incomeCategory,
  }) : super(key: key);

  final IncomeCategory incomeCategory;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: Get.find<HomeController>().editIncomeCatFormKey,
      child: Wrap(
        runSpacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Edit Income Category',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text(
                      'You cannot restore the income category after you delete.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Get.find<HomeController>()
                            .deleteIncomeCat(incomeCategory.id),
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
            initialValue: incomeCategory.name,
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
            initialValue: incomeCategory.remarks,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.find<HomeController>()
                        .editIncomeCatFormKey
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
                        : () => _.editIncomeCat(incomeCategory.id),
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
