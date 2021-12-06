import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:travel_diaries/app/data/utils/color_resources.dart';

class CustomSnackbar {
  String title;
  String message;
  CustomSnackbar({required this.title, required this.message});
  void showWarning() {
    Get.snackbar('', '',
        isDismissible: true,
        backgroundColor:
            ColorResourcesLight.mainLIGHTAPPBARcolor.withOpacity(0.5),
        icon: CircleAvatar(
          backgroundColor: ColorResourcesLight.mainLIGHTColor,
          child: Icon(
            Icons.warning_sharp,
            color: ColorResourcesLight.mainLIGHTAPPBARcolor,
            size: 25,
          ),
        ),
        messageText: Text(message,
            style: TextStyle(
                color: ColorResourcesLight.mainTextHEADINGColor,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        shouldIconPulse: true,
        colorText: ColorResourcesLight.mainLIGHTColor,
        titleText: Text(title,
            style: TextStyle(
                color: ColorResourcesLight.mainTextHEADINGColor,
                fontWeight: FontWeight.bold,
                fontSize: 17)));
  }

  void showSuccess() {
    Get.snackbar('', '',
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        backgroundColor:
            ColorResourcesLight.mainLIGHTAPPBARcolor.withOpacity(0.5),
        icon: CircleAvatar(
          backgroundColor: ColorResourcesLight.mainLIGHTColor,
          child: Icon(
            Icons.done,
            color: ColorResourcesLight.mainLIGHTAPPBARcolor,
            size: 35,
          ),
        ),
        messageText: Text(message,
            style: TextStyle(
                color: ColorResourcesLight.mainTextHEADINGColor,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        shouldIconPulse: true,
        colorText: ColorResourcesLight.mainLIGHTColor,
        titleText: Text(title,
            style: TextStyle(
                color: ColorResourcesLight.mainTextHEADINGColor,
                fontWeight: FontWeight.bold,
                fontSize: 17)));
  }
}
