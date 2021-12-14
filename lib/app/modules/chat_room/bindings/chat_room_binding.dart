import 'package:get/get.dart';

import 'package:travel_diaries/app/modules/app_bar/controllers/app_bar_controller.dart';

import '../controllers/chat_room_controller.dart';

class ChatRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatRoomController>(() => ChatRoomController(),
        tag: 'chatroomcontroller');
  }
}
