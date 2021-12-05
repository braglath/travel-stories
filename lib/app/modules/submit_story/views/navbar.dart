import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_diaries/app/data/storage/user_check_login_logout.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';
import 'package:travel_diaries/app/modules/animations/left_to_right_animation.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';

class NavBar extends GetView {
  NavBar({Key? key}) : super(key: key);
  final String name = UserDetails().readUserNamefromBox().toString();
  final String phoneorEmail =
      UserDetails().readUserPhoneorEmailfromBox().toString();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
      child: Drawer(
        backgroundColor: ThemeService().theme == ThemeMode.light
            ? ColorResourcesLight.mainLIGHTAPPBARcolor
            : ColorResourcesDark.mainDARKAPPBARcolor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: LefttoRightAnimation(
                duration: Duration(milliseconds: 500),
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              accountEmail: LefttoRightAnimation(
                duration: Duration(milliseconds: 500),
                child: Text(
                  phoneorEmail,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              currentAccountPicture: FadedScaleAnimation(
                CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      'https://mobirise.com/bootstrap-template/profile-template/assets/images/timothy-paul-smith-256424-1200x800.jpg',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
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
              onTap: () => Get.back(),
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
                  Get.reloadAll(force: true);
                  UserDetails().deleteUserDetailsfromBox();
                  Get.offAllNamed(Routes.HOME);
                }),
          ],
        ),
      ),
    );
  }
}
