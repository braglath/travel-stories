import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';
import 'package:travel_diaries/app/views/views/custom_story_bar_widget_view.dart';

import '../controllers/top_stories_controller.dart';

class TopStoriesView extends GetView<TopStoriesController> {
  final CarouselController _controller = CarouselController();
  @override
  final controller = Get.find(tag: 'topstoriescontroller');
  @override
  Widget build(BuildContext context) => Obx(
        () => Container(
          color: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainLIGHTAPPBARcolor
              : ColorResourcesDark.mainDARKAPPBARcolor,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Text(
                      'Top stories',
                      style: context.theme.textTheme.headlineMedium,
                    ),
                  ),
                  CarouselSlider.builder(
                    itemCount: controller.topStories.length,
                    options: CarouselOptions(
                        height: 170,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.9,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 4),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: false,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (itemIndex, reason) {
                          controller.count.value = itemIndex;
                        }),
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      var topStories = controller.topStories[itemIndex];
                      var dateTime =
                          DateTime.parse(topStories.dateadded.toString());
                      var formate1 =
                          '${dateTime.day}-${dateTime.month}-${dateTime.year}';
                      if (controller.topStories.isNotEmpty) {
                        return CustomStoryBarWidgetView(
                          profileOnTapped: () =>
                              Get.toNamed(Routes.OTHER_PROFILE, arguments: {
                            'authorId': topStories.personid,
                            'authorName': topStories.personname
                          }),
                          trailingOnTap: () => CustomSnackbar(
                                  title: 'Warning',
                                  message:
                                      'Read the story before adding it to favorites')
                              .showWarning(),
                          likes: topStories.likes,
                          authorProfilePic: topStories.personprofilepic,
                          storyTitle: topStories.title,
                          storyCategory: topStories.category,
                          authorName: topStories.personname,
                          storyDate: formate1,
                          authorId: topStories.personid,
                          storyId: topStories.id,
                          listTileOnTap: () =>
                              Get.toNamed(Routes.FULL_SCREEN_STORY, arguments: [
                            {'authorname': topStories.personname},
                            {'authorprofilepic': topStories.personprofilepic},
                            {'authorid': topStories.personid},
                            {'storytitle': topStories.title},
                            {'storycategory': topStories.category},
                            {'storybody': topStories.body},
                            {'storylikes': topStories.likes},
                            {'storyid': topStories.id},
                            {'storydate': formate1.toString()}
                          ]),
                          storyBody: topStories.body,
                          readmoreOnTap: () =>
                              Get.toNamed(Routes.FULL_SCREEN_STORY, arguments: [
                            {'authorname': topStories.personname},
                            {'authorprofilepic': topStories.personprofilepic},
                            {'authorid': topStories.personid},
                            {'storytitle': topStories.title},
                            {'storycategory': topStories.category},
                            {'storybody': topStories.body},
                            {'storylikes': topStories.likes},
                            {'storyid': topStories.id},
                            {'storydate': formate1.toString()}
                          ]),
                        );
                      } else {
                        return Positioned.fill(
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor:
                                  ColorResourcesLight.mainLIGHTAPPBARcolor,
                              color: ColorResourcesLight.mainLIGHTColor,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        controller.topStories.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? ColorResourcesDark.mainDARKColor
                                      : ColorResourcesLight.mainLIGHTColor)
                                  .withOpacity(
                                      controller.count.value == entry.key
                                          ? 0.9
                                          : 0.4)),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
              controller.isLoading.value
                  ? Positioned.fill(
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor:
                              ColorResourcesLight.mainLIGHTAPPBARcolor,
                          color: ColorResourcesLight.mainLIGHTColor,
                        ),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      );
}
