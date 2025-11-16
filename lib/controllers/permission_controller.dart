import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:newsly/controllers/auth_controller.dart';
import 'package:newsly/utils/app_color.dart';
import 'package:newsly/utils/app_config.dart';
import 'package:newsly/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

class PermissionController extends GetxController {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  var isPermissionGranted  = false.obs;
  final stroage = GetStorage();
  var authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  Future<void> checkPermission() async{
    //stroage.remove("asked_permission");
    bool? askedBefore = stroage.read("asked_permission");
    if(askedBefore == true){
      await getCurrentPermissionStatus();
      return;
    }else{
      if(authController.isLoggedIn.value != true) return;
    }

    // Show popup for first time
    Future.delayed(const Duration(seconds: 1), () {
      Get.defaultDialog(
        barrierDismissible: false,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        title: "អនុញ្ញាត ការជូនដំណឹង?",
        titlePadding: EdgeInsets.only(top: 15),
        middleText:
            "យើងចង់ផ្ញើព័ត៌មានថ្មីៗនៅពេលដែលព័ត៌មានថ្មីៗត្រូវបានផ្សព្វផ្សាយ។ តើអ្នកចង់អនុញ្ញាតឱ្យមានការជូនដំណឹងទេ?",
        cancel: CustomButton(
            onPressed: () => stroage.write('asked_permission', true),
            label: "​មិនអនុញ្ញាត",
            backgroundColor: Color(AppColor.secondary),
            textColor: Colors.black
        ),
        confirm: CustomButton(
            onPressed: () async => {
              Get.back(),
              await requestPermission(),
            },
            label: "អនុញ្ញាត",
            backgroundColor: Color(AppColor.primaryColor),
            textColor: Colors.white
        ),
      );
    });
  }

  Future<void> requestPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      isPermissionGranted.value = true;
      stroage.write('asked_permission', true);
      String? token = await firebaseMessaging.getToken();
      if(token != null){
        // update token
        var userId = authController.currentUser.value.id;
        var response = await http.post(Uri.parse("${AppConfig.baseUrl}/user/account/update-fcm-token"),
        body: {
          "user_id": userId.toString(),
          "fcm_token": token
        });
        if(response.statusCode == 200){
          print("Token has been updated");
        }
      }
    } else {
      isPermissionGranted.value = false;
      stroage.write('asked_permission', true);
    }
  }
   Future<void> getCurrentPermissionStatus() async {
    NotificationSettings settings = await firebaseMessaging.getNotificationSettings();
    isPermissionGranted.value =
        settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}