import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:travel_diaries/app/data/storage/user_check_login_logout.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
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
      floatingActionButton: _floatingActionButton(context),
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
            Text(
              'Travel Stories',
              style: context.theme.textTheme.headline1?.copyWith(
                height: 1,
              ),
            ),
            Text('Headline 2', style: context.theme.textTheme.headline2),
            Text(
              'Headline 3',
              style: context.theme.textTheme.headline3,
            ),
            Text(
              'Headline 4',
              style: context.theme.textTheme.headline4,
            ),
            Divider(),
            Text(
              'Caption',
              style: context.theme.textTheme.caption,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.reloadAll(force: true);
                  UserDetails().deleteUserDetailsfromBox();
                  Get.offAllNamed(Routes.HOME);
                },
                child: Text('Logout'))
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
