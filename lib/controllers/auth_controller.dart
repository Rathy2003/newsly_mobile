import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:newsly/controllers/base_controler.dart';
import 'package:newsly/controllers/beaking_news_controller.dart';
import 'package:newsly/controllers/bottom_navbar_controller.dart';
import 'package:newsly/controllers/category_controller.dart';
import 'package:newsly/controllers/news_controller.dart';
import 'package:newsly/controllers/tabbar_controller.dart';
import 'package:newsly/main.dart';
import 'package:newsly/models/user.dart';
import 'package:newsly/routes/app_route.dart';
import 'package:newsly/screen/welcome_screen.dart';
import 'package:newsly/utils/app_color.dart';
import 'package:newsly/utils/app_config.dart';
import 'package:newsly/widgets/custom_button.dart';

class AuthController extends BaseControler<User?>{
  late TextEditingController nameController,emailController,passwordController;
  var storage = GetStorage();
  var currentUser = User(0, "", "", "",null).obs;
  var isLoggedIn = false.obs;
  var username = "";
  var email = "";
  var password = "";
  

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void backToWelcomeScreen(){
    clearForm();
    Get.back();
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

   String? validateName(String value){
    final RegExp usernameRegex = RegExp(r"^[a-zA-Z0-9_]{3,20}$");
    if(!usernameRegex.hasMatch(value)){
      return 'សូមបញ្ចូលឈ្មោះអ្នកប្រើប្រាស់ដែលត្រឹមត្រូវ';
    }
    return null;
  }

  String? validateEmail(String value){
    if(!GetUtils.isEmail(value)){
      return 'សូមបញ្ចូលអាសយដ្ឋានអ៊ីមែលដែលត្រឹមត្រូវ';
    }
    return null;
  }

  String? validatePassword(String value){
    if(value.length < 6){
      return 'ពាក្យសម្ងាត់យ៉ាងតិច 6 អក្សរ';
    }
    return null;
  }

  void checkSignIn(GlobalKey<FormState> formKey){
    final isValid = formKey.currentState!.validate();
    if(!isValid)  return;
    formKey.currentState!.save();
    processSignIn();
  }

  void checkSignUp(GlobalKey<FormState> formKey){
    final isValid = formKey.currentState!.validate();
    if(!isValid)  return;
    formKey.currentState!.save();
    proccessSignUp();
  }

  void proccessSignUp() async{
    await APICalling(() async{
      loadingKey.currentState!.context.loaderOverlay.show();
      try{
        var response = await http.post(Uri.parse("${AppConfig.baseUrl}/user"), body: {
          "username": username,
          "email": email,
          "password": password
        });
        if(response.statusCode == HttpStatus.created){
          _showMessageDialog("គណីរបស់អ្នកបានបង្កើតដោយជោគជ័យ");
          processSignIn();
        }else if(response.statusCode == HttpStatus.badRequest){
          var data = json.decode(response.body);
          String message = data['message'];
          _showMessageDialog(message);
        }
      }catch(e){
        _showMessageDialog("មានអ្វីមួយមិនប្រក្រតី។ សូមព្យាយាមម្តងទៀត");
      }finally{
         loadingKey.currentState!.context.loaderOverlay.hide();
      }
      return null;
    });
  }

  void processSignIn() async{
    await APICalling(() async{
      try{
        loadingKey.currentState!.context.loaderOverlay.show();
        var response = await http.post(Uri.parse("${AppConfig.baseUrl}/user/account/login"), body: {
          "email": email,
          "password": password
        }).timeout(Duration(seconds: 10));
        if(response.statusCode == 200){
          initController();
          var data = json.decode(response.body);
          String token = data['token'];
          var userObject = data['user'];
          userObject["token"] = token;
          var userItem = User.fromJson(userObject);
          currentUser.value.id = userItem.id;
          currentUser.value.email = userItem.email;
          currentUser.value.username = userItem.username;
          storage.write("token", token);
          isLoggedIn.value = true;
          Get.offAll(() => MyApp());
        }else if(response.statusCode == HttpStatus.badRequest){
         _showMessageDialog("អាសយដ្ឋានអ៊ីមែលឬពាក្យសម្ងាត់មិនត្រឹមត្រូវ។ សូមព្យាយាមម្តងទៀត");
        }
      }catch(e){
        _showMessageDialog("មានអ្វីមួយមិនប្រក្រតី។ សូមព្យាយាមម្តងទៀត");
      }finally{
        loadingKey.currentState!.context.loaderOverlay.hide();
      }
      return null;
    });
  }

  void _showMessageDialog(String message) {
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

  void proccessSignOut() async{
    await APICalling(() async{
      try{
        var response = await http.post(Uri.parse("${AppConfig.baseUrl}/user/account/logout"),body: {
          "user_id":currentUser.value.id.toString()
        });
        if(response.statusCode == 200){
          storage.remove("token");
          storage.remove("asked_permission");
          isLoggedIn.value = false;
          currentUser.value.id = 0;
          currentUser.value.email = "";
          currentUser.value.username = "";
          currentUser.value.token = "";
          Get.offAllNamed(AppRoute.welcome);
        }
      }catch(e){
        _showMessageDialog("មានអ្វីមួយមិនប្រក្រតី។ សូមព្យាយាមម្តងទៀត");
      }finally{
      }
      return null;
    });
  }

   void checkLoginStatus() {
    final token = storage.read('token');
    if (token != null) {
      initController();
      isLoggedIn.value = true;
      fetchProfile(token);
    }
  }

  void initController(){
    Get.put(BreakingNewsController(), permanent: true);
    Get.put(NewsController(), permanent: true);
    Get.put(CategoryController(), permanent: true);
    Get.put(TabBarController(), permanent: true);
    Get.put(BottomNavbarController(), permanent: true);
  }

  Future<User?> fetchProfile(String token) async{
    await APICalling(() async{
      try{
        var response = await http.get(Uri.parse("${AppConfig.baseUrl}/user/account/profile"),headers: {"Authorization":"Bearer $token"});
        if(response.statusCode == 200){
            var data = json.decode(response.body);
            var userItem = User.fromJson(data['data']);
            currentUser.value.id = userItem.id;
            currentUser.value.email = userItem.email;
            currentUser.value.profile = userItem.profile;
            currentUser.value.username = userItem.username;
            return userItem;
        }
        return null;
      }catch(e){
        _showMessageDialog("មានអ្វីមួយមិនប្រក្រតី។ សូមព្យាយាមម្តងទៀត");
      }
      return null;
    });
    return null;
    
  }
}