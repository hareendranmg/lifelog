import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../../global_widgets/custom_circular_progress_indicator.dart';
import '../../../controllers/home_controller.dart';

class AddIncomeCatBottomSheet extends StatelessWidget {
  const AddIncomeCatBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: Get.find<HomeController>().addIncomeCatFormKey,
      child: Wrap(
        runSpacing: 12,
        children: [
          const Text(
            'Add Income Category',
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
                        .addIncomeCatFormKey
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
                    onPressed: _.isDataUploading ? null : _.addIncomeCat,
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
