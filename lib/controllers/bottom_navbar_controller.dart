import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BottomNavbarController extends GetxController {
  int old_index = 0;
  var selectedIndex = 0.obs;
  var pageController = PageController(initialPage: 0);

  void changeIndex(int index) {
    old_index = selectedIndex.value;
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}