import 'dart:io';

import 'package:get/get.dart';
import 'package:newsly/controllers/auth_controller.dart';
import 'package:newsly/helper/message_dialog.dart';
import 'package:newsly/models/user.dart';
import 'package:newsly/services/user_services.dart';

class UserController extends GetxController {
  final UserService _userService = UserService();
  var authController = Get.find<AuthController>();
  void onUpdateProfile(String userId,String username,String email, File? image) async{
    var res = await _userService.updateUserProfile(userId, username, email,image);
    if(res.success == true){
      var userData = res.data["data"];
      var user =  User.fromJson(userData);
      authController.currentUser.value = user;
      String message = res.data["message"];
      MessageDialog.showMessageDialog(message);
    }
  }
}