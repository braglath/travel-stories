import 'package:get/get.dart';

import '../controllers/my_stories_controller.dart';

class MyStoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyStoriesController>(() => MyStoriesController(),
        tag: 'mystoriescontroller');
  }
}
