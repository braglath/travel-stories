import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_slide_animation.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';

import '../controllers/change_language_controller.dart';

class ChangeLanguageView extends GetView<ChangeLanguageController> {
  final void Function()? onSubmit;
  ChangeLanguageView({required this.onSubmit});
  final int? _selectedLanguage = -1;
  final bool needAppBar = Get.arguments ?? false;

  @override
  Widget build(BuildContext context) {
    final List<String> _languages = [
      'English',
      'தமிழ்',
      'हिन्दी',
      'عربى',
      'français',
      'Español',
    ];
    return Scaffold(
      appBar: needAppBar == true
          ? AppBarView(title: 'Change language', bottom: null, appBarSize: 56)
          : null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              needAppBar == false
                  ? Text(
                      'Change language',
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 3,
                child: FadedSlideAnimation(
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 80),
                    itemCount: _languages.length,
                    itemBuilder: (context, index) => RadioListTile(
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (dynamic value) async {},
                      groupValue: _selectedLanguage,
                      value: index,
                      title: Text(_languages[index],
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontSize: 18)),
                    ),
                  ),
                  beginOffset: Offset(0, 0.3),
                  endOffset: Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                ),
              ),
              Expanded(
                flex: 0,
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (onSubmit == null) {
                          Get.offAndToNamed(Routes.THEME_SELECTION);
                        } else {
                          onSubmit;
                        }
                      },
                      child: Text(
                        'Submit',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color: ColorResourcesDark.mainDARKTEXTICONcolor,
                                fontSize: 20),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int getCurrentLanguage(Locale locale) {
  if (locale == Locale('en')) {
    return 0;
  } else if (locale == Locale('ar')) {
    return 1;
  } else if (locale == Locale('fr')) {
    return 2;
  } else if (locale == Locale('id')) {
    return 3;
  } else if (locale == Locale('pt')) {
    return 4;
  } else if (locale == Locale('es')) {
    return 5;
  } else if (locale == Locale('it')) {
    return 6;
  } else if (locale == Locale('tr')) {
    return 7;
  } else if (locale == Locale('sw')) {
    return 8;
  } else {
    return -1;
  }
}
