import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsly/utils/app_color.dart';
import 'package:newsly/widgets/custom_button.dart';

class MessageDialog {
  static void showMessageDialog(String message) {
    Get.defaultDialog(
      barrierDismissible: false,
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      title: "ការជូនដំណឹង",
      titlePadding: EdgeInsets.only(top: 15),
      middleText:
          message,
      confirm: CustomButton(
          onPressed: () async => {
            Get.back(),
          },
          label: "យល់ព្រម",
          backgroundColor: Color(AppColor.primaryColor),
          textColor: Colors.white
      ),
    );
  }
}