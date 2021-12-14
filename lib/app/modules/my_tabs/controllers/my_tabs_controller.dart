import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyTabsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(
      icon: FaIcon(FontAwesomeIcons.book),
    ),
    Tab(
      icon: FaIcon(FontAwesomeIcons.comment),
    ),
  ];
  //TODO: Implement MyTabsController

  final count = 0.obs;
  @override
  void onInit() {
    tabController = TabController(
        length: 2, vsync: this, animationDuration: Duration(milliseconds: 600));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
