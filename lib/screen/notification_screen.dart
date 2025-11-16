import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsly/controllers/bottom_navbar_controller.dart';
import 'package:newsly/utils/app_font.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bottomNavbarController = Get.find<BottomNavbarController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            bottomNavbarController.changeIndex(bottomNavbarController.old_index);
          },
          icon: Icon(Icons.arrow_back_ios)
          
        ),
        title: Text("សារជូនដំណឹង", style: AppFont.heading,),
        centerTitle: true,
        elevation: 1,
      ),
      body: Center(
        child: Text(
          "សារជូនដំណឹង",
          style: AppFont.normal,
        ),
      ),
    );
  }
}