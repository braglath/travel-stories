import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';

class IntroductioScreensView extends StatelessWidget {
  final List<String> travelmodes = [
    'Cycle',
    'Bike',
    'Car',
    'Bus',
    'Train',
    'Flight'
  ];

  final List<IconData> travelIcons = [
    Icons.directions_bike_sharp,
    Icons.motorcycle_rounded,
    FontAwesomeIcons.car,
    FontAwesomeIcons.bus,
    FontAwesomeIcons.train,
    Icons.flight_takeoff,
  ];
  List<PageViewModel> get introductionScreens => [
        PageViewModel(
          decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainTextHEADINGColor
                    : ColorResourcesDark.mainDARKTEXTICONcolor,
              ),
              bodyTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainTextHEADINGColor
                    : ColorResourcesDark.mainDARKTEXTICONcolor,
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
                    ? ColorResourcesLight.mainTextHEADINGColor
                    : ColorResourcesDark.mainDARKTEXTICONcolor,
              ),
              bodyTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainTextHEADINGColor
                    : ColorResourcesDark.mainDARKTEXTICONcolor,
              )),
          image: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      mainAxisExtent: 100,
                      childAspectRatio: 1),
                  // itemExtent: 100,
                  shrinkWrap: true,
                  itemCount: travelmodes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return ChoiceChip(
                      selected: true,
                      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      avatar: Icon(
                        travelIcons[index],
                        color: Colors.white,
                      ),
                      label: Text(
                        travelmodes[index],
                      ),
                    );
                  })),
          title: '',
          body: 'No matter what your travel mode is',
        ),
        PageViewModel(
          decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainTextHEADINGColor
                    : ColorResourcesDark.mainDARKTEXTICONcolor,
              ),
              bodyTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainTextHEADINGColor
                    : ColorResourcesDark.mainDARKTEXTICONcolor,
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
      globalBackgroundColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainLIGHTScaffoldBG
          : ColorResourcesDark.mainDARKScaffoldBG,
      animationDuration: 500,
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        activeColor: ThemeService().theme == ThemeMode.light
            ? ThemeService().theme == ThemeMode.light
                ? ColorResourcesLight.mainLIGHTColor
                : ColorResourcesDark.mainDARKColor
            : ColorResourcesDark.mainDARKColor,
      ),
      dotsFlex: 2,
      done: Text(
        'Done',
        style: context.theme.textTheme.displaySmall?.copyWith(
          color: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainTextHEADINGColor
              : ColorResourcesDark.mainDARKTEXTICONcolor,
        ),
      ),
      onDone: () {
        Get.offAllNamed(Routes.HOME);
      },
      skipColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      nextColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      doneColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      next: Text(
        'next',
        style: context.theme.textTheme.displaySmall?.copyWith(
          color: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainTextHEADINGColor
              : ColorResourcesDark.mainDARKTEXTICONcolor,
        ),
      ),
      showNextButton: true,
      skip: Text(
        'skip',
        style: context.theme.textTheme.displaySmall?.copyWith(
          color: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainTextHEADINGColor
              : ColorResourcesDark.mainDARKTEXTICONcolor,
        ),
      ),
      showSkipButton: true,
      pages: introductionScreens,
    ));
  }
}
