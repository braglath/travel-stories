import 'package:get/get.dart';

import '../controllers/edit_my_stories_controller.dart';

class EditMyStoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditMyStoriesController>(
      () => EditMyStoriesController(),tag: 'editmystoriescontroller'
    );
  }
}
