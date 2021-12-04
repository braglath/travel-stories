import 'package:get/get.dart';

import '../controllers/submit_story_controller.dart';

class SubmitStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmitStoryController>(() => SubmitStoryController(),
        tag: 'submitstorycontroller');
  }
}
