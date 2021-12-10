import 'package:get/get.dart';

import 'package:travel_diaries/app/modules/app_bar/controllers/app_bar_controller.dart';
import 'package:travel_diaries/app/modules/top_stories/controllers/top_stories_controller.dart';

import '../controllers/submit_story_controller.dart';

class SubmitStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmitStoryController>(() => SubmitStoryController(),
        tag: 'submitstorycontroller');
    Get.lazyPut<AppBarController>(() => AppBarController(),
        tag: 'appbarcontroller');
    Get.lazyPut<TopStoriesController>(() => TopStoriesController(),
        tag: 'topstoriescontroller');
  }
}
