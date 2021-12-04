// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  // final PersistentTabController _controller =
  //     PersistentTabController(initialIndex: 0);
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Login',
                style: context.theme.textTheme.headline1,
              ),
            ),
            Hero(
              tag: 'loginlogo',
              child: SizedBox(
                  child: Image.asset('images/introfinal.png',
                      fit: BoxFit.contain)),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  phoneNumber(),
                  SizedBox(
                    height: 15,
                  ),
                  password(),
                  SizedBox(
                    height: 25,
                  ),
                  Hero(
                    tag: 'loginbutton',
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () => Get.offAllNamed(Routes.SUBMIT_STORY),
                        child: Text(
                          'Login',
                          style: context.theme.textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: InkWell(
                  onTap: () => Get.toNamed(Routes.SIGNUP),
                  child: RichText(
                    text: TextSpan(
                      text: 'Dont have an account? ',
                      style: context.theme.textTheme.headline4,
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Sign up',
                            style: context.theme.textTheme.headline4?.copyWith(
                              color: ThemeService().theme == ThemeMode.light
                                  ? ColorResourcesLight.mainLIGHTColor
                                  : ColorResourcesDark.mainDARKColor,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget phoneNumber() => TextFormField(
      cursorColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      keyboardType: TextInputType.phone,
      controller: _phonenumberController,
      autovalidate: true,
      validator: (val) {},
      decoration: InputDecoration(
        labelText: 'Phone number or Email',
      ));

  Widget password() => TextFormField(
      cursorColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordController,
      obscureText: true,
      autovalidate: true,
      validator: (val) {},
      decoration: InputDecoration(
        labelText: 'Password',
      ));

  // Widget bottomNavTab(context) {
  //   return PersistentTabView(
  //     context,
  //     controller: _controller,
  //     screens: _buildScreens(),
  //     items: _navBarsItems(),
  //     confineInSafeArea: true,
  //     backgroundColor: Colors.white, // Default is Colors.white.
  //     handleAndroidBackButtonPress: true, // Default is true.
  //     resizeToAvoidBottomInset:
  //         true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
  //     stateManagement: true, // Default is true.
  //     hideNavigationBarWhenKeyboardShows:
  //         true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
  //     decoration: NavBarDecoration(
  //       borderRadius: BorderRadius.circular(10.0),
  //       colorBehindNavBar: Colors.white,
  //     ),
  //     popAllScreensOnTapOfSelectedTab: true,
  //     popActionScreens: PopActionScreensType.all,
  //     itemAnimationProperties: ItemAnimationProperties(
  //       // Navigation Bar's items animation properties.
  //       duration: Duration(milliseconds: 200),
  //       curve: Curves.ease,
  //     ),
  //     screenTransitionAnimation: ScreenTransitionAnimation(
  //       // Screen transition animation on change of selected tab.
  //       animateTabTransition: true,
  //       curve: Curves.ease,
  //       duration: Duration(milliseconds: 200),
  //     ),
  //     navBarStyle:
  //         NavBarStyle.style13, // Choose the nav bar style with this property.
  //   );
  // }

  // List<Widget> _buildScreens() {
  //   return [SubmitStoryView(), ProfileView()];
  // }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.home),
  //       title: ("Home"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //       routeAndNavigatorSettings: RouteAndNavigatorSettings(
  //         initialRoute: Routes.HOME,
  //         routes: {
  //           Routes.SUBMIT_STORY: (context) => SubmitStoryView(),
  //           Routes.PROFILE: (context) => ProfileView(),
  //         },
  //       ),
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.settings),
  //       title: ("Settings"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //       routeAndNavigatorSettings: RouteAndNavigatorSettings(
  //         initialRoute: Routes.HOME,
  //         routes: {
  //           Routes.SUBMIT_STORY: (context) => SubmitStoryView(),
  //           Routes.PROFILE: (context) => ProfileView(),
  //         },
  //       ),
  //     )
  //   ];
  // }
}
