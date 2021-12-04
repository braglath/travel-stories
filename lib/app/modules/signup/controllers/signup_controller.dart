import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController

  final count = 0.obs;
  final defaultChoiceIndex = 0.obs;
  RxBool isSelected = false.obs;

  List<String> travelmodes =
      ['All', 'Cycle', 'Bike', 'Car', 'Bus', 'Train', 'Flight'].obs;
  List<IconData> travelIcons = [
    Icons.flutter_dash,
    Icons.directions_bike_sharp,
    Icons.motorcycle_rounded,
    FontAwesomeIcons.car,
    FontAwesomeIcons.bus,
    FontAwesomeIcons.train,
    Icons.flight_takeoff,
  ].obs;

  bool isSelectedLabel() => isSelected.value = true;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
