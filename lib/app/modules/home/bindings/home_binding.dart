import 'package:get/get.dart';
import 'package:travel_diaries/app/modules/submit_story/controllers/submit_story_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), tag: 'homecontroller');
  }
}
