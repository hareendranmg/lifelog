import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../../data/income_category.dart';
import '../../../../../global_widgets/custom_bottom_sheet.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../services/account_services.dart';
import '../../../controllers/home_controller.dart';
import 'add_income_cat_bottom_sheet.dart';

class IncomeCatBottomSheet extends StatelessWidget {
  const IncomeCatBottomSheet({
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
                'Income Category',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Get.toNamed(Routes.EDIT_INCOME_CAT),
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => showCustomBottomSheet(
                  context,
                  const AddIncomeCatBottomSheet(),
                ),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          GetBuilder<HomeController>(
            builder: (_) => Get.find<AccountService>()
                    .incomeCategories
                    .isNotEmpty
                ? FormBuilderChoiceChip<IncomeCategory>(
                    name: 'choice_chip',
                    spacing: 12,
                    options: Get.find<AccountService>()
                        .incomeCategories
                        .map(
                          (final e) => FormBuilderFieldOption(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    decoration: const InputDecoration(border: InputBorder.none),
                    initialValue: _.selectedIncCat,
                    onChanged: (final value) {
                      _.selectedIncCat = value;
                      _.addIncomeFormKey.currentState?.fields['income_category']
                          ?.didChange(value?.name);
                    },
                  )
                : const Center(
                    child: Text(
                      'You are not added any income categories yet. \nAdd a new one by clicking the + button.',
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
