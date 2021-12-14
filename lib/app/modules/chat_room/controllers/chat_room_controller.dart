import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement ChatRoomController

  final count = 0.obs;
  late TabController tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(
      icon: FaIcon(FontAwesomeIcons.bicycle),
    ),
    Tab(
      icon: FaIcon(FontAwesomeIcons.motorcycle),
    ),
    Tab(
      icon: FaIcon(FontAwesomeIcons.car),
    ),
    Tab(
      icon: FaIcon(FontAwesomeIcons.bus),
    ),
    Tab(
      icon: FaIcon(FontAwesomeIcons.train),
    ),
    Tab(
      icon: FaIcon(FontAwesomeIcons.plane),
    ),
  ];
  @override
  void onInit() {
    tabController = TabController(
      length: 6,
      vsync: this,
      animationDuration: Duration(milliseconds: 500),
    );
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
