import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';

import '../controllers/edit_my_stories_controller.dart';

class EditMyStoriesView extends GetView<EditMyStoriesController> {
  List<String> travelmodes = [
    'Pick a category',
    'Cycle',
    'Bike',
    'Car',
    'Bus',
    'Train',
    'Flight'
  ];

  List<IconData> travelIcons = [
    Icons.flutter_dash,
    Icons.directions_bike_sharp,
    Icons.motorcycle_rounded,
    FontAwesomeIcons.car,
    FontAwesomeIcons.bus,
    FontAwesomeIcons.train,
    Icons.flight_takeoff,
  ];
  @override
  final controller = Get.find(tag: 'editmystoriescontroller');
  final args = Get.arguments;
  String get title => args['title'];
  String get category => args['category'];
  String get body => args['body'];
  String get id => args['id'];
  @override
  Widget build(BuildContext context) {
    controller.titleController.text = title;
    controller.bodyController.text = body;
    controller.dropdownVal.value = category;

    return Scaffold(
      appBar: AppBarView(
        appBarSize: 56,
        bottom: null,
        title: 'Edit story',
      ),
      body: Obx(
        () {
          return Stack(
            children: [
              _customStepperWidget(context),
              controller.isloading.value
                  ? Positioned.fill(
                      child: Center(
                          child: CircularProgressIndicator(
                      backgroundColor: ColorResourcesLight.mainLIGHTAPPBARcolor,
                      color: ColorResourcesLight.mainLIGHTColor,
                    )))
                  : SizedBox.shrink()
            ],
          );
        },
      ),
    );
  }

  Widget _customStepperWidget(context) => Obx(() {
        return ThemeService().theme == ThemeMode.light
            ? Theme(
                data: ThemeData(
                    canvasColor: ColorResourcesLight.mainLIGHTAPPBARcolor,
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: ColorResourcesLight.mainLIGHTColor,
                        )),
                child: Stepper(
                  elevation: 0,
                  steps: controller.getSteps(),
                  type: StepperType.horizontal,
                  currentStep: controller.currentStep.value,
                  onStepContinue: () =>
                      controller.onStepContinued(oldtitle: title, id: id),
                  onStepCancel: () => controller.onStepCanceled(),
                ),
              )
            : Theme(
                data: ThemeData(
                    canvasColor: ColorResourcesDark.mainDARKAPPBARcolor,
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: ColorResourcesDark.mainDARKColor,
                        )),
                child: Stepper(
                    elevation: 0,
                    // onStepTapped: (step) => controller.onStepTapped(step),
                    steps: controller.getSteps(),
                    type: StepperType.horizontal,
                    currentStep: controller.currentStep.value,
                    onStepContinue: () =>
                        controller.onStepContinued(oldtitle: title, id: id),
                    onStepCancel: () => controller.onStepCanceled()),
              );
      });

  Widget dropDown() => Obx(() {
        return DropdownButton<String>(
          isExpanded: true,
          value: controller.dropdownVal.toString(),
          icon: const Icon(Icons.arrow_downward_rounded),
          iconSize: 20,
          elevation: 16,
          underline: Container(),
          onChanged: (newValue) {
            controller.setDropdownValue(newValue);
            // dropdownVal = newValue.toString();
          },
          items: List.generate(
            travelmodes.length,
            (index) => DropdownMenuItem(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      travelmodes[index],
                      style: TextStyle(
                        color: ThemeService().theme == ThemeMode.light
                            ? ColorResourcesLight.mainTextHEADINGColor
                            : ColorResourcesDark.mainDARKTEXTICONcolor,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(travelIcons[index])
                  ],
                ),
              ),
              value: travelmodes[index],
            ),
          ),
        );
      });
}
