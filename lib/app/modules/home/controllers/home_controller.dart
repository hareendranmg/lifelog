import 'package:get/get.dart';

import '../../../utils/constants.dart';

class HomeController extends GetxController {
  final user = supabase.auth.currentUser!;
}
