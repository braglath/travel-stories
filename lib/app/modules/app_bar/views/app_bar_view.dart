import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';
import 'package:travel_diaries/app/modules/animations/top_to_bottom_animation.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';

import '../controllers/app_bar_controller.dart';

class AppBarView extends GetView<AppBarController>
    implements PreferredSizeWidget {
  final Size preferredSize;
  final String title;

  AppBarView({
    Key? key,
    required this.title,
  })  : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  // final bool args = Get.arguments;
  @override
  final controller = Get.find(tag: 'appbarcontroller');
  @override
  Widget build(BuildContext context) {
    print('${ModalRoute.of(context)?.settings.name}');
    return AppBar(
      title: ToptoBottomAnimation(
          duration: Duration(milliseconds: 800),
          child: Text(title,
              style:
                  context.theme.textTheme.headline3?.copyWith(fontSize: 22))),
      leading: ModalRoute.of(context)!.settings.name!.contains('/submit-story')
          ? null
          : IconButton(
              splashRadius: 15,
              icon: Icon(Icons.chevron_left_outlined),
              onPressed: () {
                if (ModalRoute.of(context)!
                    .settings
                    .name!
                    .contains('/full-screen-story')) {}
                if (ModalRoute.of(context)!
                    .settings
                    .name!
                    .contains('/fav-full-screen')) {
                  Get.offAllNamed(Routes.SUBMIT_STORY);
                }
                Get.back();
              }),

      // line weight
      // clear_all_rounded
      actions: ModalRoute.of(context)!.settings.name!.contains('/profile') ||
              ModalRoute.of(context)!
                  .settings
                  .name!
                  .contains('/fave-stories') ||
              ModalRoute.of(context)!
                  .settings
                  .name!
                  .contains('/full-screen-story')
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
                    child: Obx(
                      () {
                        return Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    ThemeService().theme == ThemeMode.light
                                        ? ColorResourcesLight.mainLIGHTColor
                                        : ColorResourcesDark.mainDARKColor,
                                radius: 15,
                                child: CircleAvatar(
                                    radius: 13.0,
                                    child: controller
                                            .profilePicture.value.isNotEmpty
                                        ? null
                                        : Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                    backgroundColor: controller
                                            .profilePicture.value.isNotEmpty
                                        ? ThemeService().theme ==
                                                ThemeMode.light
                                            ? ColorResourcesLight.mainLIGHTColor
                                            : ColorResourcesDark.mainDARKColor
                                        : null,
                                    backgroundImage: controller
                                            .profilePicture.value.isNotEmpty
                                        ? NetworkImage(
                                            "http://ubermensch.studio/travel_stories/profileimages/${controller.profilePicture.value}")
                                        : null),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
    );
  }
}
