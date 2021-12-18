import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:travel_diaries/app/data/Services/logout_user_service.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';
import 'package:travel_diaries/app/modules/animations/left_to_right_animation.dart';
import 'package:travel_diaries/app/modules/app_bar/controllers/app_bar_controller.dart';
import 'package:travel_diaries/app/modules/navigation_drawer/controllers/navigation_drawer_controller.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';

class MenuScreenView extends GetView {
  @override
  final controller2 =
      Get.put<NavigationDrawerController>(NavigationDrawerController());
  final controller3 =
      Get.put<AppBarController>(AppBarController(), tag: 'appbarcontroller');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: LefttoRightAnimation(
                duration: Duration(milliseconds: 500),
                child: Text(
                  UserDetails().readUserNamefromBox(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              accountEmail: LefttoRightAnimation(
                duration: Duration(milliseconds: 500),
                child: Text(
                  UserDetails().readUserPhoneorEmailfromBox(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              currentAccountPicture: _profileImage(),
              decoration: BoxDecoration(
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor
                    : ColorResourcesDark.mainDARKColor,
              ),
            ),
            ListTile(
              title: Text(
                'Main pages',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor2
                    : ColorResourcesDark.mainDARKColor2,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: ThemeService().theme == ThemeMode.light
                      ? ColorResourcesLight.mainTextHEADINGColor
                      : ColorResourcesDark.mainDARKTEXTICONcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              onTap: () {
                controller3.drawerOpened();
                controller2.drawerController.toggle!();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.add,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor2
                    : ColorResourcesDark.mainDARKColor2,
              ),
              title: Text(
                'Post story',
                style: TextStyle(
                  color: ThemeService().theme == ThemeMode.light
                      ? ColorResourcesLight.mainTextHEADINGColor
                      : ColorResourcesDark.mainDARKTEXTICONcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              onTap: () => Get.toNamed(Routes.POST_STORY),
            ),
            ListTile(
                leading: Icon(
                  Icons.person,
                  color: ThemeService().theme == ThemeMode.light
                      ? ColorResourcesLight.mainLIGHTColor2
                      : ColorResourcesDark.mainDARKColor2,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    color: ThemeService().theme == ThemeMode.light
                        ? ColorResourcesLight.mainTextHEADINGColor
                        : ColorResourcesDark.mainDARKTEXTICONcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  Get.toNamed(Routes.PROFILE);
                }),
            Divider(),
            ListTile(
              title: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.language,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor2
                    : ColorResourcesDark.mainDARKColor2,
              ),
              title: Text(
                'Change language',
                style: TextStyle(
                  color: ThemeService().theme == ThemeMode.light
                      ? ColorResourcesLight.mainTextHEADINGColor
                      : ColorResourcesDark.mainDARKTEXTICONcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                ThemeService().theme == ThemeMode.light
                    ? Icons.light_mode_sharp
                    : FontAwesomeIcons.moon,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor2
                    : ColorResourcesDark.mainDARKColor2,
              ),
              title: Text(
                ThemeService().theme == ThemeMode.light
                    ? 'Toggle dark mode'
                    : 'Toggle light mode',
                style: TextStyle(
                  color: ThemeService().theme == ThemeMode.light
                      ? ColorResourcesLight.mainTextHEADINGColor
                      : ColorResourcesDark.mainDARKTEXTICONcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              onTap: () => ThemeService().switchTheme(),
            ),
            ListTile(
                leading: Icon(
                  Icons.logout,
                  color: ThemeService().theme == ThemeMode.light
                      ? ColorResourcesLight.mainLIGHTColor2
                      : ColorResourcesDark.mainDARKColor2,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: ThemeService().theme == ThemeMode.light
                        ? ColorResourcesLight.mainTextHEADINGColor
                        : ColorResourcesDark.mainDARKTEXTICONcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  LogoutUserFromAll().now();
                }),
          ],
        ),
      ),
    );
  }

  FadedScaleAnimation _profileImage() {
    return FadedScaleAnimation(
      Stack(
        children: [
          CircleAvatar(
              radius: 50.0,
              child: UserDetails().readUserProfilePicfromBox().isNotEmpty
                  ? null
                  : Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
              backgroundColor:
                  UserDetails().readUserProfilePicfromBox().isNotEmpty
                      ? ThemeService().theme == ThemeMode.light
                          ? ColorResourcesLight.mainLIGHTColor
                          : ColorResourcesDark.mainDARKColor
                      : null,
              backgroundImage: UserDetails()
                      .readUserProfilePicfromBox()
                      .isNotEmpty
                  ? NetworkImage(UserDetails()
                          .readUserProfilePicfromBox()
                          .contains('https')
                      ? UserDetails().readUserProfilePicfromBox()
                      : "http://ubermensch.studio/travel_stories/profileimages/${UserDetails().readUserProfilePicfromBox()}")
                  : null),
        ],
      ),
    );
  }
}
