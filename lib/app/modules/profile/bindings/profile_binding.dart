import 'package:get/get.dart';

import 'package:travel_diaries/app/modules/other_profile/controllers/other_profile_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController(),
        tag: 'profilecontroller');
    Get.lazyPut<OtherProfileController>(
      () => OtherProfileController(),
    );
  }
}
