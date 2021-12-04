import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/modules/animations/top_to_bottom_animation.dart';

import '../controllers/app_bar_controller.dart';

class AppBarView extends GetView<AppBarController>
    implements PreferredSizeWidget {
  final Size preferredSize;
  final String title;

  AppBarView({Key? key, required this.title})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  // final bool args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    print('${ModalRoute.of(context)?.settings.name}');
    return AppBar(
      title: ToptoBottomAnimation(
          duration: Duration(milliseconds: 800), child: Text(title)),
      leading: ModalRoute.of(context)!.settings.name!.contains('/submit-story')
          ? null
          : IconButton(
              splashRadius: 15,
              icon: Icon(Icons.chevron_left_outlined),
              onPressed: () => Get.back(),
            ),

      // line weight
      // clear_all_rounded
      actions: <Widget>[
        IconButton(
          splashRadius: 20,
          onPressed: () => ThemeService().switchTheme(),
          icon: ThemeService().theme == ThemeMode.light
              ? FaIcon(
                  FontAwesomeIcons.lightbulb,
                  color: Colors.amber,
                )
              : FaIcon(
                  FontAwesomeIcons.moon,
                  color: Colors.deepPurpleAccent,
                ),
        ),
      ],
    );
  }
}
