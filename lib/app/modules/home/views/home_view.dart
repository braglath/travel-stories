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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final textFieldFocusNode = FocusNode();
  @override
  final controller = Get.find(tag: 'homecontroller');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            reverse: true,
            child: Obx(() {
              return Stack(
                children: [
                  Column(
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
                            name(),
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
                                  onPressed: () => controller.loginUser(
                                      _nameController.text,
                                      _passwordController.text),
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
                                      style: context.theme.textTheme.headline4
                                          ?.copyWith(
                                        color:
                                            ColorResourcesLight.mainLIGHTColor,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  controller.isLoading.value
                      ? Positioned.fill(
                          child: Center(
                              child: CircularProgressIndicator(
                          backgroundColor:
                              ColorResourcesLight.mainLIGHTAPPBARcolor,
                          color: ColorResourcesLight.mainLIGHTColor,
                        )))
                      : SizedBox.shrink()
                ],
              );
            })),
      ),
    );
  }

  Widget name() => TextFormField(
      style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
      cursorColor: ColorResourcesLight.mainTextHEADINGColor,
      keyboardType: TextInputType.name,
      controller: _nameController,
      autovalidate: true,
      validator: (val) {
        if (val!.length > 25) {
          return 'Name cannot be more than 25 characters';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: ColorResourcesLight.mainLIGHTColor,
        ),
        labelText: 'Name',
      ));

  Widget password() => Obx(() {
        return TextFormField(
            focusNode: textFieldFocusNode,
            style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
            cursorColor: ThemeService().theme == ThemeMode.light
                ? ColorResourcesLight.mainTextHEADINGColor
                : ColorResourcesDark.mainDARKTEXTICONcolor,
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordController,
            obscureText: controller.obscured.value,
            autovalidate: true,
            validator: (val) {
              if (val!.length > 15) {
                return 'Password cannot be more than 15 characters';
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: ColorResourcesLight.mainLIGHTColor,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: GestureDetector(
                  onTap: () {
                    controller.toggleObscured();
                    if (textFieldFocusNode.hasPrimaryFocus) return;
                    textFieldFocusNode.canRequestFocus = false;
                  },
                  child: Icon(
                    controller.obscured.isFalse
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: controller.obscured.isFalse
                        ? ColorResourcesLight.mainLIGHTColor
                        : ColorResourcesLight.mainTextHEADINGColor,
                    size: 24,
                  ),
                ),
              ),
              labelText: 'Password',
            ));
      });

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
