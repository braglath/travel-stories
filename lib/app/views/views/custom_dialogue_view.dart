import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:travel_diaries/app/data/utils/color_resources.dart';

class CustomDialogue {
  String title;
  String textConfirm;
  String textCancel;
  Function()? onpressedConfirm;
  Function()? onpressedCancel;
  Widget? contentWidget;
  CustomDialogue({
    required this.title,
    required this.textConfirm,
    required this.textCancel,
    required this.onpressedConfirm,
    required this.onpressedCancel,
    required this.contentWidget,
  });

  void showDialogue() {
    Get.defaultDialog(
        title: title,
        backgroundColor: ColorResourcesLight.mainLIGHTAPPBARcolor,
        titleStyle: TextStyle(
          color: ColorResourcesLight.mainTextHEADINGColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        buttonColor: ColorResourcesLight.mainLIGHTColor,
        confirm: ElevatedButton(
            onPressed: onpressedConfirm, child: Text(textConfirm)),
        cancel:
            ElevatedButton(onPressed: onpressedCancel, child: Text(textCancel)),
        radius: 12,
        content: contentWidget);
  }
}
