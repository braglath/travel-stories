import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  final controller = Get.find(tag: 'signupcontroller');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
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
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Pick your favorite transport mode',
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
                        onPressed: () => Get.offAllNamed(Routes.SUBMIT_STORY),
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
                              style:
                                  context.theme.textTheme.headline4?.copyWith(
                                color: ThemeService().theme == ThemeMode.light
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
        ),
      ),
    );
  }

  Widget name() => TextFormField(
      cursorColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      keyboardType: TextInputType.name,
      controller: _nameController,
      autovalidate: true,
      validator: (val) {},
      decoration: InputDecoration(
        labelText: 'Name',
      ));

  Widget phoneNumber() => TextFormField(
      cursorColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      keyboardType: TextInputType.phone,
      controller: _phonenumberController,
      autovalidate: true,
      validator: (val) {},
      decoration: InputDecoration(
        labelText: 'Phone number or Email',
      ));

  Widget password() => TextFormField(
      cursorColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainTextHEADINGColor
          : ColorResourcesDark.mainDARKTEXTICONcolor,
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordController,
      obscureText: true,
      autovalidate: true,
      validator: (val) {},
      decoration: InputDecoration(
        labelText: 'Password',
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
}
