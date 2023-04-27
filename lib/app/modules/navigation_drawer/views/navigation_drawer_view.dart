import 'package:flutter/material.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/app_bar/controllers/app_bar_controller.dart';
import 'package:travel_diaries/app/modules/submit_story/controllers/submit_story_controller.dart';
import 'package:travel_diaries/app/modules/submit_story/views/submit_story_view.dart';
import 'package:travel_diaries/app/modules/top_stories/controllers/top_stories_controller.dart';
import 'package:travel_diaries/app/views/views/menu_screen_view.dart';

import '../controllers/navigation_drawer_controller.dart';

class NavigationDrawerView extends GetView<NavigationDrawerController> {
  // @override
  final controller2 = Get.put<SubmitStoryController>(SubmitStoryController(),
      tag: 'submitstorycontroller');
  final controller3 =
      Get.put<AppBarController>(AppBarController(), tag: 'appbarcontroller');
  final controller4 = Get.put<TopStoriesController>(TopStoriesController(),
      tag: 'topstoriescontroller');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ZoomDrawer(
      controller: controller.drawerController,
      mainScreen: SubmitStoryView(),
      menuScreen: MenuScreenView(),
      style: DrawerStyle.Style1,
      borderRadius: 24.0,
      showShadow: true,
      disableGesture: false,
      angle: -2.0,
      backgroundColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainLIGHTSplashColor
          : ColorResourcesDark.mainDARKSplashColor,
      slideWidth: MediaQuery.of(context).size.width * 0.7,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.fastOutSlowIn,
    ));
  }
}
