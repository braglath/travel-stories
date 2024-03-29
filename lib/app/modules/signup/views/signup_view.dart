import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  final textFieldFocusNode = FocusNode();

  @override
  final controller = Get.find(tag: 'signupcontroller');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainBody(context),
    );
  }

  SafeArea _mainBody(BuildContext context) {
    return SafeArea(
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
                        style: context.theme.textTheme.displayLarge,
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
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: name(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: phoneNumber(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: password(),
                        ),
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: LinearProgressIndicator(
                              minHeight: 3,
                              semanticsLabel: 'password strength',
                              value: controller.passwordStrength.value,
                              backgroundColor: Colors.white,
                              color: controller.passwordStrength.value <= 1 / 4
                                  ? Colors.red.withOpacity(0.8)
                                  : controller.passwordStrength.value == 2 / 4
                                      ? Colors.amber.withOpacity(0.8)
                                      : controller.passwordStrength.value ==
                                              3 / 4
                                          ? Colors.deepPurpleAccent
                                              .withOpacity(0.8)
                                          : Colors.green.withOpacity(0.8),
                            ),
                          );
                        }),
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
                        SizedBox(height: 20),
                        Hero(
                          tag: 'loginbutton',
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () =>
                                  controller.profilePictureDialogue(
                                      _nameController.text,
                                      _phonenumberController.text,
                                      _captionController.text,
                                      _passwordController.text),
                              child: Text(
                                'Sign up',
                                style: context.theme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Text('Other options',
                              style: context.theme.textTheme.headlineMedium
                                  ?.copyWith(fontSize: 15)),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _googleLoginButton(context),
                        _facebookLoginButton(context),
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
                              style: context.theme.textTheme.headlineMedium,
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Login',
                                    style: context
                                        .theme.textTheme.headlineMedium
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
    );
  }

  ElevatedButton _googleLoginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () => controller.googleLogin(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.google,
              size: 15,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Google',
              style: context.theme.textTheme.headlineMedium?.copyWith(
                  color: ColorResourcesLight.mainLIGHTAPPBARcolor,
                  fontSize: 15),
            )
          ],
        ));
  }

  ElevatedButton _facebookLoginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () => controller.facebookLogin(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.facebook,
              size: 15,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Facebook',
              style: context.theme.textTheme.headlineMedium?.copyWith(
                  color: ColorResourcesLight.mainLIGHTAPPBARcolor,
                  fontSize: 15),
            )
          ],
        ));
  }

  Widget name() {
    _nameController.text = controller.name.value;
    return TextFormField(
        style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
        cursorColor: ThemeService().theme == ThemeMode.light
            ? ColorResourcesLight.mainTextHEADINGColor
            : ColorResourcesDark.mainDARKTEXTICONcolor,
        keyboardType: TextInputType.name,
        controller: _nameController,
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
  }

  Widget phoneNumber() {
    _phonenumberController.text = controller.email.value;
    return TextFormField(
        style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
        cursorColor: ThemeService().theme == ThemeMode.light
            ? ColorResourcesLight.mainTextHEADINGColor
            : ColorResourcesDark.mainDARKTEXTICONcolor,
        keyboardType: TextInputType.emailAddress,
        controller: _phonenumberController,
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
  }

  Widget password() => Obx(() {
        return TextFormField(
            onChanged: (value) => controller.checkPasswordStrength(value),
            style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
            cursorColor: ThemeService().theme == ThemeMode.light
                ? ColorResourcesLight.mainTextHEADINGColor
                : ColorResourcesDark.mainDARKTEXTICONcolor,
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordController,
            obscureText: controller.obscured.value,
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

  Widget caption() => TextFormField(
      style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
      cursorColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      keyboardType: TextInputType.visiblePassword,
      controller: _captionController,
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
}
