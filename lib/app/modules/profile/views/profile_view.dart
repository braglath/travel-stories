import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:travel_diaries/app/data/Services/logout_user_service.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/modules/fave_stories/controllers/fave_stories_controller.dart';
import 'package:travel_diaries/app/modules/my_stories/controllers/my_stories_controller.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_counter.dart';

import '../controllers/profile_controller.dart';

class MenuTile {
  String? title;
  String? subtitle;
  IconData iconData;
  Function onTap;
  MenuTile(this.title, this.subtitle, this.iconData, this.onTap);
}

class ProfileView extends GetView<ProfileController> {
  final args = Get.arguments;
  final id = UserDetails().readUserIDfromBox();
  final name = UserDetails().readUserNamefromBox();
  @override
  final controller = Get.find(tag: 'profilecontroller');
  final mystoryController = Get.put<MyStoriesController>(MyStoriesController());
  final favestoriesController =
      Get.put<FaveStoriesController>(FaveStoriesController());

  @override
  Widget build(BuildContext context) {
    controller.addStoriedPosted();
    List<MenuTile> _menu = [
      MenuTile('Profile', 'Edit your profile', FontAwesomeIcons.edit,
          () => Get.toNamed(Routes.EDIT_PROFILE)),
      MenuTile('My stories', 'Stories that you have posted',
          FontAwesomeIcons.book, () => Get.toNamed(Routes.MY_STORIES)),
      MenuTile('Favorites', 'Stories which you liked', FontAwesomeIcons.heart,
          () => Get.toNamed(Routes.FAVE_STORIES)),
      MenuTile(
          'Localization', 'Set app language', FontAwesomeIcons.globe, () {}),
      MenuTile('Contact us', 'Submit your query', Icons.email,
          () => Get.toNamed(Routes.CONTACT_US)),
      MenuTile(
          'Toggle modes',
          'Toggle between dark and light mode',
          ThemeService().theme == ThemeMode.light
              ? FontAwesomeIcons.lightbulb
              : FontAwesomeIcons.moon,
          () => ThemeService().switchTheme()),
      MenuTile(
          'Privacy policy',
          'Checkout our privacy policy',
          FontAwesomeIcons.userShield,
          () => Get.toNamed(Routes.PRIVACY_POLICY)),
      MenuTile(
          'Logout', 'Logout and restart the app', FontAwesomeIcons.signOutAlt,
          () {
        LogoutUserFromAll().now();
      }),
    ];
    return Scaffold(
      appBar: AppBarView(appBarSize: 56, bottom: null, title: 'Profile page'),
      floatingActionButton: Obx(() {
        return controller.shouldAutoscroll.value
            ? FadedScaleAnimation(
                FloatingActionButton(
                    heroTag: null,
                    mini: true,
                    tooltip: 'move to top',
                    child: FaIcon(
                      FontAwesomeIcons.chevronUp,
                    ),
                    onPressed: () {
                      controller.scrollToTop();
                      print(controller.scrollController.value);
                    }),
              )
            : SizedBox.shrink();
      }),
      body: _listView(context, _menu),
    );
  }

