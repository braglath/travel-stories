import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/top_to_bottom_animation.dart';
import 'package:travel_diaries/app/modules/navigation_drawer/controllers/navigation_drawer_controller.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';

import '../controllers/app_bar_controller.dart';

class AppBarView extends GetView<AppBarController>
    implements PreferredSizeWidget {
  final Size preferredSize;
  final String title;
  final PreferredSizeWidget? bottom;
  final double appBarSize;

  AppBarView(
      {Key? key,
      required this.title,
      required this.bottom,
      required this.appBarSize})
      : preferredSize = Size.fromHeight(appBarSize),
        super(key: key);

  // final bool args = Get.arguments;
  @override
  final controller = Get.find<AppBarController>(tag: 'appbarcontroller');
  final controller2 =
      Get.put<NavigationDrawerController>(NavigationDrawerController());
  @override
  Widget build(BuildContext context) {
    print('${ModalRoute.of(context)?.settings.name}');
    return AppBar(
      // excludeHeaderSemantics: true,
      // ignore: unnecessary_null_in_if_null_operators
      bottom: bottom ?? null,
      title: ToptoBottomAnimation(
          duration: Duration(milliseconds: 800),
          child: Text(title,
              style:
                  context.theme.textTheme.headline3?.copyWith(fontSize: 22))),
      leading: ModalRoute.of(context)!.settings.name!.contains('/submit-story')
          ? null
          : ModalRoute.of(context)!
                  .settings
                  .name!
                  .contains('/navigation-drawer')
              ? Obx(() {
                  return IconButton(
                      splashRadius: 15,
                      onPressed: () {
                        controller2.drawerController.toggle!();
                        controller.drawerOpened();
                      },
                      icon: FaIcon(
                        controller.isDrawerOpened.isFalse
                            ? FontAwesomeIcons.stream
                            : FontAwesomeIcons.minus,
                        size: 18,
                        color: ThemeService().theme == ThemeMode.light
                            ? ColorResourcesLight.mainTextHEADINGColor
                            : ColorResourcesDark.mainDARKTEXTICONcolor,
                      ));
                })
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
                      Get.offAllNamed(Routes.NAVIGATION_DRAWER);
                    }
                    if (ModalRoute.of(context)!
                        .settings
                        .name!
                        .contains('/profile')) {
                      Get.offAllNamed(Routes.NAVIGATION_DRAWER);
                    }
                    if (ModalRoute.of(context)!
                        .settings
                        .name!
                        .contains('/edit-profile')) {
                      Get.offAllNamed(Routes.NAVIGATION_DRAWER);
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
                  .contains('/full-screen-story') ||
              ModalRoute.of(context)!.settings.name!.contains('/my-stories') ||
              ModalRoute.of(context)!
                  .settings
                  .name!
                  .contains('/edit-my-stories') ||
              ModalRoute.of(context)!
                  .settings
                  .name!
                  .contains('/edit-profile') ||
              ModalRoute.of(context)!
                  .settings
                  .name!
                  .contains('/other-profile') ||
              ModalRoute.of(context)!.settings.name!.contains('/chat-room') ||
              ModalRoute.of(context)!
                  .settings
                  .name!
                  .contains('/privacy-policy') ||
              ModalRoute.of(context)!
                  .settings
                  .name!
                  .contains('/change-language')
          ? null
          : <Widget>[
              _profileImage(context),
            ],
    );
  }

  Padding _profileImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        radius: 5,
        borderRadius: BorderRadius.circular(50),
        onTap: () => ModalRoute.of(context)!.settings.name!.contains('/profile')
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
                      backgroundColor: ThemeService().theme == ThemeMode.light
                          ? ColorResourcesLight.mainLIGHTColor
                          : ColorResourcesDark.mainDARKColor,
                      radius: 15,
                      child: CircleAvatar(
                          radius: 13.0,
                          child: controller.profilePicture.value.isNotEmpty
                              ? null
                              : Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                          backgroundColor:
                              controller.profilePicture.value.isNotEmpty
                                  ? ThemeService().theme == ThemeMode.light
                                      ? ColorResourcesLight.mainLIGHTColor
                                      : ColorResourcesDark.mainDARKColor
                                  : null,
                          backgroundImage: controller
                                  .profilePicture.value.isNotEmpty
                              ? NetworkImage(controller.profilePicture.value
                                      .contains('https')
                                  ? controller.profilePicture.value
                                  : "http://ubermensch.studio/travel_stories/profileimages/${controller.profilePicture.value}")
                              : null),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
