import '../../../data/income.dart';
import 'home_base_controller.dart';

class HomeController extends HomeBaseController {
  Future<bool> addIncome() async {
    if (addIncomeFormKey.currentState?.saveAndValidate() ?? false) {
      final income = Income.fromJson(addIncomeFormKey.currentState!.value);
      print(income);
    }
    return true;
  }
}
