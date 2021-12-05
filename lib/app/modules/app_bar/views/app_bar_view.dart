import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/top_to_bottom_animation.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';

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
      actions: ModalRoute.of(context)!.settings.name!.contains('/profile')
          ? null
          : <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  radius: 5,
                  borderRadius: BorderRadius.circular(50),
                  onTap: () => ModalRoute.of(context)!
                          .settings
                          .name!
                          .contains('/profile')
                      ? null
                      : Get.toNamed(Routes.PROFILE),
                  child: Hero(
                    tag: 'profileicon',
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: ThemeService().theme == ThemeMode.light
                          ? ColorResourcesLight.mainLIGHTColor
                          : ColorResourcesDark.mainDARKColor,
                      child: Icon(Icons
                          .person), // todo if no profile image implement default
                    ),
                  ),
                ),
              )
            ],
    );
  }
}
