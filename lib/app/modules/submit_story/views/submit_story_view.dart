import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/modules/submit_story/views/navbar.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

import '../controllers/submit_story_controller.dart';

class SubmitStoryView extends GetView<SubmitStoryController> {
  @override
  final controller = Get.find(tag: 'submitstorycontroller');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBarView(
          title: 'Submit Page',
        ),
        floatingActionButton: FadedScaleAnimation(
          _floatingActionButton(context),
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
                    Obx(() {
                      print('story length ${controller.story.length}');
                      return controller.isEmpty.isTrue
                          ? Text(
                              'i am empty',
                              style: TextStyle(
                                color: ThemeService().theme == ThemeMode.light
                                    ? ColorResourcesLight.mainTextHEADINGColor
                                    : ColorResourcesDark.mainDARKTEXTICONcolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          : Expanded(child: Obx(() {
                              // controller.update();
                              return RefreshIndicator(
                                color: ThemeService().theme == ThemeMode.light
                                    ? ColorResourcesLight.mainLIGHTColor
                                    : ColorResourcesDark.mainDARKColor,
                                strokeWidth: 3,
                                onRefresh: () => controller.refreshStories(
                                    controller.travelmodes[
                                        controller.defaultChoiceIndex.value]),
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: controller.story.length,
                                  itemBuilder: (context, index) {
                                    var dateTime = DateTime.parse(controller
                                        .story[index].dateadded
                                        .toString());
                                    var formate1 =
                                        "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                                    var story = controller.story[index];

                                    return FadedScaleAnimation(
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: ThemeService().theme ==
                                                    ThemeMode.light
                                                ? ColorResourcesLight
                                                    .mainLIGHTAPPBARcolor
                                                : ColorResourcesDark
                                                    .mainDARKAPPBARcolor,
                                            boxShadow: [
                                              BoxShadow(
                                                color: ColorResourcesLight
                                                    .mainTextHEADINGColor
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
                                            children: [
                                              ListTile(
                                                // isThreeLine: true,
                                                trailing: Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: Colors
                                                          .grey.shade300
                                                          .withOpacity(0.4),
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  6))),
                                                  child: InkWell(
                                                    splashColor: Colors.red,
                                                    onTap: () => CustomSnackbar(
                                                            title: 'Warning',
                                                            message:
                                                                'Read the story before adding it to favorites')
                                                        .showWarning(),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        FaIcon(
                                                          FontAwesomeIcons
                                                              .solidHeart,
                                                          size: 15,
                                                        ),
                                                        Text(
                                                          story.likes.isEmpty
                                                              ? '0'
                                                              : story.likes,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                leading: Stack(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: ThemeService()
                                                                  .theme ==
                                                              ThemeMode.light
                                                          ? ColorResourcesLight
                                                              .mainLIGHTColor
                                                          : ColorResourcesDark
                                                              .mainDARKColor,
                                                      radius: 25,
                                                      child: CircleAvatar(
                                                        radius: 22,
                                                        child: story
                                                                .personprofilepic
                                                                .isNotEmpty
                                                            ? null
                                                            : Icon(
                                                                Icons.person,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        backgroundColor: story
                                                                .personprofilepic
                                                                .isNotEmpty
                                                            ? null
                                                            : ThemeService()
                                                                        .theme ==
                                                                    ThemeMode
                                                                        .light
                                                                ? ColorResourcesLight
                                                                    .mainLIGHTColor
                                                                : ColorResourcesDark
                                                                    .mainDARKColor,
                                                        backgroundImage: story
                                                                .personprofilepic
                                                                .isNotEmpty
                                                            ? NetworkImage(
                                                                "http://ubermensch.studio/travel_stories/profileimages/${story.personprofilepic}")
                                                            : null,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                title: Text(
                                                  story.title,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: ThemeService()
                                                                .theme ==
                                                            ThemeMode.light
                                                        ? ColorResourcesLight
                                                            .mainTextHEADINGColor
                                                        : ColorResourcesDark
                                                            .mainDARKTEXTICONcolor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                subtitle: IntrinsicHeight(
                                                    child: Row(
                                                  children: [
                                                    Text(
                                                      story.category,
                                                    ),
                                                    VerticalDivider(
                                                      thickness: 1,
                                                    ),
                                                    Expanded(
                                                      flex: controller
                                                                  .story[index]
                                                                  .personname
                                                                  .length >
                                                              8
                                                          ? 1
                                                          : 0,
                                                      child: Text(controller
                                                          .story[index]
                                                          .personname),
                                                    ),
                                                    VerticalDivider(
                                                      thickness: 1,
                                                    ),
                                                    Text(
                                                      formate1,
                                                    ),
                                                  ],
                                                )),
                                                onTap: () => Get.toNamed(
                                                    Routes.FULL_SCREEN_STORY,
                                                    arguments: [
                                                      {
                                                        "authorname": controller
                                                            .story[index]
                                                            .personname
                                                      },
                                                      {
                                                        "authorprofilepic":
                                                            controller
                                                                .story[index]
                                                                .personprofilepic
                                                      },
                                                      {
                                                        "authorid": controller
                                                            .story[index]
                                                            .personid
                                                      },
                                                      {
                                                        "storytitle": controller
                                                            .story[index].title
                                                      },
                                                      {
                                                        "storycategory":
                                                            controller
                                                                .story[index]
                                                                .category
                                                      },
                                                      {
                                                        "storybody": controller
                                                            .story[index].body
                                                      },
                                                      {
                                                        "storylikes": controller
                                                            .story[index].likes
                                                      },
                                                      {
                                                        "storyid": controller
                                                            .story[index].id
                                                      },
                                                      {
                                                        "storydate": controller
                                                            .story[index]
                                                            .dateadded
                                                            .toString()
                                                      }
                                                    ]),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        controller
                                                            .story[index].body,
                                                        maxLines: 3,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: TextStyle(
                                                          color: ThemeService()
                                                                      .theme ==
                                                                  ThemeMode
                                                                      .light
                                                              ? ColorResourcesLight
                                                                  .mainTextHEADINGColor
                                                              : ColorResourcesDark
                                                                  .mainDARKTEXTICONcolor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () => Get.toNamed(
                                                          Routes
                                                              .FULL_SCREEN_STORY,
                                                          arguments: [
                                                            {
                                                              "authorname":
                                                                  controller
                                                                      .story[
                                                                          index]
                                                                      .personname
                                                            },
                                                            {
                                                              "authorprofilepic":
                                                                  controller
                                                                      .story[
                                                                          index]
                                                                      .personprofilepic
                                                            },
                                                            {
                                                              "authorid":
                                                                  controller
                                                                      .story[
                                                                          index]
                                                                      .personid
                                                            },
                                                            {
                                                              "storytitle":
                                                                  controller
                                                                      .story[
                                                                          index]
                                                                      .title
                                                            },
                                                            {
                                                              "storycategory":
                                                                  controller
                                                                      .story[
                                                                          index]
                                                                      .category
                                                            },
                                                            {
                                                              "storybody":
                                                                  controller
                                                                      .story[
                                                                          index]
                                                                      .body
                                                            },
                                                            {
                                                              "storylikes":
                                                                  controller
                                                                      .story[
                                                                          index]
                                                                      .likes
                                                            },
                                                            {
                                                              "storyid":
                                                                  controller
                                                                      .story[
                                                                          index]
                                                                      .id
                                                            },
                                                            {
                                                              "storydate":
                                                                  controller
                                                                      .story[
                                                                          index]
                                                                      .dateadded
                                                                      .toString()
                                                            }
                                                          ]),
                                                      child: Text(
                                                        'Read more',
                                                        style: TextStyle(
                                                          color: ThemeService()
                                                                      .theme ==
                                                                  ThemeMode
                                                                      .light
                                                              ? ColorResourcesLight
                                                                  .mainLIGHTColor
                                                              : ColorResourcesDark
                                                                  .mainDARKColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }));
                    })
                  ],
                ),
              ),
              controller.isLoading.value
                  ? Positioned.fill(
                      child: Center(
                          child: CircularProgressIndicator(
                      backgroundColor: ColorResourcesLight.mainLIGHTAPPBARcolor,
                      color: ColorResourcesLight.mainLIGHTColor,
                    )))
                  : SizedBox.shrink()
            ],
          );
        }));
  }

  Widget _floatingActionButton(context) => FloatingActionButton.extended(
        onPressed: () => Get.toNamed(Routes.POST_STORY),
        // extendedPadding: EdgeInsets.zero,
        icon: FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
        label: Text(
          'Post Story',
          style: Theme.of(context)
              .textTheme
              .subtitle1
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
}
