import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../../global_widgets/custom_circular_progress_indicator.dart';
import '../../../controllers/home_controller.dart';

class AddExpenseCatBottomSheet extends StatelessWidget {
  const AddExpenseCatBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: Get.find<HomeController>().addExpenseCatFormKey,
      child: Wrap(
        runSpacing: 12,
        children: [
          const Text(
            'Add Expense Category',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(
              labelText: 'Name*',
              border: OutlineInputBorder(),
            ),
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
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.find<HomeController>()
                        .addExpenseCatFormKey
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
                    onPressed: _.isDataUploading ? null : _.addExpenseCat,
                    child: _.isDataUploading
                        ? const CustomCircularProgressIndicator()
                        : const Text('Add'),
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
