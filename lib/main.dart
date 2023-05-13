import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kreditoption/pages/splash_screen.dart';
import 'package:kreditoption/providers/firebase_provider.dart';
import 'package:kreditoption/theme/color.dart';
import 'package:kreditoption/utils/app_constants.dart';
import 'package:url_strategy/url_strategy.dart';
import 'helper/get_di.dart' as di;

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp();
  await Get.putAsync(() => FirebaseProvider().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.APP_NAME,
      theme: ThemeData(
        primaryColor: appBgColor,
      ),
      home: SplashScreen(),
    );
  }
}
