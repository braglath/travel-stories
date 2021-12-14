import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class ContactUsController extends GetxController {
  final count = 0.obs;
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

  Future sendEmail({
    required String email,
    required String message,
    required String subject,
  }) async {
    final serviceId = 'service_wn7k3r9';
    final templateId = 'template_syzg26y';
    final userId = 'user_mqQnO48frHBXl8HXoMPZW';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost', //app this if you cant send email
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': UserDetails().readUserNamefromBox(),
          'user_email': email,
          'user_subject': 'Support',
          'user_message': message,
        }
      }),
    );

    if (response.statusCode == 200) {
      CustomSnackbar(
              title: 'Successfully sent',
              message:
                  'Your with subject - $subject, has been sent successfully! \n Give us some time to take a look')
          .showSuccess();
    } else {
      CustomSnackbar(
              title: 'Error',
              message:
                  'There was an error sending this message, kindly try again')
          .showWarning();
    }
  }
}
