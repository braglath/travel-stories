import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/views/views/custom_bottom_sheet_view.dart';
import 'package:travel_diaries/app/views/views/custom_dialogue_view.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  final textFieldFocusNode = FocusNode();
  @override
  final controller = Get.find(tag: 'editprofilecontroller');
  @override
  Widget build(BuildContext context) {
    controller.nameController.text = UserDetails().readUserNamefromBox();
    controller.emailController.text =
        UserDetails().readUserPhoneorEmailfromBox();
    controller.passwordController.text =
        UserDetails().readUserPasswordfromBox();
    controller.captionController.text = UserDetails().readUserCaptionfromBox();

    return Scaffold(
      appBar: AppBarView(
        appBarSize: 56,
        bottom: null,
        title: 'Edit profile',
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Stack(
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    profileImage(),
                    IconButton(
                        splashRadius: 12,
                        alignment: Alignment.bottomCenter,
                        onPressed: () => CustomBottomSheet(
                              icon1: FontAwesomeIcons.cameraRetro,
                              icon2: FontAwesomeIcons.photoVideo,
                              title1: 'Camera',
                              titile2: 'Gallery',
                              onTap1: () =>
                                  controller.pickImage(ImageSource.camera),
                              onTap2: () =>
                                  controller.pickImage(ImageSource.gallery),
                            ).show(),
                        icon: FaIcon(
                          FontAwesomeIcons.camera,
                          color: ColorResourcesLight.mainLIGHTAPPBARcolor,
                        )),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: name(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: phoneNumber(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: password(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: caption(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Pick one favorite mode of transport',
                        style: context.theme.textTheme.headlineMedium,
                      ),
                      SizedBox(height: 50, child: customchips()),
                      SizedBox(
                        height: 20,
                      ),
                      Hero(
                        tag: 'loginbutton',
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () => CustomDialogue(
                                    title: 'Check profile changes',
                                    textConfirm: 'Confirm',
                                    textCancel: 'Cancel',
                                    onpressedConfirm: () =>
                                        controller.saveUserDetails(),
                                    onpressedCancel: () => Get.back(),
                                    contentWidget: contentWidget(context),
                                    isDismissible: false)
                                .showDialogue(),
                            child: Text(
                              'Confirm',
                              style: context.theme.textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Obx(() {
              return controller.isLoading.value
                  ? Positioned.fill(
                      child: Center(
                          child: CircularProgressIndicator(
                      backgroundColor: ColorResourcesLight.mainLIGHTAPPBARcolor,
                      color: ColorResourcesLight.mainLIGHTColor,
                    )))
                  : SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }

  Widget profileImage() => Obx(() {
        return InkWell(
          radius: 5,
          borderRadius: BorderRadius.circular(50),
          onTap: () => {},
          child: Hero(
            tag: 'profileicon',
            child: controller.profileImage.value.isEmpty
                ? CircleAvatar(
                    radius: 50,
                    backgroundColor: ThemeService().theme == ThemeMode.light
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
                              child: controller.profileImage.value.isNotEmpty
                                  ? null
                                  : Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                              backgroundColor:
                                  controller.profileImage.value.isNotEmpty
                                      ? ThemeService().theme == ThemeMode.light
                                          ? ColorResourcesLight.mainLIGHTColor
                                          : ColorResourcesDark.mainDARKColor
                                      : null,
                              backgroundImage: controller
                                      .profileImage.value.isNotEmpty
                                  ? NetworkImage(controller.profileImage.value
                                          .contains('https')
                                      ? controller.profileImage.value
                                      : 'http://ubermensch.studio/travel_stories/profileimages/${controller.profileImage.value}')
                                  : null),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      });

  Widget name() => TextFormField(
      style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
      cursorColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      keyboardType: TextInputType.name,
      controller: controller.nameController,
      validator: (val) {
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: ColorResourcesLight.mainLIGHTColor,
        ),
        labelText: 'Name',
      ));

  Widget phoneNumber() => TextFormField(
      style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
      cursorColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      keyboardType: TextInputType.emailAddress,
      controller: controller.emailController,
      validator: (val) {
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.phone,
          color: ColorResourcesLight.mainLIGHTColor,
        ),
        labelText: 'Phone number or Email',
      ));

  Widget password() => Obx(() {
        return TextFormField(
            style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
            cursorColor: ThemeService().theme == ThemeMode.light
                ? ColorResourcesLight.mainTextHEADINGColor
                : ColorResourcesDark.mainDARKTEXTICONcolor,
            keyboardType: TextInputType.visiblePassword,
            controller: controller.passwordController,
            obscureText: controller.obscured.value,
            validator: (val) {
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: ColorResourcesLight.mainLIGHTColor,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: GestureDetector(
                  onTap: () {
                    controller.toggleObscured();
                    if (textFieldFocusNode.hasPrimaryFocus) return;
                    textFieldFocusNode.canRequestFocus = false;
                  },
                  child: Icon(
                    controller.obscured.isFalse
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: controller.obscured.isFalse
                        ? ColorResourcesLight.mainLIGHTColor
                        : ColorResourcesLight.mainTextHEADINGColor,
                    size: 24,
                  ),
                ),
              ),
              labelText: 'Password',
            ));
      });

  Widget caption() => TextFormField(
      style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
      cursorColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      keyboardType: TextInputType.visiblePassword,
      controller: controller.captionController,
      maxLength: 90,
      validator: (val) {
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.format_quote,
          color: ColorResourcesLight.mainLIGHTColor,
        ),
        labelText: 'caption',
      ));

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

  Widget contentWidget(context) => Column(
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: ThemeService().theme == ThemeMode.light
                      ? ColorResourcesLight.mainLIGHTColor
                      : ColorResourcesDark.mainDARKColor,
                  radius: 55,
                  child: CircleAvatar(
                      radius: 52.0,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      backgroundColor: ThemeService().theme == ThemeMode.light
                          ? ColorResourcesLight.mainLIGHTColor
                          : ColorResourcesDark.mainDARKColor,
                      backgroundImage: controller.profileImage.value.isNotEmpty
                          ? NetworkImage(controller.profileImage.value
                                  .contains('https')
                              ? controller.profileImage.value
                              : 'http://ubermensch.studio/travel_stories/profileimages/${controller.profileImage.value}')
                          : null),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: controller.nameController.text.length > 18
                        ? "${controller.nameController.text.replaceAll(" ", "\n")} \n"
                        : '${controller.nameController.text} \n',
                    style: Theme.of(context).textTheme.displaySmall),
                TextSpan(
                    text: '${controller.emailController.text}\n',
                    style: Theme.of(context).textTheme.headlineMedium),
                TextSpan(
                    text: '${controller.passwordController.text}\n',
                    style: Theme.of(context).textTheme.headlineMedium),
                TextSpan(
                    text: '${controller.captionController.text}\n',
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                    text:
                        '${controller.travelmodes[controller.defaultChoiceIndex.value]}\n',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      );
}
