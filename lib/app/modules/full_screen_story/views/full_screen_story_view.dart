import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/comments_card_view.dart';

import '../controllers/full_screen_story_controller.dart';

class FullScreenStoryView extends GetView<FullScreenStoryController> {
  final data = Get.arguments;

  @override
  final controller = Get.find(tag: 'fullscreenstorycontroller');

  @override
  Widget build(BuildContext context) {
    final String authorName = data[0]['authorname'];
    final String authorprofilepic = data[1]['authorprofilepic'];
    final String authorid = data[2]['authorid'];
    final String storytitle = data[3]['storytitle'];
    final String storycategory = data[4]['storycategory'];
    final String storybody = data[5]['storybody'];
    final String storylikes = data[6]['storylikes'];
    final String storyid = data[7]['storyid'];
    final String storydate = data[8]['storydate'];
    controller.storyID.value = storyid;
    controller.storyTitle.value = storytitle;
    controller.count.value = int.parse(storylikes);
    // ? checking user already like or not
    controller.checkLikedStories(
        title: storytitle,
        authorid: authorid,
        likedpersonid: UserDetails().readUserIDfromBox(),
        likedpersonname: UserDetails().readUserNamefromBox());

    return Scaffold(
      appBar: AppBarView(
        appBarSize: 56,
        bottom: null,
        title: 'Stories',
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: FadedScaleAnimation(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Screenshot(
                          controller: controller.screenshotController,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4)),
                                  color: ThemeService().theme == ThemeMode.light
                                      ? ColorResourcesLight.mainLIGHTAPPBARcolor
                                      : ColorResourcesDark.mainDARKAPPBARcolor,
                                ),
                                child: ListTile(
                                  // isThreeLine: true,
                                  trailing: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300
                                            .withOpacity(0.4),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6))),
                                    child: Obx(
                                      () {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.solidHeart,
                                              size: 15,
                                              color: controller.isLiked.isFalse
                                                  ? null
                                                  : ThemeService().theme ==
                                                          ThemeMode.light
                                                      ? ColorResourcesLight
                                                          .mainLIGHTColor
                                                      : ColorResourcesDark
                                                          .mainDARKColor,
                                            ),
                                            Text(
                                              controller.count.toString(),
                                              style: context
                                                  .theme.textTheme.bodySmall,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),

                                  leading: InkWell(
                                    onTap: () => Get.toNamed(
                                        Routes.OTHER_PROFILE,
                                        arguments: {
                                          'authorId': authorid,
                                          'authorName': authorName
                                        }),
                                    child: Stack(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              ThemeService().theme ==
                                                      ThemeMode.light
                                                  ? ColorResourcesLight
                                                      .mainLIGHTColor
                                                  : ColorResourcesDark
                                                      .mainDARKColor,
                                          radius: 25,
                                          child: CircleAvatar(
                                              radius: 22,
                                              child: authorprofilepic.isEmpty
                                                  ? Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                    )
                                                  : null,
                                              backgroundColor:
                                                  ThemeService().theme ==
                                                          ThemeMode.light
                                                      ? ColorResourcesLight
                                                          .mainLIGHTColor
                                                      : ColorResourcesDark
                                                          .mainDARKColor,
                                              backgroundImage: NetworkImage(
                                                  'http://ubermensch.studio/travel_stories/profileimages/$authorprofilepic')),
                                        )
                                      ],
                                    ),
                                  ),
                                  title: Text(
                                    storytitle,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ThemeService().theme ==
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
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        storycategory,
                                        style: context.theme.textTheme.bodySmall
                                            ?.copyWith(fontSize: 12),
                                      ),
                                      Container(
                                        height: 12,
                                        child: VerticalDivider(
                                          thickness: 1,
                                        ),
                                      ),
                                      Text(
                                        authorName.length > 12
                                            ? authorName.replaceFirst(' ', '\n')
                                            : authorName,
                                        textAlign: TextAlign.center,
                                        style: context.theme.textTheme.bodySmall
                                            ?.copyWith(fontSize: 12),
                                      ),
                                      Container(
                                        height: 12,
                                        child: VerticalDivider(
                                          thickness: 1,
                                        ),
                                      ),
                                      Text(
                                        storydate.toString().trim(),
                                        style: context.theme.textTheme.bodySmall
                                            ?.copyWith(fontSize: 12),
                                      ),
                                    ],
                                  )),
                                  onTap: () => {},
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: ThemeService().theme == ThemeMode.light
                                      ? ColorResourcesLight.mainLIGHTAPPBARcolor
                                      : ColorResourcesDark.mainDARKAPPBARcolor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0,
                                      left: 12,
                                      right: 12,
                                      bottom: 12),
                                  child: Text(
                                    storybody,
                                    style: TextStyle(
                                      color: ThemeService().theme ==
                                              ThemeMode.light
                                          ? ColorResourcesLight
                                              .mainTextHEADINGColor
                                          : ColorResourcesDark
                                              .mainDARKTEXTICONcolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(4),
                                      bottomRight: Radius.circular(4)),
                                  color: ThemeService().theme == ThemeMode.light
                                      ? ColorResourcesLight.mainLIGHTAPPBARcolor
                                      : ColorResourcesDark.mainDARKAPPBARcolor,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Obx(() {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              onPressed: () =>
                                                  controller.animateContainer(),
                                              padding: EdgeInsets.zero,
                                              color: ThemeService().theme ==
                                                      ThemeMode.light
                                                  ? ColorResourcesLight
                                                      .mainLIGHTColor
                                                  : ColorResourcesDark
                                                      .mainDARKColor,
                                              splashRadius: 12,
                                              iconSize: 20,
                                              icon: FaIcon(controller
                                                      .isLarge.isFalse
                                                  ? FontAwesomeIcons.commentAlt
                                                  : FontAwesomeIcons
                                                      .solidCommentAlt)),
                                        ],
                                      );
                                    }),
                                    Obx(() {
                                      return IconButton(
                                          padding: EdgeInsets.zero,
                                          color: ThemeService().theme ==
                                                  ThemeMode.light
                                              ? ColorResourcesLight
                                                  .mainLIGHTColor
                                              : ColorResourcesDark
                                                  .mainDARKColor,
                                          splashRadius: 12,
                                          iconSize: 20,
                                          onPressed: () =>
                                              controller.liked(storylikes,
                                                  authorid: authorid,
                                                  authorname: authorName,
                                                  authorprofilepic:
                                                      authorprofilepic,
                                                  likedpersonname: UserDetails()
                                                      .readUserNamefromBox(),
                                                  likedpersonid: UserDetails()
                                                      .readUserIDfromBox(),
                                                  title: storytitle,
                                                  category: storycategory,
                                                  body: storybody,
                                                  date: storydate),
                                          icon: FaIcon(controller.isLiked.isTrue
                                              ? FontAwesomeIcons.solidHeart
                                              : FontAwesomeIcons.heart));
                                    }),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        color: ThemeService().theme ==
                                                ThemeMode.light
                                            ? ColorResourcesLight.mainLIGHTColor
                                            : ColorResourcesDark.mainDARKColor,
                                        iconSize: 20,
                                        splashRadius: 12,
                                        onPressed: () {
                                          // await Share.share(
                                          //     'Checkout this story from $authorName\n\n$storytitle\n\n$storybody');
                                          controller.takeScreenshot();
                                        },
                                        icon:
                                            FaIcon(FontAwesomeIcons.shareAlt)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        controller.isLoading.isTrue
                            ? Center(
                                child: CircularProgressIndicator(
                                backgroundColor:
                                    ColorResourcesLight.mainLIGHTAPPBARcolor,
                                color: ColorResourcesLight.mainLIGHTColor,
                              ))
                            : SizedBox.shrink()
                      ],
                    );
                  }),
                  Container(
                    // height: 345,
                    // color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Comments',
                          style: context.theme.textTheme.bodySmall,
                        ),
                        Obx(
                          () => IconButton(
                            onPressed: () => controller.animateContainer(),
                            padding: EdgeInsets.zero,
                            color: ThemeService().theme == ThemeMode.light
                                ? ColorResourcesLight.mainLIGHTColor
                                : ColorResourcesDark.mainDARKColor,
                            iconSize: 15,
                            splashRadius: 12,
                            icon: FaIcon(controller.isLarge.isFalse
                                ? FontAwesomeIcons.chevronDown
                                : FontAwesomeIcons.chevronUp),
                          ),
                        )
                      ],
                    ),
                  ),
                  Obx(() {
                    return Column(
                      children: [
                        AnimatedContainer(
                          curve: Curves.fastOutSlowIn,
                          height: controller.height.value.toDouble(),
                          duration: Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: controller.isLarge.isTrue
                                ? Form(
                                    key: controller.commentkey,
                                    child: Obx(() {
                                      return TextFormField(
                                        focusNode: controller.focusNode.value,
                                        controller:
                                            controller.commentController,
                                        maxLines: 3,
                                        style: TextStyle(
                                            color: ColorResourcesLight
                                                .mainTextHEADINGColor),
                                        cursorColor: ColorResourcesLight
                                            .mainTextHEADINGColor,
                                        keyboardType: TextInputType.name,
                                        onSaved: (value) {
                                          controller.comment.value =
                                              value.toString();
                                        },
                                        validator: (value) =>
                                            controller.validateComment(value!),
                                        decoration: InputDecoration(
                                            labelText: 'Your comment',
                                            labelStyle: context
                                                .theme.textTheme.bodySmall),
                                      );
                                    }),
                                  )
                                : SizedBox.shrink(),
                          ),
                        ),
                        controller.height.value != 0
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: FadedScaleAnimation(
                                  ElevatedButton(
                                      onPressed: () =>
                                          controller.commentValidator(),
                                      child: Text('submit')),
                                ),
                              )
                            : SizedBox.shrink(),
                        // commentsBuilder(),
                      ],
                    );
                  }),
                  FadedScaleAnimation(Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: commentsBuilder(),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget commentsBuilder() {
    return Obx(() {
      return Container(
        height: controller.comments.length * 100,
        child: ListView.builder(
            itemCount: controller.comments.length,
            itemBuilder: (context, index) {
              final data = controller.comments[index];
              return CommentesCardView().showCustomComments(
                  context,
                  data.commentername,
                  data.comment,
                  data.commenterprofilepic,
                  data.isliked,
                  data.datecommented);
            }),
      );
    });
  }
}
