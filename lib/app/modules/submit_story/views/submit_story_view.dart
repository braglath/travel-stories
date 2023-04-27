import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:travel_diaries/app/data/Models/stories_model.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/modules/navigation_drawer/controllers/navigation_drawer_controller.dart';
import 'package:travel_diaries/app/modules/top_stories/views/top_stories_view.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';
import 'package:travel_diaries/app/views/views/custom_story_bar_widget_view.dart';

import '../controllers/submit_story_controller.dart';

class SubmitStoryView extends GetView<SubmitStoryController> {
  final TextEditingController textController = TextEditingController();
  final DateTime timeBackButtonPressed = DateTime.now();
  // final PersistentTabController _controller =
  //   PersistentTabController(initialIndex: 0);
  @override
  final controller = Get.find(tag: 'submitstorycontroller');
  final controller2 =
      Get.put<NavigationDrawerController>(NavigationDrawerController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.pressBackAgainToExit(),
      child: Scaffold(
          // drawer: NavBar(),
          appBar: AppBarView(
            appBarSize: 56,
            bottom: null,
            title: 'Travel stories',
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Obx(() {
                return controller.shouldAutoscroll.value
                    ? FadedScaleAnimation(
                        FloatingActionButton(
                            heroTag: null,
                            mini: true,
                            tooltip: 'move to top',
                            child: FaIcon(FontAwesomeIcons.chevronUp,
                                color:
                                    ColorResourcesLight.mainLIGHTAPPBARcolor),
                            onPressed: () {
                              controller.scrollToTop();
                              print(controller.scrollController.value);
                            }),
                      )
                    : SizedBox.shrink();
              }),
              SizedBox(
                height: 20,
              ),
              FadedScaleAnimation(
                _floatingActionButton(context, FontAwesomeIcons.plus, 'Post',
                    () => Get.toNamed(Routes.POST_STORY)),
              ),
            ],
          ),
          body: Obx(() {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          color: ThemeService().theme == ThemeMode.light
                              ? ColorResourcesLight.mainLIGHTAPPBARcolor
                              : Color(0xFF8F260F),
                          height: 50,
                          child: customchips()),
                      // Column(
                      //   children: [],
                      // ),
                      Obx(() {
                        print('story length ${controller.story.length}');
                        return controller.isEmpty.isTrue
                            ? Text(
                                'i am empty',
                                style: TextStyle(
                                  color: ThemeService().theme == ThemeMode.light
                                      ? ColorResourcesLight.mainTextHEADINGColor
                                      : ColorResourcesDark
                                          .mainDARKTEXTICONcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                            : Expanded(
                                child: SingleChildScrollView(
                                controller: controller.scrollController.value,
                                child: Column(
                                  children: [
                                    Container(
                                      color: ThemeService().theme ==
                                              ThemeMode.light
                                          ? ColorResourcesLight
                                              .mainLIGHTAPPBARcolor
                                          : Color(0xFF8F260F),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('Search stories',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 28)),
                                          IconButton(
                                              splashRadius: 15,
                                              onPressed: () => showSearch(
                                                  context: context,
                                                  delegate:
                                                      CustomSearchDelegate()),
                                              icon: FaIcon(
                                                FontAwesomeIcons.search,
                                                color: ThemeService().theme ==
                                                        ThemeMode.light
                                                    ? Colors.grey[500]
                                                    : Colors.grey[300],
                                              )),
                                        ],
                                      ),
                                    ),
                                    TopStoriesView(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, bottom: 4),
                                      child: Text(
                                        'Recent stories',
                                        style: context
                                            .theme.textTheme.headlineMedium,
                                      ),
                                    ),
                                    Obx(() {
                                      // controller.update();
                                      return RefreshIndicator(
                                          color: ThemeService().theme ==
                                                  ThemeMode.light
                                              ? ColorResourcesLight
                                                  .mainLIGHTColor
                                              : ColorResourcesDark
                                                  .mainDARKColor,
                                          strokeWidth: 3,
                                          onRefresh: () =>
                                              controller.refreshStories(
                                                  controller.travelmodes[
                                                      controller
                                                          .defaultChoiceIndex
                                                          .value]),
                                          child: _recentStories());
                                    }),
                                  ],
                                ),
                              ));
                      })
                    ],
                  ),
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
    );
  }

  Widget _recentStories() => ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: controller.story.length,
        itemBuilder: (context, index) {
          var dateTime =
              DateTime.parse(controller.story[index].dateadded.toString());
          var formate1 = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
          var story = controller.story[index];
          print(controller.story[index].personprofilepic);

          return CustomStoryBarWidgetView(
            profileOnTapped: () =>
                Get.toNamed(Routes.OTHER_PROFILE, arguments: {
              'authorId': controller.story[index].personid,
              'authorName': controller.story[index].personname
            }),
            trailingOnTap: () => CustomSnackbar(
                    title: 'Warning',
                    message: 'Read the story before adding it to favorites')
                .showWarning(),
            likes: story.likes,
            authorProfilePic: story.personprofilepic,
            storyTitle: story.title,
            storyCategory: story.category,
            authorName: story.personname,
            storyDate: formate1,
            authorId: story.personid,
            storyId: story.id,
            listTileOnTap: () =>
                Get.toNamed(Routes.FULL_SCREEN_STORY, arguments: [
              {'authorname': controller.story[index].personname},
              {'authorprofilepic': controller.story[index].personprofilepic},
              {'authorid': controller.story[index].personid},
              {'storytitle': controller.story[index].title},
              {'storycategory': controller.story[index].category},
              {'storybody': controller.story[index].body},
              {'storylikes': controller.story[index].likes},
              {'storyid': controller.story[index].id},
              {'storydate': formate1.toString()}
            ]),
            storyBody: story.body,
            readmoreOnTap: () =>
                Get.toNamed(Routes.FULL_SCREEN_STORY, arguments: [
              {'authorname': controller.story[index].personname},
              {'authorprofilepic': controller.story[index].personprofilepic},
              {'authorid': controller.story[index].personid},
              {'storytitle': controller.story[index].title},
              {'storycategory': controller.story[index].category},
              {'storybody': controller.story[index].body},
              {'storylikes': controller.story[index].likes},
              {'storyid': controller.story[index].id},
              {'storydate': formate1.toString()}
            ]),
          );
        },
      );

  Widget _floatingActionButton(context, faIcon, title, Function()? onPressed) =>
      FloatingActionButton.extended(
        heroTag: null,
        onPressed: onPressed,
        // extendedPadding: EdgeInsets.zero,
        icon: FaIcon(
          faIcon,
          color: Colors.white,
        ),
        label: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white),
        ),
      );

  Widget customchips() => ListView.builder(
      // itemExtent: 100,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.travelmodes.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (
        context,
        index,
      ) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Obx(
            () {
              return ChoiceChip(
                labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                avatar: Icon(
                  controller.travelIcons[index],
                  color: Colors.white,
                ),
                label: Text(
                  controller.travelmodes[index],
                ),
                selected: controller.defaultChoiceIndex.value == index,
                // selectedColor: Colors.deepPurple,
                onSelected: (value) {
                  controller.defaultChoiceIndex.value =
                      value ? index : controller.defaultChoiceIndex.value;
                  print('$value \n ${controller.defaultChoiceIndex.value} ');
                  print(controller
                      .travelmodes[controller.defaultChoiceIndex.value]);
                  controller.fetchStories(controller
                      .travelmodes[controller.defaultChoiceIndex.value]);
                },
                // backgroundColor: color,
                // elevation: 2,
                // padding: EdgeInsets.symmetric(horizontal: 10),
              );
            },
          ),
        );
      });

  //     Widget bottomNavTab(context) {
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
  //           Routes.NAVIGATION_DRAWER: (context) => SubmitStoryView(),
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
  //           Routes.NAVIGATION_DRAWER: (context) => SubmitStoryView(),
  //           Routes.PROFILE: (context) => ProfileView(),
  //         },
  //       ),
  //     )
  //   ];
  // }
}

