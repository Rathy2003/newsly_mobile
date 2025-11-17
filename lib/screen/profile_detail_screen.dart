import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsly/controllers/auth_controller.dart';
import 'package:newsly/controllers/profile_info_controller.dart';
import 'package:newsly/controllers/user_controller.dart';
import 'package:newsly/screen/custom_textfield.dart';
import 'package:newsly/utils/app_color.dart';
import 'package:newsly/utils/app_font.dart';
import 'package:newsly/widgets/custom_button.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final profileInfoController = Get.put(ProfileInfoController());
    final userController = Get.put(UserController());
    final TextEditingController usernameController = TextEditingController(
      text: authController.currentUser.value.username ?? "",
    );

    final TextEditingController emailController = TextEditingController(
      text: authController.currentUser.value.email ?? "",
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("ព័ត៌មានអ្នកប្រើប្រាស់", style: AppFont.heading),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              children: [
                // Avatar
                Stack(
                  children: [
                    Obx(() {
                      var user = authController.currentUser.value;
                      var imageFile = profileInfoController.selectedImage.value;
                      var profileUrl = user.profile;

                      // If user uploaded new image, show that
                      if (imageFile != null) {
                        return CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(imageFile),
                        );
                      }

                      // If user has remote profile URL, show network image
                      if (profileUrl != null && profileUrl.isNotEmpty) {
                        return CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(profileUrl),
                        );
                      }

                      // Otherwise show default asset image
                      return CircleAvatar(
                        radius: 80,
                        backgroundImage: const AssetImage(
                          "assets/images/default-avatar.webp",
                        ),
                      );
                    }),

                    Positioned(
                      bottom: 20,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => profileInfoController.pickImage(),
                        child: Container(
                          width: 35,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                // Username
                CustomTextField(
                  onChanged: (value) {
                    if (usernameController.text.isNotEmpty) {
                      profileInfoController.isChanged.value = true;
                    } else {
                      profileInfoController.isChanged.value = false;
                    }
                  },
                  controller: usernameController,
                  placeholder: "ឈ្មោះអ្នកប្រើប្រាស់",
                ),
                SizedBox(height: 20),
                // // Email Address
                CustomTextField(
                  onChanged: (value) {
                    if (emailController.text.isNotEmpty) {
                      profileInfoController.isChanged.value = true;
                    } else {
                      profileInfoController.isChanged.value = false;
                    }
                  },
                  controller: emailController,
                  placeholder: "អាសយដ្ឋានអ៊ីមែល",
                ),

                SizedBox(height: 50),
                // Save Button
                Obx(() {
                  var isChanged = profileInfoController.isChanged.value;
                  return CustomButton(
                    isDisabled: isChanged == false,
                    onPressed: () async {
                      String userId = authController.currentUser.value.id
                          .toString();
                      String username = usernameController.text.trim();
                      String email = emailController.text.trim();
                      userController.onUpdateProfile(
                        userId,
                        username,
                        email,
                        profileInfoController.selectedImage.value,
                      );
                    },
                    label: "រក្សាទុក",
                    backgroundColor: Color(AppColor.primaryColor),
                    textColor: Colors.white,
                  );
                }),
              ],
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
