import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:travel_diaries/app/modules/app_bar/controllers/app_bar_controller.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/modules/chat_room/controllers/chat_room_controller.dart';
import 'package:travel_diaries/app/modules/chat_room/views/chat_room_view.dart';
import 'package:travel_diaries/app/modules/submit_story/controllers/submit_story_controller.dart';
import 'package:travel_diaries/app/modules/submit_story/views/submit_story_view.dart';
import 'package:travel_diaries/app/modules/top_stories/controllers/top_stories_controller.dart';

import '../controllers/my_tabs_controller.dart';

class MyTabsView extends GetView<MyTabsController> {
  @override
  final controller = Get.find<MyTabsController>(tag: 'mytabscontroller');
  final controller1 =
      Get.find<SubmitStoryController>(tag: 'submitstorycontroller');
  final controller2 = Get.find<ChatRoomController>(tag: 'chatroomcontroller');
  final controller3 = Get.find<AppBarController>(tag: 'appbarcontroller');
  final controller4 =
      Get.find<TopStoriesController>(tag: 'topstoriescontroller');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(
          appBarSize: 56,
          title: 'Tab bar',
          bottom: TabBar(
            tabs: controller.myTabs,
            controller: controller.tabController,
          ),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: [SubmitStoryView(), ChatRoomView()],
        ));
  }
}
