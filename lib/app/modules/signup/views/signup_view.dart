import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/views/views/custom_bottom_sheet_view.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final textFieldFocusNode = FocusNode();

  @override
  final controller = Get.find(tag: 'signupcontroller');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            reverse: true,
            child: Obx(() {
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Sign up',
                          style: context.theme.textTheme.headline1,
                        ),
                      ),
                      Hero(
                        tag: 'loginlogo',
                        child: SizedBox(
                            child: Image.asset('images/introfinal.png',
                                fit: BoxFit.contain)),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: name(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: phoneNumber(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: password(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Pick one favorite mode of transport',
                            style: context.theme.textTheme.headline4,
                          ),
                          SizedBox(height: 50, child: customchips()),
                          SizedBox(
                            height: 20,
                          ),
                          Hero(
                            tag: 'loginbutton',
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () =>
                                    controller.profilePictureDialogue(
                                        _nameController.text,
                                        _phonenumberController.text,
                                        _passwordController.text),
                                child: Text(
                                  'Sign up',
                                  style: context.theme.textTheme.headline6,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: RichText(
                              text: TextSpan(
                                text: 'Have an account? ',
                                style: context.theme.textTheme.headline4,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Login',
                                      style: context.theme.textTheme.headline4
                                          ?.copyWith(
                                        color: ThemeService().theme ==
                                                ThemeMode.light
                                            ? ColorResourcesLight.mainLIGHTColor
                                            : ColorResourcesDark.mainDARKColor,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  controller.isLoading.value
                      ? Positioned.fill(
                          child: Center(
                              child: CircularProgressIndicator(
                          backgroundColor:
                              ColorResourcesLight.mainLIGHTAPPBARcolor,
                          color: ColorResourcesLight.mainLIGHTColor,
                        )))
                      : SizedBox.shrink()
                ],
              );
            })),
      ),
    );
  }

  Widget name() => TextFormField(
      style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
      cursorColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      keyboardType: TextInputType.name,
      controller: _nameController,
      autovalidate: true,
      validator: (val) {
        if (val!.length > 25) {
          return 'Name cannot be more than 25 characters';
        }
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
      controller: _phonenumberController,
      autovalidate: true,
      validator: (val) {},
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
            controller: _passwordController,
            obscureText: controller.obscured.value,
            autovalidate: true,
            validator: (val) {
              if (val!.length > 15) {
                return 'Password cannot be more than 25 characters';
              }
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
