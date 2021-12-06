import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';

import 'package:travel_diaries/app/data/utils/color_resources.dart';

class CustomBottomSheet {
  IconData icon1;
  IconData icon2;
  String title1;
  String titile2;
  Function()? onTap1;
  Function()? onTap2;

  CustomBottomSheet(
      {required this.icon1,
      required this.icon2,
      required this.title1,
      required this.titile2,
      required this.onTap1,
      required this.onTap2});
  void show() {
    Get.bottomSheet(
      Container(
        child: Wrap(
          children: [
            ListTile(
              tileColor: ThemeService().theme == ThemeMode.light
                  ? ColorResourcesLight.mainLIGHTAPPBARcolor
                  : ColorResourcesDark.mainDARKAPPBARcolor,
              leading: FaIcon(
                icon1,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor
                    : ColorResourcesDark.mainDARKColor,
              ),
              title: Text(
                title1,
                style: TextStyle(
                    color: ColorResourcesLight.mainTextHEADINGColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              onTap: onTap1,
            ),
            ListTile(
              tileColor: ThemeService().theme == ThemeMode.light
                  ? ColorResourcesLight.mainLIGHTAPPBARcolor
                  : ColorResourcesDark.mainDARKAPPBARcolor,
              leading: FaIcon(
                icon2,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor
                    : ColorResourcesDark.mainDARKColor,
              ),
              title: Text(titile2,
                  style: TextStyle(
                      color: ColorResourcesLight.mainTextHEADINGColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22)),
              onTap: onTap2,
            ),
          ],
        ),
      ),
      // barrierColor: Colors.red[50],
      isDismissible: true,
      enableDrag: true,
    );
  }
}
