import 'package:flutter/material.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

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
              accountName: Text(
                'this is my name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              accountEmail: Text(
                'this is my email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    'https://mobirise.com/bootstrap-template/profile-template/assets/images/timothy-paul-smith-256424-1200x800.jpg',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
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
            ),
            Divider(),
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
                Icons.edit,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor2
                    : ColorResourcesDark.mainDARKColor2,
              ),
              title: Text(
                'Edit profile',
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
                Icons.notifications,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor2
                    : ColorResourcesDark.mainDARKColor2,
              ),
              title: Text(
                'Notification',
                style: TextStyle(
                  color: ThemeService().theme == ThemeMode.light
                      ? ColorResourcesLight.mainTextHEADINGColor
                      : ColorResourcesDark.mainDARKTEXTICONcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.sync,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor2
                    : ColorResourcesDark.mainDARKColor2,
              ),
              title: Text(
                'Restart',
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
            ),
          ],
        ),
      ),
    );
  }
}
