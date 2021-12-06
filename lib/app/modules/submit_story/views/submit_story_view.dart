import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import 'package:travel_diaries/app/data/storage/user_check_login_logout.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';
import 'package:travel_diaries/app/modules/animations/top_to_bottom_animation.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/modules/submit_story/views/navbar.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';

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
      body: SingleChildScrollView(
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
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: controller.story.length,
                itemBuilder: (context, index) {
                  var story = controller.story[index];
                  return mainbody(index);
                },
              );
            })
          ],
        ),
      ),
    );
  }

  Widget mainbody(int index) {
    var dateTime = DateTime.parse(controller.story[index].dateadded.toString());
    var formate1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    var story = controller.story[index];
    print(story.personprofilepic);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainLIGHTAPPBARcolor
              : ColorResourcesDark.mainDARKAPPBARcolor,
          boxShadow: [
            BoxShadow(
              color: ColorResourcesLight.mainTextHEADINGColor.withOpacity(0.2),
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
              leading: Stack(
                children: [
                  CircleAvatar(
                    child: story.personprofilepic.isNotEmpty
                        ? null
                        : Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                    backgroundColor: story.personprofilepic.isNotEmpty
                        ? null
                        : ThemeService().theme == ThemeMode.light
                            ? ColorResourcesLight.mainLIGHTColor
                            : ColorResourcesDark.mainDARKColor,
                    backgroundImage: story.personprofilepic.isNotEmpty
                        ? NetworkImage(
                            "http://ubermensch.studio/travel_stories/profileimages/${story.personprofilepic}")
                        : null,
                  )
                ],
              ),
              title: Text(
                story.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: ThemeService().theme == ThemeMode.light
                      ? ColorResourcesLight.mainTextHEADINGColor
                      : ColorResourcesDark.mainDARKTEXTICONcolor,
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
                  VerticalDivider(),
                  Text(
                    formate1,
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ReadMoreText(
                controller.story[index].body,
                trimLines: 2,
                colorClickableText: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor
                    : ColorResourcesDark.mainDARKColor,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Interested',
                trimExpandedText: 'Show less',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: ThemeService().theme == ThemeMode.light
                      ? ColorResourcesLight.mainTextHEADINGColor
                      : ColorResourcesDark.mainDARKTEXTICONcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
