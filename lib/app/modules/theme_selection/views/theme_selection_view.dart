import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';
import 'package:travel_diaries/app/modules/animations/top_to_bottom_animation.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import '../controllers/theme_selection_controller.dart';

class ThemeSelectionView extends GetView<ThemeSelectionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          _mainBody(context),
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'Pick theme mode',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  SafeArea _mainBody(context) {
    return SafeArea(
      child: Row(
        children: <Widget>[
          _leftSide(context),
          _rightSide(context),
        ],
      ),
    );
  }

  Widget _leftSide(context) => Container(
        width: MediaQuery.of(context).size.width / 2,
        color: ColorResourcesLight.mainLIGHTScaffoldBG,
        child: Column(
          children: <Widget>[
            Spacer(),
            ToptoBottomAnimation(
              duration: Duration(milliseconds: 800),
              child: Text(
                'Light',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Container(
              child: SimpleShadow(
                child: Image(
                  width: 400.0,
                  height: 400.0,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/themes/light.png'),
                  semanticLabel: 'light thme mode',
                ),
                opacity: 0.3, // Default: 0.5
                color: Colors.black, // Default: Black
                offset: Offset(3, 8), // Default: Offset(2, 2)
                sigma: 7, // Default: 2
              ),
            ),
            IconButton(
                splashColor: ColorResourcesDark.mainDARKScaffoldBG,
                splashRadius: 15,
                onPressed: () {
                  ThemeService().saveThemeToBox(false);
                  Get.offAndToNamed(Routes.INTRODUCTION);
                },
                icon: FaIcon(
                  FontAwesomeIcons.lightbulb,
                  color: ColorResourcesLight.mainTextHEADINGColor,
                  size: 28,
                )),
            Spacer(),
          ],
        ),
      );
  Widget _rightSide(context) => Container(
        width: MediaQuery.of(context).size.width / 2,
        color: ColorResourcesDark.mainDARKScaffoldBG,
        child: Column(
          children: <Widget>[
            Spacer(),
            ToptoBottomAnimation(
              duration: Duration(milliseconds: 800),
              child: Text(
                'Dark',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: ColorResourcesLight.mainLIGHTScaffoldBG),
              ),
            ),
            Container(
              child: SimpleShadow(
                child: Image(
                  width: 400.0,
                  height: 400.0,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/themes/dark.png'),
                  semanticLabel: 'light thme mode',
                ),
                opacity: 0.3, // Default: 0.5
                color: Colors.black, // Default: Black
                offset: Offset(3, 8), // Default: Offset(2, 2)
                sigma: 7, // Default: 2
              ),
            ),
            IconButton(
                splashColor: ColorResourcesLight.mainLIGHTScaffoldBG,
                splashRadius: 15,
                onPressed: () {
                  ThemeService().saveThemeToBox(true);
                  Get.offAndToNamed(Routes.INTRODUCTION);
                },
                icon: FaIcon(
                  FontAwesomeIcons.moon,
                  color: ColorResourcesLight.mainLIGHTScaffoldBG,
                  size: 28,
                )),
            Spacer(),
          ],
        ),
      );
}
