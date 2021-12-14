import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:travel_diaries/app/modules/app_bar/controllers/app_bar_controller.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';

import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  @override
  final controller = Get.find<ChatRoomController>(tag: 'chatroomcontroller');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(
        appBarSize: 100,
        title: 'Chat room',
        bottom: TabBar(
          tabs: controller.myTabs,
          controller: controller.tabController,
        ),
      ),
      body: Center(
        child: Text(
          'ChatRoomView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
