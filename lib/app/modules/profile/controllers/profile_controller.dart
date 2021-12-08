import 'package:get/get.dart';

import 'package:travel_diaries/app/data/storage/user_details.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final args = Get.arguments;
  final count = 0.obs;
  RxString profilePicture = ''.obs;
  @override
  void onInit() {
    super.onInit();
    profilePicture.value = UserDetails().readUserProfilePicfromBox();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count + 15;
  void onTapped() => count.value++;
}
