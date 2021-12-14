import 'package:get/get.dart';

import '../controllers/top_stories_controller.dart';

class TopStoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopStoriesController>(() => TopStoriesController(),
        tag: 'topstoriescontroller');
  }
}
