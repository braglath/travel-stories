import 'package:get/get.dart';

import '../controllers/loading_chat_room_controller.dart';

class LoadingChatRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoadingChatRoomController>(() => LoadingChatRoomController(),
        tag: 'loadingchatroomcontroller');
  }
}
