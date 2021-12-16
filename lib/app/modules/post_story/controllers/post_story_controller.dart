import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:travel_diaries/app/data/Services/api_services.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/post_story/views/post_story_view.dart';
import 'package:travel_diaries/app/modules/submit_story/controllers/submit_story_controller.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class PostStoryController extends GetxController {
  //TODO: Implement PostStoryController
  final currentStep = 0.obs;
  final count = 0.obs;
  final profilePicture = UserDetails().readUserProfilePicfromBox();
  RxString dropdownVal = 'Pick a category'.obs;
  RxBool isloading = false.obs;

  // ? to get the current date
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  // ?

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

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

  void onStepContinued() {
    final isLastStep = currentStep.value == getSteps().length - 1;
    if (isLastStep) {
      print('is last step $isLastStep');
      isloading.value = true;
      addStory();
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
              PostStoryView().dropDown(),
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
            controller: _titleController,
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
            controller: _bodyController,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            // autovalidate: true,
            validator: (val) {},
            decoration: InputDecoration(
              labelText: title,
            )),
      );

  Widget stepperThree() {
    var dateTime = DateTime.now();
    var formatedDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    return SingleChildScrollView(
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
                          backgroundImage: profilePicture.isNotEmpty
                              ? NetworkImage(profilePicture.contains('https')
                                  ? profilePicture
                                  : "http://ubermensch.studio/travel_stories/profileimages/${profilePicture}")
                              : null,
                        )
                      ],
                    ),
                    title: Text(
                      _titleController.text.isEmpty
                          ? 'Your title appears here'
                          : _titleController.text,
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          dropdownVal.toString().length > 12
                              ? dropdownVal.toString().replaceAll(" ", "\n")
                              : dropdownVal.toString(),
                          style: TextStyle().copyWith(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Container(
                          height: 12,
                          child: VerticalDivider(
                            thickness: 1,
                          ),
                        ),
                        Text(
                          UserDetails().readUserNamefromBox().length > 12
                              ? UserDetails()
                                  .readUserNamefromBox()
                                  .replaceFirst(" ", "\n")
                              : UserDetails().readUserNamefromBox(),
                          textAlign: TextAlign.center,
                          style: TextStyle().copyWith(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Container(
                          height: 12,
                          child: VerticalDivider(
                            thickness: 1,
                          ),
                        ),
                        Text(
                          formatedDate.toString().trim(),
                          style: TextStyle().copyWith(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _bodyController.text.isEmpty
                          ? 'Your story appears here'
                          : _bodyController.text,
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
  }

  void addStory() async {
    print('body - ${_bodyController.text}');
    var url = 'http://ubermensch.studio/travel_stories/addstory.php';
    var uri = Uri.parse(url);
    var data = {
      'title': _titleController.text,
      'category': dropdownVal.value,
      'body': _bodyController.text,
      'personid': UserDetails().readUserIDfromBox(),
      'personname': UserDetails().readUserNamefromBox(),
      'personprofilepic': UserDetails().readUserProfilePicfromBox()
    };

    print('data - $data');

    http.Response res = await http.post(Uri.parse(url), body: data);
    var details = json.decode(json.encode(res.body));
    print('details - $details');
    if (details.toString().contains("titleexists")) {
      print('story title exists');
      isloading.value = false;
      CustomSnackbar(
              title: 'Error',
              message:
                  'The title of this story already exists! Kindly change the title')
          .showWarning();
    } else {
      if (details.toString().contains("true")) {
        print('story added');
        isloading.value = false;
        CustomSnackbar(title: 'Success', message: 'Story added successfully')
            .showSuccess();
        currentStep.value = 0;
        _titleController.clear();
        dropdownVal.value = 'Pick a category';
        _bodyController.clear();
        Get.offAllNamed(Routes.NAVIGATION_DRAWER);
      } else if (details.toString().contains("false")) {
        print('story error');
        isloading.value = false;
        CustomSnackbar(
                title: 'Error',
                message: 'An error occured while adding the story! Try again')
            .showWarning();
      } else {
        isloading.value = false;
      }
    }
  }
}
