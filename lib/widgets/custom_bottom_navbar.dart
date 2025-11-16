import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsly/controllers/bottom_navbar_controller.dart';
import 'package:newsly/utils/app_color.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    var bottomNavbarController = Get.find<BottomNavbarController>();
    return Obx(
      () => Container(
        width: MediaQuery.of(context).size.width - 31,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 5,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => bottomNavbarController.changeIndex(0),
              icon: Icon(
                bottomNavbarController.selectedIndex.value == 0 ? Icons.home_filled : Icons.home_outlined,
                color: Color(bottomNavbarController.selectedIndex.value == 0 ?AppColor.primaryColor : AppColor.dark),
                size: 35
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              onPressed: () => bottomNavbarController.changeIndex(1),
              icon: Icon(
                bottomNavbarController.selectedIndex.value == 1 ? Icons.search : Icons.search_outlined,
                color: Color(bottomNavbarController.selectedIndex.value == 1 ? AppColor.primaryColor : AppColor.dark),
                size: 35
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              onPressed: () => bottomNavbarController.changeIndex(2),
              icon: Icon(
                bottomNavbarController.selectedIndex.value == 2 ? Icons.notifications : Icons.notifications,
                color: Color(bottomNavbarController.selectedIndex.value == 2 ? AppColor.primaryColor : AppColor.dark),
                size: 35
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              onPressed: () => bottomNavbarController.changeIndex(3),
              icon: Icon(
                bottomNavbarController.selectedIndex.value == 3 ? Icons.person : Icons.person_outline,
                color: Color(bottomNavbarController.selectedIndex.value == 3 ? AppColor.primaryColor : AppColor.dark),
                size: 35
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
