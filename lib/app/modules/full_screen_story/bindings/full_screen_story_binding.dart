import 'package:get/get.dart';

import '../controllers/full_screen_story_controller.dart';

class FullScreenStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FullScreenStoryController>(() => FullScreenStoryController(),
        tag: 'fullscreenstorycontroller');
  }
}
