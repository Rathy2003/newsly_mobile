import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:newsly/bindings/main_binding.dart';
import 'package:newsly/controllers/bottom_navbar_controller.dart';
import 'package:newsly/controllers/auth_controller.dart';
import 'package:newsly/firebase_options.dart';
import 'package:newsly/routes/app_route.dart';
import 'package:newsly/screen/home_screen.dart';
import 'package:newsly/screen/notification_screen.dart';
import 'package:newsly/screen/profile_screen.dart';
import 'package:newsly/screen/search_screen.dart';
import 'package:newsly/screen/welcome_screen.dart';
import 'package:newsly/widgets/custom_bottom_navbar.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("km",null);
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // on background
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){

  });
  var authController = Get.put(AuthController());

  // Local Notification channel
  const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings = InitializationSettings(android: androidSettings);
  await FlutterLocalNotificationsPlugin().initialize(initSettings);

  // Show notification when in app open
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _showNotification(message);
  });

  runApp(
    GetMaterialApp(
      initialBinding: MainBinding(),
      debugShowCheckedModeBanner: false,
      home: Obx(() => authController.isLoggedIn.value ? MyApp() : WelcomeScreen()),
      getPages: AppRoute.routes
    )
  );
}


// handle background or terminated (user not open app)
@pragma('vm:entry-point')
Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  _showNotification(message);
}

void _showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'firebase_channel',
    'Firebase Notifications',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    message.hashCode,
    message.notification?.title ?? 'No Title',
    message.notification?.body ?? 'No Body',
    notificationDetails,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var bottomNavbarController = Get.find<BottomNavbarController>();
    return Scaffold(
      body: PageView(
        controller: bottomNavbarController.pageController,
        children: [
          HomeScreen(),
          SearchScreen(),
          NotificationScreen(),
          ProfileScreen(),
        ],
      ),
      floatingActionButton: CustomBottomNavBar(),
    );
  }
}