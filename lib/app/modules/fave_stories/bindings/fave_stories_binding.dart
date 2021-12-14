import 'package:get/get.dart';

import '../controllers/fave_stories_controller.dart';

class FaveStoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaveStoriesController>(() => FaveStoriesController(),
        tag: 'favstoriescontroller');
  }
}
