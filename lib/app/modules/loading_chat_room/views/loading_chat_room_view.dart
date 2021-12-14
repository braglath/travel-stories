import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';

import '../controllers/loading_chat_room_controller.dart';

class LoadingChatRoomView extends GetView<LoadingChatRoomController> {
  @override
  final controller =
      Get.find<LoadingChatRoomController>(tag: 'loadingchatroomcontroller');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset('assets/lottie/chatintro.json')),
    );
  }
}
