import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsly/controllers/auth_controller.dart';
import 'package:newsly/screen/custom_textfield.dart';
import 'package:newsly/utils/app_color.dart';
import 'package:newsly/utils/app_font.dart';
import 'package:newsly/utils/keyboard_type.dart';
import 'package:newsly/widgets/custom_button.dart';
import '../routes/app_route.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Material(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              IconButton(
                alignment: Alignment.topLeft,
                onPressed: () => authController.backToWelcomeScreen(),
                icon: Icon(Icons.arrow_back_ios),
              ),
              Text("ចូលគណនី",
                style: AppFont.heading,
              ),
              Text("សូមស្វាគមន៍! សូមបញ្ចួលព័ត៍មានរបសអ្នកប្រើប្រាស់", style: AppFont.normal,),
        
              SizedBox(height: 50,),
              CustomTextField(
                controller: authController.emailController,
                onSaved: (value) => authController.email = value!,
                type: KeyboardType.email,
                placeholder:"អាសយដ្ឋានអ៊ីមែល",
                prefixIcon: Icons.email,
                validator: (value){
                  return authController.validateEmail(value!);
                },
              ),
              SizedBox(height: 18,),
              CustomTextField(
                controller: authController.passwordController,
                onSaved: (value) => authController.password = value!,
                type: KeyboardType.password,
                isObscure: true,
                placeholder:"ពាក្យសម្ងាត់",
                prefixIcon: Icons.password,
                validator: (value) => authController.validatePassword(value!),
              ),
              SizedBox(height: 50,),
              CustomButton(
                onPressed: () => authController.checkSignIn(formKey),
                label: "ចូលគណនី",
                backgroundColor: Color(AppColor.primaryColor),
                textColor: Colors.white,
              ),
              SizedBox(height: 15,),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "មិនមានគណនី?",
                    style: TextStyle(
                      color: Colors.black
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = () => Get.offAndToNamed(AppRoute.signup),
                        text: " បង្កើតគណនី",
                        style: TextStyle(
                          color: Color(AppColor.primaryColor)
                        )
                      )
                    ]
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}