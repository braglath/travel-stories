import 'package:get/get.dart';

import '../controllers/post_story_controller.dart';

class PostStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostStoryController>(() => PostStoryController(),
        tag: 'poststorycontroller');
  }
}
