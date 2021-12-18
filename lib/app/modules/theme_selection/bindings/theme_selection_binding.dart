import 'package:get/get.dart';

import '../controllers/theme_selection_controller.dart';

class ThemeSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeSelectionController>(
      () => ThemeSelectionController(),
    );
  }
}
