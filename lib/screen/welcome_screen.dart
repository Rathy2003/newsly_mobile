import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:newsly/routes/app_route.dart';
import 'package:newsly/utils/app_color.dart';
import 'package:newsly/utils/app_font.dart';
import 'package:newsly/widgets/custom_button.dart';


final loadingKey = GlobalKey();

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      key: loadingKey,
      child: Material(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                SizedBox(height: 25,),
                Image.asset("assets/images/bg-01.png",
                  width: MediaQuery.of(context).size.width / 1.8,
                ),
                SizedBox(height: 25,),            
                Text("សូមស្វាគមន៍មកកាន់ Newsly",
                  style: AppFont.heading,
                ),
                SizedBox(height: 15,),
                // Description
                Text("ជាមួយនឹង Newsly អ្នកនឹងទទួលបានព័ត៌មានថ្មីៗគ្រប់ប្រភេទនៅក្នុងកម្មវិធីតែមួយ។ ចាប់ពីលទ្ធផលបាល់ទាត់ដល់ព័ត៌មានបច្ចេកវិទ្យាថ្មីៗ Newsly ជ្រើសរើសនិងបង្ហោះព័ត៌មានសំខាន់ៗពីជួរផ្សេងៗដូចជា៖ អាជីវកម្ម កម្សាន្ត សុខភាព វិទ្យាសាស្ត្រ និងច្រើនទៀត។ មិនថាអ្នកជាសំណព្វបាល់ទាត់ ឬអ្នកចូលចិត្តបច្ចេកវិទ្យា Newsly នឹងផ្តល់ព័ត៌មានដែលទាន់សម័យ និងពាក់ព័ន្ធជាមួយអ្នកជារៀងរាល់ថ្ងៃ។",
                  style: AppFont.secondary,  
                ),
                // End Description
                SizedBox(height: 25,),
                CustomButton(
                  onPressed: () => Get.toNamed(AppRoute.signin),
                  label: "ចូលគណនី",
                  backgroundColor: Color(AppColor.primaryColor),
                  textColor: Colors.white,
                ),
                SizedBox(height: 15,),
                CustomButton(
                  onPressed: () => Get.toNamed(AppRoute.signup),
                  label: "បង្កើតគណនី",
                  backgroundColor: Color(AppColor.secondary),
                  textColor: Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

