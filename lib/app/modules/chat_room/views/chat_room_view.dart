import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/first_chat_page_view.dart';
import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          splashRadius: 15,
          icon: Icon(Icons.chevron_left_outlined),
          onPressed: () => Get.offAllNamed(Routes.SUBMIT_STORY),
        ),
      ),
      body: FirstCharPage(),
    );
  }
}