  Widget _listView(BuildContext context, _menu) {
    return ListView(
      controller: controller.scrollController.value,
      physics: BouncingScrollPhysics(),
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          color: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainLIGHTAPPBARcolor
              : ColorResourcesDark.mainDARKAPPBARcolor,
          child: InkWell(
            radius: 5,
            borderRadius: BorderRadius.circular(50),
            onTap: () => {},
            child: Hero(
                tag: 'profileicon',
                child: Obx(() {
                  return controller.profilePicture.value.isEmpty
                      ? CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              ThemeService().theme == ThemeMode.light
                                  ? ColorResourcesLight.mainLIGHTColor
                                  : ColorResourcesDark.mainDARKColor,
                          child: Icon(Icons.person))
                      : Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    ThemeService().theme == ThemeMode.light
                                        ? ColorResourcesLight.mainLIGHTColor
                                        : ColorResourcesDark.mainDARKColor,
                                radius: 55,
                                child: CircleAvatar(
                                    radius: 52.0,
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
                                        ? NetworkImage(controller
                                                .profilePicture.value
                                                .contains('https')
                                            ? controller.profilePicture.value
                                            : "http://ubermensch.studio/travel_stories/profileimages/${controller.profilePicture.value}")
                                        : null),
                              ),
                            ],
                          ),
                        );
                })),
          ),
        ),
        Container(
          color: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainLIGHTAPPBARcolor
              : ColorResourcesDark.mainDARKAPPBARcolor,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: UserDetails().readUserNamefromBox().length > 18
                        ? "${UserDetails().readUserNamefromBox().replaceAll(" ", "\n")} \n"
                        : "${UserDetails().readUserNamefromBox()} \n",
                    style: context.theme.textTheme.headline3),
                TextSpan(
                    text: '${UserDetails().readUserPhoneorEmailfromBox()}\n',
                    style: context.theme.textTheme.headline4),
                TextSpan(
                    text: '${UserDetails().readUserCaptionfromBox()}',
                    style: context.theme.textTheme.caption),
              ],
            ),
          ),
        ),
        Container(
          height: 5,
          color: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainLIGHTAPPBARcolor
              : ColorResourcesDark.mainDARKAPPBARcolor,
        ),
        Stack(
          children: [
            Container(
              height: 50,
              color: ThemeService().theme == ThemeMode.light
                  ? ColorResourcesLight.mainLIGHTAPPBARcolor
                  : ColorResourcesDark.mainDARKAPPBARcolor,
            ),
            cards(context),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height + 150,
          child: GridView.builder(
              itemCount: _menu.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.6,
                  crossAxisCount: 1,
                  mainAxisExtent: 102),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: _menu[index].onTap as void Function()?,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: ThemeService().theme == ThemeMode.light
                              ? ColorResourcesLight.mainLIGHTAPPBARcolor
                              : ColorResourcesDark.mainDARKAPPBARcolor,
                          boxShadow: [
                            BoxShadow(
                              color: ColorResourcesLight.mainTextHEADINGColor
                                  .withOpacity(0.2),
                              offset: const Offset(
                                5.0,
                                2.0,
                              ),
                              blurRadius: 5.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                            //BoxShadow
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadedScaleAnimation(
                              Text(_menu[index].title!,
                                  style: context.theme.textTheme.headline4),
                              durationInMilliseconds: 400,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  _menu[index].subtitle!,
                                  style: context.theme.textTheme.caption,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Icon(
                                  _menu[index].iconData,
                                  size: 25,
                                  color: ThemeService().theme == ThemeMode.light
                                      ? ColorResourcesLight.mainLIGHTColor
                                      : ColorResourcesDark.mainDARKColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      index == 1
                          ? Obx(() {
                              return CircleAvatar(
                                backgroundColor:
                                    ThemeService().theme == ThemeMode.light
                                        ? ColorResourcesLight.mainLIGHTColor
                                        : ColorResourcesDark.mainDARKColor,
                                radius: 12,
                                child: Text(
                                  mystoryController.story.length.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(
                                          color: ColorResourcesLight
                                              .mainLIGHTScaffoldBG),
                                ),
                              );
                            })
                          : index == 2
                              ? Obx(() {
                                  return CircleAvatar(
                                    backgroundColor:
                                        ThemeService().theme == ThemeMode.light
                                            ? ColorResourcesLight.mainLIGHTColor
                                            : ColorResourcesDark.mainDARKColor,
                                    radius: 12,
                                    child: Text(
                                      favestoriesController.story.length
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          ?.copyWith(
                                              color: ColorResourcesLight
                                                  .mainLIGHTScaffoldBG),
                                    ),
                                  );
                                })
                              : SizedBox.shrink(),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget cards(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [totalStoriesPosted(context), totalLikedStories(context)],
    );
  }

  Widget totalStoriesPosted(context) {
    return Container(
      height: 125,
      width: 135,
      child: Card(
        color: ThemeService().theme == ThemeMode.light
            ? ColorResourcesLight.mainLIGHTAPPBARcolor
            : ColorResourcesDark.mainDARKAPPBARcolor,
        child: Center(
          child: ListTile(
            trailing: FaIcon(
              FontAwesomeIcons.book,
              size: 22,
              color: ThemeService().theme == ThemeMode.light
                  ? ColorResourcesLight.mainLIGHTColor
                  : ColorResourcesDark.mainDARKColor,
            ),
            title: Text(
              'Stories posted',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            subtitle: Obx(() {
              return CustomCounter(
                  percentage:
                      double.parse(controller.storiesPosted.length.toString()));
            }),
          ),
        ),
      ),
    );
  }

  Widget totalLikedStories(context) {
    return Container(
      height: 125,
      width: 135,
      child: Card(
        color: ThemeService().theme == ThemeMode.light
            ? ColorResourcesLight.mainLIGHTAPPBARcolor
            : ColorResourcesDark.mainDARKAPPBARcolor,
        child: Center(
          child: ListTile(
            trailing: FaIcon(
              FontAwesomeIcons.solidHeart,
              size: 22,
              color: ThemeService().theme == ThemeMode.light
                  ? ColorResourcesLight.mainLIGHTColor
                  : ColorResourcesDark.mainDARKColor,
            ),
            title: Text(
              'Total likes',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            subtitle: Obx(() {
              return CustomCounter(
                  percentage:
                      double.parse(controller.totallikes.value.toString()));
            }),
          ),
        ),
      ),
    );
  }
}
