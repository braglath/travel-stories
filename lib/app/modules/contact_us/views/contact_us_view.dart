import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';

import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  @override
  final controller = Get.find(tag: 'contactuscontroller');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(
        title: 'Contact us',
      ),
      body: emailTab(),
    );
  }

  Widget emailTab() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'May I help you',
              style: TextStyle(
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainTextHEADINGColor
                    : ColorResourcesDark.mainDARKTEXTICONcolor,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Let us know your queries and feedbacks',
              style: TextStyle(
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainTextHEADINGColor
                    : ColorResourcesDark.mainDARKTEXTICONcolor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              UserDetails().readUserNamefromBox(),
              style: TextStyle(
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainTextHEADINGColor
                    : ColorResourcesDark.mainDARKTEXTICONcolor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 15.0),
            _email(),
            SizedBox(height: 15.0),
            _subject(),
            SizedBox(height: 15.0),
            _message(),
            SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => controller.sendEmail(
                    email: _emailController.text,
                    message: _messageController.text,
                    subject: _subjectController.text),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: ColorResourcesLight.mainLIGHTAPPBARcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _email() => TextFormField(
      style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
      cursorColor: ColorResourcesLight.mainTextHEADINGColor,
      keyboardType: TextInputType.name,
      controller: _emailController,
      // autovalidate: true,
      validator: (val) {
        if (!val!.contains('@')) {
          return 'Enter valid email address';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainLIGHTColor
              : ColorResourcesDark.mainDARKColor,
        ),
        labelText: 'Email',
      ));
  Widget _subject() => IntrinsicHeight(
        child: TextFormField(
            style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
            cursorColor: ColorResourcesLight.mainTextHEADINGColor,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            controller: _subjectController,
            validator: (val) {},
            minLines: null,
            maxLines: null,
            expands: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.edit,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor
                    : ColorResourcesDark.mainDARKColor,
              ),
              labelText: 'Subject',
            )),
      );

  Widget _message() => IntrinsicHeight(
        child: TextFormField(
            style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
            cursorColor: ColorResourcesLight.mainTextHEADINGColor,
            keyboardType: TextInputType.multiline,
            controller: _messageController,
            textInputAction: TextInputAction.newline,
            maxLines: 8,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.edit_attributes,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor
                    : ColorResourcesDark.mainDARKColor,
              ),
              labelText: 'Message',
            )),
      );
}