class CustomSearchDelegate extends SearchDelegate<dynamic> {
  // @override
  final controller = Get.put<SubmitStoryController>(SubmitStoryController(),
      tag: 'submitstorycontroller');
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      // ? this is to clear the query
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          Icons.clear,
          color: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainTextHEADINGColor
              : ColorResourcesDark.mainDARKTEXTICONcolor,
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // ? to leave and close the search bar
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.chevron_left,
        color: ThemeService().theme == ThemeMode.light
            ? ColorResourcesLight.mainTextHEADINGColor
            : ColorResourcesDark.mainDARKTEXTICONcolor,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // ? for the result
    List<StoriesModel> matchQuery = <StoriesModel>[];
    for (final title in controller.story) {
      if (title.title.toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(title);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          var dateTime = DateTime.parse(result.dateadded.toString());
          var formate1 = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
          return CustomStoryBarWidgetView(
            profileOnTapped: () => Get.toNamed(Routes.OTHER_PROFILE,
                arguments: {
                  'authorId': result.personid,
                  'authorName': result.personname
                }),
            trailingOnTap: () => CustomSnackbar(
                    title: 'Warning',
                    message: 'Read the story before adding it to favorites')
                .showWarning(),
            likes: result.likes,
            authorProfilePic: result.personprofilepic,
            storyTitle: result.title,
            storyCategory: result.category,
            authorName: result.personname,
            storyDate: formate1,
            authorId: result.personid,
            storyId: result.id,
            listTileOnTap: () =>
                Get.toNamed(Routes.FULL_SCREEN_STORY, arguments: [
              {'authorname': result.personname},
              {'authorprofilepic': result.personprofilepic},
              {'authorid': result.personid},
              {'storytitle': result.title},
              {'storycategory': result.category},
              {'storybody': result.body},
              {'storylikes': result.likes},
              {'storyid': result.id},
              {'storydate': formate1.toString()}
            ]),
            storyBody: result.body,
            readmoreOnTap: () =>
                Get.toNamed(Routes.FULL_SCREEN_STORY, arguments: [
              {'authorname': result.personname},
              {'authorprofilepic': result.personprofilepic},
              {'authorid': result.personid},
              {'storytitle': result.title},
              {'storycategory': result.category},
              {'storybody': result.body},
              {'storylikes': result.likes},
              {'storyid': result.id},
              {'storydate': formate1.toString()}
            ]),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<StoriesModel> matchQuery = <StoriesModel>[];
    for (final title in controller.story) {
      if (title.title.toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(title);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          var dateTime = DateTime.parse(result.dateadded.toString());
          var formate1 = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
          return CustomStoryBarWidgetView(
            profileOnTapped: () => Get.toNamed(Routes.OTHER_PROFILE,
                arguments: {
                  'authorId': result.personid,
                  'authorName': result.personname
                }),
            trailingOnTap: () => CustomSnackbar(
                    title: 'Warning',
                    message: 'Read the story before adding it to favorites')
                .showWarning(),
            likes: result.likes,
            authorProfilePic: result.personprofilepic,
            storyTitle: result.title,
            storyCategory: result.category,
            authorName: result.personname,
            storyDate: formate1,
            authorId: result.personid,
            storyId: result.id,
            listTileOnTap: () =>
                Get.toNamed(Routes.FULL_SCREEN_STORY, arguments: [
              {'authorname': result.personname},
              {'authorprofilepic': result.personprofilepic},
              {'authorid': result.personid},
              {'storytitle': result.title},
              {'storycategory': result.category},
              {'storybody': result.body},
              {'storylikes': result.likes},
              {'storyid': result.id},
              {'storydate': formate1.toString()}
            ]),
            storyBody: result.body,
            readmoreOnTap: () =>
                Get.toNamed(Routes.FULL_SCREEN_STORY, arguments: [
              {'authorname': result.personname},
              {'authorprofilepic': result.personprofilepic},
              {'authorid': result.personid},
              {'storytitle': result.title},
              {'storycategory': result.category},
              {'storybody': result.body},
              {'storylikes': result.likes},
              {'storyid': result.id},
              {'storydate': formate1.toString()}
            ]),
          );
        });
  }
}
