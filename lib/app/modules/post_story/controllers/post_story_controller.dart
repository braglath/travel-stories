import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/post_story/views/post_story_view.dart';
import 'package:travel_diaries/app/modules/profile/views/profile_view.dart';

class PostStoryController extends GetxController {
  //TODO: Implement PostStoryController
  final currentStep = 0.obs;
  final count = 0.obs;
  RxString dropdownVal = 'Pick a category'.obs;

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
      print('stepper completed');
      // ! send data to server
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

  Widget firstSteptitleFormField(title) => TextFormField(
      style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
      cursorColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      keyboardType: TextInputType.name,
      maxLines: 3,
      maxLength: 80,
      controller: _titleController,
      // autovalidate: true,
      validator: (val) {},
      decoration: InputDecoration(
        labelText: title,
      ));

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

  Widget secondSteptitleFormField(title) => TextFormField(
      style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
      cursorColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      keyboardType: TextInputType.name,
      maxLines: 15,
      controller: _bodyController,
      // autovalidate: true,
      validator: (val) {},
      decoration: InputDecoration(
        labelText: title,
      ));

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
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
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
                        child: Text(
                          dropdownVal.toString(),
                        ),
                      ),
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
