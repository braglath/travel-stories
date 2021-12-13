import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/modules/submit_story/views/navbar.dart';
import 'package:travel_diaries/app/modules/top_stories/views/top_stories_view.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';
import 'package:travel_diaries/app/views/views/custom_story_bar_widget_view.dart';

import '../controllers/submit_story_controller.dart';

class SubmitStoryView extends GetView<SubmitStoryController> {
  final TextEditingController textController = TextEditingController();
  DateTime timeBackButtonPressed = DateTime.now();
  @override
  final controller = Get.find(tag: 'submitstorycontroller');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.pressBackAgainToExit(),
      child: Scaffold(
          drawer: NavBar(),
          appBar: AppBarView(
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
                      Column(
                        children: [],
                      ),
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
                                    TopStoriesView(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, bottom: 4),
                                      child: Text(
                                        'Recent stories',
                                        style:
                                            context.theme.textTheme.headline4,
                                      ),
                                    ),
                                    Obx(() {
                                      // controller.update();
                                      return RefreshIndicator(
                                        color: ThemeService().theme ==
                                                ThemeMode.light
                                            ? ColorResourcesLight.mainLIGHTColor
                                            : ColorResourcesDark.mainDARKColor,
                                        strokeWidth: 3,
                                        onRefresh: () =>
                                            controller.refreshStories(
                                                controller.travelmodes[
                                                    controller
                                                        .defaultChoiceIndex
                                                        .value]),
                                        child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: controller.story.length,
                                          itemBuilder: (context, index) {
                                            var dateTime = DateTime.parse(
                                                controller
                                                    .story[index].dateadded
                                                    .toString());
                                            var formate1 =
                                                "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                                            var story = controller.story[index];
                                            print(controller
                                                .story[index].personprofilepic);

                                            return CustomStoryBarWidgetView(
                                              profileOnTapped: () =>
                                                  Get.toNamed(
                                                      Routes.OTHER_PROFILE,
                                                      arguments: {
                                                    'authorId': controller
                                                        .story[index].personid,
                                                    'authorName': controller
                                                        .story[index].personname
                                                  }),
                                              trailingOnTap: () => CustomSnackbar(
                                                      title: 'Warning',
                                                      message:
                                                          'Read the story before adding it to favorites')
                                                  .showWarning(),
                                              likes: story.likes,
                                              authorProfilePic:
                                                  story.personprofilepic,
                                              storyTitle: story.title,
                                              storyCategory: story.category,
                                              authorName: story.personname,
                                              storyDate: formate1,
                                              authorId: story.personid,
                                              storyId: story.id,
                                              listTileOnTap: () => Get.toNamed(
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
                                                          .story[index].personid
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
                                                      "storydate":
                                                          formate1.toString()
                                                    }
                                                  ]),
                                              storyBody: story.body,
                                              readmoreOnTap: () => Get.toNamed(
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
                                                          .story[index].personid
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
                                                      "storydate":
                                                          formate1.toString()
                                                    }
                                                  ]),
                                            );
                                          },
                                        ),
                                      );
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
