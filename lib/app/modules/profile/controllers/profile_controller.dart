import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final args = Get.arguments;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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
