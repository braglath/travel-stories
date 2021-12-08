import 'package:get/get.dart';

import '../controllers/fav_full_screen_controller.dart';

class FavFullScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavFullScreenController>(() => FavFullScreenController(),
        tag: 'favfullscreencontroller');
  }
}
