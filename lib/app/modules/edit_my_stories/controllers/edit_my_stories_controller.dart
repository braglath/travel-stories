import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/edit_my_stories/views/edit_my_stories_view.dart';
import 'package:travel_diaries/app/modules/post_story/views/post_story_view.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class EditMyStoriesController extends GetxController {
  final currentStep = 0.obs;
  final count = 0.obs;
  RxString dropdownVal = 'Pick a category'.obs;
  RxBool isloading = false.obs;
  // ? to get the current date
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  // ?

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text(
            'Title',
          ),
          content: stepperOne(),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('Story'),
          content: stepperTwo(),
        ),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 2,
            title: Text('Confirm'),
            content: stepperThree()),
      ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;
  void onStepCanceled() {
    print('stepper canceled');
    if (currentStep.value != 0) {
      currentStep.value -= 1;
    }
  }

  void onStepContinued({required oldtitle, required id}) {
    final isLastStep = currentStep.value == getSteps().length - 1;
    if (isLastStep) {
      print('is last step $isLastStep');
      isloading.value = true;
      editMyStory(oldtitle: oldtitle, id: id);
    } else {
      currentStep.value += 1;
    }
  }

  void setDropdownValue(String? newvalue) {
    dropdownVal.value = RxString(newvalue.toString()).toString();
  }

  // void onStepTapped(int step) => currentStep.value = step.round();

  Widget stepperOne() => SingleChildScrollView(
        reverse: true,
        child: Container(
          child: Column(
            children: [
              Text(
                'Give a unique title to your story',
                style: TextStyle(
                  color: ThemeService().theme == ThemeMode.light
                      ? ColorResourcesLight.mainTextHEADINGColor
                      : ColorResourcesDark.mainDARKTEXTICONcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              firstSteptitleFormField('Title'),
              EditMyStoriesView().dropDown(),
            ],
          ),
        ),
      );

  Widget firstSteptitleFormField(title) => IntrinsicHeight(
        child: TextFormField(
            style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
            cursorColor: ThemeService().theme == ThemeMode.light
                ? ColorResourcesLight.mainTextHEADINGColor
                : ColorResourcesDark.mainDARKTEXTICONcolor,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: null,
            maxLength: null,
            expands: true,
            controller: titleController,
            // autovalidate: true,
            validator: (val) {},
            decoration: InputDecoration(
              labelText: title,
            )),
      );

  Widget stepperTwo() => SingleChildScrollView(
        reverse: true,
        child: Container(
          child: Column(
            children: [
              Text(
                'Main content of your story',
                style: TextStyle(
                  color: ThemeService().theme == ThemeMode.light
                      ? ColorResourcesLight.mainTextHEADINGColor
                      : ColorResourcesDark.mainDARKTEXTICONcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              secondSteptitleFormField('Body'),
            ],
          ),
        ),
      );

  Widget secondSteptitleFormField(title) => IntrinsicHeight(
        child: TextFormField(
            style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
            cursorColor: ThemeService().theme == ThemeMode.light
                ? ColorResourcesLight.mainTextHEADINGColor
                : ColorResourcesDark.mainDARKTEXTICONcolor,
            maxLines: 10,
            controller: bodyController,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            // autovalidate: true,
            validator: (val) {},
            decoration: InputDecoration(
              labelText: title,
            )),
      );

  Widget stepperThree() => SingleChildScrollView(
        reverse: true,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Check your story',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: ThemeService().theme == ThemeMode.light
                      ? ColorResourcesLight.mainTextHEADINGColor
                      : ColorResourcesDark.mainDARKTEXTICONcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTAPPBARcolor
                    : ColorResourcesDark.mainDARKAPPBARcolor,
                child: Column(
                  children: [
                    ListTile(
                      // isThreeLine: true,
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            child: UserDetails()
                                    .readUserProfilePicfromBox()
                                    .isNotEmpty
                                ? null
                                : Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                            backgroundColor: UserDetails()
                                    .readUserProfilePicfromBox()
                                    .isNotEmpty
                                ? null
                                : ThemeService().theme == ThemeMode.light
                                    ? ColorResourcesLight.mainLIGHTColor
                                    : ColorResourcesDark.mainDARKColor,
                            backgroundImage: UserDetails()
                                    .readUserProfilePicfromBox()
                                    .isNotEmpty
                                ? NetworkImage(
                                    "http://ubermensch.studio/travel_stories/profileimages/${UserDetails().readUserProfilePicfromBox()}")
                                : null,
                          )
                        ],
                      ),
                      title: Text(
                        titleController.text.isEmpty
                            ? 'Your title appears here'
                            : titleController.text,
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
                        child: Text(
                          dropdownVal.toString(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        bodyController.text.isEmpty
                            ? 'Your story appears here'
                            : bodyController.text,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ThemeService().theme == ThemeMode.light
                              ? ColorResourcesLight.mainTextHEADINGColor
                              : ColorResourcesDark.mainDARKTEXTICONcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  void editMyStory({required oldtitle, required id}) async {
    print('body - ${bodyController.text}');
    var url = 'http://ubermensch.studio/travel_stories/editmystory.php';
    var uri = Uri.parse(url);
    var data = {
      'personid': UserDetails().readUserIDfromBox(),
      'personname': UserDetails().readUserNamefromBox(),
      'title': titleController.text,
      'category': dropdownVal.value,
      'body': bodyController.text,
      'id': id
    };

    print('data - $data');

    http.Response res = await http.post(Uri.parse(url), body: data);
    if (res.statusCode == 200) {
      print('story added');
      isloading.value = false;
      CustomSnackbar(title: 'Success', message: 'Story added successfully')
          .showSuccess();
      currentStep.value = 0;
      titleController.clear();
      dropdownVal.value = 'Pick a category';
      bodyController.clear();
      Get.offAllNamed(Routes.NAVIGATION_DRAWER);
    } else {
      print('story error');
      isloading.value = false;
      CustomSnackbar(
              title: 'Error',
              message: 'An error occured while adding the story! Try again')
          .showWarning();
    }
  }
}
