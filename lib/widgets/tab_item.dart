import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsly/controllers/tabbar_controller.dart';
import 'package:newsly/utils/app_color.dart';


class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.label,
    required this.index,
  });

  final String label;
  final int index;
  

  @override
  Widget build(BuildContext context) {
    var tabBarController = Get.find<TabBarController>();
    return Obx(() {
      return Tab(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),
          decoration: BoxDecoration(
          color: Color(index == tabBarController.tabIndex.value ? AppColor.primaryColor : AppColor.secondary),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(color: index == tabBarController.tabIndex.value ? Colors.white : Colors.black),
          ),
        ),
      );
    },);
  }
}