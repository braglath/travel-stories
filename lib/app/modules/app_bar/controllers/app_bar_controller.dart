import 'package:get/get.dart';

import 'package:travel_diaries/app/data/storage/user_details.dart';

class AppBarController extends GetxController {
  //TODO: Implement AppBarController

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
  void increment() => count.value++;
}
