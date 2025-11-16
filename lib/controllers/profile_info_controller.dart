import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileInfoController extends GetxController{

  var selectedImage = Rx<File?>(null);
  var isChanged = false.obs;
  Future<void> pickImage() async{
    final _picker =  ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      selectedImage.value = File(image.path);
      isChanged.value = true;
    }
  }
}