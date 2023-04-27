import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class NavigationDrawerController extends GetxController {
  //TODO: Implement NavigationDrawerController

  final drawerController = ZoomDrawerController();

  final count = 0.obs;

  @override
  void onClose() {}

  void increment() => count.value++;
}
