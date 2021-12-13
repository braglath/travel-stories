import 'package:get/get.dart';
import 'package:travel_diaries/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/other_profile_controller.dart';

class OtherProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtherProfileController>(
      () => OtherProfileController(),
    );
  }
}
