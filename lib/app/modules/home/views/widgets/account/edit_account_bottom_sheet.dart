import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../../data/account.dart';
import '../../../../../global_widgets/custom_circular_progress_indicator.dart';
import '../../../controllers/home_controller.dart';

class EditAccountBottomSheet extends StatelessWidget {
  const EditAccountBottomSheet({
    Key? key,
    required this.account,
  }) : super(key: key);

  final Account account;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: Get.find<HomeController>().editAccountFormKey,
      child: Wrap(
        runSpacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Edit Account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text(
                      'You cannot restore the account after you delete.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Get.find<HomeController>()
                            .deleteAccount(account.id),
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
            initialValue: account.name,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
            maxLength: 30,
          ),
          FormBuilderTextField(
            name: 'amount',
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Initial Amount*',
              border: OutlineInputBorder(),
            ),
            maxLength: 7,
            initialValue: account.amount.toString().endsWith('.0')
                ? account.amount.toInt().toString()
                : account.amount.toString(),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.numeric(context),
            ]),
          ),
          FormBuilderTextField(
            name: 'remarks',
            decoration: const InputDecoration(
              labelText: 'Remarks',
              border: OutlineInputBorder(),
            ),
            maxLength: 30,
            initialValue: account.remarks,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.find<HomeController>()
                        .editAccountFormKey
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
                        : () => _.editAccount(account.id),
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
