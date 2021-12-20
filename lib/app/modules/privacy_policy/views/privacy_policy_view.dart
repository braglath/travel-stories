import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';

import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(
            title: 'Our privacy policy', bottom: null, appBarSize: 56),
        body: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/pdf/privacy-policy.md'),
            builder: (context, snapshot) {
              return Markdown(
                data: snapshot.data.toString(),
                styleSheet: MarkdownStyleSheet(
                  h2Padding: EdgeInsets.only(bottom: 25),
                  pPadding: EdgeInsets.only(bottom: 25),
                  h2: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: ThemeService().theme == ThemeMode.light
                          ? ColorResourcesLight.mainTextHEADINGColor
                          : ColorResourcesDark.mainDARKTEXTICONcolor),
                  h3: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ThemeService().theme == ThemeMode.light
                          ? ColorResourcesLight.mainTextHEADINGColor
                          : ColorResourcesDark.mainDARKTEXTICONcolor),
                  p: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: ThemeService().theme == ThemeMode.light
                          ? ColorResourcesLight.mainTextHEADINGColor
                          : ColorResourcesDark.mainDARKTEXTICONcolor),
                ),
              );
            }));
  }
}
