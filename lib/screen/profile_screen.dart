import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsly/controllers/auth_controller.dart';
import 'package:newsly/controllers/bottom_navbar_controller.dart';
import 'package:newsly/routes/app_route.dart';
import 'package:newsly/utils/app_font.dart';
import 'package:newsly/widgets/menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bottomNavbarController = Get.find<BottomNavbarController>();
    var authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            bottomNavbarController.changeIndex(bottomNavbarController.old_index);
          },
          icon: Icon(Icons.arrow_back_ios)
          
        ),
        title: Text("ព័ត៌មានអ្នកប្រើប្រាស់", style: AppFont.heading,),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              children: [
                // Start Profile Picture
                Obx((){
                  var profileImage = authController.currentUser.value.profile;
                  return CircleAvatar(
                    radius: 80,
                    backgroundImage: profileImage == null ? AssetImage("assets/images/default-avatar.webp") : NetworkImage(profileImage),
                  );
                }),
                // End Profile Picture
                SizedBox(height: 15,),
                // Username
                Obx(() => Text(authController.currentUser.value.username ?? "",
                  style: AppFont.heading,
                ),),
                // Email Address
                Obx(()=> Text(authController.currentUser.value.email ?? "",
                  style: AppFont.normal,
                ))
              ],
            ),
            SizedBox(height: 25,),
            // Start Menu Items
            MenuItem(
              onTap: () => Get.toNamed(AppRoute.editProfile),
              icon:Icons.person,
              label:"កែប្រែព័ត៌មានផ្ទាល់ខ្លួន"
            ),
            SizedBox(height: 20,),
            
            MenuItem(
              onTap: () => authController.proccessSignOut(),
              icon:Icons.logout,
              label:"ចាកចេញ"
            )
            // End Menu Items 
          ],
        ),
      ),
    );
  }
}

