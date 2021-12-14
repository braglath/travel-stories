import 'package:get/get.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';

class LoadingChatRoomController extends GetxController {
  //TODO: Implement LoadingChatRoomController

  final count = 0.obs;
  @override
  void onInit() {
    Future.delayed(
        Duration(seconds: 3), () => Get.offAndToNamed(Routes.CHAT_ROOM));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
