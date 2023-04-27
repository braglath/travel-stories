import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_dialogue_view.dart';
import 'package:travel_diaries/app/views/views/custom_story_bar_widget_view.dart';

import '../controllers/fave_stories_controller.dart';

class FaveStoriesView extends GetView<FaveStoriesController> {
  @override
  final controller = Get.find(tag: 'favstoriescontroller');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(
          appBarSize: 56,
          bottom: null,
          title: 'Fav stories',
        ),
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
                                onRefresh: () => controller.refreshFavStories(),
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
        // var dateTime = DateTime.parse(_controller.date);
        // var formatedDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
        return Stack(
          children: [
            CustomStoryBarWidgetView(
              profileOnTapped: () => Get.toNamed(Routes.OTHER_PROFILE,
                  arguments: {
                    'authorId': _controller.authorid,
                    'authorName': _controller.authorname
                  }),
              likes: _controller.likes,
              trailingOnTap: () => CustomDialogue(
                isDismissible: false,
                title: 'Remove this story form favorites list?',
                textConfirm: 'Yes',
                textCancel: 'No',
                onpressedConfirm: () => controller.liked(_controller.likes,
                    authorid: _controller.authorid,
                    authorname: _controller.authorname,
                    authorprofilepic: _controller.authorprofilepic,
                    likedpersonname: UserDetails().readUserNamefromBox(),
                    likedpersonid: UserDetails().readUserIDfromBox(),
                    title: _controller.title,
                    category: _controller.category,
                    body: _controller.body,
                    date: _controller.date,
                    storiesIndex: _controller),
                onpressedCancel: () => Get.back(),
                contentWidget: SizedBox.shrink(),
              ).showDialogue(),
              authorProfilePic: _controller.authorprofilepic,
              storyTitle: _controller.title,
              storyCategory: _controller.category,
              authorName: _controller.authorname,
              storyDate: _controller.date.toString(),
              authorId: _controller.authorid,
              storyId: _controller.id,
              listTileOnTap: () =>
                  Get.toNamed(Routes.FAV_FULL_SCREEN, arguments: [
                {'authorname': _controller.authorname},
                {'authorprofilepic': _controller.authorprofilepic},
                {'authorid': _controller.authorid},
                {'storytitle': _controller.title},
                {'storycategory': _controller.category},
                {'storybody': _controller.body},
                {'storylikes': _controller.likes},
                {'storyid': _controller.id},
                {'storydate': _controller.date.toString()}
              ]),
              storyBody: _controller.body,
              readmoreOnTap: () =>
                  Get.toNamed(Routes.FAV_FULL_SCREEN, arguments: [
                {'authorname': _controller.authorname},
                {'authorprofilepic': _controller.authorprofilepic},
                {'authorid': _controller.authorid},
                {'storytitle': _controller.title},
                {'storycategory': _controller.category},
                {'storybody': _controller.body},
                {'storylikes': _controller.likes},
                {'storyid': _controller.id},
                {'storydate': _controller.date.toString()}
              ]),
            ),
            FadedScaleAnimation(
              IconButton(
                  splashRadius: 15,
                  onPressed: () => CustomDialogue(
                        isDismissible: false,
                        title: 'Remove this story form favorites list?',
                        textConfirm: 'Yes',
                        textCancel: 'No',
                        onpressedConfirm: () => controller.liked(
                            _controller.likes,
                            authorid: _controller.authorid,
                            authorname: _controller.authorname,
                            authorprofilepic: _controller.authorprofilepic,
                            likedpersonname:
                                UserDetails().readUserNamefromBox(),
                            likedpersonid: UserDetails().readUserIDfromBox(),
                            title: _controller.title,
                            category: _controller.category,
                            body: _controller.body,
                            date: _controller.date,
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
