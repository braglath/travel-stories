import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';

class IntroductioScreensView extends GetView {
  List<String> travelmodes = ['Cycle', 'Bike', 'Car', 'Bus', 'Train', 'Flight'];

  List<IconData> travelIcons = [
    Icons.directions_bike_sharp,
    Icons.motorcycle_rounded,
    FontAwesomeIcons.car,
    FontAwesomeIcons.bus,
    FontAwesomeIcons.train,
    Icons.flight_takeoff,
  ];
  List<PageViewModel> introductionScreens() => [
        PageViewModel(
          decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor
                    : ColorResourcesDark.mainDARKColor,
              ),
              bodyTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor
                    : ColorResourcesDark.mainDARKColor,
              )),
          image: Container(
              child: Image.asset('images/intro2.png', fit: BoxFit.cover)),
          title: '',
          body: 'Share incidents that happened on your travel with the world',
        ),
        PageViewModel(
          decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor
                    : ColorResourcesDark.mainDARKColor,
              ),
              bodyTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor
                    : ColorResourcesDark.mainDARKColor,
              )),
          image: Container(
              child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                      // itemExtent: 100,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: travelmodes.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (
                        context,
                        index,
                      ) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ChoiceChip(
                            selected: true,
                            labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                            avatar: Icon(
                              travelIcons[index],
                              color: Colors.white,
                            ),
                            label: Text(
                              travelmodes[index],
                            ),
                          ),
                        );
                      }))),
          title: '',
          body: 'No matter what your travel mode is',
        ),
        PageViewModel(
          decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor
                    : ColorResourcesDark.mainDARKColor,
              ),
              bodyTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor
                    : ColorResourcesDark.mainDARKColor,
              )),
          image: Container(
              child: Image.asset('images/introfinal.png', fit: BoxFit.cover)),
          title: 'Travel Stories',
          body: 'Social Media for travellers and real life travel incidents',
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      animationDuration: 500,
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        activeColor: ThemeService().theme == ThemeMode.light
            ? ColorResourcesLight.mainLIGHTColor
            : ColorResourcesDark.mainDARKColor,
      ),
      dotsFlex: 2,
      done: Text(
        'Done',
        style: context.theme.textTheme.headline3?.copyWith(
          color: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainLIGHTColor
              : ColorResourcesDark.mainDARKColor,
        ),
      ),
      onDone: () {
        Get.offAllNamed(Routes.HOME);
      },
      skipColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainLIGHTColor
          : ColorResourcesDark.mainDARKColor,
      nextColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainLIGHTColor
          : ColorResourcesDark.mainDARKColor,
      doneColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainLIGHTColor
          : ColorResourcesDark.mainDARKColor,
      next: Text(
        'next',
        style: context.theme.textTheme.headline3?.copyWith(
          color: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainLIGHTColor
              : ColorResourcesDark.mainDARKColor,
        ),
      ),
      showNextButton: true,
      skip: Text(
        'skip',
        style: context.theme.textTheme.headline3?.copyWith(
          color: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainLIGHTColor
              : ColorResourcesDark.mainDARKColor,
        ),
      ),
      showSkipButton: true,
      pages: introductionScreens(),
    ));
  }
}
