import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ebuy/helper/objectbox.dart';
import 'package:ebuy/pages/login_page.dart';
import 'package:ebuy/pages/regi_page.dart';
import 'package:ebuy/screen/splashScreen.dart';
import 'package:ebuy/screen/wearos/watchscreen.dart';
import 'package:ebuy/state/objectboc_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  AwesomeNotifications().initialize('resource://drawable/book', [
    NotificationChannel(
      channelGroupKey: 'basic_channel_group',
      channelKey: 'basic_channel',
      channelName: 'Login Notification',
      channelDescription: 'notification channel for Login',
      defaultColor: const Color(0xFF905aDD),
      importance: NotificationImportance.Max,
      ledColor: Colors.white,
    ),
    NotificationChannel(
      channelGroupKey: 'alert_channel_group',
      channelKey: 'Alert_channel',
      channelName: 'alert Notification',
      channelDescription: 'notification channel for alert',
      defaultColor: const Color(0xFF905aDD),
      importance: NotificationImportance.Max,
      ledColor: Colors.white,
    )
  ]);

  WidgetsFlutterBinding.ensureInitialized();
  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eBuy',
      initialRoute: '/',
      theme: getApplicationTheme(),
      routes: {
        '/': (context) => SplashScreen(),
        // '/': (context) => const WearLogin(),
        '/login_screen': (context) => LoginPage(),
        '/register_screen': (context) => RegPage(),
      },
    ),
  );
}

getApplicationTheme() {}








// import 'package:ebuy/state/objectboc_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'app/app.dart';
// import 'helper/objectbox.dart';

// // void main() async {
// //   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
// //     statusBarColor: Colors.transparent,
// //     statusBarIconBrightness: Brightness.dark,
// //   ));
// //   WidgetsFlutterBinding.ensureInitialized();
// //   ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();
// //   runApp(const MyApp());
// // }