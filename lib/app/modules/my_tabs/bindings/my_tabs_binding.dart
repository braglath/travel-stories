import 'package:get/get.dart';

import 'package:travel_diaries/app/modules/app_bar/controllers/app_bar_controller.dart';
import 'package:travel_diaries/app/modules/chat_room/controllers/chat_room_controller.dart';
import 'package:travel_diaries/app/modules/submit_story/controllers/submit_story_controller.dart';
import 'package:travel_diaries/app/modules/top_stories/controllers/top_stories_controller.dart';

import '../controllers/my_tabs_controller.dart';

class MyTabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTabsController>(() => MyTabsController(),
        tag: 'mytabscontroller');
    Get.lazyPut<SubmitStoryController>(() => SubmitStoryController(),
        tag: 'submitstorycontroller');
    Get.lazyPut<ChatRoomController>(() => ChatRoomController(),
        tag: 'chatroomcontroller');
    Get.lazyPut<AppBarController>(() => AppBarController(),
        tag: 'appbarcontroller');
    Get.lazyPut<TopStoriesController>(() => TopStoriesController(),
        tag: 'topstoriescontroller');
  }
}
