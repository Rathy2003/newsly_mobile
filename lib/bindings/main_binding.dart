import 'package:get/get.dart';
import 'package:newsly/controllers/permission_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PermissionController());
  }
}