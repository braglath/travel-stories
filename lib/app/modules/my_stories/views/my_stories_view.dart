import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_bottom_sheet_view.dart';
import 'package:travel_diaries/app/views/views/custom_dialogue_view.dart';
import 'package:travel_diaries/app/views/views/custom_story_bar_widget_view.dart';

import '../controllers/my_stories_controller.dart';

class MyStoriesView extends GetView<MyStoriesController> {
  @override
  final controller = Get.find(tag: 'mystoriescontroller');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(title: 'My stories'),
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
                    Obx(() {
                      print('story length ${controller.story.length}');
                      return controller.story.isEmpty
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
                                onRefresh: () => controller.refreshMyStories(),
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: controller.story.length,
                                  itemBuilder: (context, index) {
                                    return listviewMainWidget(index);
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

  Widget listviewMainWidget(i) => Obx(() {
        final _controller = controller.story[i];
        var dateTime = DateTime.parse(_controller.dateadded.toString());
        var formatedDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
        return Stack(
          children: [
            CustomStoryBarWidgetView(
              likes: _controller.likes,
              trailingOnTap: () => {},
              authorProfilePic: _controller.personprofilepic,
              storyTitle: _controller.title,
              storyCategory: _controller.category,
              authorName: _controller.personname,
              storyDate: formatedDate,
              authorId: _controller.id,
              storyId: _controller.id,
              listTileOnTap: () =>
                  Get.toNamed(Routes.MY_STORIES_FULL_SCREEN, arguments: [
                {"authorname": _controller.personname},
                {"authorprofilepic": _controller.personprofilepic},
                {"authorid": _controller.id},
                {"storytitle": _controller.title},
                {"storycategory": _controller.category},
                {"storybody": _controller.body},
                {"storylikes": _controller.likes},
                {"storyid": _controller.id},
                {"storydate": formatedDate}
              ]),
              storyBody: _controller.body,
              readmoreOnTap: () =>
                  Get.toNamed(Routes.MY_STORIES_FULL_SCREEN, arguments: [
                {"authorname": _controller.personname},
                {"authorprofilepic": _controller.personprofilepic},
                {"authorid": _controller.id},
                {"storytitle": _controller.title},
                {"storycategory": _controller.category},
                {"storybody": _controller.body},
                {"storylikes": _controller.likes},
                {"storyid": _controller.id},
                {"storydate": formatedDate}
              ]),
            ),
            FadedScaleAnimation(
              IconButton(
                  splashRadius: 15,
                  onPressed: () => CustomDialogue(
                        isDismissible: false,
                        title: 'Do you want to permanently delete this story?',
                        textConfirm: 'Yes',
                        textCancel: 'No',
                        onpressedConfirm: () => controller.removeStory(
                            id: _controller.id,
                            personid: _controller.personid,
                            personname: _controller.personname,
                            storiesIndex: _controller),
                        onpressedCancel: () => Get.back(),
                        contentWidget: SizedBox.shrink(),
                      ).showDialogue(),
                  icon: Icon(
                    Icons.cancel,
                    color: ThemeService().theme == ThemeMode.light
                        ? ColorResourcesLight.mainLIGHTColor
                        : ColorResourcesDark.mainDARKColor,
                  )),
            )
          ],
        );
      });
}
