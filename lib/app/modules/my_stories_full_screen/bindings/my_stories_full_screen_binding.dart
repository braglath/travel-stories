import 'package:get/get.dart';

import '../controllers/my_stories_full_screen_controller.dart';

class MyStoriesFullScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyStoriesFullScreenController>(
        () => MyStoriesFullScreenController(),
        tag: 'mystoriesfullscreenscontroller');
  }
}
