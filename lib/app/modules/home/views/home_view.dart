import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

// ignore_for_file: must_be_immutable

class HomeView extends GetView<HomeController> {
  // final PersistentTabController _controller =
  //     PersistentTabController(initialIndex: 0);
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
                        child: Form(
                          key: controller.loginFormKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                    onPressed: () => controller.checkLogin(),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        'Login',
                                        style:
                                            context.theme.textTheme.headline6,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Text('Other options',
                                style: context.theme.textTheme.headline4
                                    ?.copyWith(fontSize: 15)),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.google,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Google',
                                    style: context.theme.textTheme.headline4
                                        ?.copyWith(
                                            color: ColorResourcesLight
                                                .mainLIGHTAPPBARcolor,
                                            fontSize: 15),
                                  )
                                ],
                              )),
                          ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.facebook,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Facebook',
                                    style: context.theme.textTheme.headline4
                                        ?.copyWith(
                                            color: ColorResourcesLight
                                                .mainLIGHTAPPBARcolor,
                                            fontSize: 15),
                                  )
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: InkWell(
                            onTap: () => controller.anonymousLogin(),
                            child: RichText(
                              text: TextSpan(
                                text: 'Test the app! ',
                                style: context.theme.textTheme.headline4,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Go anonymous',
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
      controller: controller.nameController,
      onSaved: (value) {
        controller.name = value!;
      },
      validator: (value) {
        return controller.validateName(value!);
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
            controller: controller.passwordController,
            onSaved: (value) {
              controller.password = value!;
            },
            validator: (value) {
              return controller.validatePassword(value!);
            },
            obscureText: controller.obscured.value,
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
